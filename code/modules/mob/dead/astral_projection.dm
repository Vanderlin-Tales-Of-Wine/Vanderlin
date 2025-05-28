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

/mob/dead/astral_projection/Hear(message, atom/movable/speaker, datum/language/message_language, raw_message, radio_freq, list/spans, message_mode)
	. = ..()
	if(!client)
		return

	// Create map text prior to modifying message for goonchat
	create_chat_message(speaker, message_language, raw_message, spans, message_mode)
	// Recompose message for AI hrefs, language incomprehension.
	message = compose_message(speaker, message_language, raw_message, radio_freq, spans, message_mode)
	// voice muffling
	if(isliving(speaker))
		var/mob/living/living_speaker = speaker
		if(living_speaker != src && living_speaker.client && src.can_hear()) //src.client already checked above
			log_message("heard [key_name(living_speaker)] say: [raw_message]", LOG_SAY, "#0978b8", FALSE)
	show_message(message, MSG_AUDIBLE)
	return message
