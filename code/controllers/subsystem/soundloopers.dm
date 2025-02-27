
SUBSYSTEM_DEF(soundloopers)
	name = "soundloopers"
	wait = 1
	flags = SS_NO_INIT
	priority = FIRE_PRIORITY_DEFAULT
	var/list/processing = list()
	var/list/currentrun = list()

/datum/controller/subsystem/soundloopers/fire(resumed = 0)
	if (!resumed || !currentrun.len)
		src.currentrun = processing.Copy()

	//cache for sanic speed (lists are references anyways)
	var/list/current = src.currentrun

	while (current.len)
		var/datum/looping_sound/thing = current[current.len]
		current.len--
		if (!thing || QDELETED(thing))
			processing -= thing
			if (MC_TICK_CHECK)
				return
			continue
		if(thing.sound_loop())
			STOP_PROCESSING(SSsoundloopers, thing)
		if (MC_TICK_CHECK)
			return
