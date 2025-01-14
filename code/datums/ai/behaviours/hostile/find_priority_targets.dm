/datum/ai_behavior/find_priority_targets
	action_cooldown = 1 SECONDS
	/// How far can we see stuff?
	var/vision_range = 9

/datum/ai_behavior/find_priority_targets/perform(seconds_per_tick, datum/ai_controller/controller, priority_key, target_key, targetting_datum_key, hiding_location_key)
	. = ..()
	var/mob/living/living_mob = controller.pawn
	var/datum/targetting_datum/targetting_datum = controller.blackboard[targetting_datum_key]

	if(!targetting_datum)
		CRASH("No target datum was supplied in the blackboard for [controller.pawn]")

	var/priority_targets = controller.blackboard[priority_key]

	if(islist(priority_targets))
		var/list/list = priority_targets
		if(!list.len)
			finish_action(controller, succeeded = FALSE)
			return
	else
		if(!priority_targets)
			finish_action(controller, succeeded = FALSE)
			return

	var/atom/current_target = controller.blackboard[target_key]
	if(islist(priority_targets))
		if(current_target && (current_target in priority_targets))
			finish_action(controller, succeeded = FALSE)
			return
	else
		if(current_target && current_target == priority_targets)
			finish_action(controller, succeeded = FALSE)
			return

	var/list/potential_targets = hearers(vision_range, controller.pawn) - living_mob //Remove self, so we don't suicide
	if(!potential_targets.len)
		finish_action(controller, succeeded = FALSE)
		return

	var/list/filtered_targets = list()
	if(islist(priority_targets))
		for(var/atom/pot_target in potential_targets)
			if((pot_target in priority_targets) && targetting_datum.can_attack(living_mob, pot_target))//Can we attack it?
				filtered_targets += pot_target
	else
		for(var/atom/pot_target in potential_targets)
			if((pot_target == priority_targets) && targetting_datum.can_attack(living_mob, pot_target))//Can we attack it?
				filtered_targets += pot_target
				break

	for(var/mob/living/living_target in filtered_targets)
		if(!living_target.rogue_sneaking)
			continue
		var/extra_chance = (living_mob.health <= living_mob.maxHealth * 50) ? 30 : 0 // if we're below half health, we're way more alert
		if (!living_mob.npc_detect_sneak(living_target, extra_chance))
			filtered_targets -= living_target

	if(!filtered_targets.len)
		finish_action(controller, succeeded = FALSE)
		return

	var/atom/target = pick_final_target(controller, filtered_targets)
	controller.set_blackboard_key(target_key, target)
	var/atom/potential_hiding_location = targetting_datum.find_hidden_mobs(living_mob, target)

	if(potential_hiding_location) //If they're hiding inside of something, we need to know so we can go for that instead initially.
		controller.set_blackboard_key(hiding_location_key, potential_hiding_location)

	finish_action(controller, succeeded = TRUE)

/datum/ai_behavior/find_priority_targets/finish_action(datum/ai_controller/controller, succeeded, ...)
	. = ..()
	if (succeeded)
		controller.CancelActions() // On retarget cancel any further queued actions so that they will setup again with new target

/// Returns the desired final target from the filtered list of targets
/datum/ai_behavior/find_priority_targets/proc/pick_final_target(datum/ai_controller/controller, list/filtered_targets)
	return pick(filtered_targets)
