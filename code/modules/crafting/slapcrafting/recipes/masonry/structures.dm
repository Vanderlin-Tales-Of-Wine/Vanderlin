/datum/slapcraft_recipe/masonry/structure/smelter
	name = "ore furnace"
	steps = list(
		/datum/slapcraft_step/item/coal,
		/datum/slapcraft_step/item/stone,
		/datum/slapcraft_step/item/stone/second,
		/datum/slapcraft_step/item/stone/third,
		/datum/slapcraft_step/item/stone/fourth,
		)
	result_type = /obj/machinery/light/fueled/smelter

/datum/slapcraft_recipe/masonry/structure/great_smelter
	name = "great furnace"
	steps = list(
		/datum/slapcraft_step/item/iron,
		/datum/slapcraft_step/item/iron/second,
		/datum/slapcraft_step/item/riddleofsteel,
		/datum/slapcraft_step/use_item/masonry/hammer,
		/datum/slapcraft_step/item/coal,
		)
	result_type = /obj/machinery/light/fueled/smelter/great

/datum/slapcraft_recipe/masonry/structure/forge
	name = "forge"
	steps = list(
		/datum/slapcraft_step/item/coal,
		/datum/slapcraft_step/item/stone,
		/datum/slapcraft_step/item/stone/second,
		/datum/slapcraft_step/item/stone/third,
		/datum/slapcraft_step/item/stone/fourth,
		/datum/slapcraft_step/item/small_log,
		)
	result_type = /obj/machinery/light/fueled/forge

/datum/slapcraft_recipe/masonry/structure/sharp_wheel
	name = "sharpening wheel"
	steps = list(
		/datum/slapcraft_step/item/stone,
		/datum/slapcraft_step/item/iron,
		)
	result_type = /obj/structure/grindwheel

/datum/slapcraft_recipe/masonry/structure/oven
	name = "oven"
	steps = list(
		/datum/slapcraft_step/item/small_log,
		/datum/slapcraft_step/item/stone,
		/datum/slapcraft_step/item/stone/second,
		/datum/slapcraft_step/item/stone/third,
		/datum/slapcraft_step/use_item/masonry/hammer,
		)
	result_type = /obj/machinery/light/fueled/oven

//Oven will shift icon based on dir
/datum/slapcraft_recipe/masonry/structure/oven/check_craft_requirements(mob/user, turf/T)
	var/turf/check_turf = get_step(T, user.dir)
	if(!isclosedturf(check_turf))
		return FALSE
	return TRUE

/datum/slapcraft_recipe/masonry/structure/stonedoor
	name = "stone door"
	steps = list(
		/datum/slapcraft_step/item/stone,
		/datum/slapcraft_step/item/stone/second,
		/datum/slapcraft_step/use_item/masonry/hammer
	)
	result_type = /obj/structure/door/stone

/datum/slapcraft_recipe/masonry/structure/stonetable_small
	name = "stone table"
	steps = list(
		/datum/slapcraft_step/item/stone,
		/datum/slapcraft_step/use_item/masonry/hammer,
		/datum/slapcraft_step/item/stone/second,
		/datum/slapcraft_step/use_item/masonry/hammer/second
	)
	result_type = /obj/structure/table/stone_small
	craftdiff = 0

/datum/slapcraft_recipe/masonry/structure/cauldron
	name = "cauldron"
	steps = list(
		/datum/slapcraft_step/item/iron,
		/datum/slapcraft_step/use_item/masonry/hammer,
		/datum/slapcraft_step/item/stone,
		/datum/slapcraft_step/item/stone/second,
		/datum/slapcraft_step/item/stone/third,
		/datum/slapcraft_step/use_item/masonry/hammer/second,
		/datum/slapcraft_step/item/small_log,
		)
	result_type = /obj/machinery/light/fueled/cauldron

/datum/slapcraft_recipe/masonry/structure/stonestairsd
	name = "stone stairs (down)"
	steps = list(
		/datum/slapcraft_step/item/stone,
		/datum/slapcraft_step/item/stone/second,
		/datum/slapcraft_step/use_item/masonry/hammer
		)
	result_type = /obj/structure/stairs/stone/d

/datum/slapcraft_recipe/masonry/structure/stonestairsd/check_craft_requirements(mob/user, turf/T)
	var/turf/checking = get_step(T, user.dir)
	if(!checking)
		return FALSE
	if(!istype(checking,/turf/open/transparent/openspace))
		return FALSE
	checking = get_step_multiz(checking, DOWN)
	if(!checking)
		return FALSE
	if(!isopenturf(checking))
		return FALSE
	if(istype(checking,/turf/open/transparent/openspace))
		return FALSE
	for(var/obj/structure/S in checking)
		if(S.density)
			return FALSE
	return TRUE

/datum/slapcraft_recipe/masonry/structure/stonerailing
	name = "stone railing"
	steps = list(
		/datum/slapcraft_step/item/stone,
		/datum/slapcraft_step/use_item/masonry/hammer
		)
	result_type = /obj/structure/fluff/railing/stonehedge
	craftdiff = 0
	offset_user = TRUE

/datum/slapcraft_recipe/masonry/structure/stonerailing/check_craft_requirements(mob/user, turf/T)
	for(var/obj/structure/S in T)
		if(istype(S, /obj/structure/fluff/railing))
			if(user.dir == S.dir)
				return FALSE
	return ..()

/datum/slapcraft_recipe/masonry/structure/stained_window
	name = "stained glass window (psycross silver)"
	steps = list(
		/datum/slapcraft_step/item/silver,
		/datum/slapcraft_step/use_item/masonry/hammer,
		/datum/slapcraft_step/item/stone,
		/datum/slapcraft_step/item/stone/second,
		/datum/slapcraft_step/item/stone/third,
		/datum/slapcraft_step/use_item/masonry/hammer/second,
		/datum/slapcraft_step/item/glass,
		/datum/slapcraft_step/item/glass/second,
		)
	result_type = /obj/structure/window/stained/silver
	craftdiff = 2

/datum/slapcraft_recipe/masonry/structure/stained_window
	name = "stained glass window (silver)"
	steps = list(
		/datum/slapcraft_step/item/silver,
		/datum/slapcraft_step/use_item/masonry/hammer,
		/datum/slapcraft_step/item/stone,
		/datum/slapcraft_step/item/stone/second,
		/datum/slapcraft_step/item/stone/third,
		/datum/slapcraft_step/use_item/masonry/hammer/second,
		/datum/slapcraft_step/item/glass,
		/datum/slapcraft_step/item/glass/second,
		)
	result_type = /obj/structure/window/stained/silver/alt
	craftdiff = 2

/datum/slapcraft_recipe/masonry/structure/stained_window
	name = "stained glass window (psycross gold)"
	steps = list(
		/datum/slapcraft_step/item/gold,
		/datum/slapcraft_step/use_item/masonry/hammer,
		/datum/slapcraft_step/item/stone,
		/datum/slapcraft_step/item/stone/second,
		/datum/slapcraft_step/item/stone/third,
		/datum/slapcraft_step/use_item/masonry/hammer/second,
		/datum/slapcraft_step/item/glass,
		/datum/slapcraft_step/item/glass/second,
		)
	result_type = /obj/structure/window/stained/yellow
	craftdiff = 2

/datum/slapcraft_recipe/masonry/structure/windowopen
	name = "openable glass window"
	steps = list(
		/datum/slapcraft_step/item/iron,
		/datum/slapcraft_step/use_item/masonry/hammer,
		/datum/slapcraft_step/item/plank,
		/datum/slapcraft_step/item/plank/second,
		/datum/slapcraft_step/use_item/masonry/hammer/second,
		/datum/slapcraft_step/item/glass,
		)
	result_type = /obj/structure/window/openclose

/datum/slapcraft_recipe/masonry/structure/window
	name = "solid glass window"
	steps = list(
		/datum/slapcraft_step/item/plank,
		/datum/slapcraft_step/item/plank/second,
		/datum/slapcraft_step/use_item/masonry/hammer,
		/datum/slapcraft_step/item/glass,
		)
	result_type = /obj/structure/window/solid
