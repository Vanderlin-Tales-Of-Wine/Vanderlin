/datum/sex_action/thighjob
	name = "use thighs"

/datum/sex_action/thighjob/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(user.gender == FEMALE)
		return
	return TRUE

/datum/sex_action/thighjob/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!get_location_accessible(user, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(user.gender == FEMALE)
		return FALSE
	if(user.underwear != "Nude")
		return FALSE
	return TRUE

/datum/sex_action/thighjob/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] slides between [target]'s thighs."))

/datum/sex_action/thighjob/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.do_message_signature("[type]"))
		user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] uses [target]'s thighs."))
	playsound(user, 'modular/stonekeep/sound/sexcon/segso.ogg', 20, TRUE, -2, ignore_walls = FALSE)
	do_thrust_animate(user, target)

	user.sexcon.perform_sex_action(user, 2, 4, TRUE)
	user.sexcon.handle_passive_ejaculation()

/datum/sex_action/thighjob/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] slides out from between [target]'s thighs."))

/datum/sex_action/force_thighjob
	name = "use own thighs"

/datum/sex_action/force_thighjob/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(target.gender == FEMALE)
		return FALSE
	return TRUE

/datum/sex_action/force_thighjob/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!get_location_accessible(target, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(target.gender == FEMALE)
		return FALSE
	return TRUE

/datum/sex_action/force_thighjob/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] envelops [target] with their thighs."))

/datum/sex_action/force_thighjob/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.do_message_signature("[type]"))
		user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] jerks [target] with their thighs."))
	playsound(user, 'modular/stonekeep/sound/sexcon/fingering.ogg', 30, TRUE, -2, ignore_walls = FALSE)
	do_thrust_animate(target, user)

	user.sexcon.perform_sex_action(target, 2, 4, TRUE)

	target.sexcon.handle_passive_ejaculation()

/datum/sex_action/force_thighjob/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] stops jerking [target] their thighs."))

/datum/sex_action/force_thighjob/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(target.sexcon.finished_check())
		return TRUE
	return FALSE
