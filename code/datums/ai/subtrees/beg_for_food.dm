/datum/ai_planning_subtree/beg_human

/datum/ai_planning_subtree/beg_human/SelectBehaviors(datum/ai_controller/controller, seconds_per_tick)
	if(istype(controller.pawn, /mob/living/simple_animal/hostile/retaliate))
		var/mob/living/simple_animal/hostile/retaliate/mob = controller.pawn
		if((mob.food >= (mob.food_max * 0.25)) && !mob.eat_forever)
			return // not hungry

	if(controller.blackboard_key_exists(BB_HUMAN_BEG_TARGET))
		controller.queue_behavior(/datum/ai_behavior/beacon_for_food, BB_HUMAN_BEG_TARGET, BB_HUNGRY_MEOW)
		return

	controller.queue_behavior(/datum/ai_behavior/find_and_set/human_beg, BB_HUMAN_BEG_TARGET, /mob/living/carbon/human)

/datum/ai_behavior/find_and_set/human_beg/search_tactic(datum/ai_controller/controller, locate_path, search_range)
	var/list/locate_items = controller.blackboard[BB_BASIC_FOODS]
	for(var/mob/living/carbon/human/human_target in oview(search_range, controller.pawn))
		if(human_target.stat != CONSCIOUS || isnull(human_target.mind))
			continue
		if(!length(typecache_filter_list(human_target.held_items, locate_items)))
			continue
		return human_target

	return null

/datum/ai_behavior/beacon_for_food
	action_cooldown = 5 SECONDS
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_MOVE_AND_PERFORM | AI_BEHAVIOR_CAN_PLAN_DURING_EXECUTION
	required_distance = 2

/datum/ai_behavior/beacon_for_food/setup(datum/ai_controller/controller, target_key, meows_key)
	. = ..()
	var/atom/target = controller.blackboard[target_key]
	if(QDELETED(target))
		return FALSE
	set_movement_target(controller, (target))

/datum/ai_behavior/beacon_for_food/perform(seconds_per_tick, datum/ai_controller/controller, target_key, meows_key)
	. = ..()
	var/atom/target = controller.blackboard[target_key]
	if(QDELETED(target))
		finish_action(controller, FALSE, target_key)
	var/mob/living/living_pawn = controller.pawn
	var/list/meowing_list = controller.blackboard[meows_key]
	if(length(meowing_list))
		living_pawn.say(pick(meowing_list), forced = "ai_controller")
	finish_action(controller, TRUE, target_key)

/datum/ai_behavior/beacon_for_food/finish_action(datum/ai_controller/controller, success, target_key)
	. = ..()
	controller.clear_blackboard_key(target_key)
