/datum/duel
	var/mob/living/carbon/human/challenger
	var/mob/living/carbon/human/challenged
	var/ongoing = TRUE

/datum/duel/New(mob/living/carbon/human/challenger, mob/living/carbon/human/challenged)
	src.challenger = challenger
	src.challenged = challenged

/datum/duel/proc/end_duel(mob/living/winner)
	if(!ongoing)
		return

	ongoing = FALSE
	to_chat(winner, span_green("You have won the duel of honor!"))
	to_chat(winner == challenger ? challenged : challenger, span_red("You have lost the duel of honor!"))

	if(winner.mind)
		var/datum/objective/ravox_duel/objective = locate() in winner.mind.get_all_objectives()
		if(objective)
			objective.on_duel_won()

	qdel(src)

/obj/effect/proc_holder/spell/targeted/ravox_challenge
	name = "Challenge to Duel"
	overlay_state = "call_to_arms"
	antimagic_allowed = TRUE
	recharge_time = 20 SECONDS
	range = 7
	selection_type = "view"
	include_user = FALSE
	uses_mana = FALSE

/obj/effect/proc_holder/spell/targeted/ravox_challenge/cast(list/targets, mob/living/carbon/human/user)
	var/mob/living/carbon/human/target = targets[1]

	if(!istype(target))
		to_chat(user, span_warning("You can only challenge human warriors!"))
		return FALSE

	if(target == user)
		to_chat(user, span_warning("Challenging yourself would prove nothing!"))
		return FALSE

	if(target.stat != CONSCIOUS)
		to_chat(user, span_warning("Your target must be conscious to accept a duel!"))
		return FALSE

	if(user.stat != CONSCIOUS)
		to_chat(user, span_warning("You must be conscious to issue a challenge!"))
		return FALSE

	var/challenge_message = "[user] challenges you to an honor duel! Do you accept?"
	user.visible_message(span_notice("[user] challenges [target] to an honor duel!"), span_notice("You challenge [target] to a duel!"))
	if(alert(target, challenge_message, "Duel Challenge", "Accept", "Refuse") != "Accept")
		to_chat(user, span_warning("[target] has refused your challenge!"))
		to_chat(target, span_warning("You refuse [user]'s challenge."))
		user.visible_message(span_warning("[target] refuses [user]'s duel challenge."))
		return FALSE

	user.visible_message(span_notice("[user] and [target] prepare for an honor duel!"), span_notice("The duel begins!"))
	to_chat(user, span_notice("The duel begins! Combat ends at unconsciousness or when a fighter yields (RMB on Combat Mode button)."))
	user.playsound_local(user, 'sound/magic/inspire_02.ogg', 100)

	to_chat(target, span_notice("The duel begins! Combat ends at unconsciousness or when a fighter yields (RMB on Combat Mode button)."))
	target.playsound_local(target, 'sound/magic/inspire_02.ogg', 100)

	var/datum/duel/current_duel = new(user, target)
	var/start_time = world.time
	var/max_duel_duration = 8 MINUTES

	while(current_duel && current_duel.ongoing)
		CHECK_TICK

		if(world.time > start_time + max_duel_duration)
			to_chat(user, span_notice("The duel has gone on too long and is declared a draw!"))
			to_chat(target, span_notice("The duel has gone on too long and is declared a draw!"))
			qdel(current_duel)
			break

		if(user.stat >= SOFT_CRIT || user.surrendering)
			target.visible_message(span_notice("[target] defeats [user] in the honor duel!"))
			current_duel.end_duel(target)
			break
		if(target.stat >= SOFT_CRIT || target.surrendering)
			user.visible_message(span_notice("[user] defeats [target] in the honor duel!"))
			current_duel.end_duel(user)
			break
		sleep(2 SECONDS)

	return ..()
