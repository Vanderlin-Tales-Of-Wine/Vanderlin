/datum/ai_planning_subtree/find_valid_home

/datum/ai_planning_subtree/find_valid_home/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	var/obj/structure/current_home = controller.blackboard[BB_CURRENT_HOME]

	if(QDELETED(current_home))
		controller.queue_behavior(/datum/ai_behavior/find_and_set/home, BB_CURRENT_HOME, controller.blackboard[BB_HOME_PATH])
		return

	return
