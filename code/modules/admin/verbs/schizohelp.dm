GLOBAL_LIST_EMPTY_TYPED(schizohelps, /datum/schizohelp)

/mob
	COOLDOWN_DECLARE(schizohelp_cooldown)

/mob/proc/schizohelp(msg as text)
	if(!msg)
		return
	msg = copytext(sanitize(msg), 1, MAX_MESSAGE_LEN)
	if(!msg)
		return

	if(client?.prefs?.muted & MUTE_MEDITATE)
		to_chat(src, span_notice("You have been muted from mentor help."))
		return

	to_chat(src, span_notice("[mentor_block("<i>You meditate...</i>\n<b>[msg]</b>")]"))
	var/datum/schizohelp/ticket = new(src)
	var/display_name = get_schizo_name()
	var/message = span_notice("<i>[display_name] meditates...</i>\n<b>[msg]</b>")
	var/message_admins = span_notice("<i>[display_name] ([key || "NO KEY"]) [ADMIN_FLW(src)] [ADMIN_SM(src)] meditates...</i>\n<b>[msg]</b>")
	log_game("([key || "NO KEY"]) mentorhelped: [msg]")

	for(var/client/voice in ((GLOB.clients - client) - GLOB.admins))
		if(!(voice.prefs.toggles & SCHIZO_VOICE))
			continue
		var/answer_button = span_notice("(<a href='byond://?src=[voice];schizohelp=[REF(ticket)];'>ANSWER</a>)")
		to_chat(voice, mentor_block("[message]  [answer_button]"))

		var/sound/used = sound('sound/misc/notice (2).ogg')
		used.pitch *= 0.5
		SEND_SOUND(voice, used)

	for(var/client/admin in (GLOB.admins - client))
		if(!(admin.prefs.chat_toggles & CHAT_PRAYER))
			continue
		var/added_text = span_notice("(<A href='?_src_=holder;[HrefToken()];mute=[ckey];mute_type=[MUTE_MEDITATE]'><span class='adminsay'>MUTE</span></a>)")
		var/answer_button = span_notice("(<a href='byond://?src=[admin];schizohelp=[REF(ticket)];'>ANSWER</a>)")
		to_chat(admin,  mentor_block("[message_admins] [added_text] [answer_button]"))
	COOLDOWN_START(src, schizohelp_cooldown, 1 MINUTES)

/mob/proc/get_schizo_name()
	var/static/list/possible_adjectives = list(
		"Indecisive",
		"Doubtful",
		"Confused",
		"Hysteric",
		"Unstable",
		"Unsure",
		"Unsettled",
	)
	var/static/list/possible_nouns = list(
		"Fool",
		"Madman",
		"Nimrod",
		"Lunatic",
		"Imbecile",
		"Simpleton",
	)
	/// generate a consistent but anonymous name
	var/static/fumbling_seed = text2num(GLOB.rogue_round_id)
	var/md5_num = text2num(md5(real_name || src.name))
	var/adjective = possible_adjectives[(md5_num % length(possible_adjectives)) + 1]
	var/noun = possible_nouns[(round(md5_num * noise_hash(md5_num, fumbling_seed)) % length(possible_nouns)) + 1]
	return "[adjective] [noun]"

/client/proc/answer_schizohelp(datum/schizohelp/schizo)
	if(QDELETED(schizo) || QDELETED(schizo.owner))
		to_chat(src, span_warning("This meditation can no longer be answered..."))
		return
	if(schizo.owner == src.mob)
		to_chat(src, span_warning("I can't answer my own meditation!"))
		return
	if(schizo.answers[src.key])
		to_chat(src, span_warning("I have already answered this meditation!"))
		return
	var/answer = browser_input_text(src, "Answer their meditations...", "THE VOICE", multiline = TRUE)
	if(!answer || QDELETED(schizo))
		return
	schizo.answer_schizo(answer, src.mob)

/datum/schizohelp
	/// Guy who made this schizohelp "ticket"
	var/datum/weakref/owner
	/// Answers we got so far, indexed by client key
	var/list/answers = list()
	/// How many answers we can get at maximum
	var/max_answers = 3
	/// How much time we have to be answered
	var/timeout = 5 MINUTES

/datum/schizohelp/New(mob/owner)
	. = ..()
	if(!owner)
		stack_trace("shizohelp created without an owner!")
		qdel(src)
		return
	RegisterSignal(owner, COMSIG_PARENT_QDELETING, PROC_REF(owner_qdeleted))
	GLOB.schizohelps += src
	src.owner = WEAKREF(owner)
	if(timeout)
		addtimer(CALLBACK(src, PROC_REF(decay)), timeout)

/datum/schizohelp/Destroy(force)
	owner = null
	answers = null
	GLOB.schizohelps -= src
	return ..()

/datum/schizohelp/proc/owner_qdeleted(mob/source)
	if(QDELETED(src))
		return
	var/mob/schizo = owner.resolve()
	if(schizo)
		UnregisterSignal(schizo, COMSIG_PARENT_QDELETING)
	qdel(src)

/datum/schizohelp/proc/decay()
	var/mob/schizo = owner.resolve()
	if(!length(answers) && !QDELETED(schizo))
		to_chat(schizo, mentor_block("[span_notice("<i><b>My meditation goes unanswered...</b></i>")]"))
		SEND_SOUND(schizo, 'sound/misc/notice.ogg')
	qdel(src)

/datum/schizohelp/proc/answer_schizo(answer, mob/voice)
	if(QDELETED(src) || !voice.client)
		return
	var/mob/schizo = owner.resolve()
	if(!schizo)
		qdel(src)
		return
	to_chat(schizo, mentor_block("[span_notice("<i>I hear a voice in my head...</i>\n<b>[answer]</b>")]"))
	var/sound/used = sound('sound/misc/notice (2).ogg')
	used.pitch *= 1.5
	SEND_SOUND(schizo, used)
	for(var/client/admin in GLOB.admins)
		if(!(admin.prefs.chat_toggles & CHAT_PRAYER))
			continue
		to_chat(admin, span_admin_log(
			"[voice] ([voice.key || "NO KEY"]) [ADMIN_FLW(voice)] [ADMIN_SM(voice)] \
			answered [schizo] ([schizo.key || "NO KEY"])'s [ADMIN_FLW(schizo)] [ADMIN_SM(schizo)] Mentor Help: [answer]"))

	answers[voice.key] = answer

	log_game("([voice.key || "NO KEY"]) answered ([schizo.key || "NO KEY"])'s Mentor Help: [answer]")

	if(length(answers) >= max_answers)
		qdel(src)
