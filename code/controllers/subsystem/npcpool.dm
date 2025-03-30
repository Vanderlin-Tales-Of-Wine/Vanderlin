SUBSYSTEM_DEF(npcpool)
	name = "NPC Pool"
	wait  = 1 SECONDS //doubles ai responsiveness
	flags = SS_POST_FIRE_TIMING|SS_NO_INIT|SS_BACKGROUND
	priority = FIRE_PRIORITY_NPC
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	var/list/currentrun = list()

/datum/controller/subsystem/npcpool/fire(resumed = FALSE)

	if (!resumed || !src.currentrun.len)
		var/list/activelist = GLOB.simple_animals["[AI_ON]"]
		src.currentrun = activelist.Copy()

	//cache for sanic speed (lists are references anyways)
	var/list/currentrun = src.currentrun

	while(currentrun.len)
		var/mob/living/simple_animal/SA = currentrun[currentrun.len]
		--currentrun.len

		if(SA)
			if(!SA.ckey && !SA.notransform)
				if(SA.stat != DEAD)
					SA.handle_automated_action()
				if(SA.stat != DEAD)
					SA.handle_automated_movement()
				if(SA.stat != DEAD)
					SA.handle_automated_speech()
		if (MC_TICK_CHECK)
			return

/datum/controller/subsystem/npcpool/proc/handle_automated_action(mob/living/simple_animal/mobinput)
	if(!mobinput)
		return
	if(QDELETED(mobinput))
		return
	mobinput.handle_automated_action()
	mobinput.action_skip = FALSE

/datum/controller/subsystem/npcpool/proc/handle_automated_movement(mob/living/simple_animal/mobinput)
	if(!mobinput)
		return
	if(QDELETED(mobinput))
		return
	mobinput.handle_automated_movement()
	mobinput.move_skip = FALSE
