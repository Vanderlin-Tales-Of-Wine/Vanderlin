/mob/dead/astral_projection
	name = "astral projection"
	icon = 'icons/mob/mob.dmi'
	icon_state = "god"
	see_invisible = SEE_INVISIBLE_LIVING
	/// thing this projection is tied to
	var/atom/projection_source
	/// the spirit we are
	var/mob/camera/ancestral_spirit/spirit
	/// how many tiles can we move from the projection_source?
	var/range_limit = 3
	var/beam
	var/projection_source_is_containment = FALSE

/mob/dead/astral_projection/New(loc, atom)
	. = ..()
	projection_source = atom

/mob/dead/astral_projection/Initialize()
	. = ..()
	AddComponent(/datum/component/leash, projection_source, range_limit, null, null, "curse0", 'icons/effects/beam.dmi', FALSE, CALLBACK(src, PROC_REF(link_break_callback)))
	if(projection_source == spirit.containment)
		projection_source_is_containment = TRUE

/mob/dead/astral_projection/proc/link_break_callback()
	return_to_camera()

/mob/dead/astral_projection/Destroy()
	. = ..()
	QDEL_NULL(beam)

/mob/dead/astral_projection/AltClickOn(atom/A, params)
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

