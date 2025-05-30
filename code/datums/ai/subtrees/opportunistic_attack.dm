/// Attack something which is already adjacent to us, without ending planning
/datum/ai_planning_subtree/basic_melee_attack_subtree/opportunistic
	melee_attack_behavior = /datum/ai_behavior/basic_melee_attack/opportunistic
	end_planning = FALSE

/datum/ai_planning_subtree/basic_melee_attack_subtree/opportunistic/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	. = ..()
	var/atom/target = controller.blackboard[BB_BASIC_MOB_CURRENT_TARGET]
	if(QDELETED(target) || !controller.pawn.Adjacent(target))
		return
	controller.queue_behavior(melee_attack_behavior, BB_BASIC_MOB_CURRENT_TARGET, BB_TARGETTING_DATUM, BB_BASIC_MOB_CURRENT_TARGET_HIDING_LOCATION)

/// Attack something which is already adjacent to us, without ending planning
/datum/ai_planning_subtree/basic_melee_attack_subtree/opportunistic_watcher
	melee_attack_behavior = /datum/ai_behavior/basic_melee_attack/opportunistic_watcher
	end_planning = FALSE
