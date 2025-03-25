/// Try to line up with a cardinal direction of your target
/datum/ai_planning_subtree/move_to_cardinal
	/// Behaviour to execute to line ourselves up
	var/move_behaviour = /datum/ai_behavior/move_to_cardinal
	/// Blackboard key in which to store selected target
	var/target_key = BB_BASIC_MOB_CURRENT_TARGET

/datum/ai_planning_subtree/move_to_cardinal/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	if(!controller.blackboard_key_exists(target_key))
		return
	controller.queue_behavior(move_behaviour, target_key)
