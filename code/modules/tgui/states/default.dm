/**
 * tgui state: default_state
 *
 * Checks a number of things -- mostly physical distance for humans and view for robots.
 **/

GLOBAL_DATUM_INIT(default_state, /datum/ui_state/default, new)

/datum/ui_state/default/can_use_topic(src_object, mob/user)
	return user.default_can_use_topic(src_object) // Call the individual mob-overridden procs.

/mob/proc/default_can_use_topic(src_object)
	return UI_CLOSE // Don't allow interaction by default.

/mob/living/default_can_use_topic(src_object)
	. = shared_ui_interaction(src_object)
	if(. > UI_CLOSE && loc)
		. = min(., loc.contents_ui_distance(src_object, src)) // Check the distance...
	if(. == UI_INTERACTIVE) // Non-human living mobs can only look, not touch.
		return UI_UPDATE

/mob/living/carbon/humanoid/default_can_use_topic(src_object)
	. = shared_ui_interaction(src_object)
	if(. > UI_CLOSE)
		. = min(., shared_living_ui_distance(src_object)) // Check the distance...
