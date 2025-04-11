/turf/open/floor/carpet
	name = "carpet"
	icon = 'icons/turf/floors/inn.dmi'
	icon_state = "carpet"
	broken_states = list("damaged")
	smoothing_flags = NONE
	smoothing_groups = null
	canSmoothWith = null
	flags_1 = NONE
	bullet_bounce_sound = null
	footstep = FOOTSTEP_CARPET
	barefootstep = FOOTSTEP_SOFT_BAREFOOT
	clawfootstep = FOOTSTEP_SOFT_BAREFOOT
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_dirt = FALSE

	spread_chance = 15

/turf/open/floor/carpet/Initialize()
	. = ..()
	update_icon()

/turf/open/floor/carpet/update_icon()
	if(!..())
		return 0
	if(!broken && !burnt)
		if(smoothing_flags)
			QUEUE_SMOOTH(src)
	else
		make_plating()
		if(smoothing_flags)
			QUEUE_SMOOTH_NEIGHBORS(src)

/turf/open/floor/carpet/purple
	icon = 'icons/turf/floors/carpet_purple.dmi'
	smoothing_flags = SMOOTH_CORNERS
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_CARPET_PURPLE)
	canSmoothWith = list(SMOOTH_GROUP_CARPET_PURPLE)

/turf/open/floor/carpet/stellar
	icon = 'icons/turf/floors/carpet_stellar.dmi'
	smoothing_flags = SMOOTH_CORNERS
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_CARPET_STELLAR)
	canSmoothWith = list(SMOOTH_GROUP_CARPET_PURPLE)

/turf/open/floor/carpet/red
	icon = 'icons/turf/floors/carpet_red.dmi'
	smoothing_flags = SMOOTH_CORNERS
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_CARPET_RED)
	canSmoothWith = list(SMOOTH_GROUP_CARPET_RED)

/turf/open/floor/carpet/royalblack
	icon = 'icons/turf/floors/carpet_royalblack.dmi'
	smoothing_flags = SMOOTH_CORNERS
	smoothing_groups = list(SMOOTH_GROUP_TURF_OPEN, SMOOTH_GROUP_CARPET_ROYAL_BLACK)
	canSmoothWith = list(SMOOTH_GROUP_CARPET_ROYAL_BLACK)

/turf/open/floor/carpet/break_tile()
	broken = TRUE
	update_icon()

/turf/open/floor/carpet/burn_tile()
	burnt = TRUE
	update_icon()

/turf/open/floor/carpet/get_smooth_underlay_icon(mutable_appearance/underlay_appearance, turf/asking_turf, adjacency_dir)
	return FALSE
