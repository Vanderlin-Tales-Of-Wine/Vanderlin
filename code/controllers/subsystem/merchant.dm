SUBSYSTEM_DEF(merchant)
	name = "Merchant Packs"
	wait = 10
	init_order = INIT_ORDER_DEFAULT
	runlevels = RUNLEVEL_SETUP | RUNLEVEL_GAME
	flags = SS_NO_FIRE

	var/list/supply_packs = list()
	var/list/supply_cats = list()
	var/list/shoppinglist = list()
	var/list/requestlist = list()
	var/list/fencerequestlist = list()
	var/list/orderhistory = list()


	var/datum/lift_master/tram/cargo_boat
	var/cargo_docked = TRUE

	var/datum/lift_master/tram/fence_boat
	var/fence_docked = TRUE

/datum/controller/subsystem/merchant/Initialize(timeofday)
	for(var/pack in subtypesof(/datum/supply_pack/rogue))
		var/datum/supply_pack/P = new pack()
		if(!P.contains)
			continue
		supply_packs[P.type] = P
		if(!(P.group in supply_cats))
			supply_cats += P.group
	return ..()


/datum/controller/subsystem/merchant/proc/prepare_cargo_shipment()
	if(!cargo_boat || !cargo_docked)
		return

	cargo_boat.show_tram()
	var/list/boat_spaces = list()
	for(var/obj/structure/industrial_lift/lift in cargo_boat.lift_platforms)
		boat_spaces |= lift.locs
		boat_spaces -= get_turf(lift)
	for(var/atom/movable/request as anything in requestlist)
		var/turf/boat_turf = pick_n_take(boat_spaces)
		var/atom/movable/new_item = new request
		new_item.forceMove(boat_turf)
		for(var/obj/structure/industrial_lift/lift in cargo_boat.lift_platforms)
			lift.held_cargo |= new_item

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
		boat_spaces |= lift.locs
		boat_spaces -= get_turf(lift)
	for(var/atom/movable/request as anything in fencerequestlist)
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
