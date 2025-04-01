/*

GLOBAL_VAR_INIT(xylix_bad, FALSE)

SUBSYSTEM_DEF(xylixmaze)
	name = "Xylix Maze"
	init_order = INIT_ORDER_DISCORD
	priority = FIRE_PRIORITY_WATER_LEVEL

/datum/controller/subsystem/xylixmaze/Initialize()
	return ..()

/datum/controller/subsystem/migrants/fire()
	if(prob(99))
		GLOB.xylix_bad = TRUE

*/
