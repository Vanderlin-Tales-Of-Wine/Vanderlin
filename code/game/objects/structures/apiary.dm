/obj/effect/bees
	name = "bees"

	icon = 'icons/obj/structures/apiary.dmi'
	icon_state = "bee"
	pass_flags = PASSTABLE | PASSMOB

	var/atom/target
	var/obj/effect/bees/merge_target
	var/obj/structure/apiary/hive

	var/stored_pollen = 0
	var/bee_count = 1

	var/pollinating = FALSE
	var/turf/last_pollinated

/obj/effect/bees/update_overlays()
	. = ..()
	cut_overlays()
	var/bee_spawn = bee_count - 1
	if(!bee_spawn)
		return

	for(var/i=1 to bee_spawn)
		var/mutable_appearance/bee = mutable_appearance(icon, icon_state)
		bee.pixel_x = rand(12, -12)
		bee.pixel_y = rand(12, -12)
		overlays += bee

/obj/effect/bees/Initialize()
	. = ..()
	START_PROCESSING(SSfaster_obj, src)

/obj/effect/bees/process()
	if(merge_target)
		var/turf/turf = get_step_towards2(src, merge_target)
		Move(turf, get_dir(src, turf))
		if(get_dist(merge_target, src) == 0)
			merge_target.bee_count++
			merge_target.update_overlays()
			merge_target = null
			hive?.bee_objects -= src
			qdel(src)

	if(target)
		var/turf/turf = get_step_towards2(src, target)
		Move(turf, get_dir(src, turf))
		if(get_dist(target, src) == 0)
			if(istype(target, /obj/structure/apiary))
				enter_hive()
				return
			target = null
			try_pollinate()

/obj/effect/bees/proc/enter_hive()
	hive.bee_objects -= src
	hive.sleeping_bees += bee_count
	hive.outside_bees -= bee_count
	hive.pollen += stored_pollen
	hive.on_bee_enter(bee_count)
	hive = null
	target = null
	qdel(src)

/obj/effect/bees/proc/try_pollinate()
	if(pollinating)
		return TRUE
	if(last_pollinated == get_turf(src))
		return FALSE
	var/turf/turf = get_turf(src)
	var/obj/structure/soil/soil = locate(/obj/structure/soil) in turf
	var/obj/structure/flora/grass/herb/herb = locate(/obj/structure/flora/grass/herb) in turf
	if(!soil && !herb)
		return FALSE

	pollinating = TRUE
	addtimer(CALLBACK(src, PROC_REF(finish_pollinating)), 30 SECONDS)

/obj/effect/bees/proc/finish_pollinating()
	pollinating = FALSE
	last_pollinated = get_turf(src)
	stored_pollen += rand(1, 2) * bee_count

	if(stored_pollen > (10 * bee_count))
		return_to_hive()

/obj/effect/bees/proc/return_to_hive()
	target = hive

/obj/structure/apiary
	name = "apiary"
	desc = ""

	icon = 'icons/obj/structures/apiary.dmi'
	icon_state = "beebox-empty"

	var/stored_combs = 0
	var/outside_bees = 0
	var/sleeping_bees = 0

	var/bee_count = 0
	var/max_bees = 30

	var/list/bee_objects = list()

	var/comb_progress = 0
	var/pollen = 0

/obj/structure/apiary/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/structure/apiary/update_icon_state()
	if(stored_combs > 0)
		icon_state = "beebox-full"
	else
		icon_state = "beebox-empty"

/obj/structure/apiary/process()
	process_comb_gain()

	if((outside_bees + bee_count) < max_bees)
		try_create_bees()

	if(bee_count)
		try_send_bees_out()

	process_bee_objects()

/obj/structure/apiary/attack_hand(mob/user)
	. = ..()
	if(!stored_combs)
		return
	user.visible_message("[user] starts to collect combs from [src].", "You start to collect combs from [src]")
	if(!do_after(user, 2.5 SECONDS, src))
		return
	for(var/i=1 to stored_combs)
		new /obj/item/reagent_containers/food/snacks/spiderhoney/honey(get_turf(src))
	stored_combs = 0
	update_icon_state()
/obj/structure/apiary/proc/process_comb_gain()
	if(!pollen)
		return

	var/pollen_multi = CEILING(bee_count * 0.5, 1)
	var/pollen_to_process = min(pollen_multi, pollen)
	pollen -= pollen_to_process
	comb_progress += pollen_to_process

	if(comb_progress > 100)
		stored_combs = min(stored_combs + 1, 5)
		comb_progress -= 100
		update_icon_state()

	if(comb_progress > 100)
		comb_progress = 100

	if(stored_combs >= 5)
		pollen = 0

/obj/structure/apiary/proc/process_bee_objects()
	if(SSParticleWeather.runningWeather?.target_trait == PARTICLEWEATHER_RAIN)
		for(var/obj/effect/bees/bee in bee_objects)
			bee.return_to_hive(src)
		return

	for(var/obj/effect/bees/bee in bee_objects)
		if(bee.pollinating || bee.target)
			continue
		if(!bee.try_pollinate())
			give_bee_target()

/obj/structure/apiary/proc/try_send_bees_out()
	if(pollen && stored_combs < 5)
		return

	var/obj/effect/bees/new_bee = new(get_turf(src))
	if(length(bee_objects))
		for(var/obj/effect/bees/bee in bee_objects)
			if(bee.bee_count > 5)
				continue
			new_bee.merge_target = bee
			outside_bees++
			bee_count--
			return
	new_bee.hive = src
	outside_bees++
	bee_count--
	bee_objects += new_bee

/obj/structure/apiary/proc/give_bee_target()
	var/list/targets = list()
	for(var/obj/structure/soil/soil in view(7, src))
		if(!soil.plant)
			continue
		targets |= soil
	for(var/obj/structure/flora/grass/herb/herb in view(7, src))
		targets |= herb

	for(var/obj/effect/bees/bee in bee_objects)
		if(bee.pollinating || bee.target)
			continue
		bee.target = pick(targets)

/obj/structure/apiary/proc/try_create_bees()
	if(!comb_progress)
		return
	if((outside_bees + bee_count + sleeping_bees) > max_bees)
		return

	if(comb_progress < 10)
		return

	comb_progress -= 10
	bee_count++

/obj/structure/apiary/proc/on_bee_enter(amount)
	addtimer(CALLBACK(src, PROC_REF(finish_sleep), amount), 30 SECONDS)

/obj/structure/apiary/proc/finish_sleep(amount)
	sleeping_bees -= amount
	bee_count += amount
