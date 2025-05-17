/datum/objective/ravox_duel
	name = "Prove Your Might"
	triumph_count = 0
	var/duels_won = 0
	var/duels_required = 2

/datum/objective/ravox_duel/on_creation()
	. = ..()
	if(owner?.current)
		owner.current.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/ravox_challenge)
	update_explanation_text()

/datum/objective/ravox_duel/proc/on_duel_won()
	duels_won++
	if(duels_won >= duels_required && !completed)
		to_chat(owner.current, span_greentext("You have proven your worth in combat! Ravox is pleased!"))
		owner.current.adjust_triumphs(2)
		completed = TRUE
		adjust_storyteller_influence("Ravox", 25)
		escalate_objective()
	else
		to_chat(owner.current, span_greentext("You have won one duel needed to prove your worth to Ravox!"))

/datum/objective/ravox_duel/update_explanation_text()
	explanation_text = "Win [duels_required] honor duels against other warriors to prove your might!"

/obj/effect/proc_holder/spell/targeted/ravox_challenge
	name = "Challenge to Duel"
	overlay_state = "ravox_challenge"
	antimagic_allowed = TRUE
	recharge_time = 20 SECONDS
	range = 7
	selection_type = "view"
	include_user = FALSE

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
	if(alert(target, challenge_message, "Duel Challenge", "Accept", "Refuse") != "Accept")
		to_chat(user, span_warning("[target] has refused your challenge!"))
		to_chat(target, span_warning("You refuse [user]'s challenge."))
		return FALSE

	to_chat(user, span_green("The duel begins! Fight until yield or unconsciousness!"))
	to_chat(target, span_green("The duel begins! Fight until yield or unconsciousness!"))

	var/datum/duel/current_duel = new(user, target)
	var/start_time = world.time
	var/max_duel_duration = 10 MINUTES

	while(current_duel && current_duel.ongoing)
		CHECK_TICK

		if(world.time > start_time + max_duel_duration)
			to_chat(user, span_warning("The duel has gone on too long and is declared a draw!"))
			to_chat(target, span_warning("The duel has gone on too long and is declared a draw!"))
			qdel(current_duel)
			break

		if(user.stat >= SOFT_CRIT || user.surrendering)
			current_duel.end_duel(target)
			break
		if(target.stat >= SOFT_CRIT || target.surrendering)
			current_duel.end_duel(user)
			break
		sleep(2 SECONDS)

	return TRUE

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
