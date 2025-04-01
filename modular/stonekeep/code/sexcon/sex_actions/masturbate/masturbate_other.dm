/datum/sex_action/masturbate_other_vagina
	name = "fingerservice"
	check_same_tile = FALSE

/datum/sex_action/masturbate_other_vagina/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(target.gender == MALE)
		return FALSE
	return TRUE

/datum/sex_action/masturbate_other_vagina/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!get_location_accessible(target, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(target.underwear != "Nude")
		return FALSE
	if(target.gender == MALE)
		return FALSE
	return TRUE

/datum/sex_action/masturbate_other_vagina/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] starts rubbing [target]."))

/datum/sex_action/masturbate_other_vagina/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.do_message_signature("[type]"))
		if(prob(50))
			user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] rubs [target]."))
		else
			user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] fingers [target]."))
	playsound(user, 'modular/stonekeep/sound/sexcon/fingering.ogg', 30, TRUE, -2, ignore_walls = FALSE)

	user.sexcon.perform_sex_action(target, 2, 4, TRUE)

	target.sexcon.handle_passive_ejaculation()

/datum/sex_action/masturbate_other_vagina/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] stops rubbing [target]."))

/datum/sex_action/masturbate_other_vagina/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(target.sexcon.finished_check())
		return TRUE
	return FALSE

/datum/sex_action/masturbate_penis_other
	name = "handservice"
	check_same_tile = FALSE

/datum/sex_action/masturbate_penis_other/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(target.gender == FEMALE)
		return FALSE
	return TRUE

/datum/sex_action/masturbate_penis_other/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!get_location_accessible(target, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(target.underwear != "Nude")
		return FALSE
	if(target.gender == FEMALE)
		return FALSE
	return TRUE

/datum/sex_action/masturbate_penis_other/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] starts jerking [target]."))

/datum/sex_action/masturbate_penis_other/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.do_message_signature("[type]"))
		if(prob(50))
			user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] jerks [target]."))
		else
			user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] plays with [target]'s pintle."))
	playsound(user, 'modular/stonekeep/sound/sexcon/fingering.ogg', 30, TRUE, -2, ignore_walls = FALSE)

	user.sexcon.perform_sex_action(target, 2, 0, TRUE)

	target.sexcon.handle_passive_ejaculation()

/datum/sex_action/masturbate_penis_other/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] stops jerking [target]."))

/datum/sex_action/masturbate_penis_other/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(target.sexcon.finished_check())
		return TRUE
	return FALSE

/datum/sex_action/masturbate_other_anus
	name = "massage whistler"
	check_same_tile = FALSE

/datum/sex_action/masturbate_other_anus/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	return TRUE

/datum/sex_action/masturbate_other_anus/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!get_location_accessible(target, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(target.underwear != "Nude")
		return FALSE
	return TRUE

/datum/sex_action/masturbate_other_anus/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] starts to rub [target]'s whistler."))

/datum/sex_action/masturbate_other_anus/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.do_message_signature("[type]"))
		if(prob(50))
			user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] rubs [target]'s whistler."))
		else
			user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] massages [target]'s whistler."))
	playsound(user, 'modular/stonekeep/sound/sexcon/fingering.ogg', 30, TRUE, -2, ignore_walls = FALSE)

	user.sexcon.perform_sex_action(target, 2, 6, TRUE)
	target.sexcon.handle_passive_ejaculation()

/datum/sex_action/masturbate_other_anus/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] stops rubbing [target]'s whistler."))

/datum/sex_action/masturbate_other_anus/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(target.sexcon.finished_check())
		return TRUE
	return FALSE
