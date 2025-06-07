/datum/ai_controller/basic_controller/gnome_homunculus
	max_target_distance = 300 //we want them to realistically be able to path literally everywhere

	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic(),
		BB_PET_TARGETING_DATUM = new /datum/targetting_datum/basic(),
		BB_GNOME_WAYPOINT_A = null,
		BB_GNOME_WAYPOINT_B = null,
		BB_GNOME_HOME_TURF = null,
		BB_SIMPLE_CARRY_ITEM = null,
		BB_GNOME_TRANSPORT_MODE = FALSE,
		BB_GNOME_TRANSPORT_SOURCE = null,
		BB_GNOME_TRANSPORT_DEST = null,
		BB_GNOME_SPLITTER_MODE = FALSE,
		BB_GNOME_TARGET_SPLITTER = null,
		BB_GNOME_FOUND_ITEM = null,
		BB_GNOME_CROP_MODE = FALSE,
		BB_GNOME_WATER_SOURCE = null,
		BB_GNOME_SEED_SOURCE = null,
		BB_GNOME_ALCHEMY_MODE = FALSE,
		BB_GNOME_TARGET_CAULDRON = null,
		BB_GNOME_TARGET_WELL = null,
		BB_GNOME_CURRENT_RECIPE = null,
		BB_GNOME_ALCHEMY_STATE = ALCHEMY_STATE_IDLE,
		BB_GNOME_ESSENCE_STORAGE = null,
		BB_GNOME_BOTTLE_STORAGE = null,
		BB_GNOME_SEARCH_RANGE = 1,
	)

	ai_traits = STOP_MOVING_WHEN_PULLED
	ai_movement = /datum/ai_movement/hybrid_pathing/gnome
	idle_behavior = /datum/idle_behavior/idle_random_walk

	planning_subtrees = list(
		/datum/ai_planning_subtree/pet_planning/gnome_automation,
	)

/datum/ai_controller/basic_controller/gnome_homunculus/TryPossessPawn(atom/new_pawn)
	. = ..()
	if(. & AI_CONTROLLER_INCOMPATIBLE)
		return
	RegisterSignal(new_pawn, COMSIG_PARENT_EXAMINE, PROC_REF(on_examine))

/datum/ai_controller/basic_controller/gnome_homunculus/proc/on_examine(atom/source, mob/user, list/examine_list)
	SIGNAL_HANDLER
	var/mob/living/simple_animal/hostile/gnome_homunculus/gnome = source
	var/obj/item/carried_item = blackboard[BB_SIMPLE_CARRY_ITEM]
	if(carried_item)
		examine_list += span_notice("It is carrying [carried_item].")
	if(length(gnome.waypoints))
		examine_list += span_notice("It has [length(gnome.waypoints)] waypoint[length(gnome.waypoints) > 1 ? "s" : ""] set.")


/datum/ai_planning_subtree/pet_planning/gnome_automation

/datum/ai_planning_subtree/pet_planning/gnome_automation/SelectBehaviors(datum/ai_controller/controller, delta_time)
	if(controller.blackboard[BB_GNOME_CROP_MODE])
		controller.queue_behavior(/datum/ai_behavior/gnome_crop_tending)
		return SUBTREE_RETURN_FINISH_PLANNING
	if(controller.blackboard[BB_GNOME_ALCHEMY_MODE])
		controller.queue_behavior(/datum/ai_behavior/gnome_alchemy_cycle)
		return SUBTREE_RETURN_FINISH_PLANNING
	if(controller.blackboard[BB_GNOME_TRANSPORT_MODE])
		controller.queue_behavior(/datum/ai_behavior/gnome_transport_cycle)
		return SUBTREE_RETURN_FINISH_PLANNING

	if(controller.blackboard[BB_GNOME_SPLITTER_MODE])
		controller.queue_behavior(/datum/ai_behavior/gnome_splitter_cycle)
		return SUBTREE_RETURN_FINISH_PLANNING

	var/turf/home_turf = controller.blackboard[BB_GNOME_HOME_TURF]
	if(home_turf)
		var/mob/living/pawn = controller.pawn
		if(get_turf(pawn) != home_turf)
			controller.queue_behavior(/datum/ai_behavior/gnome/return_home)
			return SUBTREE_RETURN_FINISH_PLANNING

	var/datum/pet_command/active_command = controller.blackboard[BB_ACTIVE_PET_COMMAND]
	if(active_command)
		active_command.execute_action(controller)
		return SUBTREE_RETURN_FINISH_PLANNING
