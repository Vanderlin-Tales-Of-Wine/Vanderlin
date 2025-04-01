/datum/sex_action/masturbate_vagina
	name = "pleasure self"

/datum/sex_action/masturbate_vagina/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user != target)
		return FALSE
	if(!user.gender == FEMALE)
		return FALSE
	return TRUE

/datum/sex_action/masturbate_vagina/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user != target)
		return FALSE
	if(!get_location_accessible(user, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(user.underwear != "Nude")
		return FALSE
	if(user.gender == MALE)
		return FALSE
	return TRUE

/datum/sex_action/masturbate_vagina/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] starts to pleasure herself."))

/datum/sex_action/masturbate_vagina/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.do_message_signature("[type]"))
		user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] pleasures herself."))
	playsound(user, 'modular/stonekeep/sound/sexcon/fingering.ogg', 30, TRUE, -2, ignore_walls = FALSE)

	user.sexcon.perform_sex_action(user, 2, 4, TRUE)

	user.sexcon.handle_passive_ejaculation()

/datum/sex_action/masturbate_vagina/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] stops stroking."))

/datum/sex_action/masturbate_vagina/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE

/datum/sex_action/masturbate_penis
	name = "pleasure self"

/datum/sex_action/masturbate_penis/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user != target)
		return FALSE
	if(user.gender == FEMALE)
		return FALSE
	return TRUE

/datum/sex_action/masturbate_penis/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user != target)
		return FALSE
	if(!get_location_accessible(user, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(!user.underwear == "Nude")
		return FALSE
	if(user.gender == FEMALE)
		return FALSE
	if(!user.sexcon.can_use_penis())
		return
	return TRUE

/datum/sex_action/masturbate_penis/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] starts to pleasure himself."))

/datum/sex_action/masturbate_penis/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.do_message_signature("[type]"))
		user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] pleasures himself."))
	playsound(user, 'modular/stonekeep/sound/sexcon/fingering.ogg', 30, TRUE, -2, ignore_walls = FALSE)

	user.sexcon.perform_sex_action(user, 2, 0, TRUE)

	user.sexcon.handle_passive_ejaculation()

/datum/sex_action/masturbate_penis/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] stops pleasuring himself."))

/datum/sex_action/masturbate_penis/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE

/datum/sex_action/masturbate_anus
	name = "pleasure whistler"

/datum/sex_action/masturbate_anus/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user != target)
		return FALSE
	return TRUE

/datum/sex_action/masturbate_anus/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user != target)
		return FALSE
	if(!get_location_accessible(user, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	return TRUE

/datum/sex_action/masturbate_anus/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] starts pleasuring their whistler."))

/datum/sex_action/masturbate_anus/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.do_message_signature("[type]"))
		user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] pleasures their whistler."))
	playsound(user, 'modular/stonekeep/sound/sexcon/fingering.ogg', 30, TRUE, -2, ignore_walls = FALSE)

	user.sexcon.perform_sex_action(user, 2, 6, TRUE)
	user.sexcon.handle_passive_ejaculation()

/datum/sex_action/masturbate_anus/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] stops pleasuring their whistler."))

/datum/sex_action/masturbate_anus/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE
