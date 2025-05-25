/// Attack something which is already adjacent to us without moving
/datum/ai_behavior/basic_melee_attack/opportunistic
	action_cooldown = 0.2 SECONDS // We gotta check unfortunately often because we're in a race condition with nextmove
	behavior_flags = AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION

/datum/ai_behavior/basic_melee_attack/opportunistic/setup(datum/ai_controller/controller, target_key, targeting_strategy_key, hiding_location_key)
	if (!controller.blackboard_key_exists(targeting_strategy_key))
		CRASH("No target datum was supplied in the blackboard for [controller.pawn]")
	return controller.blackboard_key_exists(target_key)

/datum/ai_behavior/basic_melee_attack/opportunistic/perform(seconds_per_tick, datum/ai_controller/controller, target_key, targeting_strategy_key, hiding_location_key)
	var/atom/movable/atom_pawn = controller.pawn
	if(!atom_pawn.CanReach(controller.blackboard[target_key]))
		finish_action(controller, TRUE, target_key) // Don't clear target
		return FALSE
	. = ..()
	finish_action(controller, TRUE, target_key) // Try doing something else


/datum/ai_behavior/basic_melee_attack/opportunistic_watcher/perform(seconds_per_tick, datum/ai_controller/controller, target_key, targeting_strategy_key, hiding_location_key)
	var/atom/movable/atom_pawn = controller.pawn
	if(!atom_pawn.CanReach(controller.blackboard[target_key]))
		finish_action(controller, TRUE, target_key) // Don't clear target
		return FALSE
	. = ..()
	for(var/t in RANGE_TURFS(1, controller.pawn))
		new /obj/effect/hotspot(t)
		controller.pawn.visible_message(span_danger("[controller.pawn] emits a burst of flames from it's core!"))
