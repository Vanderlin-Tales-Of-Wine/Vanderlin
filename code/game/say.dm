/*
	Miauw's big Say() rewrite.
	This file has the basic atom/movable level speech procs.
	And the base of the send_speech() proc, which is the core of saycode.
*/
GLOBAL_LIST_INIT(freqtospan, list(
	"[FREQ_SCIENCE]" = "sciradio",
	"[FREQ_MEDICAL]" = "medradio",
	"[FREQ_ENGINEERING]" = "engradio",
	"[FREQ_SUPPLY]" = "suppradio",
	"[FREQ_SERVICE]" = "servradio",
	"[FREQ_SECURITY]" = "secradio",
	"[FREQ_COMMAND]" = "comradio",
	"[FREQ_AI_PRIVATE]" = "aiprivradio",
	"[FREQ_SYNDICATE]" = "syndradio",
	"[FREQ_CENTCOM]" = "centcomradio",
	"[FREQ_CTF_RED]" = "redteamradio",
	"[FREQ_CTF_BLUE]" = "blueteamradio"
	))

/atom/movable/proc/say(message, bubble_type, list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null)
	if(!can_speak())
		return
	if(message == "" || !message)
		return
	spans |= speech_span
	if(!language)
		language = get_default_language()
	send_speech(message, 7, src, , spans, message_language=language)

/atom/movable/proc/Hear(message, atom/movable/speaker, message_language, raw_message, radio_freq, list/spans, message_mode)
	SEND_SIGNAL(src, COMSIG_MOVABLE_HEAR, args)

/atom/movable/proc/can_speak()
	return TRUE

/atom/movable/proc/send_speech(message, range = 7, obj/source = src, bubble_type, list/spans, datum/language/message_language = null, message_mode)
	var/rendered = compose_message(src, message_language, message, , spans, message_mode)
	for(var/_AM in get_hearers_in_view(range, source))
		var/atom/movable/AM = _AM
		AM.Hear(rendered, src, message_language, message, , spans, message_mode)

/atom/movable/proc/compose_message(atom/movable/speaker, datum/language/message_language, raw_message, radio_freq, list/spans, message_mode, face_name = FALSE)
	//This proc uses text() because it is faster than appending strings. Thanks BYOND.
	//Basic span
	var/spanpart1 = "<span class='[radio_freq ? get_radio_span(radio_freq) : "say"]' target-ref='[REF(speaker)]' visible-flags='[get_admin_flags()]' data-options='[get_message_flags()]'>"
	//Start name span.
	var/spanpart2 = "<span class='name'>"
	//Radio freq/name display
	var/freqpart = radio_freq ? "\[[get_radio_name(radio_freq)]\] " : ""
	//Speaker name
	var/namepart = "[speaker.GetVoice()]"
	if(speaker.get_alt_name())
		namepart = "[speaker.get_alt_name()]"
	var/colorpart = "<span style='text-shadow:-1px -1px 0 #000,1px -1px 0 #000,-1px 1px 0 #000,1px 1px 0 #000;'>"
	if(ishuman(speaker))
		var/mob/living/carbon/human/H = speaker
		if(face_name)
			namepart = "[H.get_face_name()]" //So "fake" speaking like in hallucinations does not give the speaker away if disguised
		if(H.voice_color)
			colorpart = "<span style='color:#[H.voice_color];text-shadow:-1px -1px 0 #000,1px -1px 0 #000,-1px 1px 0 #000,1px 1px 0 #000;'>"
	if(speaker.voicecolor_override)
		colorpart = "<span style='color:#[speaker.voicecolor_override];text-shadow:-1px -1px 0 #000,1px -1px 0 #000,-1px 1px 0 #000,1px 1px 0 #000;'>"
	//End name span.
	var/endspanpart = "</span></span>"

	//Message
	var/messagepart = "[lang_treat(speaker, message_language, raw_message, spans, message_mode)]"
	messagepart = " <span class='message'>[messagepart]</span></span>"

	//Arrow
	var/arrowpart = ""

	if(istype(src,/mob/living))
		var/turf/speakturf = get_turf(speaker)
		var/turf/sourceturf = get_turf(src)
		if(istype(speakturf) && istype(sourceturf) && !(speakturf in get_hear(7, sourceturf)))
			switch(get_dir(src,speaker))
				if(NORTH)
					arrowpart = " ⇑"
				if(SOUTH)
					arrowpart = " ⇓"
				if(EAST)
					arrowpart = " ⇒"
				if(WEST)
					arrowpart = " ⇐"
				if(NORTHWEST)
					arrowpart = " ⇖"
				if(NORTHEAST)
					arrowpart = " ⇗"
				if(SOUTHWEST)
					arrowpart = " ⇙"
				if(SOUTHEAST)
					arrowpart = " ⇘"
			if(speakturf.z > sourceturf.z)
				arrowpart += " ⇈"
			if(speakturf.z < sourceturf.z)
				arrowpart += " ⇊"
			if(istype(speaker, /mob/living))
				var/mob/living/L = speaker
				namepart = "Unknown [(L.gender == FEMALE) ? "Woman" : "Man"]"
			else
				namepart = "Unknown"
			spanpart1 = "<span class='smallyell'>"

	var/languageicon = ""
	var/datum/language/D = GLOB.language_datum_instances[message_language]
	if(istype(D) && D.display_icon(src))
		languageicon = "[D.get_icon()] "

	return "[spanpart1][spanpart2][colorpart][freqpart][languageicon][compose_track_href(speaker, namepart)][namepart][compose_job(speaker, message_language, raw_message, radio_freq)][arrowpart][endspanpart][messagepart]"

/atom/movable/proc/compose_track_href(atom/movable/speaker, message_langs, raw_message, radio_freq)
	return ""

/atom/movable/proc/compose_job(atom/movable/speaker, message_langs, raw_message, radio_freq)
	return ""

/atom/movable/proc/say_mod(input, message_mode)
	var/ending = copytext(input, length(input))
	if(copytext(input, length(input) - 1) == "!!")
		return verb_yell
	else if(ending == "?")
		return verb_ask
	else if(ending == "!")
		return verb_exclaim
	else
		return verb_say

/atom/movable/proc/say_quote(input, list/spans=list(speech_span), message_mode)
	if(!input)
		input = "..."

	var/say_mod

	var/mob/living/living_speaker = src
	if(istype(living_speaker) && living_speaker.cmode)
		say_mod = "—"
	else
		say_mod = say_mod(input, message_mode)
		say_mod = "[say_mod]," //acknowledge the comma

	if(copytext(input, length(input) - 1) == "!!")
		spans |= SPAN_YELL

	/* all inputs should be fully figured out past this point */

	var/processed_input = say_emphasis(input)
	processed_input = attach_spans(processed_input, spans)

	var/processed_say_mod = say_emphasis(say_mod) // port custom emotes one day?

	return "[processed_say_mod] \"[processed_input]\""

/atom/movable/proc/quoteless_say_quote(input, list/spans = list(speech_span), message_mode) //what the fuck.
	var/pos = findtext(input, "*")
	var/final_quoteless = pos ? copytext(input, pos + 1) : input
	return say_emphasis(final_quoteless)

/atom/movable/proc/check_language_hear(language)
	return FALSE

/// Transforms the speech emphasis mods from [/atom/movable/proc/say_emphasis] into the appropriate HTML tags. Includes escaping backslash (\)
#define ENCODE_HTML_EMPHASIS(input, char, html, varname) \
	var/static/regex/##varname = regex("(?<!\\\\)[char](.+?)(?<!\\\\)[char]", "g");\
	input = varname.Replace_char(input, "<[html]>$1</[html]>")

/// Scans the input sentence for speech emphasis modifiers, notably |italics|, +bold+, and _underline_ -mothblocks
/atom/movable/proc/say_emphasis(input)
	ENCODE_HTML_EMPHASIS(input, "\\|", "i", italics)
	ENCODE_HTML_EMPHASIS(input, "\\+", "b", bold)
	ENCODE_HTML_EMPHASIS(input, "_", "u", underline)
	var/static/regex/remove_escape_backlashes = regex("\\\\(_|\\+|\\|)", "g") // Removes backslashes used to escape text modification.
	input = remove_escape_backlashes.Replace_char(input, "$1")
	return input

#undef ENCODE_HTML_EMPHASIS

// tg#69799 please i beg
/atom/movable/proc/lang_treat(atom/movable/speaker, datum/language/language, raw_message, list/spans, message_mode, no_quote = FALSE)
	var/atom/movable/source = speaker.GetSource() || speaker //is the speaker virtual
	if(has_language(language) || check_language_hear(language))
		return no_quote ? source.quoteless_say_quote(raw_message, spans, message_mode) : source.say_quote(raw_message, spans, message_mode)
	else if(language)
		var/datum/language/D = GLOB.language_datum_instances[language]
		raw_message = D.scramble(raw_message)
		return no_quote ? source.quoteless_say_quote(raw_message, spans, message_mode) : source.say_quote(raw_message, spans, message_mode)
	else
		return "makes a strange sound."

/proc/get_radio_span(freq)
	var/returntext = GLOB.freqtospan["[freq]"]
	if(returntext)
		return returntext
	return "radio"

/proc/get_radio_name(freq)
	return freq
/* 	var/returntext = GLOB.reverseradiochannels["[freq]"]
	if(returntext)
		return returntext
	return "[copytext("[freq]", 1, 4)].[copytext("[freq]", 4, 5)]" */

/proc/attach_spans(input, list/spans)
	return "[message_spans_start(spans)][input]</span>"

/proc/message_spans_start(list/spans)
	var/output = "<span class='"
	for(var/S in spans)
		output = "[output][S] "
	output = "[output]'>"
	return output

/proc/say_test(text)
	var/ending = copytext(text, length(text))
	if (ending == "?")
		return "1"
	if (ending == "!")
		return "2"
	return "0"

/atom/movable/proc/GetVoice()
	return "[src]"	//Returns the atom's name, prepended with 'The' if it's not a proper noun

/atom/movable/proc/IsVocal()
	return 1

/atom/movable/proc/get_alt_name()

//HACKY VIRTUALSPEAKER STUFF BEYOND THIS POINT
//these exist mostly to deal with the AIs hrefs and job stuff.

/atom/movable/proc/GetJob() //Get a job, you lazy butte

/atom/movable/proc/GetSource()

/atom/movable/proc/GetRadio()

//VIRTUALSPEAKERS
/atom/movable/virtualspeaker
	var/job
	var/atom/movable/source
	var/obj/item/radio/radio

INITIALIZE_IMMEDIATE(/atom/movable/virtualspeaker)
/atom/movable/virtualspeaker/Initialize(mapload, atom/movable/M, radio)
	. = ..()
	radio = radio
	source = M
	if (istype(M))
		name = M.GetVoice()
		verb_say = M.verb_say
		verb_ask = M.verb_ask
		verb_exclaim = M.verb_exclaim
		verb_yell = M.verb_yell

	// The mob's job identity
	if(ishuman(M))
		// Humans use their job as seen on the crew manifest. This is so the AI
		// can know their job even if they don't carry an ID.
		var/datum/data/record/findjob = find_record("name", name, GLOB.data_core.general)
		if(findjob)
			job = findjob.fields["rank"]
		else
			job = "Unknown"
	else if(iscarbon(M))  // Carbon nonhuman
		job = "No ID"
	else if(isobj(M))  // Cold, emotionless machines
		job = "Machine"
	else  // Unidentifiable mob
		job = "Unknown"

/atom/movable/virtualspeaker/GetJob()
	return job

/atom/movable/virtualspeaker/GetSource()
	return source

