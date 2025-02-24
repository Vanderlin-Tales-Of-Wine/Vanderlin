/obj/structure/fluff/millstone
	name = "millstone"
	desc = ""
	icon = 'icons/obj/rotation_machines.dmi'
	icon_state = "millstone6"
	density = TRUE
	anchored = TRUE
	blade_dulling = DULLING_BASH
	max_integrity = 400

	rotation_structure = TRUE
	stress_use = 64

	var/mill_progress = 0
	var/list/millable_contents = list()

/obj/structure/fluff/millstone/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/structure/fluff/millstone/Destroy()
	. = ..()
	STOP_PROCESSING(SSobj, src)
	for(var/obj/item/item in millable_contents)
		item.forceMove(get_turf(src))
		millable_contents -= item

/obj/structure/fluff/millstone/attackby(obj/item/W, mob/living/user, params)
	if(istype(W, /obj/item/reagent_containers/food/snacks))
		var/obj/item/reagent_containers/food/snacks/S = W
		if(S.mill_result)
			millable_contents += S
			S.forceMove(src)
			return
	..()

/obj/structure/fluff/millstone/attack_right(mob/living/carbon/human/user)
	. = ..()
	var/obj/item/item = input("Choose an item to remove") as anything in millable_contents
	if(!item)
		return
	if(QDELETED(item) || !(item in millable_contents))
		item.forceMove(get_turf(src))
		millable_contents -= item
		var/wound_prob = 60
		if(user.age == AGE_CHILD)
			wound_prob -= 20
		if(rotations_per_minute > 16 && prob(wound_prob))
			visible_message(span_warning("[user] gets their arm stuck in [src]!"), span_warning("You get your arm caught in [src]"))
			user.flash_fullscreen("redflash3")
			user.emote("painscream")
			user.take_overall_damage(4 + rotations_per_minute)

/obj/structure/fluff/millstone/attack_hand(mob/user)
	var/running = TRUE
	while(running)
		running = work_on_mill(user)
	..()


/obj/structure/fluff/millstone/set_rotations_per_minute(speed)
	. = ..()
	set_stress_use(64 * (speed / 8))

/obj/structure/fluff/millstone/update_animation_effect()
	if(!rotation_network || rotation_network?.overstressed || !rotations_per_minute)
		animate(src, icon_state = "millstone1", time = 1)
		return
	var/frame_stage = 1 / ((rotations_per_minute / 60) * 6)
	if(rotation_direction == WEST)
		animate(src, icon_state = "millstone1", time = frame_stage, loop=-1)
		animate(icon_state = "millstone2", time = frame_stage)
		animate(icon_state = "millstone3", time = frame_stage)
		animate(icon_state = "millstone4", time = frame_stage)
		animate(icon_state = "millstone5", time = frame_stage)
		animate(icon_state = "millstone6", time = frame_stage)
	else
		animate(src, icon_state = "millstone6", time = frame_stage, loop=-1)
		animate(icon_state = "millstone5", time = frame_stage)
		animate(icon_state = "millstone4", time = frame_stage)
		animate(icon_state = "millstone3", time = frame_stage)
		animate(icon_state = "millstone2", time = frame_stage)
		animate(icon_state = "millstone1", time = frame_stage)

/obj/structure/fluff/millstone/process()
	if(rotations_per_minute && !rotation_network.overstressed)
		work_on_mill(powered = TRUE)

/obj/structure/fluff/millstone/proc/work_on_mill(mob/living/user, powered = FALSE)
	if(!user && !powered)
		return
	if(!length(millable_contents))
		return
	playsound(src, 'sound/foley/milling.ogg', 100, TRUE, -1)
	if(powered)
		mill_progress += rotations_per_minute * 2
	else
		if(do_after(user, 2 SECONDS, src))
			mill_progress += 50
		else
			return FALSE

	if(mill_progress >= 100)
		mill_progress -= 100
		var/obj/item/reagent_containers/food/snacks/S = millable_contents[1]
		new S.mill_result(get_turf(loc))
		millable_contents -= S
		qdel(S)

	return TRUE
