/turf/open/floor/carpet
	name = "carpet"
	landsound = 'sound/foley/jumpland/carpetland.wav'
	icon = 'icons/turf/floors.dmi'
	icon_state = "carpet"
	flags_1 = NONE
	footstep = FOOTSTEP_CARPET
	barefootstep = FOOTSTEP_SOFT_BAREFOOT
	clawfootstep = FOOTSTEP_SOFT_BAREFOOT
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

	spread_chance = 15

/turf/open/floor/carpet/Initialize()
	. = ..()
	update_icon()

/turf/open/floor/carpet/update_icon()
	if(!..())
		return FALSE
	if(smoothing_flags & SMOOTH_BITMASK)
		QUEUE_SMOOTH(src)

/turf/open/floor/carpet/purple
	icon = 'icons/turf/smooth/floors/carpet_purple.dmi'
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_OPEN + SMOOTH_GROUP_CARPET_PURPLE
	canSmoothWith = SMOOTH_GROUP_CARPET_PURPLE

/turf/open/floor/carpet/stellar
	icon = 'icons/turf/smooth/floors/carpet_stellar.dmi'
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_OPEN + SMOOTH_GROUP_CARPET_STELLAR
	canSmoothWith = SMOOTH_GROUP_CARPET_STELLAR

/turf/open/floor/carpet/red
	icon = 'icons/turf/smooth/floors/carpet_red.dmi'
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_OPEN + SMOOTH_GROUP_CARPET_RED
	canSmoothWith = SMOOTH_GROUP_CARPET_RED

/turf/open/floor/carpet/royalblack
	icon = 'icons/turf/smooth/floors/carpet_royalblack.dmi'
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_OPEN + SMOOTH_GROUP_CARPET_ROYAL_BLACK
	canSmoothWith = SMOOTH_GROUP_CARPET_ROYAL_BLACK

/turf/open/floor/carpet/break_tile()
	broken = TRUE
	update_icon()

/turf/open/floor/carpet/burn_tile()
	burnt = TRUE
	update_icon()

/turf/open/floor/carpet/get_smooth_underlay_icon(mutable_appearance/underlay_appearance, turf/asking_turf, adjacency_dir)
	return FALSE
