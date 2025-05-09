/datum/component/container_craft
	/// Recipe types that can be used with this container
	var/list/viable_recipe_types = list()
	/// Callback when craft starts
	var/datum/callback/on_craft_start
	/// Callback when craft fails
	var/datum/callback/on_craft_failed
	/// Callback when craft is successful
	var/datum/callback/on_craft_finished
	/// Whether crafting is currently being attempted
	var/crafting = FALSE

/**
 * Initialize the component
 */
/datum/component/container_craft/Initialize(list/recipes, temperature_listener, datum/callback/start, datum/callback/fail, datum/callback/success)
	. = ..()
	if(!length(recipes))
		return COMPONENT_INCOMPATIBLE
	viable_recipe_types = recipes
	on_craft_start = start
	on_craft_failed = fail
	on_craft_finished = success
	RegisterSignal(parent, COMSIG_STORAGE_CLOSED, PROC_REF(async_start))
	if(temperature_listener)
		RegisterSignal(parent, COMSIG_REAGENTS_EXPOSE_TEMPERATURE, PROC_REF(async_start))

/**
 * Asynchronously start crafting
 */
/datum/component/container_craft/proc/async_start(datum/source, mob/user)
	INVOKE_ASYNC(src, PROC_REF(attempt_crafts), source, user)

/**
 * Attempt to craft all possible recipes
 */
/datum/component/container_craft/proc/attempt_crafts(datum/source, mob/user)
	if(crafting)
		return
	crafting = TRUE

	var/list/stored_items = list()
	var/obj/item/host = parent
	if(!length(host.contents))
		return
	for(var/obj/item/item in host.contents)
		stored_items |= item.type
		stored_items[item.type]++

	// Check if we already have active crafts for this container
	var/has_active_crafts = FALSE
	for(var/datum/container_craft_operation/op in GLOB.active_container_crafts)
		if(op.crafter == host)
			has_active_crafts = TRUE
			break

	// If no active crafts, try to start new ones
	if(!has_active_crafts)
		for(var/datum/container_craft/recipe as anything in viable_recipe_types)
			var/datum/container_craft/singleton = GLOB.container_craft_to_singleton[recipe]
			if(!singleton)
				continue

			// Try to start the craft
			if(singleton.try_craft(host, stored_items.Copy(), user, on_craft_start, on_craft_failed))
				stored_items.Cut()
				for(var/obj/item/item in host.contents)
					stored_items |= item.type
					stored_items[item.type]++

	crafting = FALSE
