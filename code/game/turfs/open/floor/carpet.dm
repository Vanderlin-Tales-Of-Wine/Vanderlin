/turf/open/floor/carpet
	name = "carpet"
	desc = ""
	icon = 'icons/turf/floors/inn.dmi'
	icon_state = "carpet"
	broken_states = list("damaged")
	smooth = SMOOTH_FALSE
	canSmoothWith = null
	flags_1 = NONE
	bullet_bounce_sound = null
	footstep = FOOTSTEP_CARPET
	barefootstep = FOOTSTEP_SOFT_BAREFOOT
	clawfootstep = FOOTSTEP_SOFT_BAREFOOT
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_dirt = FALSE

	spread_chance = 0.6

/turf/open/floor/carpet/examine(mob/user)
	. = ..()
//	. += "<span class='notice'>There's a <b>small crack</b> on the edge of it.</span>"

/turf/open/floor/carpet/Initialize()
	. = ..()
	update_icon()

/turf/open/floor/carpet/update_icon()
	if(!..())
		return 0
	if(!broken && !burnt)
		if(smooth)
			queue_smooth(src)
	else
		make_plating()
		if(smooth)
			queue_smooth_neighbors(src)

/turf/open/floor/carpet/purple
	icon = 'icons/turf/floors/carpet_purple.dmi'
	canSmoothWith = list(/turf/open/floor/carpet/purple)
	smooth = SMOOTH_TRUE

/turf/open/floor/carpet/stellar
	icon = 'icons/turf/floors/carpet_stellar.dmi'
	canSmoothWith = list(/turf/open/floor/carpet/stellar)
	smooth = SMOOTH_TRUE

/turf/open/floor/carpet/red
	icon = 'icons/turf/floors/carpet_red.dmi'
	canSmoothWith = list(/turf/open/floor/carpet/red)
	smooth = SMOOTH_TRUE

/turf/open/floor/carpet/royalblack
	icon = 'icons/turf/floors/carpet_royalblack.dmi'
	canSmoothWith = list(/turf/open/floor/carpet/royalblack)
	smooth = SMOOTH_TRUE


/turf/open/floor/carpet/break_tile()
	broken = TRUE
	update_icon()

/turf/open/floor/carpet/burn_tile()
	burnt = TRUE
	update_icon()

/turf/open/floor/carpet/get_smooth_underlay_icon(mutable_appearance/underlay_appearance, turf/asking_turf, adjacency_dir)
	return FALSE
