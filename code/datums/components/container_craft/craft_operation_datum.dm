/**
 * Datum to track a specific crafting operation in progress
 */
/datum/container_craft_operation
	/// The container being crafted in
	var/obj/item/crafter
	/// The recipe being crafted
	var/datum/container_craft/recipe
	/// The user initiating the craft, if any
	var/mob/initiator
	/// The estimated multiplier for this craft
	var/estimated_multiplier = 1
	/// Progress time in deciseconds
	var/progress = 0
	/// Target time in deciseconds
	var/target_time = 0
	/// Last time progress was made
	var/last_progress_time = 0
	/// If the craft has been aborted
	var/aborted = FALSE
	/// Data for item consumption
	var/list/stored_items
	/// Callback for when craft is started
	var/datum/callback/on_craft_start
	/// Callback for when craft fails
	var/datum/callback/on_craft_failed
	/// Time with no progress before auto-aborting (in deciseconds)
	var/timeout_period = 30 SECONDS // 30 seconds default
	///do we need the initator near us
	var/requires_proximity = FALSE

/**
 * Initialize a new crafting operation
 */
/datum/container_craft_operation/New(obj/item/crafter, datum/container_craft/recipe, mob/initiator, estimated_multiplier, datum/callback/on_craft_start, datum/callback/on_craft_failed)
	src.crafter = crafter
	src.recipe = recipe
	src.initiator = initiator
	src.estimated_multiplier = estimated_multiplier
	src.on_craft_start = on_craft_start
	src.on_craft_failed = on_craft_failed

	if(recipe.user_craft)
		target_time = recipe.get_real_time(crafter, initiator, estimated_multiplier)
		src.requires_proximity = TRUE
	else
		target_time = recipe.crafting_time

	// Store current inventory state
	refresh_stored_items()
	last_progress_time = world.time

	START_PROCESSING(SSprocessing, src)
	GLOB.active_container_crafts += src

	if(on_craft_start)
		on_craft_start.InvokeAsync(crafter, initiator)

/**
 * Refreshes the stored items list from the crafter's contents
 */
/datum/container_craft_operation/proc/refresh_stored_items()
	stored_items = list()
	for(var/obj/item/item in crafter.contents)
		stored_items |= item.type
		stored_items[item.type]++

/**
 * Process tick for crafting progress
 */
/datum/container_craft_operation/process()
	// Check if the container or user are still valid
	if(recipe.user_craft)
		if((QDELETED(initiator) || !initiator.can_perform_action(crafter, NEED_DEXTERITY|FORBID_TELEKINESIS_REACH)))
			return FALSE

	if(QDELETED(crafter))
		abort_craft("Container or user no longer valid")
		return

	// Check if recipe requirements are still met
	if(!recipe.requirements_still_met(crafter, stored_items))
		abort_craft("Requirements no longer met")
		return

	// Check for timeout (no progress in a while)
	if((world.time - last_progress_time) > timeout_period)
		abort_craft("Craft timed out")
		return

	if(requires_proximity && !initiator.CanReach(crafter))
		return

	// Update progress
	progress += SSprocessing.wait
	last_progress_time = world.time

	// Check if craft is complete
	if(progress >= target_time)
		complete_craft()

/**
 * Completes the crafting operation successfully
 */
/datum/container_craft_operation/proc/complete_craft()
	STOP_PROCESSING(SSprocessing, src)
	GLOB.active_container_crafts -= src

	// Check for failure one last time
	if(recipe.check_failure(crafter, initiator))
		if(on_craft_failed)
			on_craft_failed.InvokeAsync(crafter, initiator)
		qdel(src)
		return

	// Execute the craft
	recipe.execute_craft_completion(crafter, initiator, estimated_multiplier)
	qdel(src)

/**
 * Aborts the crafting operation
 * @param reason The reason for aborting
 */
/datum/container_craft_operation/proc/abort_craft(reason)
	if(aborted)
		return

	aborted = TRUE
	STOP_PROCESSING(SSprocessing, src)
	GLOB.active_container_crafts -= src

	if(on_craft_failed)
		on_craft_failed.InvokeAsync(crafter, initiator)

	qdel(src)

/**
 * Clean up when the datum is destroyed
 */
/datum/container_craft_operation/Destroy()
	STOP_PROCESSING(SSprocessing, src)
	GLOB.active_container_crafts -= src
	on_craft_start = null
	on_craft_failed = null
	return ..()
