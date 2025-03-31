/datum/ai_planning_subtree/equip_item

/datum/ai_planning_subtree/equip_item/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/atom/target = controller.blackboard[BB_MOB_EQUIP_TARGET]
	if(!target)
		return

	controller.queue_behavior(/datum/ai_behavior/equip_target, BB_MOB_EQUIP_TARGET)
