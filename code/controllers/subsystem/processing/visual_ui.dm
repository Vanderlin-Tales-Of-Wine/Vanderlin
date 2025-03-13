PROCESSING_SUBSYSTEM_DEF(visual_ui)
	name = "Mind UI Processing"
	init_order = INIT_ORDER_AIR
	flags = SS_NO_FIRE
	wait = 1 SECONDS

/datum/controller/subsystem/processing/visual_ui/Initialize()
	init_visual_ui()
	return ..()
