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

/proc/hasomen(input)
	return (input in GLOB.badomens)

/proc/addomen(input)
	if(!(input in GLOB.badomens))
		testing("Omen added: [input]")
		GLOB.badomens += input

/proc/removeomen(input)
	if(!hasomen(input))
		return
	testing("Omen removed: [input]")
	GLOB.badomens -= input

/datum/round_event_control/proc/badomen(eventreason)
	var/used
	switch(eventreason)
		if(OMEN_ROUNDSTART)
			used = "Zizo's apocalypse brings death to the land once more."
		if(OMEN_NOPRIEST)
			used = "The Priest has perished! The Ten are weakened..."
		if(OMEN_SKELETONSIEGE)
			used = "Unwelcome visitors invade our lands!"
		if(OMEN_NOLORD)
			used = "The Monarch has been slain! Our town is at the mercy of invaders."
		if(OMEN_SUNSTEAL)
			used = "The Sun is wounded! Astrata falls silent across the land!"
		if(OMEN_ASCEND)
			used = "Zizo has risen again! Make peace with your god for not even they can save you!"
	if(eventreason && used)
		priority_announce(used, "Bad Omen", 'sound/misc/evilevent.ogg')

