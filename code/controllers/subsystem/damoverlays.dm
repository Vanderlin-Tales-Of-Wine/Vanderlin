SUBSYSTEM_DEF(damoverlays)
	name = "damoverlays"
	wait = 20
	flags = SS_NO_INIT
	priority = 1
	var/list/currentrun = list()
	var/list/processing = list()
	processing_flag = PROCESSING_DAMOVERLAYS

/datum/controller/subsystem/damoverlays/fire(resumed = 0)
	if (!resumed || !src.currentrun.len)
		src.currentrun = processing.Copy()

	//cache for sanic speed (lists are references anyways)
	var/list/currentrun = src.currentrun

	while(currentrun.len)
		var/mob/living/carbon/human/thing = currentrun[currentrun.len]
		currentrun.len--
		if (!thing || QDELETED(thing))
			processing -= thing
			if(MC_TICK_CHECK)
				return
			continue
		if(istype(thing))
			thing.update_damage_overlays_real()
		STOP_PROCESSING(SSdamoverlays, thing)
		if(MC_TICK_CHECK)
			return
