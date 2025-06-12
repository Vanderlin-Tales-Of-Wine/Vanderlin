SUBSYSTEM_DEF(bounties)
	name = "Matthios's Tasks"
	wait = 0.5 SECONDS
	flags = SS_KEEP_TIMING | SS_NO_INIT | SS_BACKGROUND
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME


/datum/controller/subsystem/bounties/fire(resumed)
	for(var/obj/structure/bounty_board/board in GLOB.bounty_boards)
		board.process_contracts()

		// Check area completions for all bounty hunters
		for(var/mob/living/harlequinn in GLOB.player_list) // could probably add a list here specifically for this but thats a later me thing
			if(!board.is_bounty_hunter(harlequinn))
				continue
			for(var/obj/effect/landmark/bounty_location/location in GLOB.bounty_locations)
				board.check_area_completion(harlequinn, location)
