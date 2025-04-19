//Dead mobs can exist whenever. This is needful

INITIALIZE_IMMEDIATE(/mob/dead)

/mob/dead
	sight = SEE_TURFS | SEE_MOBS | SEE_OBJS | SEE_SELF
	move_resist = INFINITY
	throwforce = 0

/mob/dead/Initialize()
	SHOULD_CALL_PARENT(FALSE)
	if(flags_1 & INITIALIZED_1)
		stack_trace("Warning: [src]([type]) initialized multiple times!")
	flags_1 |= INITIALIZED_1
	tag = "mob_[next_mob_id++]"
	GLOB.mob_list += src

	prepare_huds()

	if(length(CONFIG_GET(keyed_list/cross_server)))
		verbs += /mob/dead/proc/server_hop
	set_focus(src)
	return INITIALIZE_HINT_NORMAL

/mob/dead/Destroy()
	GLOB.mob_list -= src
	return ..()

/mob/dead/canUseStorage()
	return FALSE

/mob/dead/dust(just_ash, drop_items, force)	//ghosts can't be vaporised.
	return

/mob/dead/gib()		//ghosts can't be gibbed.
	return

/mob/dead/ConveyorMove()	//lol
	return

/mob/dead/forceMove(atom/destination)
	var/turf/old_turf = get_turf(src)
	var/turf/new_turf = get_turf(destination)
	if (old_turf?.z != new_turf?.z)
		onTransitZ(old_turf?.z, new_turf?.z)
	var/oldloc = loc
	loc = destination
	Moved(oldloc, NONE, TRUE)


/mob/dead/new_player/proc/lobby_refresh()
	set waitfor = 0

	if(!client)
		return

	if(client.is_new_player())
		return

	if(SSticker.HasRoundStarted())
		src << browse(null, "window=lobby_window")
		return

	var/list/dat = list("<center>")

	var/time_remaining = SSticker.GetTimeLeft()
	if(time_remaining > 0)
		dat += "Time To Start: [round(time_remaining/10)]s<br>"
	else if(time_remaining == -10)
		dat += "Time To Start: DELAYED<br>"
	else
		dat += "Time To Start: SOON<br>"

	dat += "Total players ready: [SSticker.totalPlayersReady]<br>"
	dat += "<B>Classes:</B><br>"

	dat += "</center>"

	for(var/datum/job/job in SSjob.joinable_occupations)
		if(!job)
			continue
		if(!job.shows_in_list)
			continue
		var/readied_as = 0
		var/list/PL = list()
		for(var/mob/dead/new_player/player in GLOB.player_list)
			// Are we ready?
			if(!player)
				continue
			if(player.client.prefs.job_preferences[job.title] != JP_HIGH)
				//i'm sorry for doing this
				if(!is_adventurer_job(job) || player.client.prefs.job_preferences["Court Agent"] != JP_HIGH)
					continue
			if(player.ready != PLAYER_READY_TO_PLAY)
				continue

			// We are ready
			readied_as++
			// But do we show them?

			// We will show them
			if(player.client.prefs.real_name)
				var/thing = "[player.client.prefs.real_name]"
				PL += thing

		var/list/PL2 = list()
		for(var/i in 1 to PL.len)
			if(i == PL.len)
				PL2 += "[PL[i]]"
			else
				PL2 += "[PL[i]], "

		var/str_job = job.title
		if(readied_as)
			if(PL2.len)
				dat += "<B>[str_job]</B> ([readied_as]) - [PL2.Join()]<br>"
			else
				dat += "<B>[str_job]</B> ([readied_as])<br>"

	var/datum/browser/popup = new(src, "lobby_window", "<div align='center'>LOBBY</div>", 330, 430)
	popup.set_window_options(can_minimize = FALSE, can_maximize = FALSE, can_resize = TRUE)
	popup.set_content(dat.Join())
	if(!client)
		return
	if(winexists(src, "lobby_window"))
		src << browse(popup.build_page(), "window=lobby_window") //dont update the size or annoyingly refresh
		qdel(popup)
		return
	else
		popup.open(FALSE)

/mob/dead/proc/server_hop()
	set category = "OOC"
	set name = "Server Hop!"
	set desc= "Jump to the other server"
	set hidden = 1
	if(notransform)
		return
	var/list/csa = CONFIG_GET(keyed_list/cross_server)
	var/pick
	switch(csa.len)
		if(0)
			verbs -= /mob/dead/proc/server_hop
			to_chat(src, "<span class='notice'>Server Hop has been disabled.</span>")
		if(1)
			pick = csa[1]
		else
			pick = input(src, "Pick a server to jump to", "Server Hop") as null|anything in csa

	if(!pick)
		return

	var/addr = csa[pick]

	if(alert(src, "Jump to server [pick] ([addr])?", "Server Hop", "Yes", "No") != "Yes")
		return

	var/client/C = client
	to_chat(C, "<span class='notice'>Sending you to [pick].</span>")
	new /atom/movable/screen/splash(C)

	notransform = TRUE
	sleep(29)	//let the animation play
	notransform = FALSE

	if(!C)
		return

	winset(src, null, "command=.options") //other wise the user never knows if byond is downloading resources

	C << link("[addr]?server_hop=[key]")

/mob/dead/proc/update_z(new_z) // 1+ to register, null to unregister
	if (registered_z != new_z)
		if (registered_z)
			SSmobs.dead_players_by_zlevel[registered_z] -= src
		if (client)
			if (new_z)
				SSmobs.dead_players_by_zlevel[new_z] += src
			registered_z = new_z
		else
			registered_z = null

/mob/dead/Login()
	. = ..()
	var/turf/T = get_turf(src)
	if (isturf(T))
		update_z(T.z)

/mob/dead/auto_deadmin_on_login()
	return

/mob/dead/Logout()
	update_z(null)
	return ..()

/mob/dead/onTransitZ(old_z,new_z)
	..()
	update_z(new_z)
