
/obj/machinery/anvil
	icon = 'icons/roguetown/misc/forge.dmi'
	name = "anvil"
	icon_state = "anvil"
	var/hott = 0
	var/obj/item/ingot/hingot
	max_integrity = 2000
	density = TRUE
	damage_deflection = 25
	climbable = TRUE
	var/previous_material_quality = 0
	var/cool_time = 10 SECONDS

/obj/machinery/anvil/crafted
	icon_state = "caveanvil"

/obj/machinery/anvil/examine(mob/user)
	. = ..()
	if(hingot && hott)
		. += "<span class='warning'>[hingot] is too hot to touch.</span>"

/obj/machinery/anvil/attackby(obj/item/W, mob/living/user, params)
	if(istype(W, /obj/item/rogueweapon/tongs))
		var/obj/item/rogueweapon/tongs/T = W
		if(hingot)
			if(T.hingot)
				if(hingot.currecipe && hingot.currecipe.needed_item && istype(T.hingot, hingot.currecipe.needed_item))
					hingot.currecipe.item_added(user)
					qdel(T.hingot)
					T.hingot = null
					T.update_icon()
					update_icon()
				return
			else
				hingot.forceMove(T)
				T.hingot = hingot
				hingot = null
				T.update_icon()
				update_icon()
				return
		else
			if(T.hingot && istype(T.hingot, /obj/item/ingot))
				T.hingot.forceMove(src)
				hingot = T.hingot
				T.hingot = null
				hott = T.hott
				if(hott)
					START_PROCESSING(SSmachines, src)
				T.update_icon()
				update_icon()
				return

	if(istype(W, /obj/item/ingot))
		if(!hingot)
			W.forceMove(src)
			hingot = W
			hott = 0
			update_icon()
			return

	if(istype(W, /obj/item/rogueweapon/hammer))
		var/obj/item/rogueweapon/hammer/hammer = W
		if(!hammer.can_smith)
			return
		user.changeNext_move(CLICK_CD_MELEE)
		if(!hingot)
			return
		if(!hott)
			to_chat(user, "<span class='warning'>The bar has gone too cold to continue working on it.</span>")
			return
		if(!hingot.currecipe)
			if(!choose_recipe(user))
				return
			user.flash_fullscreen("whiteflash")
			shake_camera(user, 1, 1)
			playsound(src,pick('sound/items/bsmith1.ogg','sound/items/bsmith2.ogg','sound/items/bsmith3.ogg','sound/items/bsmith4.ogg'), 100, FALSE)
		var/used_str = user.STASTR
		if(iscarbon(user))
			var/mob/living/carbon/C = user
			if(C.domhand)
				used_str = C.get_str_arms(C.used_hand)
			C.adjust_stamina(max(30 - (used_str * 3), 0))
		var/total_chance = 7 * user.mind.get_skill_level(hingot.currecipe.appro_skill)
		var/breakthrough = 0
		if(prob(1 + total_chance))
			user.flash_fullscreen("whiteflash")
			var/datum/effect_system/spark_spread/S = new()
			var/turf/front = get_turf(src)
			S.set_up(1, 1, front)
			S.start()
			breakthrough = 1
			hingot.currecipe.numberofbreakthroughs++

		if(!hingot.currecipe.advance(user, breakthrough))
			shake_camera(user, 1, 1)
			playsound(src,'sound/items/bsmithfail.ogg', 100, FALSE)

		playsound(src,pick('sound/items/bsmith1.ogg','sound/items/bsmith2.ogg','sound/items/bsmith3.ogg','sound/items/bsmith4.ogg'), 100, FALSE)

		for(var/mob/M in GLOB.player_list)
			if(!is_in_zweb(M.z,src.z))
				continue
			var/turf/M_turf = get_turf(M)
			var/far_smith_sound = sound(pick('sound/items/smithdist1.ogg','sound/items/smithdist2.ogg','sound/items/smithdist3.ogg'))
			if(M_turf)
				var/dist = get_dist(M_turf, loc)
				if(dist < 7)
					continue
				M.playsound_local(M_turf, null, 100, 1, get_rand_frequency(), falloff = 5, S = far_smith_sound)

		return

	if(hingot && hingot.currecipe && hingot.currecipe.needed_item && istype(W, hingot.currecipe.needed_item))
		hingot.currecipe.item_added(user)
		if(istype(W, /obj/item/ingot))
			var/obj/item/ingot/I = W
			hingot.currecipe.material_quality += I.quality
			previous_material_quality = I.quality
		else
			hingot.currecipe.material_quality += previous_material_quality
		hingot.currecipe.num_of_materials += 1
		qdel(W)
		return

	if(W.anvilrepair)
		user.visible_message("<span class='info'>[user] places \a [W] on the anvil.</span>")
		W.forceMove(src.loc)
		return
	..()

/obj/machinery/anvil/proc/choose_recipe(user)
	if(!hingot || !hott)
		return

	var/list/valid_types = list()
	for(var/datum/anvil_recipe/R in GLOB.anvil_recipes)
		if(istype(hingot, R.req_bar))
			if(!valid_types.Find(R.i_type))
				valid_types += R.i_type

	if(!valid_types.len)
		return

	var/i_type_choice = input(user, "Choose a category", "Anvil") as null|anything in valid_types
	if(!i_type_choice)
		return

	var/list/appro_recipe = list()
	for(var/datum/anvil_recipe/R in GLOB.anvil_recipes)
		if(R.i_type == i_type_choice && istype(hingot, R.req_bar))
			appro_recipe += R

	for(var/I in appro_recipe)
		var/datum/anvil_recipe/R = I
		if(!R.req_bar)
			appro_recipe -= R
		if(!istype(hingot, R.req_bar))
			appro_recipe -= R

	if(appro_recipe.len)
		var/datum/chosen_recipe = input(user, "Choose what to start working on:", "Anvil") as null|anything in sortNames(appro_recipe.Copy())
		if(!hingot.currecipe && chosen_recipe)
			hingot.currecipe = new chosen_recipe.type(hingot)
			hingot.currecipe.material_quality += hingot.quality
			previous_material_quality = hingot.quality
			return TRUE

	return FALSE

/obj/machinery/anvil/attack_hand(mob/user, params)
	if(hingot)
		if(hott)
			to_chat(user, "<span class='warning'>It's too hot to handle with your hands.</span>")
			return
		else
			var/obj/item/I = hingot
			hingot = null
			I.loc = user.loc
			user.put_in_active_hand(I)
			update_icon()

/obj/machinery/anvil/process()
	if(hott)
		if(world.time > hott + cool_time)
			hott = 0
			STOP_PROCESSING(SSmachines, src)
	else
		STOP_PROCESSING(SSmachines, src)
	update_icon()

/obj/machinery/anvil/update_icon()
	cut_overlays()
	if(hingot)
		var/obj/item/I = hingot
		I.pixel_x = 0
		I.pixel_y = 0
		var/mutable_appearance/M = new /mutable_appearance(I)
		if(hott)
			M.filters += filter(type="color", color = list(3,0,0,1, 0,2.7,0,0.4, 0,0,1,0, 0,0,0,1))
		M.transform *= 0.5
		M.pixel_y = 5
		M.pixel_x = 3
		add_overlay(M)
