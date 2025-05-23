/datum/ai_controller/basic_controller/dryad
	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic(),
		BB_PET_TARGETING_DATUM = new /datum/targetting_datum/basic/not_friends(),
		BB_SHROOM_COOLDOWN = 0,
	)

	planning_subtrees = list(
		/datum/ai_planning_subtree/pet_planning,
		/datum/ai_planning_subtree/aggro_find_target,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
		/datum/ai_planning_subtree/sylph_special_abilities,
	)

	idle_behavior = /datum/idle_behavior/idle_random_walk
