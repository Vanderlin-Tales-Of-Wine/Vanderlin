/datum/pet_command/gnome/use_splitter
	command_name = "Use Splitter"
	command_desc = "Grab items from waypoint A and process them in the splitter"
	radial_icon_state = "split"
	speech_commands = list("split", "process", "use splitter", "extract")
	requires_pointing = TRUE
	pointed_reaction = "and focuses on the splitter"

/datum/pet_command/gnome/use_splitter/look_for_target(mob/living/pointing_friend, atom/pointed_atom)
	if(!istype(pointed_atom, /obj/machinery/essence/splitter))
		return FALSE
	return ..()

/datum/pet_command/gnome/use_splitter/execute_action(datum/ai_controller/controller)
	var/turf/waypoint_a = controller.blackboard[BB_GNOME_WAYPOINT_A]
	var/obj/machinery/essence/splitter/target_splitter = controller.blackboard[BB_CURRENT_PET_TARGET]

	if(!waypoint_a)
		var/mob/living/pawn = controller.pawn
		pawn.visible_message(span_warning("[pawn] beeps confusedly - no source waypoint set!"))
		controller.clear_blackboard_key(BB_ACTIVE_PET_COMMAND)
		return

	if(!target_splitter)
		return

	controller.set_blackboard_key(BB_GNOME_SPLITTER_MODE, TRUE)
	controller.set_blackboard_key(BB_GNOME_TARGET_SPLITTER, target_splitter)
	controller.clear_blackboard_key(BB_ACTIVE_PET_COMMAND)

/datum/ai_behavior/gnome_splitter_cycle
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_REQUIRE_REACH

/datum/ai_behavior/gnome_splitter_cycle/setup(datum/ai_controller/controller)
	. = ..()
	var/obj/item/carried_item = controller.blackboard[BB_SIMPLE_CARRY_ITEM]
	var/obj/machinery/essence/splitter/target_splitter = controller.blackboard[BB_GNOME_TARGET_SPLITTER]

	if(!target_splitter)
		return FALSE

	if(carried_item)
		set_movement_target(controller, target_splitter)
	else
		var/obj/item/found_item = find_splitter_item(controller)
		if(!found_item)
			return FALSE
		controller.set_blackboard_key(BB_GNOME_FOUND_ITEM, found_item)
		set_movement_target(controller, found_item)

	return TRUE

/datum/ai_behavior/gnome_splitter_cycle/perform(delta_time, datum/ai_controller/controller)
	. = ..()
	var/obj/item/carried_item = controller.blackboard[BB_SIMPLE_CARRY_ITEM]
	var/mob/living/pawn = controller.pawn
	var/obj/machinery/essence/splitter/target_splitter = controller.blackboard[BB_GNOME_TARGET_SPLITTER]

	if(!target_splitter)
		finish_action(controller, FALSE)
		return

	if(carried_item && get_dist(pawn, target_splitter) <= 1)
		if(target_splitter.processing)
			finish_action(controller, TRUE)
			return

		if(target_splitter.current_items.len >= target_splitter.max_items)
			finish_action(controller, TRUE)
			return

		var/datum/natural_precursor/precursor = get_precursor_data(carried_item)
		if(!precursor)
			pawn.dropItemToGround(carried_item)
			controller.clear_blackboard_key(BB_SIMPLE_CARRY_ITEM)
			controller.clear_blackboard_key(BB_GNOME_FOUND_ITEM)
			finish_action(controller, TRUE)
			return

		if(carried_item.forceMove(target_splitter))
			target_splitter.current_items += carried_item
			controller.clear_blackboard_key(BB_SIMPLE_CARRY_ITEM)
			controller.clear_blackboard_key(BB_GNOME_FOUND_ITEM)
			pawn.visible_message(span_notice("[pawn] carefully places [carried_item] into the splitter."))
			if(target_splitter.current_items.len >= target_splitter.max_items || should_activate_splitter(controller, target_splitter))
				target_splitter.begin_bulk_splitting(pawn)

			finish_action(controller, TRUE)
			return
		else
			finish_action(controller, FALSE)
			return

	var/obj/item/found_item = controller.blackboard[BB_GNOME_FOUND_ITEM]
	if(!found_item)
		finish_action(controller, FALSE)
		return

	if(get_dist(pawn, found_item) <= 1)
		if(found_item.forceMove(pawn))
			controller.set_blackboard_key(BB_SIMPLE_CARRY_ITEM, found_item)
			pawn.visible_message(span_notice("[pawn] picks up [found_item]."))
			finish_action(controller, TRUE)
		else
			finish_action(controller, FALSE)
	else
		finish_action(controller, TRUE)

/datum/ai_behavior/gnome_splitter_cycle/proc/find_splitter_item(datum/ai_controller/controller)
	var/mob/living/simple_animal/hostile/gnome_homunculus/gnome = controller.pawn
	var/turf/start = controller.blackboard[BB_GNOME_WAYPOINT_A]
	var/range = controller.blackboard[BB_GNOME_SEARCH_RANGE]
	var/list/turfs = view(range, start)
	turfs |= start
	if(!start)
		return null

	for(var/turf/open/source in turfs)
		for(var/obj/item/I in source.contents)
			if(I.anchored)
				continue
			if(I.w_class > gnome.max_carry_size)
				continue
			if(!gnome.item_matches_filter(I))
				continue

			var/datum/natural_precursor/precursor = get_precursor_data(I)
			if(!precursor)
				continue

			return I
	return null

/datum/ai_behavior/gnome_splitter_cycle/proc/should_activate_splitter(datum/ai_controller/controller, obj/machinery/essence/splitter/splitter)
	return splitter.current_items.len >= splitter.max_items

/datum/ai_behavior/gnome_splitter_cycle/finish_action(datum/ai_controller/controller, succeeded)
	. = ..()
	controller.clear_blackboard_key(BB_CURRENT_PET_TARGET)
	controller.clear_blackboard_key(BB_GNOME_FOUND_ITEM)

/datum/pet_command/gnome/stop_splitter
	command_name = "Stop Splitter"
	command_desc = "Stop using the splitter and return to normal behavior"
	radial_icon_state = "split-stop"
	speech_commands = list("stop splitting", "stop splitter", "enough")

/datum/pet_command/gnome/stop_splitter/execute_action(datum/ai_controller/controller)
	controller.set_blackboard_key(BB_GNOME_SPLITTER_MODE, FALSE)
	controller.clear_blackboard_key(BB_GNOME_TARGET_SPLITTER)
	controller.clear_blackboard_key(BB_ACTIVE_PET_COMMAND)

	var/mob/living/pawn = controller.pawn
	pawn.visible_message(span_notice("[pawn] beeps and stops focusing on the splitter."))
