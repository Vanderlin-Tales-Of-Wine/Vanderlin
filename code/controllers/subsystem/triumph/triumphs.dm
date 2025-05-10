/*
	A fun fact is that it is important to note triumph procs all used key, whilas player quality likes to use ckey
	It doesn't help that the params to insert a json key in both are just key to go with byond clients having a ckey and key

	As to how it currently saves, loads, and decides what decides to get wiped. Here is the following information:

	When client joins -
		We get their triumphs from their saved file
		If the version number is below the current wipe season we put them back to 0
		It is then cached into a global list attached to their ckey

	Was running into issues saving this all at server reboot
	Thusly triumphs all jus save into individual files everytime its ran into
	triumph_adjust()

	Simple enough
*/

//To note any triumph files that try to be loaded in at a lower number than current wipe season get wiped.
// Also we have to handle this here cause the triumphs ss might get loaded too late to handle clients joining fast enough
GLOBAL_VAR_INIT(triumph_wipe_season, get_triumph_wipe_season())
/proc/get_triumph_wipe_season()
	var/current_wipe_season
	var/json_file = file("data/triumph_wipe_season.json")
	if(!fexists(json_file)) // If theres no file we start from the beginning lol
		var/list/uhh_ohhh = list("current_wipe_season" = 1)
		current_wipe_season = 1
		WRITE_FILE(json_file, json_encode(uhh_ohhh))
		return current_wipe_season

	var/list/json = json_decode(file2text(json_file))
	current_wipe_season = json["current_wipe_season"]

	return current_wipe_season

// I need some shit early v early, so uhhh enjoy having lists on the define
SUBSYSTEM_DEF(triumphs)
	name = "Triumphs"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_TRIUMPHS
	lazy_load = FALSE

	// List of top ten for display in browser page on button click
	var/list/triumph_leaderboard = list()
	var/triumph_leaderboard_positions_tracked = 21

	// A cache for triumphs
	// Basically when client first hops in for the session we will cram their ckey in and retrieve from file
	// When the server session is about to end we will write it all in.
	var/list/triumph_amount_cache = list()

/*
	TRIUMPH BUY MENU THINGS
*/
	// Whether triumph buys are enabled
	var/triumph_buys_enabled = TRUE
	//init list to hold triumph buy menus for the session (aka menu data)
	// Assc list "ckey" = datum
	var/list/active_triumph_menus = list()

	// display limit per page in a category on the user menu
	var/page_display_limit = 12

	// This represents the triumph buy organization on the main SS for triumphs
	// Each key is a category name
	// And then the list will have a number in a string that leads to a list of datums
	var/list/list/list/central_state_data = list( // this is updated to be a list of lists in subsystem Initialize
		TRIUMPH_CAT_ROUND_EFX = 0,
		TRIUMPH_CAT_CHARACTER = 0,
		TRIUMPH_CAT_MISC = 0,
		TRIUMPH_CAT_ACTIVE_DATUMS = 0
	)


/*
	TRIUMPH BUY DATUM THINGS
*/

	var/current_refund_percentage = 1.00 // Current refund percentage is 100%
	//this is basically the total list of triumph buy datums on init
	var/list/triumph_buy_datums = list()

	// This is a list of all active datums
	var/list/active_triumph_buy_queue = list()

	// These get on_activate() called in /datum/outfit/job/post_equip() in roguetown.dm
	var/list/post_equip_calls = list()

/datum/controller/subsystem/triumphs/Initialize()
	. = ..()

	prep_the_triumphs_leaderboard()


	for(var/cur_path in subtypesof(/datum/triumph_buy))
		var/datum/triumph_buy/cur_datum = new cur_path // We will do this
		triumph_buy_datums += cur_datum
		central_state_data[cur_datum.category] += 1 // Tally up the totals here to save on a total of one loop

	// Make a local copy I guess?
	var/list/copy_list = triumph_buy_datums.Copy()

	//Figure out how many lists we are about to make to represent the pages
	for(var/catty_key in central_state_data)
		var/page_count = ceil(central_state_data[catty_key]/page_display_limit) // Get the page count total
		central_state_data[catty_key] = list() // Now we swap the numbers out for lists on each cat as it will contain lists representing one page

		// Now fill in the lists starting at index "1"
		for(var/page_numba in 1 to page_count)
			central_state_data[catty_key]["[page_numba]"] = list()
			for(var/ii = copy_list.len, ii > 0, ii--)
				var/datum/triumph_buy/current_triumph_buy_datum = copy_list[ii]
				if(current_triumph_buy_datum.category == catty_key)
					central_state_data[catty_key]["[page_numba]"] += current_triumph_buy_datum
					copy_list -= current_triumph_buy_datum
				if(central_state_data[catty_key]["[page_numba]"].len == page_display_limit)
					break

/*
	This occurs when you try to buy a triumph condition and sets it up
*/
/datum/controller/subsystem/triumphs/proc/attempt_to_buy_triumph_condition(client/C, datum/triumph_buy/ref_datum)
	// This segments the payment part
	var/triumph_amount = get_triumphs(C.ckey) - ref_datum.triumph_cost
	if(triumph_amount >= 0)
		triumph_adjust(ref_datum.triumph_cost*-1, C.ckey)

		var/datum/triumph_buy/stick_it_in = new ref_datum.type

		stick_it_in.key_of_buyer = C.key
		stick_it_in.ckey_of_buyer = C.ckey
		active_triumph_buy_queue += stick_it_in

		// The thing someone is buying conflicts with things
		if(stick_it_in.conflicts_with.len)
			for(var/cur_check_path in stick_it_in.conflicts_with) // Time to refund anything already bought it personally hates
				for(var/datum/triumph_buy/active_datum in active_triumph_buy_queue)
					if(ispath(cur_check_path, active_datum.type))
						attempt_to_unbuy_triumph_condition(C, active_datum, reason = "CONFLICTS")

		stick_it_in.on_buy()
		call_menu_refresh()
/**
	This occurs when you try to unbuy a triumph condition and removes it
	Also used for refunding due to conflicts
 */
/datum/controller/subsystem/triumphs/proc/attempt_to_unbuy_triumph_condition(client/C, datum/triumph_buy/pull_it_out, reason = "\improper UNBUY")
	var/ckey_prev_owna = pull_it_out.ckey_of_buyer
	var/refund_amount = round(pull_it_out.triumph_cost * current_refund_percentage)
	triumph_adjust(refund_amount, ckey_prev_owna)
	if(GLOB.directory[ckey_prev_owna]) // If they are still logged into the game, inform them they got refunded
		to_chat(GLOB.directory[ckey_prev_owna], span_redtext("You were refunded [refund_amount] triumph\s due to \a [reason]."))
	pull_it_out.on_removal()
	active_triumph_buy_queue -= pull_it_out
	return TRUE

// Same deal as the role class stuff, we are only really just caching this to update displays as people buy stuff.
// So we have to be careful to not leave it in when unneeded otherwise we will have to keep track of which menus are actually open.
/datum/controller/subsystem/triumphs/proc/startup_triumphs_menu(client/C)
	if(!triumph_buys_enabled)
		return
	if(C)
		var/datum/triumph_buy_menu/check_this = active_triumph_menus[C.ckey]
		if(check_this)
			check_this.linked_client = C
			check_this.triumph_menu_startup_slop()
		else
			var/datum/triumph_buy_menu/BIGBOY = new()
			BIGBOY.linked_client = C
			active_triumph_menus[C.ckey] = BIGBOY
			BIGBOY.triumph_menu_startup_slop()

/*
	This tells all alive triumph datums to re_update their visuals, shitty but ya
*/
/datum/controller/subsystem/triumphs/proc/call_menu_refresh()
	for(var/MENS in active_triumph_menus)
		var/datum/triumph_buy_menu/current_view = active_triumph_menus[MENS]
		if(!current_view) // Insure we actually have something yes?
			active_triumph_menus.Remove(MENS)
			continue

		if(!current_view.linked_client) // We have something and it has no client
			active_triumph_menus.Remove(MENS)
			qdel(current_view)
			continue

		current_view.show_menu()


// We cleanup the datum thats just holding the stuff for displaying the menu.
/datum/controller/subsystem/triumphs/proc/remove_triumph_buy_menu(client/C)
	if(C && active_triumph_menus[C.ckey])
		var/datum/triumph_buy_menu/me_local = active_triumph_menus[C.ckey]
		C << browse(null, "window=triumph_buy_window")
		active_triumph_menus.Remove(C.ckey)
		qdel(me_local)

// Called from the place its slopped in in SSticker, this will occur right after the gamemode starts ideally, aka roundstart.
/datum/controller/subsystem/triumphs/proc/fire_on_PostSetup()
	call_menu_refresh()

/*
	We save everything when its time for reboot
*/
/datum/controller/subsystem/triumphs/proc/end_triumph_saving_time()
	to_chat(world, "<span class='boldannounce'> Recording VICTORIES to the WORLD END MACHINE. </span>")
	//for(var/target_ckey in triumph_amount_cache)
	//	var/list/saving_data = list()
	//	// this will be for example "data/player_saves/a/ass/triumphs.json" if their ckey was ass
	//	var/target_file = file("data/player_saves/[target_ckey[1]]/[target_ckey]/triumphs.json")
	//	if(fexists(target_file))
	//		fdel(target_file)
//
//		saving_data["triumph_wipe_season"] = GLOB.triumph_wipe_season
//		saving_data["triumph_count"] = triumph_amount_cache[target_ckey]
//
//		WRITE_FILE(target_file, json_encode(saving_data))

	// handle the leaderboard here too i guess
	var/leaderboard_file = file("data/triumph_leaderboards/triumphs_leaderboard_season_[GLOB.triumph_wipe_season].json")
	if(fexists(leaderboard_file))
		fdel(leaderboard_file)
	WRITE_FILE(leaderboard_file, json_encode(triumph_leaderboard))



// Adjust triumphs
/datum/controller/subsystem/triumphs/proc/triumph_adjust(amt, target_ckey)
	if(target_ckey in triumph_amount_cache)
		triumph_amount_cache[target_ckey] += amt
		var/list/saving_data = list()
		var/target_file = file("data/player_saves/[target_ckey[1]]/[target_ckey]/triumphs.json")
		if(fexists(target_file))
			fdel(target_file)

		saving_data["triumph_wipe_season"] = GLOB.triumph_wipe_season
		saving_data["triumph_count"] = triumph_amount_cache[target_ckey]
		WRITE_FILE(target_file, json_encode(saving_data))
	else
		triumph_amount_cache[target_ckey] = 0


// Wipe the triumphs of one person
/datum/controller/subsystem/triumphs/proc/wipe_target_triumphs(target_ckey)
	if(target_ckey)
		if(!(target_ckey in triumph_amount_cache))
			return
		else
			triumph_amount_cache[target_ckey] = 0

// Wipe the entire list
// Adjust the season up by 1 too so anyone behind gets wiped if they rejoin later
/datum/controller/subsystem/triumphs/proc/wipe_all_triumphs(target_ckey)
	if(!target_ckey)
		return
	triumph_amount_cache = list()

	var/target_file = file("data/triumph_wipe_season.json")
	GLOB.triumph_wipe_season += 1
	var/list/wipe_season = list("current_wipe_season" = GLOB.triumph_wipe_season)
	fdel(target_file)
	WRITE_FILE(target_file, json_encode(wipe_season))

	// Wipe the leaderboard list, time for a fresh season.
	// But leave the old leaderboard file in, we mite do somethin w it later
	triumph_leaderboard = list()

// Return a value of the triumphs they got
/datum/controller/subsystem/triumphs/proc/get_triumphs(target_ckey)
	if(!(target_ckey in triumph_amount_cache))
		var/target_file = file("data/player_saves/[target_ckey[1]]/[target_ckey]/triumphs.json")
		if(!fexists(target_file)) // no file or new player, write them in something
			var/list/new_guy = list("triumph_count" = 0, "triumph_wipe_season" = GLOB.triumph_wipe_season)
			WRITE_FILE(target_file, json_encode(new_guy))
			triumph_amount_cache[target_ckey] = 0
			return 0

		// This is not a new guy
		var/list/not_new_guy = json_decode(file2text(target_file))
		if(GLOB.triumph_wipe_season > not_new_guy["triumph_wipe_season"]) // Their file is behind in wipe seasons, time to be set to 0
			triumph_amount_cache[target_ckey] = 0
			return 0

		var/cur_client_triumph_count = not_new_guy["triumph_count"]
		triumph_amount_cache[target_ckey] = cur_client_triumph_count
		return cur_client_triumph_count

	return triumph_amount_cache[target_ckey]


/*
	TRIUMPH LEADERBOARD STUFF
*/
// Display leaderboard browser popup
/datum/controller/subsystem/triumphs/proc/show_triumph_leaderboard(client/C)

	var/webpagu = "<B>CHAMPIONS OF PSYDONIA</B><br>"
	webpagu += "Current Season: [GLOB.triumph_wipe_season]"
	webpagu += "<hr><br>"

	if(triumph_leaderboard.len)
		var/position_number = 0
		for(var/key in triumph_leaderboard)
			position_number++
			webpagu += "[position_number]. [key] - [triumph_leaderboard[key]]<br>"
			if(position_number >= triumph_leaderboard_positions_tracked)
				break
	else
		webpagu += "The hall of triumphs is quite empty, Yes?"

	C << browse(webpagu, "window=triumph_leaderboard;size=300x500")

// PREP THE BOARD
/datum/controller/subsystem/triumphs/proc/prep_the_triumphs_leaderboard()
	var/json_file = file("data/triumph_leaderboards/triumphs_leaderboard_season_[GLOB.triumph_wipe_season].json")
	if(!fexists(json_file)) // If theres no file then fuck you!
		return // we got a empty list up there neways

	triumph_leaderboard = json_decode(file2text(json_file))

	sort_leaderboard()

// Adjust leaderboard
// I want a key here so it looks pretty
/datum/controller/subsystem/triumphs/proc/adjust_leaderboard(CLIENT_KEY_not_CKEY)
	var/user_key = CLIENT_KEY_not_CKEY
	var/triumph_total = triumph_amount_cache[ckey(CLIENT_KEY_not_CKEY)]

	if(5 > triumph_total) // You aren't tracked at all unless you got at least 5, no iterating a bunch of losers repeatedly
		return

	// You automatically get added in if we haven't filled in all the crap
	if(triumph_leaderboard_positions_tracked > triumph_leaderboard.len)
		triumph_leaderboard[user_key] = triumph_total

	// Guy in last place is still greater than this guy
	if(triumph_leaderboard[triumph_leaderboard[triumph_leaderboard.len]] > triumph_total)
		return

	triumph_leaderboard.Cut(triumph_leaderboard.len) // Cut the end
	triumph_leaderboard[user_key] = triumph_total // Add our guy to the end

	sort_leaderboard() // Now sort it, sort it NOW!

// Sort what we got
/datum/controller/subsystem/triumphs/proc/sort_leaderboard()
	if(length(triumph_leaderboard) <= 1)
		return

	var/list/sorted_list = list()
	for(var/cache_key in triumph_leaderboard)
		for(var/sorted_key in sorted_list)
			var/their_triumphs = sorted_list[sorted_key]
			var/our_triumphs = triumph_leaderboard[cache_key]
			if(our_triumphs >= their_triumphs)
				sorted_list.Insert(sorted_list.Find(sorted_key), cache_key)
				sorted_list[cache_key] = triumph_leaderboard[cache_key]
				break

		if(!sorted_list.Find(cache_key))
			sorted_list[cache_key] = triumph_leaderboard[cache_key]

	triumph_leaderboard = sorted_list
