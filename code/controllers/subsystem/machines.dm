SUBSYSTEM_DEF(machines)
	name = "Machines"
	init_order = INIT_ORDER_MACHINES
	flags = SS_KEEP_TIMING
//	wait = 1
	var/list/processing = list()
	var/list/currentrun = list()

/datum/controller/subsystem/machines/Initialize()
	fire()
	return ..()

/datum/controller/subsystem/machines/stat_entry()
	..("M:[processing.len]")


/datum/controller/subsystem/machines/fire(resumed = 0)
	if (!resumed)
		src.currentrun = processing.Copy()

	//cache for sanic speed (lists are references anyways)
	var/list/currentrun = src.currentrun

	var/seconds = wait * 0.1
	while(currentrun.len)
		var/obj/machinery/thing = currentrun[currentrun.len]
		currentrun.len--
		if(!QDELETED(thing) && thing.process(seconds) != PROCESS_KILL)
			continue
		else
			processing -= thing
		if (MC_TICK_CHECK)
			return

/datum/controller/subsystem/machines/Recover()
	if (istype(SSmachines.processing))
		processing = SSmachines.processing
