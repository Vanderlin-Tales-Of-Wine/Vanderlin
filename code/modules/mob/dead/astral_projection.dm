/mob/dead/astral_projection
	name = "astral projection"
	icon = 'icons/mob/mob.dmi'
	icon_state = "god"
	see_invisible = SEE_INVISIBLE_LIVING
	/// thing this projection is tied to
	var/atom/movable/projection_source
	/// the spirit we are
	var/mob/camera/primogenitor/spirit
	/// how many tiles can we move from the projection_source?
	var/range_limit = 3
	var/beam
	var/projection_source_is_containment = FALSE
	alpha = 150

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

		if(projection_source_is_containment || in_view_range(src, spirit.containment))
			spirit.locomotion(A)

	. = ..()

/mob/dead/astral_projection/Move(atom/newloc, direct, glide_size_override)
	if(get_dist(projection_source, newloc) > range_limit)
		return FALSE
	if(!(newloc in oview(projection_source)))
		return FALSE
	. = ..()

/mob/dead/astral_projection/say(message, bubble_type, list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null)
	var/static/list/one_character_prefix = list(MODE_HEADSET = TRUE, MODE_ROBOT = TRUE, MODE_WHISPER = TRUE, MODE_SING = TRUE)

	var/ic_blocked = FALSE
	if(client && !forced && CHAT_FILTER_CHECK(message))
		//The filter doesn't act on the sanitized message, but the raw message.
		ic_blocked = TRUE

	if(sanitize)
		message = trim(copytext(sanitize(message), 1, MAX_MESSAGE_LEN))
	if(!message || message == "")
		return

	if(ic_blocked)
		//The filter warning message shows the sanitized message though.
		to_chat(src, "<span class='warning'>That message contained a word prohibited in IC chat! Consider reviewing the server rules.\n<span replaceRegex='show_filtered_ic_chat'>\"[message]\"</span></span>")
		SSblackbox.record_feedback("tally", "ic_blocked_words", 1, lowertext(config.ic_filter_regex.match))
		return

	var/original_message = message

	if(!language)
		language = get_default_language()

	var/message_range = 7

	log_talk("said: [message]", LOG_SAY, forced_by=forced)

	if(findtext(message, "Abyssor"))
		GLOB.vanderlin_round_stats[STATS_ABYSSOR_REMEMBERED]++

	spans |= speech_span

	if(language)
		var/datum/language/L = GLOB.language_datum_instances[language]
		if(ishuman(src))
			var/mob/living/carbon/human/H = src
			if(H.dna?.species)
				var/list/stuff = H.dna.species.get_span_language(L)
				if(stuff)
					spans |= stuff
		else
			spans |= L.spans

	send_speech(message, message_range, src, bubble_type, spans, language, original_message = original_message)

	return 1

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
