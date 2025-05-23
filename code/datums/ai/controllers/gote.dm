/datum/ai_controller/gote
	movement_delay = 0.5 SECONDS

	ai_movement = /datum/ai_movement/hybrid_pathing

	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic/allow_items(),
		BB_PET_TARGETING_DATUM = new /datum/targetting_datum/basic/not_friends(),
		BB_BABIES_PARTNER_TYPES = list(/mob/living/simple_animal/hostile/retaliate/goat, /mob/living/simple_animal/hostile/retaliate/goatmale),
		BB_BABIES_CHILD_TYPES = list(/mob/living/simple_animal/hostile/retaliate/goat/goatlet = 90, /mob/living/simple_animal/hostile/retaliate/goat/goatlet/boy = 10),
	)

	planning_subtrees = list(
		/datum/ai_planning_subtree/pet_planning,
		/datum/ai_planning_subtree/make_babies,
		/datum/ai_planning_subtree/target_retaliate,
		/datum/ai_planning_subtree/find_food,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
	)

	idle_behavior = /datum/idle_behavior/idle_random_walk
