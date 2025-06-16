/datum/pet_command/gnome/select_recipe
	command_name = "Select Recipe"
	command_desc = "Choose an alchemy recipe to focus on"
	radial_icon_state = "recipe"
	speech_commands = list("recipe", "brew", "make", "alchemy")

/datum/pet_command/gnome/select_recipe/try_activate_command(mob/living/commander, radial_command) // this is shit but it feels easier to use for players
	var/mob/living/simple_animal/hostile/gnome_homunculus/gnome = weak_parent.resolve()
	var/datum/ai_controller/controller = gnome.ai_controller

	if(!commander)
		return

	var/list/recipe_names = list()
	var/list/recipe_paths = list()

	for(var/recipe_path in subtypesof(/datum/alch_cauldron_recipe))
		var/datum/alch_cauldron_recipe/recipe = new recipe_path
		recipe_names += recipe.recipe_name
		recipe_paths[recipe.recipe_name] = recipe_path
		qdel(recipe)

	var/chosen_recipe = input(commander, "Select a recipe for the gnome to focus on:", "Alchemy Recipe") as null|anything in recipe_names

	if(!chosen_recipe)
		controller.clear_blackboard_key(BB_ACTIVE_PET_COMMAND)
		return

	var/recipe_path = recipe_paths[chosen_recipe]
	controller.set_blackboard_key(BB_GNOME_CURRENT_RECIPE, recipe_path)
	gnome.visible_message(span_notice("[gnome] looks and commits the [chosen_recipe] recipe to memory."))
	controller.clear_blackboard_key(BB_ACTIVE_PET_COMMAND)

/datum/pet_command/gnome/start_alchemy
	command_name = "Start Alchemy"
	command_desc = "Begin automated alchemy process"
	radial_icon_state = "alch"
	speech_commands = list("start alchemy", "begin brewing", "automate", "start brewing")
	requires_pointing = TRUE
	pointed_reaction = "and begins analyzing the alchemy setup"

/datum/pet_command/gnome/start_alchemy/execute_action(datum/ai_controller/controller)
	var/atom/target = controller.blackboard[BB_CURRENT_PET_TARGET]
	var/mob/living/simple_animal/hostile/gnome_homunculus/gnome = controller.pawn

	if(!istype(target, /obj/machinery/light/fueled/cauldron) && target)
		gnome.visible_message(span_warning("[gnome] looks confusedly - that's not a cauldron!"))
		controller.clear_blackboard_key(BB_ACTIVE_PET_COMMAND)
		return

	if(!controller.blackboard[BB_GNOME_CURRENT_RECIPE])
		gnome.visible_message(span_warning("[gnome] looks confusedly - no recipe selected!"))
		controller.clear_blackboard_key(BB_ACTIVE_PET_COMMAND)
		return

	var/obj/structure/well = locate(/obj/structure/well) in range(20, gnome)
	if(!well)
		gnome.visible_message(span_warning("[gnome] looks confusedly - no well found nearby!"))
		controller.clear_blackboard_key(BB_ACTIVE_PET_COMMAND)
		return

	var/obj/machinery/essence/essence_source = find_nearest_essence_machinery(gnome)
	if(!essence_source)
		gnome.visible_message(span_warning("[gnome] looks confusedly - no essence machinery found nearby!"))
		controller.clear_blackboard_key(BB_ACTIVE_PET_COMMAND)
		return

	controller.set_blackboard_key(BB_GNOME_ALCHEMY_MODE, TRUE)
	controller.set_blackboard_key(BB_GNOME_TARGET_CAULDRON, target)
	controller.set_blackboard_key(BB_GNOME_TARGET_WELL, well)
	controller.set_blackboard_key(BB_GNOME_ALCHEMY_STATE, ALCHEMY_STATE_NEED_WATER)

	controller.set_blackboard_key(BB_GNOME_ESSENCE_STORAGE, essence_source)
	controller.set_blackboard_key(BB_GNOME_BOTTLE_STORAGE, controller.blackboard[BB_GNOME_WAYPOINT_A]) // Keep bottles on waypoint for now

	gnome.visible_message(span_notice("[gnome] looks eagerly and begins the alchemy automation process!"))
	controller.clear_blackboard_key(BB_ACTIVE_PET_COMMAND)

/datum/pet_command/gnome/start_alchemy/proc/find_nearest_essence_machinery(mob/living/gnome)
	for(var/range = 3; range <= 20; range += 3)
		var/obj/machinery/essence/reservoir/reservoir = locate() in range(range, gnome)
		if(reservoir)
			return reservoir
		var/obj/machinery/essence/any_essence = locate() in range(range, gnome)
		if(any_essence)
			return any_essence

	return null

/datum/ai_behavior/gnome_alchemy_cycle/proc/setup_essence_phase(datum/ai_controller/controller)
	var/needed_essence = find_needed_essence(controller)
	if(!needed_essence)
		controller.set_blackboard_key(BB_GNOME_ALCHEMY_STATE, ALCHEMY_STATE_WAITING_BREW)
		return setup_wait_brewing(controller)

	var/obj/item/essence_vial/needed_vial = find_essence_vial_with_type(controller, needed_essence)
	if(needed_vial)
		set_movement_target(controller, needed_vial)
		controller.set_blackboard_key(BB_GNOME_ALCHEMY_STATE, ALCHEMY_STATE_FETCH_ESSENCES)
		return TRUE

	var/obj/machinery/essence/essence_machinery = find_essence_machinery_with_type(controller, needed_essence)
	if(essence_machinery)
		controller.set_blackboard_key(BB_GNOME_ESSENCE_STORAGE, essence_machinery)
		set_movement_target(controller, essence_machinery)
		controller.set_blackboard_key(BB_GNOME_ALCHEMY_STATE, ALCHEMY_STATE_FETCH_ESSENCES)
		return TRUE

	var/mob/living/pawn = controller.pawn
	pawn.visible_message(span_warning("[pawn] looks confusedly - no [needed_essence] essence found in any storage!"))
	return FALSE

/datum/ai_behavior/gnome_alchemy_cycle/proc/find_essence_machinery_with_type(datum/ai_controller/controller, essence_type)
	var/mob/living/pawn = controller.pawn
	var/list/available_machinery = list()

	for(var/obj/machinery/essence/machinery in range(20, pawn))
		if(essence_machinery_has_essence(machinery, essence_type))
			available_machinery += machinery

	if(!available_machinery.len)
		return null

	var/obj/machinery/essence/closest = null
	var/closest_dist = INFINITY

	for(var/obj/machinery/essence/machinery in available_machinery)
		var/dist = get_dist(pawn, machinery)
		if(dist < closest_dist)
			closest_dist = dist
			closest = machinery

	return closest


/datum/ai_behavior/gnome_alchemy_cycle/proc/essence_machinery_has_essence(obj/machinery/essence/machinery, essence_type)
	if(istype(machinery, /obj/machinery/essence/reservoir))
		var/obj/machinery/essence/reservoir/reservoir = machinery
		var/datum/essence_storage/storage = reservoir.return_storage()
		if(storage && storage.get_essence_amount(essence_type) > 0)
			return TRUE


/datum/ai_behavior/gnome_alchemy_cycle/proc/find_essence_vial_with_type(datum/ai_controller/controller, essence_type)
	var/mob/living/pawn = controller.pawn
	var/list/search_locations = list()
	for(var/obj/machinery/essence/machinery in range(20, pawn))
		search_locations += machinery

	for(var/obj/machinery/essence/machinery in search_locations)
		for(var/obj/item/essence_vial/vial in range(5, machinery))
			if(vial.contained_essence && istype(vial.contained_essence, essence_type) && vial.essence_amount > 0)
				return vial

	for(var/obj/item/essence_vial/vial in range(10, pawn))
		if(vial.contained_essence && istype(vial.contained_essence, essence_type) && vial.essence_amount > 0)
			return vial

	return null

/datum/ai_behavior/gnome_alchemy_cycle/proc/handle_essence_fetching(datum/ai_controller/controller, mob/living/pawn)
	var/needed_essence_type = find_needed_essence(controller)
	if(!needed_essence_type)
		controller.set_blackboard_key(BB_GNOME_ALCHEMY_STATE, ALCHEMY_STATE_WAITING_BREW)
		finish_action(controller, TRUE)
		return

	var/obj/item/carried = controller.blackboard[BB_SIMPLE_CARRY_ITEM]

	if(!carried)
		var/obj/item/essence_vial/needed_vial = find_essence_vial_with_type(controller, needed_essence_type)
		if(needed_vial && get_dist(pawn, needed_vial) <= 1)
			needed_vial.forceMove(pawn)
			controller.set_blackboard_key(BB_SIMPLE_CARRY_ITEM, needed_vial)
			controller.set_blackboard_key(BB_GNOME_ALCHEMY_STATE, ALCHEMY_STATE_ADD_ESSENCES)
			pawn.visible_message(span_notice("[pawn] picks up [needed_vial] containing [needed_vial.contained_essence.name]."))
			finish_action(controller, TRUE)
			return

		var/obj/machinery/essence/essence_machinery = controller.blackboard[BB_GNOME_ESSENCE_STORAGE]
		if(!essence_machinery || get_dist(pawn, essence_machinery) > 1)
			return

		if(!essence_machinery_has_essence(essence_machinery, needed_essence_type))
			var/obj/machinery/essence/better_machinery = find_essence_machinery_with_type(controller, needed_essence_type)
			if(better_machinery)
				controller.set_blackboard_key(BB_GNOME_ESSENCE_STORAGE, better_machinery)
				set_movement_target(controller, better_machinery)
				pawn.visible_message(span_notice("[pawn] looks and redirects to different essence storage."))
				return
			else
				pawn.visible_message(span_warning("[pawn] looks confusedly - no [needed_essence_type] essence found!"))
				return

		var/obj/item/essence_vial/empty_vial = find_empty_vial_near_machinery(essence_machinery)
		if(!empty_vial)
			pawn.visible_message(span_warning("[pawn] looks - no empty vials found near essence machinery!"))
			return

		empty_vial.forceMove(pawn)
		controller.set_blackboard_key(BB_SIMPLE_CARRY_ITEM, empty_vial)
		carried = empty_vial

	var/obj/item/essence_vial/vial = carried
	if(istype(vial) && (!vial.contained_essence || vial.essence_amount <= 0))
		var/obj/machinery/essence/essence_machinery = controller.blackboard[BB_GNOME_ESSENCE_STORAGE]
		if(essence_machinery && get_dist(pawn, essence_machinery) <= 1)
			if(extract_essence_from_machinery(essence_machinery, vial, needed_essence_type, pawn))
				controller.set_blackboard_key(BB_GNOME_ALCHEMY_STATE, ALCHEMY_STATE_ADD_ESSENCES)
				pawn.visible_message(span_notice("[pawn] extracts [vial.contained_essence.name] from the essence machinery."))
				finish_action(controller, TRUE)


/datum/ai_behavior/gnome_alchemy_cycle/proc/find_empty_vial_near_machinery(obj/machinery/essence/target_machinery)
	for(var/obj/item/essence_vial/vial in range(3, target_machinery))
		if(!vial.contained_essence || vial.essence_amount <= 0)
			return vial

	for(var/obj/machinery/essence/machinery in range(15, target_machinery))
		if(machinery == target_machinery)
			continue
		for(var/obj/item/essence_vial/vial in range(3, machinery))
			if(!vial.contained_essence || vial.essence_amount <= 0)
				return vial

	return null

/datum/ai_behavior/gnome_alchemy_cycle/proc/extract_essence_from_machinery(obj/machinery/essence/machinery, obj/item/essence_vial/vial, essence_type, mob/living/pawn)
	if(istype(machinery, /obj/machinery/essence/reservoir))
		return extract_from_reservoir(machinery, vial, essence_type, pawn)

	return FALSE

/datum/ai_behavior/gnome_alchemy_cycle/proc/extract_from_reservoir(obj/machinery/essence/reservoir/reservoir, obj/item/essence_vial/vial, essence_type, mob/living/pawn)
	var/datum/essence_storage/storage = reservoir.return_storage()

	if(!storage || storage.get_essence_amount(essence_type) <= 0)
		return FALSE

	var/max_extract = min(storage.get_essence_amount(essence_type), vial.max_essence)
	if(max_extract <= 0)
		return FALSE

	var/extracted = storage.remove_essence(essence_type, max_extract)
	if(extracted > 0)
		vial.contained_essence = new essence_type
		vial.essence_amount = extracted
		vial.update_icon()
		return TRUE

	return FALSE

/datum/ai_behavior/gnome_alchemy_cycle/proc/find_water_container(datum/ai_controller/controller)
	var/mob/living/pawn = controller.pawn
	var/obj/structure/well/target_well = controller.blackboard[BB_GNOME_TARGET_WELL]
	var/list/search_areas = list()

	if(target_well)
		search_areas += target_well

	for(var/obj/machinery/essence/machinery in range(20, pawn))
		search_areas += machinery

	for(var/atom/search_center in search_areas)
		for(var/obj/item/reagent_containers/I in range(3, search_center))
			if(I.reagents)
				return I

	for(var/obj/item/reagent_containers/I in range(5, pawn))
		if(I.reagents)
			return I

	return null

/datum/pet_command/gnome/start_alchemy/proc/find_best_essence_machinery(mob/living/gnome, recipe_path)
	var/list/found_machinery = list()
	var/datum/alch_cauldron_recipe/recipe = new recipe_path

	for(var/obj/machinery/essence/machinery in range(20, gnome))
		var/priority = 0
		if(istype(machinery, /obj/machinery/essence/reservoir))
			priority = 100
			var/obj/machinery/essence/reservoir/reservoir = machinery
			var/datum/essence_storage/storage = reservoir.return_storage()
			for(var/essence_type in recipe.required_essences)
				if(storage.get_essence_amount(essence_type) > 0)
					priority += 50
		else
			priority = 10
		found_machinery[machinery] = priority
	qdel(recipe)

	var/obj/machinery/essence/best_machinery = null
	var/highest_priority = 0

	for(var/obj/machinery/essence/machinery in found_machinery)
		if(found_machinery[machinery] > highest_priority)
			highest_priority = found_machinery[machinery]
			best_machinery = machinery

	return best_machinery

/datum/pet_command/gnome/stop_alchemy
	command_name = "Stop Alchemy"
	command_desc = "Stop automated alchemy process"
	radial_icon_state = "alch-stop"
	speech_commands = list("stop alchemy", "stop brewing", "halt alchemy", "end brewing")

/datum/pet_command/gnome/stop_alchemy/execute_action(datum/ai_controller/controller)
	var/mob/living/simple_animal/hostile/gnome_homunculus/gnome = controller.pawn

	controller.set_blackboard_key(BB_GNOME_ALCHEMY_MODE, FALSE)
	controller.set_blackboard_key(BB_GNOME_ALCHEMY_STATE, ALCHEMY_STATE_IDLE)
	controller.clear_blackboard_key(BB_GNOME_TARGET_CAULDRON)
	controller.clear_blackboard_key(BB_GNOME_TARGET_WELL)

	gnome.visible_message(span_notice("[gnome] looks and stops the alchemy process."))
	controller.clear_blackboard_key(BB_ACTIVE_PET_COMMAND)

/datum/ai_behavior/gnome_alchemy_cycle
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_REQUIRE_REACH

/datum/ai_behavior/gnome_alchemy_cycle/setup(datum/ai_controller/controller)
	. = ..()
	var/current_state = controller.blackboard[BB_GNOME_ALCHEMY_STATE]

	switch(current_state)
		if(ALCHEMY_STATE_NEED_WATER, ALCHEMY_STATE_FETCH_WATER)
			return setup_water_phase(controller)
		if(ALCHEMY_STATE_ADD_WATER)
			return setup_add_water(controller)
		if(ALCHEMY_STATE_NEED_ESSENCES, ALCHEMY_STATE_FETCH_ESSENCES)
			return setup_essence_phase(controller)
		if(ALCHEMY_STATE_ADD_ESSENCES)
			return setup_add_essences(controller)
		if(ALCHEMY_STATE_WAITING_BREW)
			return setup_wait_brewing(controller)
		if(ALCHEMY_STATE_NEED_BOTTLES, ALCHEMY_STATE_FETCH_BOTTLES)
			return setup_bottle_phase(controller)
		if(ALCHEMY_STATE_BOTTLE_PRODUCT)
			return setup_bottle_product(controller)
		if(ALCHEMY_STATE_RETURN_BOTTLE)
			return setup_return_bottle(controller)
		if(ALCHEMY_STATE_RETURN_ESSENCE_VIAL)
			return setup_return_essence_vial(controller)
		if(ALCHEMY_STATE_RETURN_WATER_CONTAINER)
			return setup_return_water_container(controller)

	return FALSE

/datum/ai_behavior/gnome_alchemy_cycle/proc/setup_water_phase(datum/ai_controller/controller)
	var/obj/item/carried = controller.blackboard[BB_SIMPLE_CARRY_ITEM]
	var/obj/structure/well/target_well = controller.blackboard[BB_GNOME_TARGET_WELL]
	if(!carried || !is_water_container(carried))
		var/obj/item/container = find_water_container(controller)
		if(!container)
			return FALSE
		set_movement_target(controller, container)
		controller.set_blackboard_key(BB_GNOME_ALCHEMY_STATE, ALCHEMY_STATE_FETCH_WATER)
	else
		set_movement_target(controller, target_well)
		controller.set_blackboard_key(BB_GNOME_ALCHEMY_STATE, ALCHEMY_STATE_FETCH_WATER)

	return TRUE

/datum/ai_behavior/gnome_alchemy_cycle/proc/setup_add_water(datum/ai_controller/controller)
	var/obj/machinery/light/fueled/cauldron/cauldron = controller.blackboard[BB_GNOME_TARGET_CAULDRON]
	set_movement_target(controller, cauldron)
	return TRUE

/datum/ai_behavior/gnome_alchemy_cycle/proc/setup_add_essences(datum/ai_controller/controller)
	var/obj/machinery/light/fueled/cauldron/cauldron = controller.blackboard[BB_GNOME_TARGET_CAULDRON]
	set_movement_target(controller, cauldron)
	return TRUE

/datum/ai_behavior/gnome_alchemy_cycle/proc/setup_wait_brewing(datum/ai_controller/controller)
	var/obj/machinery/light/fueled/cauldron/cauldron = controller.blackboard[BB_GNOME_TARGET_CAULDRON]
	set_movement_target(controller, cauldron)
	return TRUE

/datum/ai_behavior/gnome_alchemy_cycle/proc/setup_bottle_phase(datum/ai_controller/controller)
	var/turf/bottle_storage = controller.blackboard[BB_GNOME_BOTTLE_STORAGE]
	if(!bottle_storage)
		return FALSE

	set_movement_target(controller, bottle_storage)
	controller.set_blackboard_key(BB_GNOME_ALCHEMY_STATE, ALCHEMY_STATE_FETCH_BOTTLES)
	return TRUE

/datum/ai_behavior/gnome_alchemy_cycle/proc/setup_bottle_product(datum/ai_controller/controller)
	var/obj/machinery/light/fueled/cauldron/cauldron = controller.blackboard[BB_GNOME_TARGET_CAULDRON]
	set_movement_target(controller, cauldron)
	return TRUE

/datum/ai_behavior/gnome_alchemy_cycle/perform(delta_time, datum/ai_controller/controller)
	. = ..()
	var/current_state = controller.blackboard[BB_GNOME_ALCHEMY_STATE]
	var/mob/living/pawn = controller.pawn

	switch(current_state)
		if(ALCHEMY_STATE_FETCH_WATER)
			handle_water_fetching(controller, pawn)
		if(ALCHEMY_STATE_ADD_WATER)
			handle_add_water(controller, pawn)
		if(ALCHEMY_STATE_RETURN_WATER_CONTAINER)
			handle_return_water_container(controller, pawn)
		if(ALCHEMY_STATE_FETCH_ESSENCES)
			handle_essence_fetching(controller, pawn)
		if(ALCHEMY_STATE_ADD_ESSENCES)
			handle_add_essences(controller, pawn)
		if(ALCHEMY_STATE_RETURN_ESSENCE_VIAL)
			handle_return_essence_vial(controller, pawn)
		if(ALCHEMY_STATE_WAITING_BREW)
			handle_wait_brewing(controller, pawn)
		if(ALCHEMY_STATE_FETCH_BOTTLES)
			handle_bottle_fetching(controller, pawn)
		if(ALCHEMY_STATE_BOTTLE_PRODUCT)
			handle_bottle_product(controller, pawn)
		if(ALCHEMY_STATE_RETURN_BOTTLE)
			handle_return_bottle(controller, pawn)

/datum/ai_behavior/gnome_alchemy_cycle/proc/handle_water_fetching(datum/ai_controller/controller, mob/living/pawn)
	var/obj/item/carried = controller.blackboard[BB_SIMPLE_CARRY_ITEM]
	var/obj/structure/well/target_well = controller.blackboard[BB_GNOME_TARGET_WELL]
	if(!carried)
		var/obj/item/reagent_containers/container = locate() in range(1, pawn)
		if(container && is_water_container(container))
			container.forceMove(pawn)
			controller.set_blackboard_key(BB_SIMPLE_CARRY_ITEM, container)
			pawn.visible_message(span_notice("[pawn] picks up [container]."))
		return

	if(get_dist(pawn, target_well) <= 1 && is_water_container(carried))
		carried.reagents?.add_reagent(/datum/reagent/water, 50)
		controller.set_blackboard_key(BB_GNOME_ALCHEMY_STATE, ALCHEMY_STATE_ADD_WATER)
		pawn.visible_message(span_notice("[pawn] fills [carried] with water."))
		finish_action(controller, TRUE)

/datum/ai_behavior/gnome_alchemy_cycle/proc/handle_add_water(datum/ai_controller/controller, mob/living/pawn)
	var/obj/machinery/light/fueled/cauldron/cauldron = controller.blackboard[BB_GNOME_TARGET_CAULDRON]
	var/obj/item/carried = controller.blackboard[BB_SIMPLE_CARRY_ITEM]

	if(get_dist(pawn, cauldron) <= 1 && carried)
		if(carried.reagents && cauldron.reagents)
			carried.reagents.trans_to(cauldron, 30)
			pawn.visible_message(span_notice("[pawn] pours water into [cauldron]."))
			controller.set_blackboard_key(BB_GNOME_ALCHEMY_STATE, ALCHEMY_STATE_RETURN_WATER_CONTAINER)
			pawn.visible_message(span_notice("[pawn] prepares to return the container to the well."))
			finish_action(controller, TRUE)

/datum/ai_behavior/gnome_alchemy_cycle/proc/handle_add_essences(datum/ai_controller/controller, mob/living/pawn)
	var/obj/machinery/light/fueled/cauldron/cauldron = controller.blackboard[BB_GNOME_TARGET_CAULDRON]
	var/obj/item/essence_vial/vial = controller.blackboard[BB_SIMPLE_CARRY_ITEM]

	if(get_dist(pawn, cauldron) <= 1 && istype(vial))
		cauldron.attackby(vial, pawn)
		controller.set_blackboard_key(BB_GNOME_ALCHEMY_STATE, ALCHEMY_STATE_RETURN_ESSENCE_VIAL)
		pawn.visible_message(span_notice("[pawn] adds essence to the cauldron and prepares to return the vial."))
		finish_action(controller, TRUE)

/datum/ai_behavior/gnome_alchemy_cycle/proc/handle_wait_brewing(datum/ai_controller/controller, mob/living/pawn)
	var/obj/machinery/light/fueled/cauldron/cauldron = controller.blackboard[BB_GNOME_TARGET_CAULDRON]
	if(cauldron.brewing >= 21 && cauldron.reagents.total_volume > 0)
		controller.set_blackboard_key(BB_GNOME_ALCHEMY_STATE, ALCHEMY_STATE_NEED_BOTTLES)
		finish_action(controller, TRUE)
	else if(cauldron.brewing == 0)
		controller.set_blackboard_key(BB_GNOME_ALCHEMY_STATE, ALCHEMY_STATE_NEED_WATER)
		finish_action(controller, TRUE)

/datum/ai_behavior/gnome_alchemy_cycle/proc/handle_bottle_fetching(datum/ai_controller/controller, mob/living/pawn)
	var/obj/item/bottle = find_suitable_bottle(controller)
	if(bottle)
		bottle.forceMove(pawn)
		controller.set_blackboard_key(BB_SIMPLE_CARRY_ITEM, bottle)
		controller.set_blackboard_key(BB_GNOME_ALCHEMY_STATE, ALCHEMY_STATE_BOTTLE_PRODUCT)
		pawn.visible_message(span_notice("[pawn] picks up [bottle]."))
		finish_action(controller, TRUE)

/datum/ai_behavior/gnome_alchemy_cycle/proc/handle_bottle_product(datum/ai_controller/controller, mob/living/pawn)
	var/obj/machinery/light/fueled/cauldron/cauldron = controller.blackboard[BB_GNOME_TARGET_CAULDRON]
	var/obj/item/bottle = controller.blackboard[BB_SIMPLE_CARRY_ITEM]

	if(get_dist(pawn, cauldron) <= 1 && bottle && bottle.reagents)
		cauldron.reagents.trans_to(bottle, bottle.reagents.maximum_volume - bottle.reagents.total_volume)
		pawn.visible_message(span_notice("[pawn] fills [bottle] with the finished potion."))
		controller.set_blackboard_key(BB_GNOME_ALCHEMY_STATE, ALCHEMY_STATE_RETURN_BOTTLE)
		pawn.visible_message(span_notice("[pawn] prepares to store the finished potion."))
		finish_action(controller, TRUE)

/datum/ai_behavior/gnome_alchemy_cycle/proc/setup_return_water_container(datum/ai_controller/controller)
	var/obj/structure/well/target_well = controller.blackboard[BB_GNOME_TARGET_WELL]
	if(!target_well)
		return FALSE

	set_movement_target(controller, target_well)
	return TRUE

/datum/ai_behavior/gnome_alchemy_cycle/proc/setup_return_essence_vial(datum/ai_controller/controller)
	var/obj/machinery/essence/essence_machinery = controller.blackboard[BB_GNOME_ESSENCE_STORAGE]
	if(!essence_machinery)
		return FALSE

	set_movement_target(controller, essence_machinery)
	return TRUE

/datum/ai_behavior/gnome_alchemy_cycle/proc/setup_return_bottle(datum/ai_controller/controller)
	var/turf/bottle_storage = controller.blackboard[BB_GNOME_BOTTLE_STORAGE]
	if(!bottle_storage)
		return FALSE

	set_movement_target(controller, bottle_storage)
	return TRUE

/datum/ai_behavior/gnome_alchemy_cycle/proc/handle_return_water_container(datum/ai_controller/controller, mob/living/pawn)
	var/obj/structure/well/target_well = controller.blackboard[BB_GNOME_TARGET_WELL]
	var/obj/item/container = controller.blackboard[BB_SIMPLE_CARRY_ITEM]

	if(get_dist(pawn, target_well) <= 2 && container)
		var/turf/drop_location = find_suitable_drop_location(target_well, 2)
		if(drop_location)
			container.forceMove(drop_location)
			pawn.visible_message(span_notice("[pawn] places [container] near the well for later use."))
		else
			pawn.dropItemToGround(container)

		controller.clear_blackboard_key(BB_SIMPLE_CARRY_ITEM)
		controller.set_blackboard_key(BB_GNOME_ALCHEMY_STATE, ALCHEMY_STATE_NEED_ESSENCES)
		finish_action(controller, TRUE)

/datum/ai_behavior/gnome_alchemy_cycle/proc/handle_return_essence_vial(datum/ai_controller/controller, mob/living/pawn)
	var/obj/machinery/essence/essence_machinery = controller.blackboard[BB_GNOME_ESSENCE_STORAGE]
	var/obj/item/vial = controller.blackboard[BB_SIMPLE_CARRY_ITEM]

	if(get_dist(pawn, essence_machinery) <= 2 && vial)
		var/turf/drop_location = find_suitable_drop_location(essence_machinery, 2)
		if(drop_location)
			vial.forceMove(drop_location)
			pawn.visible_message(span_notice("[pawn] places the empty vial near the essence machinery."))
		else
			pawn.dropItemToGround(vial)

		controller.clear_blackboard_key(BB_SIMPLE_CARRY_ITEM)
		if(find_needed_essence(controller))
			controller.set_blackboard_key(BB_GNOME_ALCHEMY_STATE, ALCHEMY_STATE_NEED_ESSENCES)
		else
			controller.set_blackboard_key(BB_GNOME_ALCHEMY_STATE, ALCHEMY_STATE_WAITING_BREW)

		finish_action(controller, TRUE)

/datum/ai_behavior/gnome_alchemy_cycle/proc/handle_return_bottle(datum/ai_controller/controller, mob/living/pawn)
	var/turf/bottle_storage = controller.blackboard[BB_GNOME_BOTTLE_STORAGE]
	var/obj/item/bottle = controller.blackboard[BB_SIMPLE_CARRY_ITEM]
	var/obj/machinery/light/fueled/cauldron/cauldron = controller.blackboard[BB_GNOME_TARGET_CAULDRON]

	if(get_dist(pawn, bottle_storage) <= 1 && bottle)
		bottle.forceMove(bottle_storage)
		pawn.visible_message(span_notice("[pawn] stores the finished potion in the bottle storage."))

		controller.clear_blackboard_key(BB_SIMPLE_CARRY_ITEM)
		if(cauldron && cauldron.reagents && cauldron.reagents.total_volume > 10)
			controller.set_blackboard_key(BB_GNOME_ALCHEMY_STATE, ALCHEMY_STATE_NEED_BOTTLES)
		else
			controller.set_blackboard_key(BB_GNOME_ALCHEMY_STATE, ALCHEMY_STATE_NEED_WATER)

		finish_action(controller, TRUE)

/datum/ai_behavior/gnome_alchemy_cycle/proc/find_suitable_drop_location(atom/target, range_limit = 2)
	if(!target)
		return null

	var/turf/target_turf = get_turf(target)
	if(!target_turf)
		return null

	if(target_turf.density == 0)
		var/blocked = FALSE
		for(var/atom/A in target_turf)
			if(A.density)
				blocked = TRUE
				break
		if(!blocked)
			return target_turf

	for(var/range = 1; range <= range_limit; range++)
		for(var/turf/T in range(range, target))
			if(T.density == 0)
				var/blocked = FALSE
				for(var/atom/A in T)
					if(A.density)
						blocked = TRUE
						break
				if(!blocked)
					return T

	return target_turf

/datum/ai_behavior/gnome_alchemy_cycle/proc/is_water_container(obj/item/I)
	return (istype(I, /obj/item/reagent_containers) && I.reagents)

/datum/ai_behavior/gnome_alchemy_cycle/proc/find_needed_essence(datum/ai_controller/controller)
	var/recipe_path = controller.blackboard[BB_GNOME_CURRENT_RECIPE]
	var/obj/machinery/light/fueled/cauldron/cauldron = controller.blackboard[BB_GNOME_TARGET_CAULDRON]

	if(!recipe_path || !cauldron)
		return null

	var/datum/alch_cauldron_recipe/recipe = new recipe_path

	// Check what essences we still need
	for(var/essence_type in recipe.required_essences)
		var/required_amount = recipe.required_essences[essence_type]
		var/current_amount = cauldron.essence_contents[essence_type]

		if(!current_amount || current_amount < required_amount)
			qdel(recipe)
			return essence_type

	qdel(recipe)
	return null

/datum/ai_behavior/gnome_alchemy_cycle/proc/find_suitable_bottle(datum/ai_controller/controller)
	var/mob/living/pawn = controller.pawn
	var/turf/bottle_storage = controller.blackboard[BB_GNOME_BOTTLE_STORAGE]
	var/obj/machinery/light/fueled/cauldron/cauldron = controller.blackboard[BB_GNOME_TARGET_CAULDRON]

	var/list/search_areas = list()
	if(bottle_storage)
		search_areas += bottle_storage
	for(var/obj/machinery/essence/machinery in range(15, pawn))
		search_areas += get_turf(machinery)

	for(var/turf/area in search_areas)
		if(cauldron && cauldron.reagents.reagent_list.len > 0)
			var/datum/reagent/main_reagent = cauldron.reagents.reagent_list[1]
			for(var/obj/item/reagent_containers/I in range(2, area))
				if(I.reagents && I.reagents.has_reagent(main_reagent.type))
					if(I.reagents.total_volume < I.reagents.maximum_volume)
						return I

		for(var/obj/item/reagent_containers/I in range(2, area))
			if(I.reagents && I.reagents.total_volume == 0)
				return I

	return null

/datum/ai_behavior/gnome_alchemy_cycle/finish_action(datum/ai_controller/controller, succeeded)
	. = ..()
	controller.clear_blackboard_key(BB_CURRENT_PET_TARGET)
