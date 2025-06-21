/datum/ai_behavior/build_nest

/datum/ai_behavior/build_nest/perform(seconds_per_tick, datum/ai_controller/controller, found_nest, building_material_key)
	. = ..()

	var/mob/living/simple_animal/hostile/retaliate/chicken/living_pawn = controller.pawn
	var/obj/target = controller.blackboard[found_nest]
	var/list/building_material = controller.blackboard[building_material_key]

	if(!istype(living_pawn))
		return
	if(!is_type_in_list(target, building_material)) // sanity check before qdeling
		controller.clear_blackboard_key(found_nest)
		return

	if(living_pawn.production < 29)
		finish_action(controller, FALSE)
		return

	controller.clear_blackboard_key(found_nest)
	qdel(target)
	var/obj/structure/fluff/nest/new_nest = new /obj/structure/fluff/nest(living_pawn.loc)
	living_pawn.visible_message(span_notice("[living_pawn] builds a nest."))

	controller.set_blackboard_key(found_nest, new_nest)
	finish_action(controller, TRUE)
