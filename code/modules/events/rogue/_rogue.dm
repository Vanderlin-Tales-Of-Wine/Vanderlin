//GLOBAL_LIST_INIT(badomens, list("roundstart"))
GLOBAL_LIST_INIT(badomens, list())

/datum/round_event_control/rogue
	name = null

/datum/round_event_control/rogue/canSpawnEvent()
	. = ..()
	if(!.)
		return .
	var/datum/game_mode/chaosmode/C = SSticker.mode
	if(istype(C))
		if(C.allmig || C.roguefight)
			return FALSE
	if(!name)
		return FALSE

/proc/addomen(input)
	if(!(input in GLOB.badomens))
		testing("Omen added: [input]")
		GLOB.badomens += input

/datum/round_event_control/proc/badomen(eventreason)
	var/used
	switch(eventreason)
		if(OMEN_ROUNDSTART)
			used = "Zizo."
		if(OMEN_NOPRIEST)
			used = "The Priest has perished! The Ten are weakened..."
		if(OMEN_SKELETONSIEGE)
			used = "Unwelcome visitors!"
		if(OMEN_NOLORD)
			used = "The Monarch is dead! We need a new ruler."
		if(OMEN_SUNSTEAL)
			used = "The Sun, she is wounded!"
		if(OMEN_ASCEND)
			used = "Zizo will rise once again!"
	if(eventreason && used)
		priority_announce(used, "Bad Omen", 'sound/misc/evilevent.ogg')

