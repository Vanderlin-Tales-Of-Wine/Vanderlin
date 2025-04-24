SUBSYSTEM_DEF(merchant)
	name = "Merchant Packs"
	wait = 60 SECONDS
	init_order = INIT_ORDER_DEFAULT
	runlevels = RUNLEVEL_SETUP | RUNLEVEL_GAME

	var/list/supply_packs = list()
	var/list/supply_cats = list()
	var/list/shoppinglist = list()
	var/list/requestlist = list()
	var/list/fencerequestlist = list()
	var/list/orderhistory = list()


	var/list/trade_requests = list()
	var/list/sending_stuff = list()

	var/datum/lift_master/tram/cargo_boat
	var/cargo_docked = TRUE

	var/list/world_factions = list()

	var/list/staticly_setup_types = list()

	var/datum/lift_master/tram/fence_boat
	var/fence_docked = TRUE

/datum/controller/subsystem/merchant/Initialize(timeofday)
	for(var/pack in subtypesof(/datum/supply_pack))
		var/datum/supply_pack/P = new pack()
		if(!P.contains)
			continue
		supply_packs[P.type] = P
		if(!(P.group in supply_cats))
			supply_cats += P.group
	for(var/faction in typesof(/datum/world_faction))
		var/datum/world_faction/made = new faction()
		world_factions |= made
	return ..()

/datum/controller/subsystem/merchant/fire(resumed)
	for(var/datum/world_faction/faction in world_factions)
		faction.handle_world_change()

/datum/controller/subsystem/merchant/proc/prepare_cargo_shipment()
	if(!cargo_boat || !cargo_docked)
		return

	draw_selling_changes()

	cargo_boat.show_tram()
	var/list/boat_spaces = list()
	for(var/obj/structure/industrial_lift/lift in cargo_boat.lift_platforms)
		boat_spaces |= cargo_boat.get_valid_turfs(lift)

	for(var/datum/supply_pack/requested as anything in requestlist)
		if(!requestlist[requested])
			continue
		var/turf/boat_turf = pick_n_take(boat_spaces)
		var/obj/structure/closet/crate/crate_to_use
		for(var/i in 1 to requestlist[requested])
			if(i == 1)
				crate_to_use = requested.generate(boat_turf)
			else
				requested.fill(crate_to_use)
		for(var/obj/structure/industrial_lift/lift in cargo_boat.lift_platforms)
			lift.held_cargo |= crate_to_use

	for(var/atom/movable/item as anything in sending_stuff)
		var/turf/boat_turf = pick(boat_spaces)
		if(ispath(item))
			new item(boat_turf)
		else
			item.forceMove(boat_turf)

	requestlist = list()
	cargo_docked = FALSE
	SEND_GLOBAL_SIGNAL(COMSIG_DISPATCH_CARGO, cargo_boat)

/datum/controller/subsystem/merchant/proc/send_cargo_ship_back()
	var/obj/effect/landmark/tram/queued_path/cargo_stop/cargo_stop = cargo_boat.idle_platform
	cargo_stop.UnregisterSignal(cargo_boat, COMSIG_TRAM_EMPTY)
	if(!SSticker.HasRoundStarted())
		return
	if(!cargo_stop.next_path_id)
		return
	var/obj/effect/landmark/tram/destination_platform
	for (var/obj/effect/landmark/tram/destination as anything in GLOB.tram_landmarks[cargo_stop.specific_lift_id])
		if(destination.platform_code == cargo_stop.next_path_id)
			destination_platform = destination
			break

	if (!destination_platform)
		return FALSE

	cargo_boat.tram_travel(destination_platform, rapid = FALSE)
	cargo_boat.callback_platform = destination_platform



/datum/controller/subsystem/merchant/proc/prepare_fence_shipment()
	if(!fence_boat || !fence_docked)
		return

	fence_boat.show_tram()
	var/list/boat_spaces = list()
	for(var/obj/structure/industrial_lift/lift in fence_boat.lift_platforms)
		boat_spaces |= fence_boat.get_valid_turfs(lift)

	for(var/atom/movable/request as anything in fencerequestlist)
		for(var/i = 1 to fencerequestlist[request])
			var/turf/boat_turf = pick_n_take(boat_spaces)
			var/atom/movable/new_item = new request
			new_item.forceMove(boat_turf)
			for(var/obj/structure/industrial_lift/lift in fence_boat.lift_platforms)
				lift.held_cargo |= new_item

	fencerequestlist = list()
	fence_docked = FALSE
	SEND_GLOBAL_SIGNAL(COMSIG_DISPATCH_CARGO, fence_boat)

/datum/controller/subsystem/merchant/proc/send_fence_ship_back()
	var/obj/effect/landmark/tram/queued_path/fence_stop/cargo_stop = fence_boat.idle_platform
	cargo_stop.UnregisterSignal(fence_boat, COMSIG_TRAM_EMPTY)
	if(!SSticker.HasRoundStarted())
		return
	if(!cargo_stop.next_path_id)
		return
	var/obj/effect/landmark/tram/destination_platform
	for (var/obj/effect/landmark/tram/destination as anything in GLOB.tram_landmarks[cargo_stop.specific_lift_id])
		if(destination.platform_code == cargo_stop.next_path_id)
			destination_platform = destination
			break

	if (!destination_platform)
		return FALSE

	fence_boat.tram_travel(destination_platform, rapid = FALSE)
	fence_boat.callback_platform = destination_platform

/datum/controller/subsystem/merchant/proc/adjust_sell_multiplier(obj/change_type, change = 0)
	var/datum/world_faction/active_faction = world_factions[1]//when world factions we change this
	active_faction.adjust_sell_multiplier(change_type, change)


/datum/controller/subsystem/merchant/proc/handle_selling(obj/selling_type)
	var/datum/world_faction/active_faction = world_factions[1]//when world factions we change this
	active_faction.handle_selling(selling_type)

/datum/controller/subsystem/merchant/proc/changed_sell_prices(atom/atom_type, old_price, new_price)
	var/datum/world_faction/active_faction = world_factions[1]//when world factions we change this
	active_faction.changed_sell_prices(atom_type, old_price, new_price)

/datum/controller/subsystem/merchant/proc/draw_selling_changes()
	for(var/datum/world_faction/active_faction in world_factions)
		active_faction.draw_selling_changes()

/datum/controller/subsystem/merchant/proc/return_sell_modifier(atom/sell_type)
	var/datum/world_faction/active_faction = world_factions[1]
	return active_faction.return_sell_modifier(sell_type)

/datum/controller/subsystem/merchant/proc/set_faction_sell_values(atom/sell_type)
	staticly_setup_types |= sell_type
	for(var/datum/world_faction/active_faction in world_factions)
		active_faction.setup_sell_data(sell_type)

/obj/Initialize()
	. = ..()
	if(sellprice)
		if(!(type in SSmerchant.staticly_setup_types))
			SSmerchant.set_faction_sell_values(type)
