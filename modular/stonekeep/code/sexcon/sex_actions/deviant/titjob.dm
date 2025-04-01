/datum/sex_action/titjob
	name = "use bosom"

/datum/sex_action/titjob/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(user.gender == FEMALE)
		return
	if(target.gender == MALE)
		return
	return TRUE

/datum/sex_action/titjob/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!get_location_accessible(user, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(!get_location_accessible(target, BODY_ZONE_CHEST))
		return FALSE
	if(user.gender == FEMALE)
		return FALSE
	if(target.gender == MALE)
		return FALSE
	if(user.underwear != "Nude")
		return FALSE
	return TRUE

/datum/sex_action/titjob/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] slides between [target]'s bosom."))

/datum/sex_action/titjob/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.do_message_signature("[type]"))
		if(prob(80))
			user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] taffs [target]'s bosom."))
		else
			user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] thrusts his pintle between [target]'s hills."))
	playsound(user, 'modular/stonekeep/sound/sexcon/fingering.ogg', 20, TRUE, -2, ignore_walls = FALSE)

	user.sexcon.perform_sex_action(user, 2, 4, TRUE)
	user.sexcon.handle_passive_ejaculation()

/datum/sex_action/titjob/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] slides out from between [target]'s bosom."))
