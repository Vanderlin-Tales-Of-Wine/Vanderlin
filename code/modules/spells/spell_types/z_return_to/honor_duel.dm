/datum/objective/ravox_duel/on_creation()
	. = ..()
	var/datum/action/innate/ravox_challenge/challenge = new(src)
	challenge.Grant(owner.current)
	update_explanation_text()

/datum/action/innate/ravox_challenge
	name = "Challenge to Duel"
	button_icon_state = "call_to_arms"

/datum/action/innate/ravox_challenge/Activate()
	var/list/duelists = list()
	for(var/mob/living/carbon/human/H in oview(5, owner))
		if(H.stat != CONSCIOUS)
			continue
		if(!H.mind)
			continue
		duelists += H

	var/mob/living/carbon/human/duelist = browser_input_list(owner, "Who who challenge to an honor duel?", "RAVOX", sortList(duelists))
	if(QDELETED(src) || QDELETED(owner) || QDELETED(duelist))
		return

	var/challenge_message = "[owner] challenges you to an honor duel! Do you accept?"
	owner.visible_message(span_notice("[owner] challenges [duelist] to an honor duel!"), span_notice("You challenge [duelist] to a duel!"))
	var/answer = browser_alert(duelist, challenge_message, "Duel Challenge", DEFAULT_INPUT_CHOICES)
	if(QDELETED(src) || QDELETED(owner) || QDELETED(duelist))
		return
	if(answer != CHOICE_YES)
		to_chat(owner, span_warning("[duelist] has refused your challenge!"))
		to_chat(duelist, span_warning("You refuse [owner]'s challenge."))
		owner.visible_message(span_warning("[duelist] refuses [owner]'s duel challenge."))
		return

	owner.visible_message(span_notice("[owner] and [duelist] prepare for an honor duel!"), span_notice("The duel begins!"))
	to_chat(owner, span_notice("The duel begins! Combat ends at unconsciousness or when a fighter yields (RMB on Combat Mode button)."))
	owner.playsound_local(owner, 'sound/magic/inspire_02.ogg', 100)

	to_chat(duelist, span_notice("The duel begins! Combat ends at unconsciousness or when a fighter yields (RMB on Combat Mode button)."))
	duelist.playsound_local(duelist, 'sound/magic/inspire_02.ogg', 100)

	new /datum/duel(owner, duelist, target)

/datum/duel
	var/ongoing = TRUE
	var/datum/weakref/challenger
	var/datum/weakref/challenged
	var/datum/weakref/objective

/datum/duel/New(mob/living/carbon/human/challenger, mob/living/carbon/human/challenged, /datum/objective/listener)
	src.challenger = WEAKREF(challenger)
	src.challenged = WEAKREF(challenged)
	src.objective = WEAKREF(objective)

	addtimer(CALLBACK(src, PROC_REF(end_duel)), 8 MINUTES, TIMER_DELETE_ME)

	// sorry
	addtimer(CALLBACK(src, PROC_REF(check_duel)), 2 SECONDS, TIMER_LOOP|TIMER_DELETE_ME)

/datum/duel/Destroy(force, ...)
	challenger = null
	challenged = null
	return ..()

/datum/duel/proc/check_duel()
	if(QDELETED(src) || !ongoing)
		return
	var/mob/living/carbon/human/challenger_mob = challenger.resolve()
	var/mob/living/carbon/human/challenged_mob = challenged.resolve()
	if(QDELETED(challenger_mob) || QDELETED(challenged_mob))
		qdel(src)

	if(challenger_mob.surrendering || challenger_mob.incapacitated(ignore_grab = TRUE))
		challenged_mob.visible_message(span_notice("[challenged_mob] defeats [challenged_mob] in the honor duel!"))
		finish_duel(challenger_mob, challenged_mob)
		return
	if(challenged_mob.surrendering || challenged_mob.incapacitated(ignore_grab = TRUE))
		challenger_mob.visible_message(span_notice("[challenger_mob] defeats [challenged_mob] in the honor duel!"))
		finish_duel(challenged_mob, challenger_mob)

/datum/duel/proc/end_duel()
	if(QDELETED(src) || !ongoing)
		return
	ongoing = FALSE
	var/mob/living/carbon/human/challenger_mob = challenger.resolve()
	if(challenger_mob)
		to_chat(challenger_mob, span_notice("The duel has gone on too long and is declared a draw!"))
	var/mob/living/carbon/human/challenged_mob = challenged.resolve()
	if(challenged_mob)
		to_chat(challenged_mob, span_notice("The duel has gone on too long and is declared a draw!"))

	qdel(src)

/datum/duel/proc/finish_duel(mob/living/loser, mob/living/winner)
	if(QDELETED(src) || !ongoing)
		return
	ongoing = FALSE

	to_chat(loser, span_red("You have lost the duel of honor!"))
	to_chat(winner, span_green("You have won the duel of honor!"))

	if(objective)
		var/datum/objective/ravox_duel/ravox = objective.resolve()
		if(ravox?.owner == winner)
			ravox.on_duel_won()

	qdel(src)
