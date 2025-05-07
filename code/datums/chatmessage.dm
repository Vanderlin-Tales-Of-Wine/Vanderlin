#define CHAT_MESSAGE_SPAWN_TIME		0.2 SECONDS
#define CHAT_MESSAGE_LIFESPAN		5 SECONDS
#define CHAT_MESSAGE_EOL_FADE		0.7 SECONDS
#define CHAT_MESSAGE_EXP_DECAY		0.7 // Messages decay at pow(factor, idx in stack)
#define CHAT_MESSAGE_HEIGHT_DECAY	0.9 // Increase message decay based on the height of the message
#define CHAT_MESSAGE_APPROX_LHEIGHT	11 // Approximate height in pixels of an 'average' line, used for height decay
#define CHAT_MESSAGE_WIDTH			96 // pixels
#define CHAT_MESSAGE_MAX_LENGTH		110 // characters
//#define WXH_TO_HEIGHT(x)			text2num(copytext((x), findtextEx((x), "x") + 1)) // thanks lummox
#define WXH_TO_HEIGHT(measurement, return_var) \
	do { \
		var/_measurement = measurement; \
		return_var = text2num(copytext(_measurement, findtextEx(_measurement, "x") + 1)); \
	} while(FALSE);
/**
 * # Chat Message Overlay
 *
 * Datum for generating a message overlay on the map
 */
/datum/chatmessage
	/// The visual element of the chat messsage
	var/image/message
	/// The location in which the message is appearing
	var/atom/message_loc
	/// The client who heard this message
	var/client/owned_by
	/// Contains the scheduled destruction time
	var/scheduled_destruction
	/// Contains the approximate amount of lines for height decay
	var/approx_lines

/**
 * Constructs a chat message overlay
 *
 * Arguments:
 * * text - The text content of the overlay
 * * target - The target atom to display the overlay at
 * * owner - The mob that owns this overlay, only this mob will be able to view it
 * * extra_classes - Extra classes to apply to the span that holds the text
 * * lifespan - The lifespan of the message in deciseconds
 */
/datum/chatmessage/New(text, atom/target, mob/owner, datum/language/language, list/extra_classes = list(), lifespan = CHAT_MESSAGE_LIFESPAN)
	. = ..()
	if (!istype(target))
		CRASH("Invalid target given for chatmessage")
	if(QDELETED(owner) || !istype(owner) || !owner.client)
		stack_trace("/datum/chatmessage created with [isnull(owner) ? "null" : "invalid"] mob owner")
		qdel(src)
		return
	INVOKE_ASYNC(src, PROC_REF(generate_image), text, target, owner, language, extra_classes, lifespan)

/datum/chatmessage/Destroy()
	if (owned_by)
		if (owned_by.seen_messages)
			LAZYREMOVEASSOC(owned_by.seen_messages, message_loc, src)
		owned_by.images.Remove(message)
	owned_by = null
	message_loc = null
	message = null
	return ..()

/**
 * Generates a chat message image representation
 *
 * Arguments:
 * * text - The text content of the overlay
 * * target - The target atom to display the overlay at
 * * owner - The mob that owns this overlay, only this mob will be able to view it
 * * extra_classes - Extra classes to apply to the span that holds the text
 * * lifespan - The lifespan of the message in deciseconds
 */
/datum/chatmessage/proc/generate_image(text, atom/target, mob/owner, datum/language/language, list/extra_classes, lifespan)
	/// Cached icons to show what language the user is speaking
	var/static/list/language_icons
	// Register client who owns this message
	owned_by = owner.client
	RegisterSignal(owned_by, COMSIG_PARENT_QDELETING, PROC_REF(qdel), src)

	// Clip message
	var/maxlen = owned_by.prefs.max_chat_length
	if (length_char(text) > maxlen)
		text = copytext_char(text, 1, maxlen + 1) + "..." // BYOND index moment

	// Calculate target color if not already present
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		if(H.voice_color && (target.chat_color != H.voice_color))
			target.chat_color = "#[H.voice_color]"
			target.chat_color_darkened = target.chat_color
			target.chat_color_name = target.name
	if(!target.chat_color)
		target.chat_color = colorize_string(target.name)
		target.chat_color_darkened = colorize_string(target.name, 0.85, 0.85)
		target.chat_color_name = target.name
	if(target.voicecolor_override)
		target.chat_color = "#[target.voicecolor_override]"
		target.chat_color_darkened = target.chat_color

	// Get rid of any URL schemes that might cause BYOND to automatically wrap something in an anchor tag
	var/static/regex/url_scheme = new(@"[A-Za-z][A-Za-z0-9+-\.]*:\/\/", "g")
	text = replacetext(text, url_scheme, "")

	// Reject whitespace
	var/static/regex/whitespace = new(@"^\s*$")
	if (whitespace.Find(text))
		qdel(src)
		return

	// Non mobs speakers can be small
	if (!ismob(target))
		extra_classes |= "small"

	var/list/prefixes

	// Append language icon if the language uses one
	var/datum/language/language_instance = GLOB.language_datum_instances[language]
	if (language_instance?.display_icon(owner))
		var/icon/language_icon = LAZYACCESS(language_icons, language)
		if (isnull(language_icon))
			language_icon = icon(language_instance.icon, icon_state = language_instance.icon_state)
			language_icon.Scale(9, 9)
			LAZYSET(language_icons, language, language_icon)
		LAZYADD(prefixes, "\icon[language_icon]")

	text = "[prefixes?.Join("&nbsp;")][text]"
	// We dim italicized text to make it more distinguishable from regular text
	var/tgt_color = extra_classes.Find("italics") ? target.chat_color_darkened : target.chat_color

	var/font_size = 8
	if(extra_classes.Find("emote"))
		font_size = 7
		tgt_color = "#adadad"

	// Approximate text height
	// Note we have to replace HTML encoded metacharacters otherwise MeasureText will return a zero height
	// BYOND Bug #2563917
	// Construct text
	var/static/regex/html_metachars = new(@"&[A-Za-z]{1,7};", "g")
	var/complete_text = {"<span style='font-size:[font_size]pt;font-family:"Pterra";color:[tgt_color];text-shadow:0 0 5px #000,0 0 5px #000,0 0 5px #000,0 0 5px #000;' class='center maptext [extra_classes != null ? extra_classes.Join(" ") : ""]' style='color: [tgt_color]'>[text]</span>"} //AAAAAAAAAAAAAAA

	var/mheight
	WXH_TO_HEIGHT(owned_by.MeasureText(complete_text, null, CHAT_MESSAGE_WIDTH), mheight)
	if(!VERB_SHOULD_YIELD)
		return finish_image_generation(mheight, target, owner, complete_text, lifespan)
	var/datum/callback/our_callback = CALLBACK(src, PROC_REF(finish_image_generation), mheight, target, owner, complete_text, lifespan)
	SSrunechat.message_queue += our_callback



/datum/chatmessage/proc/finish_image_generation(mheight, atom/target, mob/owner, complete_text, lifespan)
	if(!owned_by || QDELETED(owned_by))
		return qdel(src)
	if(!target || QDELETED(target))
		return qdel(src)
	approx_lines = max(1, mheight / CHAT_MESSAGE_APPROX_LHEIGHT)
	message_loc = target
	// Translate any existing messages upwards, apply exponential decay factors to timers
	if (owned_by.seen_messages)
//		var/idx = 1
//		var/combined_height = approx_lines
		for(var/msg in owned_by.seen_messages[message_loc])
			var/datum/chatmessage/m = msg
//			animate(m.message, pixel_y = m.message.pixel_y + mheight, time = CHAT_MESSAGE_SPAWN_TIME)
//			combined_height += m.approx_lines
//			var/sched_remaining = m.scheduled_destruction - world.time
//			if (sched_remaining > CHAT_MESSAGE_SPAWN_TIME)
//				var/remaining_time = (sched_remaining) * (CHAT_MESSAGE_EXP_DECAY ** idx++) * (CHAT_MESSAGE_HEIGHT_DECAY ** combined_height)
//				m.scheduled_destruction = world.time + remaining_time
//				addtimer(CALLBACK(m, PROC_REF(end_of_life)), remaining_time, TIMER_UNIQUE|TIMER_OVERRIDE)
			qdel(m)

	// Build message image
	message = image(loc = message_loc, layer = ABOVE_HUD_LAYER)
	message.plane = ABOVE_HUD_PLANE
	message.appearance_flags = APPEARANCE_UI_IGNORE_ALPHA | KEEP_APART
	message.alpha = 0
	message.pixel_y = owner.bound_height * 0.95
	message.maptext_width = CHAT_MESSAGE_WIDTH
	message.maptext_height = mheight
	message.maptext_x = (CHAT_MESSAGE_WIDTH - owner.bound_width) * -0.5
	message.maptext = complete_text

	// View the message
	LAZYADDASSOCLIST(owned_by.seen_messages, message_loc, src)
	owned_by.images |= message
	animate(message, alpha = 150, time = CHAT_MESSAGE_SPAWN_TIME)

	// Prepare for destruction
	scheduled_destruction = world.time + (lifespan - CHAT_MESSAGE_EOL_FADE)
	addtimer(CALLBACK(src, PROC_REF(end_of_life)), lifespan - CHAT_MESSAGE_EOL_FADE, TIMER_UNIQUE|TIMER_OVERRIDE)





/**
 * Applies final animations to overlay CHAT_MESSAGE_EOL_FADE deciseconds prior to message deletion
 */
/datum/chatmessage/proc/end_of_life(fadetime = CHAT_MESSAGE_EOL_FADE)
	if(QDELETED(src))
		return
//	animate(message, alpha = 0, time = fadetime, flags = ANIMATION_PARALLEL)
//	sleep(fadetime)
//	if(QDELETED(src))
//		return
	qdel(src)

/**
 * Creates a message overlay at a defined location for a given speaker
 *
 * Arguments:
 * * speaker - The atom who is saying this message
 * * message_language - The language that the message is said in
 * * raw_message - The text content of the message
 * * spans - Additional classes to be added to the message
 * * message_mode - Bitflags relating to the mode of the message
 */
/mob/proc/create_chat_message(atom/movable/speaker, datum/language/message_language, raw_message, list/spans, message_mode)
	// Ensure the list we are using, if present, is a copy so we don't modify the list provided to us
	spans = spans?.Copy()

	// Check for virtual speakers (aka hearing a message through a radio)
	var/atom/movable/originalSpeaker = speaker
	if (istype(speaker, /atom/movable/virtualspeaker))
		var/atom/movable/virtualspeaker/v = speaker
		speaker = v.source
		spans |= "virtual-speaker"

	// Ignore virtual speaker (most often radio messages) from ourself
	if (originalSpeaker != src && speaker == src)
		return

	var/text
	if(spans?.Find("emote"))
		text = raw_message
	else
		text = lang_treat(speaker, message_language, raw_message, spans, null, TRUE)

	// Display visual above source
	new /datum/chatmessage(text, speaker, src, message_language, spans)
