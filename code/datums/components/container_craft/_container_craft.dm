/datum/component/container_craft
	/// Recipe types that can be used with this container
	var/list/viable_recipe_types = list()
	/// Callback when craft starts
	var/datum/callback/on_craft_start
	/// Callback when craft fails
	var/datum/callback/on_craft_failed
	/// Callback when craft is successful
	var/datum/callback/on_craft_finished

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
	var/list/stored_items = list()
	var/obj/item/host = parent
	if(!length(host.contents))
		return
	for(var/obj/item/item in host.contents)
		stored_items |= item.type
		stored_items[item.type]++

	for(var/datum/container_craft_operation/op in GLOB.active_container_crafts)
		if(op.crafter == host)
			for(var/path in op.stored_items)
				stored_items[path] -= op.stored_items[path]
				if(stored_items[path] <= 0)
					stored_items -= path

	// If no active crafts, try to start new ones
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
				for(var/datum/container_craft_operation/op in GLOB.active_container_crafts)
					if(op.crafter == host)
						for(var/path in op.stored_items)
							stored_items[path] -= op.stored_items[path]
							if(stored_items[path] <= 0)
								stored_items -= path
