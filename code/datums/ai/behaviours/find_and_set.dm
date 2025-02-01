/**find and set
 * Finds an item near themselves, sets a blackboard key as it. Very useful for ais that need to use machines or something.
 * if you want to do something more complicated than find a single atom, change the search_tactic() proc
 * cool tip: search_tactic() can set lists
 */
/datum/ai_behavior/find_and_set
	action_cooldown = 2 SECONDS

/datum/ai_behavior/find_and_set/perform(delta_time, datum/ai_controller/controller, set_key, locate_path, search_range)
	. = ..()
	var/find_this_thing = search_tactic(controller, locate_path, search_range)
	if(find_this_thing)
		controller.set_blackboard_key(set_key, find_this_thing)
		finish_action(controller, TRUE)
	else
		finish_action(controller, FALSE)

/datum/ai_behavior/find_and_set/proc/search_tactic(datum/ai_controller/controller, locate_path, search_range)
	return locate(locate_path) in oview(search_range, controller.pawn)

/**
 * Variant of find and set that fails if the living pawn doesn't hold something
 */
/datum/ai_behavior/find_and_set/pawn_must_hold_item

/datum/ai_behavior/find_and_set/pawn_must_hold_item/search_tactic(datum/ai_controller/controller)
	var/mob/living/living_pawn = controller.pawn
	if(!living_pawn.get_inactive_held_item() && !living_pawn.get_active_held_item())
		return //we want to fail the search if we don't have something held
	return ..()

/**
 * Variant of find and set that also requires the item to be edible. checks hands too
 */
/datum/ai_behavior/find_and_set/edible

/datum/ai_behavior/find_and_set/edible/search_tactic(datum/ai_controller/controller, locate_path, search_range)
	var/mob/living/living_pawn = controller.pawn
	var/list/food_candidates = list()
	for(var/held_candidate as anything in living_pawn.held_items)
		if(!held_candidate || !istype(held_candidate, /obj/item/reagent_containers/food))
			continue
		food_candidates += held_candidate
	var/list/local_results = locate(locate_path) in oview(search_range, controller.pawn)
	for(var/local_candidate in local_results)
		if(!istype(local_candidate, /obj/item/reagent_containers/food))
			continue
		food_candidates += local_candidate
	if(food_candidates.len)
		return pick(food_candidates)

/**
 * Variant of find and set that only checks in hands, search range should be excluded for this
 */
/datum/ai_behavior/find_and_set/in_hands

/datum/ai_behavior/find_and_set/in_hands/search_tactic(datum/ai_controller/controller, locate_path)
	var/mob/living/living_pawn = controller.pawn
	return locate(locate_path) in living_pawn.held_items

/**
 * Variant of find and set that takes a list of things to find.
 */
/datum/ai_behavior/find_and_set/in_list

/datum/ai_behavior/find_and_set/in_list/search_tactic(datum/ai_controller/controller, locate_paths, search_range)
	var/list/found = list()
	for(var/locate_path in locate_paths)
		var/single_locate = ..(controller, locate_path, search_range)
		if(single_locate)
			found += single_locate
	if(found.len)
		return pick(found)


/datum/ai_behavior/find_and_set/dead_bodies

/datum/ai_behavior/find_and_set/dead_bodies/search_tactic(datum/ai_controller/controller, locate_paths, search_range)
	var/list/found = list()
	for(var/mob/living/mob in oview(search_range, controller.pawn))
		if(mob.stat < DEAD)
			continue
		found |= mob
	if(!length(found))
		return null
	return pick(found)

/datum/ai_behavior/find_and_set/dead_bodies/bog_troll/finish_action(datum/ai_controller/controller, succeeded, ...)
	. = ..()
	if(succeeded)
		controller.pawn.icon_state = "Trolla"

/datum/ai_behavior/find_and_set/dead_bodies/mimic/finish_action(datum/ai_controller/controller, succeeded, ...)
	. = ..()
	if(succeeded)
		controller.pawn.icon_state = "mimicopen"
