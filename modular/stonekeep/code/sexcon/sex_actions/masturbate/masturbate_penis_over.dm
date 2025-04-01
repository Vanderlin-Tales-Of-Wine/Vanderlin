/datum/sex_action/masturbate_penis_over
	name = "pleasure self over them"
	check_same_tile = FALSE

/datum/sex_action/masturbate_penis_over/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(user.gender == FEMALE)
		return FALSE
	return TRUE

/datum/sex_action/masturbate_penis_over/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!get_location_accessible(user, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(user.gender == FEMALE)
		return FALSE
	if(!user.sexcon.can_use_penis())
		return
	if(user.underwear != "Nude")
		return FALSE
	return TRUE

/datum/sex_action/masturbate_penis_over/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] starts jerking over [target]..."))

/datum/sex_action/masturbate_penis_over/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.do_message_signature("[type]"))
		if(prob(50))
			user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] pleasures himself over [target]"))
		else
			user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] strokes his pintle over [target]"))
	playsound(user, 'modular/stonekeep/sound/sexcon/fingering.ogg', 30, TRUE, -2, ignore_walls = FALSE)

	user.sexcon.perform_sex_action(user, 2, 4, TRUE)

	if(user.sexcon.check_active_ejaculation())
		user.visible_message(span_love("[user] paints [target]'s body!"))
		user.sexcon.cum_onto()

/datum/sex_action/masturbate_penis_over/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] stops pleasuring himself."))

/datum/sex_action/masturbate_penis_over/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE
