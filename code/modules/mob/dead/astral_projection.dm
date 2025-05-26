/mob/dead/astral_projection
	name = "astral projection"
	icon = 'icons/mob/mob.dmi'
	icon_state = "god"
	see_invisible = SEE_INVISIBLE_LIVING
	/// thing this projection is tied to
	var/atom/movable/projection_source
	/// the spirit we are
	var/mob/camera/ancestral_spirit/spirit
	/// how many tiles can we move from the projection_source?
	var/range_limit = 2
	var/beam
	var/projection_source_is_containment = FALSE

/mob/dead/astral_projection/New(loc, atom)
	. = ..()
	projection_source = atom

/mob/dead/astral_projection/proc/link_break_callback()
	return_to_camera()

/mob/dead/astral_projection/Destroy()
	. = ..()
	QDEL_NULL(beam)

/mob/dead/astral_projection/ClickOn(atom/A, params)

	if(check_click_intercept(params,A))
		return

	if(SEND_SIGNAL(src, COMSIG_MOB_CLICKON, A, params) & COMSIG_MOB_CANCEL_CLICKON)
		return

	var/list/modifiers = params2list(params)

	if(modifiers["alt"] && !modifiers["right"])

		if(projection_source_is_containment)
			spirit.locomotion(A)

	. = ..()

/mob/dead/astral_projection/Move(atom/newloc, direct, glide_size_override)
	if(get_dist(projection_source, newloc) > range_limit)
		return FALSE
	if(!(newloc in oview(projection_source)))
		return FALSE
	. = ..()

/mob/dead/astral_projection/proc/return_to_camera()
	spirit.ckey = ckey
	qdel(src)

/mob/dead/astral_projection/proc/handle_projection_source()

/mob/dead/astral_projection/RightClickOn(atom/A, params)
	. = ..()
	return_to_camera()

