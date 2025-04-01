/datum/sex_action/scissoring
	name = "tribadism"

/datum/sex_action/scissoring/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(user.gender == MALE)
		return
	if(target.gender == MALE)
		return
	if(user.underwear != "Nude")
		return FALSE
	if(target.underwear != "Nude")
		return FALSE
	return TRUE

/datum/sex_action/scissoring/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!get_location_accessible(user, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(!get_location_accessible(target, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(user.gender == MALE)
		return FALSE
	if(target.gender == MALE)
		return FALSE
	return TRUE

/datum/sex_action/scissoring/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] presses against [target]."))

/datum/sex_action/scissoring/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.do_message_signature("[type]"))
		user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] rubs against [target]."))
	playsound(target, 'modular/stonekeep/sound/sexcon/segso.ogg', 50, TRUE, -2, ignore_walls = FALSE)
	do_thrust_animate(user, target)

	user.sexcon.perform_sex_action(user, 1, 4, TRUE)
	user.sexcon.handle_passive_ejaculation()

	user.sexcon.perform_sex_action(target, 1, 4, TRUE)
	target.sexcon.handle_passive_ejaculation()

/datum/sex_action/scissoring/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] stops rubbing against [target]."))
