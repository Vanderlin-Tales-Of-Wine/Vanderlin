/datum/ai_planning_subtree/lay_egg
	///how far we must be from the mom
	var/minimum_distance = 0

/datum/ai_planning_subtree/lay_egg/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/obj/structure/fluff/nest/target = controller.blackboard[BB_NESTBOX]
	var/mob/living/simple_animal/hostile/retaliate/chicken/baby = controller.pawn
	if(baby.production < 29 || baby.stat != CONSCIOUS || !baby.egg_type || !isturf(baby.loc))
		return
	if(controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET])
		return

	if(QDELETED(target))
		controller.queue_behavior(/datum/ai_behavior/find_nest, BB_NEST_LIST, BB_NEST_IGNORE_LIST, BB_NESTBOX, BB_NEST_MATERIAL_LIST)
		return

	if(get_dist(target, baby) > minimum_distance)
		controller.queue_behavior(/datum/ai_behavior/travel_towards, BB_NESTBOX)
		return SUBTREE_RETURN_FINISH_PLANNING

	if(is_type_in_list(target, controller.blackboard[BB_NEST_MATERIAL_LIST]))
		controller.queue_behavior(/datum/ai_behavior/build_nest, BB_NESTBOX, BB_NEST_MATERIAL_LIST)
		return SUBTREE_RETURN_FINISH_PLANNING

	if(!SPT_PROB(15, seconds_per_tick))
		return

	for(var/obj/item/reagent_containers/food/snacks/egg/egg in target.loc)
		if(!egg.fertile)
			continue
		controller.queue_behavior(/datum/ai_behavior/incubate_egg)
		return SUBTREE_RETURN_FINISH_PLANNING

	controller.queue_behavior(/datum/ai_behavior/lay_egg)
	return SUBTREE_RETURN_FINISH_PLANNING
