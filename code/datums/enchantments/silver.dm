#define AFFECTED_VLORD 1
#define AFFECTED 2

/datum/enchantment/silver
	enchantment_name = "Nightlurkers Bane"
	examine_text = "It's a bane to all that lurk at night."
	var/list/last_used = list()

/datum/enchantment/silver/proc/affected_by_bane(mob/target)
	if(!ishuman(target) || !target.mind)
		return UNAFFECTED

	var/datum/antagonist/vampire/vamp_datum = target.mind.has_antag_datum(/datum/antagonist/vampire)
	var/datum/antagonist/werewolf/wolf_datum = target.mind.has_antag_datum(/datum/antagonist/werewolf)
	if(!vamp_datum || !wolf_datum)
		return UNAFFECTED

	if(istype(vamp_datum, /datum/antagonist/vampire/lord))
		var/datum/antagonist/vampire/lord/lord_datum = vamp_datum
		return (lord_datum.vamplevel < 4) ? AFFECTED_VLORD : UNAFFECTED

	if(wolf_datum?.transformed == TRUE || vamp_datum)
		return AFFECTED
	return UNAFFECTED

/datum/enchantment/silver/on_hit(obj/item/source, mob/living/carbon/human/target, mob/living/carbon/human/user, proximity_flag, click_parameters)
	if(world.time < (src.last_used[source] + (1 MINUTES + 40 SECONDS))) //thanks borbop
		return

	var/affected = affected_by_bane(target)
	var/datum/antagonist/vampire/vamp_datum = target.mind.has_antag_datum(/datum/antagonist/vampire)
	if(affected)
		to_chat(target, span_userdanger("I am struck by my BANE!"))
		target.Stun(20)
		target.Knockdown(10)
		target.Paralyze(10)
		target.adjustFireLoss(25)
		target.fire_act(1,10)
		if(vamp_datum && affected != AFFECTED_VLORD)
			target.apply_status_effect(/datum/status_effect/debuff/silver_curse)
			if(vamp_datum.disguised)
				visible_message("<font color='white'>The silver weapon manifests [target]'s curse!</font>")
		last_used[source] = world.time
		return
	else if (istype(vamp_datum, /datum/antagonist/vampire/lord))
		//Unaffected but vlord means we are vamplevel 4
		user.Stun(10)
		user.Paralyze(10)
		user.adjustFireLoss(25)
		user.fire_act(1,10)
		to_chat(user, span_danger("The silver enchantment fails!"))
		H.visible_message(H, span_userdanger("This feeble metal cannot hurt me, I AM THE ANCIENT!"))

	var/datum/antagonist/werewolf/W = H.mind.has_antag_datum(/datum/antagonist/werewolf/)
	var/datum/antagonist/vampire/lesser/V = H.mind.has_antag_datum(/datum/antagonist/vampire/lesser)
	var/datum/antagonist/vampire/V_lord = H.mind.has_antag_datum(/datum/antagonist/vampire/)
	if(V_lord)
		if(V_lord.vamplevel < 4 && !V)
			H.Knockdown(10)
			H.Paralyze(10)
			to_chat(H, span_userdanger("I'm hit by my BANE!"))
			H.adjustFireLoss(25)
			H.fire_act(1,10)
			last_used |= source
			last_used[source] = world.time
		if(V_lord.vamplevel == 4 && !V)
			s_user.Stun(10)
			s_user.Paralyze(10)
			s_user.adjustFireLoss(25)
			s_user.fire_act(1,10)
			to_chat(s_user, "<font color='red'> The silver weapon fails!</font>")
	if(W && W.transformed == TRUE)
		to_chat(H, span_userdanger("I'm hit by my BANE!"))
		H.Stun(10)
		//knockdown
		H.Paralyze(10)
		H.adjustFireLoss(25)
		H.fire_act(1,10)
		last_used |= source
		last_used[source] = world.time

/datum/enchantment/silver/on_equip(obj/item/i, mob/living/carbon/human/user)
	var/affected = affected_by_bane(user)
	if(!affected)
		return

	to_chat(user, span_userdanger("I have worn my BANE!"))
	user.Knockdown(10)
	user.Paralyze(10)

	if(affected != AFFECTED_VLORD)
		user.adjustFireLoss(25)
		user.fire_act(1, 10)

/datum/enchantment/silver/on_pickup(obj/item/i, mob/living/carbon/human/user)
	. = ..()
	var/affected = affected_by_bane(user)
	if(!affected)
		return

	to_chat(user, span_userdanger("I have held my BANE!"))
	user.Knockdown(10)
	user.Paralyze(10)

	if(affected != AFFECTED_VLORD)
		user.adjustFireLoss(25)
		user.fire_act(1, 10)

#undef AFFECTED
#undef AFFECTED_VLORD
