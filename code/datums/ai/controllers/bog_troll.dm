/datum/ai_controller/bog_troll
	movement_delay = 0.7 SECONDS

	ai_movement = /datum/ai_movement/basic_avoidance

	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic/allow_items()

	)

	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target/bog_troll,
		/datum/ai_planning_subtree/basic_melee_attack_subtree/bog_troll,

		/datum/ai_planning_subtree/find_dead_bodies/bog_troll,
		/datum/ai_planning_subtree/eat_dead_body/bog_troll,
		/datum/ai_planning_subtree/no_target_hide,
	)

	idle_behavior = /datum/idle_behavior/nothing
