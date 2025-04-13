/mob/living/brain/say(message, bubble_type, list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null)
	return

/mob/living/brain/radio(message, list/message_mods = list(), list/spans, language)
	return ..()

/mob/living/brain/lingcheck()
	return LINGHIVE_NONE

/mob/living/brain/treat_message(message)
	message = capitalize(message)
	return message
