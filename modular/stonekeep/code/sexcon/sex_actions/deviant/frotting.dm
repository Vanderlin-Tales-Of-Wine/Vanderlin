/datum/sex_action/frotting
	name = "frotteurism"

/datum/sex_action/frotting/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(user.gender == FEMALE)
		return
	if(target.gender == FEMALE)
		return
	if(user.underwear != "Nude")
		return FALSE
	if(target.underwear != "Nude")
		return FALSE
	return TRUE

/datum/sex_action/frotting/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!get_location_accessible(user, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(!get_location_accessible(target, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(user.gender == FEMALE)
		return FALSE
	if(target.gender == FEMALE)
		return FALSE
	return TRUE

/datum/sex_action/frotting/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] starts to rub against [target]."))

/datum/sex_action/frotting/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.do_message_signature("[type]"))
		user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] frots against [target]."))
	playsound(user, 'modular/stonekeep/sound/sexcon/fingering.ogg', 20, TRUE, -2, ignore_walls = FALSE)

	user.sexcon.perform_sex_action(user, 1, 4, TRUE)
	user.sexcon.handle_passive_ejaculation()

	user.sexcon.perform_sex_action(target, 1, 4, TRUE)
	target.sexcon.handle_passive_ejaculation()

/datum/sex_action/frotting/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] pulls away from [target]."))
