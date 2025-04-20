PROCESSING_SUBSYSTEM_DEF(magic)
	name = "Magic"
	flags = SS_BACKGROUND|SS_POST_FIRE_TIMING

	wait = 1 SECONDS

/datum/controller/subsystem/processing/magic/Initialize()
	generate_initial_leylines()
	return ..()
