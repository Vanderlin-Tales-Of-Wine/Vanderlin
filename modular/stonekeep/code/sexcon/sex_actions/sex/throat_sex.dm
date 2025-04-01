/datum/sex_action/throat_sex
	name = "use their throat"
	stamina_cost = 1.0

/datum/sex_action/throat_sex/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(user.gender == FEMALE)
		return FALSE
	return TRUE

/datum/sex_action/throat_sex/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!get_location_accessible(user, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(!get_location_accessible(target, BODY_ZONE_PRECISE_MOUTH))
		return FALSE
	if(user.gender == FEMALE)
		return
	if(user.underwear != "Nude")
		return FALSE
	return TRUE

/datum/sex_action/throat_sex/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] starts to feed [target]."))
	playsound(target, list('modular/stonekeep/sound/sexcon/insert (1).ogg','modular/stonekeep/sound/sexcon/insert (2).ogg'), 20, TRUE, ignore_walls = FALSE)

/datum/sex_action/throat_sex/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.do_message_signature("[type]"))
		if(prob(80))
			user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] feeds [target]."))
		else
			user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] thrusts between [target]'s lips."))
	playsound(target, 'modular/stonekeep/sound/sexcon/segso.ogg', 50, TRUE, -2, ignore_walls = FALSE)
	do_thrust_animate(user, target)

	user.sexcon.perform_sex_action(user, 2, 0, TRUE)
	if(user.sexcon.check_active_ejaculation())
		user.visible_message(span_love("[user] tightens in pleasure!"))
		user.sexcon.cum_into()
		user.virginity = FALSE

	if(user.sexcon.considered_limp())
		user.sexcon.perform_sex_action(target, 0, 2, FALSE)
	target.sexcon.handle_passive_ejaculation()

/datum/sex_action/throat_sex/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] stops feeding [target]."))

/datum/sex_action/throat_sex/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE
