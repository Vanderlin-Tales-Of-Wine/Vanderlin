/datum/ai_behavior/find_nest
	///range to look for the nest
	var/look_range = 5

/datum/ai_behavior/find_nest/perform(seconds_per_tick, datum/ai_controller/controller, nest_key, ignore_nest_key, found_nest, building_material_key)
	. = ..()

	var/mob/living_pawn = controller.pawn
	var/list/nest_types = controller.blackboard[nest_key]
	var/list/all_nests = list()
	var/list/ignore_types = controller.blackboard[ignore_nest_key]

	if(!length(nest_types))
		finish_action(controller, FALSE)
		return

	var/list/nearby_stuff = oview(look_range, living_pawn)
	for(var/obj/structure/fluff/nest/nest in nearby_stuff)
		if(!is_type_in_list(nest, nest_types))
			continue
		if(is_type_in_list(nest, ignore_types)) //so the not permanent baby and the permanent baby subtype dont followed each other
			continue
		if(locate(/mob/living/simple_animal/hostile/retaliate/chicken) in nest.loc) //this means we need to have the chicken vacate the area to prevent chickens never moving
			continue
		all_nests += nest

	if(length(all_nests))
		var/obj/structure/fluff/nest/nest = pick(all_nests)
		controller.set_blackboard_key(found_nest, nest)
		finish_action(controller, TRUE)
		return
	else
		var/list/building_material = controller.blackboard[building_material_key]
		for(var/atom/movable/movable_atom as anything in nearby_stuff)
			if(!is_type_in_list(movable_atom, building_material))
				continue
			controller.set_blackboard_key(found_nest, movable_atom)
			finish_action(controller, TRUE)
			return

	finish_action(controller, FALSE)
