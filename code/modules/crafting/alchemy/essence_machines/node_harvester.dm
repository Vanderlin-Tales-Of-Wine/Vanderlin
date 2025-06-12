/obj/machinery/essence/harvester
	name = "essence harvester"
	desc = "A mechanical device that can be fitted with essence nodes to automatically extract their essence."
	icon = 'icons/roguetown/misc/splitter.dmi'
	icon_state = "splitter"
	density = TRUE
	anchored = TRUE

	var/obj/structure/essence_node/installed_node
	var/harvest_rate = 2 // Essence per process cycle
	var/efficiency_bonus = 1.5 // Multiplier for installed node recharge

	var/datum/essence_storage/storage

/obj/machinery/essence/harvester/Initialize()
	. = ..()
	storage = new /datum/essence_storage(src)
	storage.max_total_capacity = 500
	storage.max_essence_types = 10
	START_PROCESSING(SSobj, src)

/obj/machinery/essence/harvester/Destroy()
	STOP_PROCESSING(SSobj, src)
	if(storage)
		qdel(storage)
	if(installed_node)
		installed_node.forceMove(get_turf(src))
	installed_node = null
	return ..()

/obj/machinery/essence/harvester/update_icon()
	. = ..()
	cut_overlays()
	if(installed_node)
		var/mutable_appearance/node = mutable_appearance(installed_node.icon, installed_node.icon_state)
		node.color = installed_node.color
		node.layer = layer + 0.1
		node.pixel_y = 12
		overlays += node

		var/mutable_appearance/node_emissive = mutable_appearance(installed_node.icon, installed_node.icon_state)
		node_emissive.plane = EMISSIVE_PLANE
		node_emissive.pixel_y = 12
		overlays += node_emissive

/obj/machinery/essence/harvester/return_storage()
	return storage

/obj/machinery/essence/harvester/process()
	if(!installed_node)
		return

	if(installed_node.current_essence < installed_node.max_essence && world.time >= installed_node.last_recharge + 1 MINUTES)
		var/boosted_recharge = round(installed_node.recharge_rate * efficiency_bonus)
		installed_node.current_essence = min(installed_node.max_essence, installed_node.current_essence + boosted_recharge)
		installed_node.last_recharge = world.time
		installed_node.update_icon()

	if(installed_node.current_essence > 0)
		var/harvest_amount = min(installed_node.current_essence, harvest_rate)
		if(harvest_amount > 0 && storage.add_essence(installed_node.essence_type.type, harvest_amount))
			installed_node.current_essence -= harvest_amount
			installed_node.update_icon()
			create_harvest_effect()

	if(!connection_processing || !output_connections.len)
		return
	var/list/prioritized_connections = sort_connections_by_priority(output_connections)
	for(var/datum/essence_connection/connection in prioritized_connections)
		if(!connection.active || !connection.target)
			continue
		var/datum/essence_storage/target_storage = get_target_storage(connection.target)
		if(!target_storage)
			continue
		var/essence_transferred = FALSE
		for(var/essence_type in storage.stored_essences)
			var/available = storage.get_essence_amount(essence_type)
			if(available > 0)
				if(!can_target_accept_essence(connection.target, essence_type))
					continue

				var/to_transfer = min(available, connection.transfer_rate)
				var/transferred = storage.transfer_to(target_storage, essence_type, to_transfer)
				if(transferred > 0)
					create_essence_transfer_effect(connection.target, essence_type, transferred)
					essence_transferred = TRUE
					break // Only transfer one type per cycle per connection

		if(essence_transferred)
			continue

/obj/machinery/essence/harvester/proc/install_node(obj/structure/essence_node/node, mob/user)
	if(installed_node)
		to_chat(user, span_warning("There's already a node installed."))
		return FALSE

	if(!user.temporarilyRemoveItemFromInventory(node))
		return FALSE

	installed_node = node
	node.forceMove(src)
	STOP_PROCESSING(SSobj, node)

	var/datum/thaumaturgical_essence/temp = new node.essence_type.type
	to_chat(user, span_info("You install the [node.name] into the harvester. It will now automatically extract [temp.name]."))
	qdel(temp)

	update_icon()
	return TRUE


/obj/machinery/essence/harvester/proc/remove_node(mob/user)
	if(!installed_node)
		to_chat(user, span_warning("No node is installed."))
		return

	var/obj/structure/essence_node/structure_node = new(get_turf(src))
	structure_node.essence_type = installed_node.essence_type
	structure_node.tier = installed_node.tier
	structure_node.max_essence = installed_node.max_essence
	structure_node.current_essence = installed_node.current_essence
	structure_node.recharge_rate = installed_node.recharge_rate
	structure_node.update_icon()

	to_chat(user, span_info("You carefully remove the essence node from the harvester and deploy it nearby."))

	qdel(installed_node)
	installed_node = null
	update_icon()

/obj/machinery/essence/harvester/proc/create_harvest_effect()
	new /obj/effect/temp_visual/harvest_glow(get_turf(src))

/obj/machinery/essence/harvester/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/essence_node_jar))
		var/obj/item/essence_node_jar/jar = I
		if(jar.contained_node)
			if(installed_node)
				to_chat(user, span_warning("There's already a node installed."))
				return

			var/obj/item/essence_node_portable/portable = jar.contained_node
			jar.contained_node = null
			jar.update_icon()

			installed_node = portable
			portable.forceMove(src)
			STOP_PROCESSING(SSobj, portable)

			var/datum/thaumaturgical_essence/temp = new portable.essence_type.type
			to_chat(user, span_info("You install the essence node from the jar into the harvester. It will now automatically extract [temp.name]."))
			qdel(temp)

			update_icon()
		else
			to_chat(user, span_warning("The jar is empty."))
		return
	return ..()

/obj/machinery/essence/harvester/attack_hand(mob/user)
	. = ..()
	var/list/options = list()

	if(installed_node)
		options["Remove Node"] = "remove"
		options["View Node Status"] = "status"
	else
		options["Install Node"] = "install_info"

	options["View Storage"] = "storage"
	options["Cancel"] = "cancel"

	var/choice = input(user, "Harvester Control", "Essence Harvester") in options
	if(!choice || choice == "cancel")
		return

	switch(choice)
		if("remove")
			remove_node(user)
		if("install_info")
			to_chat(user, span_info("Use an essence node or node jar on the harvester to install it."))
		if("status")
			if(installed_node)
				var/datum/thaumaturgical_essence/temp = new installed_node.essence_type.type
				to_chat(user, span_info("Installed Node: [installed_node.name] (Tier [installed_node.tier])"))
				to_chat(user, span_info("Essence Type: [temp.name]"))
				to_chat(user, span_info("Node Essence: [installed_node.current_essence]/[installed_node.max_essence]"))
				to_chat(user, span_info("Recharge Rate: [round(installed_node.recharge_rate * efficiency_bonus)] essence/min (boosted)"))
				to_chat(user, span_info("Harvest Rate: [harvest_rate] essence/cycle"))
				qdel(temp)
		if("storage")
			to_chat(user, span_info("Storage: [storage.get_total_stored()]/[storage.max_total_capacity] units"))
			if(storage.stored_essences.len > 0)
				for(var/essence_type in storage.stored_essences)
					var/datum/thaumaturgical_essence/essence = new essence_type
					to_chat(user, span_info("- [essence.name]: [storage.stored_essences[essence_type]] units"))
					qdel(essence)

/obj/machinery/essence/harvester/examine(mob/user)
	. = ..()
	. += span_notice("Harvest Rate: [harvest_rate] essence per cycle")
	. += span_notice("Node Efficiency Bonus: +[round((efficiency_bonus - 1) * 100)]% recharge rate")
	. += span_notice("Storage: [storage.get_total_stored()]/[storage.max_total_capacity] units")

	if(installed_node)
		var/datum/thaumaturgical_essence/temp = new installed_node.essence_type.type
		if(HAS_TRAIT(user, TRAIT_LEGENDARY_ALCHEMIST))
			. += span_notice("Installed: [installed_node.name] ([temp.name], Tier [installed_node.tier])")
		else
			. += span_notice("Installed: [installed_node.name] (essence smelling of [temp.smells_like], Tier [installed_node.tier])")
		. += span_notice("Node Essence: [installed_node.current_essence]/[installed_node.max_essence]")
		qdel(temp)
	else
		. += span_notice("No node installed. Use an essence node or containment jar to install one.")

// Visual effect for harvesting
/obj/effect/temp_visual/harvest_glow
	icon = 'icons/effects/effects.dmi'
	icon_state = "electricity"
	duration = 2 SECONDS

// Mapgen proc for spawning nodes as items
/proc/spawn_essence_nodes_in_area(area/target_area, node_density = 0.05, allow_rare = FALSE)
	var/list/valid_turfs = list()

	for(var/turf/T in target_area)
		if(T.density)
			continue
		if(locate(/obj/structure/essence_node) in T)
			continue
		valid_turfs += T

	var/nodes_to_spawn = round(valid_turfs.len * node_density)

	for(var/i = 1 to nodes_to_spawn)
		if(!valid_turfs.len)
			break

		var/turf/spawn_turf = pick(valid_turfs)
		valid_turfs -= spawn_turf

		var/node_type = /obj/structure/essence_node

		// Rare nodes only in dungeons
		if(allow_rare && prob(5)) // 5% chance for rare
			node_type = /obj/structure/essence_node/rare

		new node_type(spawn_turf)
