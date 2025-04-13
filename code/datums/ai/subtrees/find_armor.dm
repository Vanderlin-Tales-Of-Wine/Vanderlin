/datum/ai_planning_subtree/find_armor
	var/vision_range = 9

/datum/ai_planning_subtree/find_armor/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/atom/target = controller.blackboard[BB_MOB_EQUIP_TARGET]
	if(!QDELETED(target))
		// Busy with something
		return

	controller.queue_behavior(/datum/ai_behavior/find_and_set/armor, BB_MOB_EQUIP_TARGET, null, vision_range)
