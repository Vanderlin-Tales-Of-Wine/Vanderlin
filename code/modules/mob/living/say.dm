GLOBAL_LIST_INIT(department_radio_prefixes, list(":", "."))

GLOBAL_LIST_INIT(department_radio_keys, list(
	// Location
	MODE_KEY_R_HAND = MODE_R_HAND,
	MODE_KEY_L_HAND = MODE_L_HAND,
	MODE_KEY_INTERCOM = MODE_INTERCOM,

	// Department
	MODE_KEY_DEPARTMENT = MODE_DEPARTMENT,
	RADIO_KEY_COMMAND = RADIO_CHANNEL_COMMAND,
	RADIO_KEY_SCIENCE = RADIO_CHANNEL_SCIENCE,
	RADIO_KEY_MEDICAL = RADIO_CHANNEL_MEDICAL,
	RADIO_KEY_ENGINEERING = RADIO_CHANNEL_ENGINEERING,
	RADIO_KEY_SECURITY = RADIO_CHANNEL_SECURITY,
	RADIO_KEY_SUPPLY = RADIO_CHANNEL_SUPPLY,
	RADIO_KEY_SERVICE = RADIO_CHANNEL_SERVICE,

	// Faction
	RADIO_KEY_SYNDICATE = RADIO_CHANNEL_SYNDICATE,
	RADIO_KEY_CENTCOM = RADIO_CHANNEL_CENTCOM,

	// Admin
	MODE_KEY_ADMIN = MODE_ADMIN,
	MODE_KEY_DEADMIN = MODE_DEADMIN,

	// Misc
	RADIO_KEY_AI_PRIVATE = RADIO_CHANNEL_AI_PRIVATE, // AI Upload channel
	MODE_KEY_VOCALCORDS = MODE_VOCALCORDS,		// vocal cords, used by Voice of God


	//kinda localization -- rastaf0
	//same keys as above, but on russian keyboard layout. This file uses cp1251 as encoding.
	// Location
	"ê" = MODE_R_HAND,
	"ä" = MODE_L_HAND,
	"ø" = MODE_INTERCOM,

	// Department
	"ð" = MODE_DEPARTMENT,
	"ñ" = RADIO_CHANNEL_COMMAND,
	"ò" = RADIO_CHANNEL_SCIENCE,
	"ü" = RADIO_CHANNEL_MEDICAL,
	"ó" = RADIO_CHANNEL_ENGINEERING,
	"û" = RADIO_CHANNEL_SECURITY,
	"ã" = RADIO_CHANNEL_SUPPLY,
	"ì" = RADIO_CHANNEL_SERVICE,

	// Faction
	"å" = RADIO_CHANNEL_SYNDICATE,
	"í" = RADIO_CHANNEL_CENTCOM,

	// Admin
	"ç" = MODE_ADMIN,
	"â" = MODE_ADMIN,

	// Misc
	"ù" = RADIO_CHANNEL_AI_PRIVATE,
	"÷" = MODE_VOCALCORDS
))

/mob/living/proc/Ellipsis(original_msg, chance = 50, keep_words)
	if(chance <= 0)
		return "..."
	if(chance >= 100)
		return original_msg

	var/list/words = splittext(original_msg," ")
	var/list/new_words = list()

	var/new_msg = ""

	for(var/w in words)
		if(prob(chance))
			new_words += "..."
			if(!keep_words)
				continue
		new_words += w

	new_msg = jointext(new_words," ")

	return new_msg

/mob/living/say(
	message,
	bubble_type,
	list/spans = list(),
	sanitize = TRUE,
	datum/language/language = null,
	ignore_spam = FALSE,
	forced
)
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
		to_chat(src, span_warning("That message contained a word prohibited in IC chat! Consider reviewing the server rules.\n<span replaceRegex='show_filtered_ic_chat'>\"[message]\"</span>"))
		SSblackbox.record_feedback("tally", "ic_blocked_words", 1, lowertext(config.ic_filter_regex.match))
		return

	var/original_message = message
	var/list/message_mods = list()
	message = get_message_mods(message, message_mods)
	var/datum/saymode/saymode = SSradio.saymodes[message_mods[RADIO_KEY]]

	if(message_mods[RADIO_EXTENSION] == MODE_ADMIN)
		client?.cmd_admin_say(message)
		return

	if(message_mods[RADIO_EXTENSION] == MODE_DEADMIN)
		client?.dsay(message)
		return

	// dead is the only state you can never emote
	if(stat != DEAD && check_emote(original_message, forced))
		return

	switch(stat)
		if(SOFT_CRIT)
			message_mods[WHISPER_MODE] = MODE_WHISPER
		if(UNCONSCIOUS)
			if(!((InCritical() && message_mods[WHISPER_MODE]) || message_mods[MODE_CHANGELING]))
				return
		if(DEAD)
			say_dead(original_message)
			return

	if(!try_speak(original_message, ignore_spam, forced))
		return

	language = message_mods[LANGUAGE_EXTENSION] || get_default_language()

	var/message_range = 7

	var/succumbed = FALSE

	if(message_mods[WHISPER_MODE] == MODE_WHISPER)
		message_range = 1
		message_mods[WHISPER_MODE] = MODE_WHISPER
		log_talk(message, LOG_WHISPER, forced_by = forced)
		if(InFullCritical())
			var/health_diff = round(-HEALTH_THRESHOLD_DEAD + health)
			// If we cut our message short, abruptly end it with a-..
			var/message_len = length(message)
			message = copytext(message, 1, health_diff) + "[message_len > health_diff ? "-.." : "..."]"
			message = Ellipsis(message, 10, 1)
			last_words = message
			message_mods[WHISPER_MODE] = MODE_WHISPER_CRIT
			succumbed = TRUE
	else
		log_talk(message, LOG_SAY, forced_by = forced)

	// Make sure the arglist is passed exactly - don't pass a copy of it. Say signal handlers will modify some of the parameters.
	var/sigreturn = SEND_SIGNAL(src, COMSIG_MOB_SAY, args)
	if(sigreturn & COMPONENT_UPPERCASE_SPEECH)
		message = uppertext(message)

	message = treat_message(message) // unfortunately we still need this

	spans |= speech_span

	var/datum/language/spoken_lang = GLOB.language_datum_instances[language]
	var/list/spoken_spans
	if(ishuman(src))
		var/mob/living/carbon/human/H = src
		spoken_spans = H.dna?.species?.get_span_language(spoken_lang) || spoken_lang?.spans
	else
		spoken_spans = spoken_lang?.spans
	if(LAZYLEN(spoken_spans))
		spans |= spoken_spans

	if(message_mods[MODE_SING])
		var/randomnote = pick("\u2669", "\u266A", "\u266B")
		message = "[randomnote] [message] [randomnote]"
		spans |= SPAN_SINGING

	if(message_mods[WHISPER_MODE]) // whisper away
		spans |= SPAN_ITALICS

	if(!message)
		if(succumbed)
			succumb()
		return

	if(findtext(message, "Abyssor"))
		GLOB.vanderlin_round_stats[STATS_ABYSSOR_REMEMBERED]++

	//This is before anything that sends say a radio message, and after all important message type modifications, so you can scumb in alien chat or something
	if(saymode && !saymode.handle_message(src, message, language))
		return

	var/radio_return = radio(message, message_mods, spans, language)
	if(radio_return & NOPASS)
		return TRUE

	if(radio_return & ITALICS)
		spans |= SPAN_ITALICS
	if(radio_return & REDUCE_RANGE)
		message_range = 1
		if(!message_mods[WHISPER_MODE])
			message_mods[WHISPER_MODE] = MODE_WHISPER

	send_speech(message, message_range, src, bubble_type, spans, language, message_mods, original_message)
	if(succumbed)
		succumb(TRUE)
		to_chat(src, compose_message(src, language, message, null, spans, message_mods))

	return TRUE

/// Receives a language instance, and returns a list of spans.
/// Useful if you want a language to override a language's spans,
/// like drows using the delf span when speaking elvish.
/datum/species/proc/get_span_language(datum/language/message_language)
	return message_language?.spans

// Whether the mob can see runechat from the speaker, assuming he will see his message on the text box
/mob/proc/can_see_runechat(atom/movable/speaker)
	if(!client || !client.prefs)
		return FALSE
	if(!client.prefs.chat_on_map)
		return FALSE
	if(stat >= UNCONSCIOUS)
		return FALSE
	if(!ismob(speaker) && !client.prefs.see_chat_non_mob)
		return FALSE
	return TRUE

/mob/living/Hear(message, atom/movable/speaker, datum/language/message_language, raw_message, radio_freq, list/spans, list/message_mods = list())
	. = ..()
	if(!client)
		return
	var/deaf_message
	var/deaf_type
	if(speaker != src)
		if(!radio_freq) //These checks have to be seperate, else people talking on the radio will make "You can't hear yourself!" appear when hearing people over the radio while deaf.
			deaf_message = "<span class='name'>[speaker]</span> [speaker.verb_say] something but you cannot hear [speaker.p_them()]."
			deaf_type = 1
	else
		deaf_message = "<span class='notice'>I can't hear myself!</span>"
		deaf_type = 2 // Since you should be able to hear myself without looking

	// Create map text prior to modifying message for goonchat
	if(can_see_runechat(speaker) && can_hear())
		create_chat_message(speaker, message_language, raw_message, spans)
	// Recompose message for AI hrefs, language incomprehension.
	message = compose_message(speaker, message_language, raw_message, radio_freq, spans, message_mods)
	show_message(message, MSG_AUDIBLE, deaf_message, deaf_type)
	return message

/mob/living/send_speech(message, message_range = 6, obj/source = src, bubble_type = bubble_icon, list/spans, datum/language/message_language=null, list/message_mods = list(), original_message)
	var/eavesdrop_range = 0
	var/Zs_too = FALSE
	var/Zs_all = FALSE
	var/Zs_yell = FALSE
	var/listener_has_ceiling	= TRUE
	var/speaker_has_ceiling		= TRUE

	var/turf/speaker_turf = get_turf(src)
	var/turf/speaker_ceiling = get_step_multiz(speaker_turf, UP)
	if(speaker_ceiling)
		if(istransparentturf(speaker_ceiling))
			speaker_has_ceiling = FALSE
	if(message_mods[WHISPER_MODE]) //If we're whispering
		eavesdrop_range = EAVESDROP_EXTRA_RANGE
	else
		Zs_too = TRUE
		if(say_test(message) == "2")	//CIT CHANGE - ditto
			message_range += 5
			Zs_yell = TRUE
		if(say_test(message) == "3")	//Big "!!" shout
			message_range += 10
			Zs_all = TRUE
	var/list/listening = get_hearers_in_view(message_range+eavesdrop_range, source)
	var/list/the_dead = list()
//	var/list/yellareas	//CIT CHANGE - adds the ability for yelling to penetrate walls and echo throughout areas
	for(var/_M in GLOB.player_list)
		var/mob/M = _M
//		if(M.stat != DEAD) //not dead, not important
//			if(yellareas)	//CIT CHANGE - see above. makes yelling penetrate walls
//				var/area/A = get_area(M)	//CIT CHANGE - ditto
//				if(istype(A) && A.ambientsounds != SPACE && (A in yellareas))	//CIT CHANGE - ditto
//					listening |= M	//CIT CHANGE - ditto
//			continue
		if(!client) //client is so that ghosts don't have to listen to mice
			continue
		if(!M)
			continue
		if(!M.client)
			continue
		if(get_dist(M, src) > message_range) //they're out of range of normal hearing
			if(M.client.prefs)
				if(eavesdrop_range && !(M.client.prefs.chat_toggles & CHAT_GHOSTWHISPER)) //they're whispering and we have hearing whispers at any range off
					continue
				if(!(M.client.prefs.chat_toggles & CHAT_GHOSTEARS)) //they're talking normally and we have hearing at any range off
					continue
		if(!is_in_zweb(src.z,M.z) && !(M.client.prefs.chat_toggles & CHAT_GHOSTEARS))
			continue
		listening |= M
		the_dead[M] = TRUE

	var/eavesdropping
	var/eavesrendered
	if(eavesdrop_range)
		eavesdropping = stars(message)
		eavesrendered = compose_message(src, message_language, eavesdropping, null, spans, message_mods)

	var/rendered = compose_message(src, message_language, message, null, spans, message_mods)
	for(var/_AM in listening)
		var/atom/movable/AM = _AM
		var/turf/listener_turf = get_turf(AM)
		var/turf/listener_ceiling = get_step_multiz(listener_turf, UP)
		if(listener_ceiling)
			listener_has_ceiling = TRUE
			if(istransparentturf(listener_ceiling))
				listener_has_ceiling = FALSE
		if((!Zs_too && !isobserver(AM)) || message_mods[WHISPER_MODE])
			if(AM.z != src.z)
				continue
		if(Zs_too && AM.z != src.z && !Zs_all)
			if(!Zs_yell)
				if(listener_turf.z < speaker_turf.z && listener_has_ceiling)	//Listener is below the speaker and has a ceiling above them
					continue
				if(listener_turf.z > speaker_turf.z && speaker_has_ceiling)		//Listener is above the speaker and the speaker has a ceiling above
					continue
				if(listener_has_ceiling && speaker_has_ceiling)	//Both have a ceiling, on different z-levels -- no hearing at all
					continue
			else
				if(abs((listener_turf.z - speaker_turf.z)) >= 2)	//We're yelling with only one "!", and the listener is 2 or more z levels above or below us.
					continue
			var/listener_obstructed = TRUE
			var/speaker_obstructed = TRUE
			if(src != AM && !Zs_yell)	//We always hear ourselves. Zs_yell will allow a "!" shout to bypass walls one z level up or below.
				if(!speaker_has_ceiling && isliving(AM))
					var/mob/living/M = AM
					for(var/mob/living/MH in viewers(world.view, speaker_ceiling))
						if(M == MH && MH.z == speaker_ceiling?.z)
							speaker_obstructed = FALSE

				if(!listener_has_ceiling)
					for(var/mob/living/ML in viewers(world.view, listener_ceiling))
						if(ML == src && ML.z == listener_ceiling?.z)
							listener_obstructed = FALSE
				if(listener_obstructed && speaker_obstructed)
					continue
		if(eavesdrop_range && get_dist(source, AM) > message_range && !(the_dead[AM]))
			AM.Hear(eavesrendered, src, message_language, eavesdropping, null, spans, message_mods, original_message)
		else
			AM.Hear(rendered, src, message_language, message, null, spans, message_mods, original_message)
	SEND_GLOBAL_SIGNAL(COMSIG_GLOB_LIVING_SAY_SPECIAL, src, message)

	//speech bubble
	var/list/speech_bubble_recipients = list()
	for(var/mob/M in listening)
		if(M.client?.prefs)
			if(M.client && !M.client.prefs.chat_on_map)
				speech_bubble_recipients.Add(M.client)
	var/image/I = image('icons/mob/talk.dmi', src, "[bubble_type][say_test(message)]", FLY_LAYER)
	I.appearance_flags = APPEARANCE_UI_IGNORE_ALPHA
	INVOKE_ASYNC(GLOBAL_PROC, GLOBAL_PROC_REF(flick_overlay), I, speech_bubble_recipients, 30)

/mob/proc/binarycheck()
	return FALSE

/mob/living/try_speak(message, ignore_spam = FALSE, forced = TRUE)
	if(client && !(ignore_spam || forced))
		if(client.prefs.muted & MUTE_IC)
			to_chat(src, span_danger("<VAR>You cannot speak IC. (muted)</VAR>"))
			return FALSE
		if(client.handle_spam_prevention(message, MUTE_IC))
			return FALSE

	var/sigreturn = SEND_SIGNAL(src, COMSIG_MOB_TRY_SPEECH, message, ignore_spam, forced)
	if(sigreturn & COMPONENT_IGNORE_CAN_SPEAK)
		return TRUE

	if(sigreturn & COMPONENT_CANNOT_SPEAK)
		return FALSE

	if(!..()) //the can_speak check
		if(mind?.miming)
			to_chat(src, span_danger("I consider breaking my vow of silence..."))
		else
			to_chat(src, span_warning("I try to speak, but I cannot."))
		return FALSE
	return TRUE

/mob/living/can_speak(allow_mimes = FALSE)
	if(!allow_mimes && mind?.miming)
		return FALSE

	if(HAS_TRAIT(src, TRAIT_MUTE))
		return FALSE

	if(is_muzzled())
		return FALSE

	return TRUE

/mob/living/proc/treat_message(message)
	if(HAS_TRAIT(src, TRAIT_ZOMBIE_SPEECH))
		message = "[repeat_string(rand(1, 3), "U")][repeat_string(rand(1, 6), "H")]..."
	else if(HAS_TRAIT(src, TRAIT_GARGLE_SPEECH))
		message = vocal_cord_torn(message)

	if(HAS_TRAIT(src, TRAIT_UNINTELLIGIBLE_SPEECH))
		message = unintelligize(message)

	if(derpspeech)
		message = derpspeech(message, stuttering)

	if(stuttering)
		message = stutter(message)

	if(slurring)
		message = slur(message)

	if(cultslurring)
		message = cultslur(message)

	message = capitalize(message)

	return message

/mob/living/proc/radio(message, list/message_mods = list(), list/spans, language)
	switch(message_mods[RADIO_EXTENSION])
		if(MODE_R_HAND)
			for(var/obj/item/r_hand in get_held_items_for_side(RIGHT_HANDS, all = TRUE))
				if (r_hand)
					return r_hand.talk_into(src, message, null, spans, language, message_mods)
				return ITALICS | REDUCE_RANGE
		if(MODE_L_HAND)
			for(var/obj/item/l_hand in get_held_items_for_side(LEFT_HANDS, all = TRUE))
				if (l_hand)
					return l_hand.talk_into(src, message, null, spans, language, message_mods)
				return ITALICS | REDUCE_RANGE

	return NONE

/mob/living/say_mod(input, list/message_mods = list())
	if(message_mods[WHISPER_MODE] == MODE_WHISPER)
		. = verb_whisper
	else if(message_mods[WHISPER_MODE] == MODE_WHISPER_CRIT)
		. = "[verb_whisper] in [p_their()] last breath"
	else if(message_mods[MODE_SING])
		. = verb_sing
	else if(stuttering)
		. = "stammers"
	else if(derpspeech)
		. = "gibbers"
	else
		. = ..()

/mob/living/whisper(message, bubble_type, list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null)
	say("#[message]", bubble_type, spans, sanitize, language, ignore_spam, forced)

/mob/living/get_language_holder(shadow=TRUE)
	if(mind && shadow)
		// Mind language holders shadow mob holders.
		. = mind.get_language_holder()
		if(.)
			return .

	. = ..()
