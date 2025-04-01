/datum/sex_action/anal_sex
	name = "taff whistler"
	stamina_cost = 1.0

/datum/sex_action/anal_sex/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(user.gender == FEMALE)
		return FALSE
	return TRUE

/datum/sex_action/anal_sex/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!get_location_accessible(user, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(!get_location_accessible(target, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(user.gender == FEMALE)
		return FALSE
	if(!user.sexcon.can_use_penis())
		return
	if(user.underwear != "Nude")
		return FALSE
	if(target.underwear != "Nude")
		return FALSE
	return TRUE

/datum/sex_action/anal_sex/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] enters [target]'s whistler exit."))
	playsound(target, list('modular/stonekeep/sound/sexcon/insert (1).ogg','modular/stonekeep/sound/sexcon/insert (2).ogg'), 20, TRUE, ignore_walls = FALSE)

/datum/sex_action/anal_sex/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.do_message_signature("[type]"))
		if(prob(80))
			user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] taffs [target]'s back gate."))
		else
			user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] rods [target]'s whistler."))
	playsound(target, 'modular/stonekeep/sound/sexcon/segso.ogg', 50, TRUE, -2, ignore_walls = FALSE)
	do_thrust_animate(user, target)

	user.sexcon.perform_sex_action(user, 2, 0, TRUE)
	if(user.sexcon.check_active_ejaculation())
		user.visible_message(span_love("[user] tightens in ecstasy!"))
		user.sexcon.cum_into()
		user.virginity = FALSE

	if(user.sexcon.considered_limp())
		user.sexcon.perform_sex_action(target, 1.2, 4, FALSE)
	else
		user.sexcon.perform_sex_action(target, 2.4, 9, FALSE)
	target.sexcon.handle_passive_ejaculation()

/datum/sex_action/anal_sex/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] pulls out of [target]'s rear entry."))

/datum/sex_action/anal_sex/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE

/datum/sex_action/anal_ride_sex
	name = "ride with whistler"
	stamina_cost = 1.0
	aggro_grab_instead_same_tile = FALSE

/datum/sex_action/anal_ride_sex/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(target.gender == FEMALE)
		return FALSE
	return TRUE

/datum/sex_action/anal_ride_sex/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!get_location_accessible(user, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(!get_location_accessible(target, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(target.gender == FEMALE)
		return FALSE
	if(user.underwear != "Nude")
		return FALSE
	if(target.underwear != "Nude")
		return FALSE
	return TRUE

/datum/sex_action/anal_ride_sex/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] starts to ride [target] with their whistler."))
	playsound(target, list('modular/stonekeep/sound/sexcon/insert (1).ogg','modular/stonekeep/sound/sexcon/insert (2).ogg'), 20, TRUE, ignore_walls = FALSE)

/datum/sex_action/anal_ride_sex/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.do_message_signature("[type]"))
		user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] rides [target]."))
	playsound(target, 'modular/stonekeep/sound/sexcon/segso.ogg', 50, TRUE, -2, ignore_walls = FALSE)
	do_thrust_animate(user, target)
	if(target.sexcon.considered_limp())
		user.sexcon.perform_sex_action(target, 1.2, 4, TRUE)
	else
		user.sexcon.perform_sex_action(target, 2.4, 9, TRUE)
	user.sexcon.handle_passive_ejaculation()

	user.sexcon.perform_sex_action(target, 2, 4, FALSE)
	if(target.sexcon.check_active_ejaculation())
		target.visible_message(span_love("[target] tightens in ecstasy!"))
		target.sexcon.cum_into()
		target.virginity = FALSE

/datum/sex_action/anal_ride_sex/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] gets off [target]."))

/datum/sex_action/anal_ride_sex/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE
