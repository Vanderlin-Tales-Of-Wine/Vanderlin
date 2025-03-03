/datum/sex_action/facesitting
	name = "mouth ride"

/datum/sex_action/facesitting/shows_on_menu(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	return TRUE

/datum/sex_action/facesitting/can_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user == target)
		return FALSE
	if(!get_location_accessible(user, BODY_ZONE_PRECISE_GROIN))
		return FALSE
	if(!get_location_accessible(target, BODY_ZONE_PRECISE_MOUTH))
		return FALSE
	// Need to stand up
	if(!(user.mobility_flags & MOBILITY_STAND))
		return FALSE
	// Target can't stand up
	if(target.mobility_flags & MOBILITY_STAND)
		return FALSE
	return TRUE

/datum/sex_action/facesitting/on_start(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] sits on [target]'s face."))

/datum/sex_action/facesitting/on_perform(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.do_message_signature("[type]"))
		user.visible_message(user.sexcon.spanify_force("[user] [user.sexcon.get_generic_force_adjective()] rides [target]'s face."))
	target.make_sucking_noise()
	do_thrust_animate(user, target)

	if(ishuman(user)) // Yep, dick-biting code if you're a Kaizoku changeling. From Mono.
		var/mob/living/carbon/human/H = target
		if(H.dna?.species?.name == "Changeling")
			if(prob(15))
				user.visible_message(span_danger("OH GODS! THAT FREEK TORE IT APART!"))
				target.visible_message(span_danger("The fleshy taste drives you into a trance, involuntary, carnivorous hunger! Your jaws loosen!"))
				playsound(target, 'sound/combat/dismemberment/dismem (1).ogg', 100, TRUE, ignore_walls = FALSE)
				ADD_TRAIT(target, TRAIT_MINCED, TRAIT_GENERIC)
				user.emote("scream")
				user.apply_damage(80, BRUTE, BODY_ZONE_PRECISE_GROIN)
				user.Stun(60)
				return
			else
				user.visible_message(span_info("You suppress the primal instinct, though this strain feels unnatural to your biology."))

	user.sexcon.perform_sex_action(user, 1, 3, TRUE)
	user.sexcon.handle_passive_ejaculation()

	user.sexcon.perform_sex_action(target, 0, 2, FALSE)
	target.sexcon.handle_passive_ejaculation()

/datum/sex_action/facesitting/on_finish(mob/living/carbon/human/user, mob/living/carbon/human/target)
	user.visible_message(span_warning("[user] gets off [target]'s face."))

/datum/sex_action/facesitting/is_finished(mob/living/carbon/human/user, mob/living/carbon/human/target)
	if(user.sexcon.finished_check())
		return TRUE
	return FALSE
