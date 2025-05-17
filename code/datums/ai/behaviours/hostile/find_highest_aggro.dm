/datum/ai_behavior/find_aggro_targets
	action_cooldown = 1 SECONDS

/datum/ai_behavior/find_aggro_targets/perform(seconds_per_tick, datum/ai_controller/controller, target_key, targetting_datum_key, hiding_location_key)
	. = ..()

	var/mob/living/living_mob = controller.pawn
	if(!living_mob || living_mob.pet_passive)
		finish_action(controller, succeeded = FALSE)
		return

	// Check if we already have a threat target
	var/mob/current_target = controller.blackboard[BB_HIGHEST_THREAT_MOB]
	var/datum/targetting_datum/targetting_datum = controller.blackboard[targetting_datum_key]

	// If we have a valid target, check if it's still valid
	if(current_target && istype(current_target, /mob/living))
		var/mob/living/living_target = current_target

		// Check if target is dead
		if(living_target.stat == DEAD)
			controller.clear_blackboard_key(BB_HIGHEST_THREAT_MOB)
			current_target = null
		else
			// Check if target is too far away
			var/maintain_range = controller.blackboard[BB_AGGRO_MAINTAIN_RANGE] || 12

			if(!targetting_datum)
				CRASH("No target datum was supplied in the blackboard for [controller.pawn]")

			if (!targetting_datum.can_attack(living_mob, current_target))
				controller.clear_blackboard_key(BB_HIGHEST_THREAT_MOB)
				current_target = null

			if(get_dist(living_mob, living_target) > maintain_range)
				controller.clear_blackboard_key(BB_HIGHEST_THREAT_MOB)
				current_target = null

	// If we have a valid target, set it
	if(current_target)
		if(current_target == controller.blackboard[target_key])
			finish_action(controller, succeeded = FALSE)
			return
		controller.set_blackboard_key(target_key, current_target)

		// Check if target is hiding in something
		var/atom/potential_hiding_location = find_hiding_location(living_mob, current_target)
		if(potential_hiding_location)
			controller.set_blackboard_key(hiding_location_key, potential_hiding_location)
		else
			controller.clear_blackboard_key(hiding_location_key)

		finish_action(controller, succeeded = TRUE)
		return

	// If we don't have a target, check for new targets in range
	scan_for_new_targets(controller, living_mob, target_key, targetting_datum, hiding_location_key)

/// Scans for new potential targets
/datum/ai_behavior/find_aggro_targets/proc/scan_for_new_targets(datum/ai_controller/controller, mob/living/living_mob, target_key, datum/targetting_datum/targetting_datum, hiding_location_key)
	var/aggro_range = controller.blackboard[BB_AGGRO_RANGE] || 9
	var/list/potential_targets = hearers(aggro_range, living_mob) - living_mob

	if(!potential_targets.len)
		finish_action(controller, succeeded = FALSE)
		return

	var/list/filtered_targets = list()
	for(var/mob/living/pot_target in potential_targets)
		// Skip dead mobs
		if(pot_target.stat == DEAD)
			continue
		if (!targetting_datum.can_attack(living_mob, pot_target))
			continue
		// Skip sneaking mobs with a chance to detect them
		if(pot_target.rogue_sneaking)
			var/extra_chance = (living_mob.health <= living_mob.maxHealth * 0.5) ? 30 : 0
			if(!living_mob.npc_detect_sneak(pot_target, extra_chance))
				continue

		// Add to filtered targets
		filtered_targets += pot_target

	if(!filtered_targets.len)
		finish_action(controller, succeeded = FALSE)
		return

	// Choose a random mob from filtered targets to add initial threat
	var/mob/living/chosen_target = pick(filtered_targets)

	// Find the aggro component on our mob
	var/datum/component/ai_aggro_system/aggro_comp = living_mob.GetComponent(/datum/component/ai_aggro_system)
	if(aggro_comp)
		// Add initial threat to start aggro mechanic
		aggro_comp.add_threat_to_mob_capped(chosen_target, 15, 15)
		aggro_comp.add_threat_to_mob(chosen_target, 3)
	// Check if this pushed the target over the threshold
	var/mob/highest_threat = controller.blackboard[BB_HIGHEST_THREAT_MOB]
	if(highest_threat)
		controller.set_blackboard_key(target_key, highest_threat)

		// Check if target is hiding in something
		var/atom/potential_hiding_location = find_hiding_location(living_mob, highest_threat)
		if(potential_hiding_location)
			controller.set_blackboard_key(hiding_location_key, potential_hiding_location)

		finish_action(controller, succeeded = TRUE)
	else
		finish_action(controller, succeeded = FALSE)

/// Helper proc to find if a mob is hiding in something
/datum/ai_behavior/find_aggro_targets/proc/find_hiding_location(mob/living/source, mob/living/target)
	// Check if target is inside something
	if(istype(target.loc, /obj/item) || istype(target.loc, /obj/structure) || istype(target.loc, /obj/machinery))
		return target.loc
	return null

/datum/ai_behavior/find_aggro_targets/finish_action(datum/ai_controller/controller, succeeded, ...)
	. = ..()
	if(succeeded)
		controller.CancelActions() // Cancel any further queued actions so they setup again with new target

/datum/ai_behavior/find_aggro_targets/bum/finish_action(datum/ai_controller/controller, succeeded, ...)
	. = ..()
	if(succeeded)
		var/mob/living/pawn = controller.pawn
		pawn.say(pick(GLOB.bum_aggro))
