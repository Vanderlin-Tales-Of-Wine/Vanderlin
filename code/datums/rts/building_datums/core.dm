/obj/structure/heart_of_nature
	name = "heart of the forest"
	desc = "A mystical tree home of the fae"

	icon = 'icons/obj/structures/sakura_tree.dmi'
	icon_state = "sakura_tree"
	obj_flags = CAN_BE_HIT | IGNORE_SINK

	bound_height = 128
	bound_width = 128

	SET_BASE_PIXEL(-64, 0)

/datum/building_datum/core
	name = "World Core"
	desc = "The heart of civilization. This mystical structure serves as the foundation for all development."
	building_template = "core_template" // You'll need to create this template
	build_time = 0 // Instant build
	workers_required = 0 // No workers needed

	ui_icon = 'icons/roguetown/items/natural.dmi'
	ui_icon_state = "meld"

	resource_cost = list(
		MAT_STONE = 0,
		MAT_WOOD = 0,
		MAT_GEM = 0,
		MAT_ORE = 0,
		MAT_INGOT = 0,
		MAT_COAL = 0,
		MAT_GRAIN = 0,
		MAT_MEAT = 0,
		MAT_VEG = 0,
		MAT_FRUIT = 0,
	)

/datum/building_datum/core/try_place_building(mob/camera/strategy_controller/user, turf/placed_turf)
	if(user.has_core)
		user.visible_message("A World Core already exists! Only one can be built.")
		return FALSE
	if(!..())
		return FALSE

	construct_building()
	return TRUE

/datum/building_datum/core/resource_check(mob/camera/strategy_controller/user)
	if(user.has_core)
		return FALSE
	. = ..()

/datum/building_datum/core/construct_building()
	master.has_core = TRUE
	..()

	if(generated_MA)
		generated_MA.moveToNullspace()
		qdel(generated_MA)

/datum/building_datum/core/after_construction()
	var/turf/spawn_turf = get_step(center_turf, pick(GLOB.cardinals))
	if(!spawn_turf)
		spawn_turf = center_turf

	master.create_new_worker_mob(spawn_turf)
	if(!master.resource_stockpile)
		master.resource_stockpile = new /datum/stockpile()
	master.resource_stockpile.add_resources(list(
		MAT_STONE = 10,
		MAT_WOOD = 10,
		MAT_GRAIN = 5
	))
	master.visible_message("The World Core pulses with energy! Your civilization begins...")

/mob/camera/strategy_controller
	var/has_core = FALSE
