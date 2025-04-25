/// Tracks culling pairings
GLOBAL_LIST_EMPTY(graggar_cullings)

/datum/culling_duel
	var/datum/weakref/challenger
	var/datum/weakref/target
	var/datum/weakref/challenger_heart
	var/datum/weakref/target_heart

/datum/culling_duel/New(mob/challenger, mob/target)
	. = ..()
	src.challenger = WEAKREF(challenger)
	src.target = WEAKREF(target)
	var/obj/item/organ/heart/c_heart = challenger.getorganslot(ORGAN_SLOT_HEART)
	var/obj/item/organ/heart/t_heart = target.getorganslot(ORGAN_SLOT_HEART)
	src.challenger_heart = WEAKREF(c_heart)
	src.target_heart = WEAKREF(t_heart)

/datum/culling_duel/Destroy()
	GLOB.graggar_cullings -= src
	return ..()

/datum/culling_duel/proc/handle_heart_destroyed(which_heart)
	var/mob/living/carbon/human/winner
	var/mob/living/carbon/human/loser

	if(which_heart == "target")
		winner = challenger.resolve()
		loser = target.resolve()
	else if(which_heart == "challenger")
		winner = target.resolve()
		loser = challenger.resolve()

	if(winner)
		winner.adjust_triumphs(1)
		winner.remove_stress(/datum/stressevent/graggar_culling_unfinished)
		winner.verbs -= /mob/living/carbon/human/proc/remember_culling
		winner.add_stress(/datum/stressevent/graggar_culling_finished)
		to_chat(winner, span_red("Your rival's heart has been either destroyed or has rotted away! While not the bloody consumption Graggar desired, he acknowledges you as not weak."))

	if(loser)
		loser.remove_stress(/datum/stressevent/graggar_culling_unfinished)
		loser.verbs -= /mob/living/carbon/human/proc/remember_culling
		to_chat(loser, span_red("You have FAILED Graggar for the LAST TIME!"))
		loser.gib()

	qdel(src)

/datum/culling_duel/proc/process_win(mob/living/winner, mob/living/loser)
	winner.remove_stress(/datum/stressevent/graggar_culling_unfinished)
	winner.verbs -= /mob/living/carbon/human/proc/remember_culling
	winner.set_stat_modifier("graggar_culling", STATKEY_STR, 1)
	winner.set_stat_modifier("graggar_culling", STATKEY_END, 1)
	winner.set_stat_modifier("graggar_culling", STATKEY_CON, 1)
	winner.set_stat_modifier("graggar_culling", STATKEY_PER, 1)
	winner.set_stat_modifier("graggar_culling", STATKEY_INT, 1)
	winner.set_stat_modifier("graggar_culling", STATKEY_SPD, 1)
	winner.set_stat_modifier("graggar_culling", STATKEY_LCK, 1)
	winner.adjust_triumphs(2)
	to_chat(winner, span_notice("You have proven your strength to Graggar by consuming your rival's heart!"))
	winner.add_stress(/datum/stressevent/graggar_culling_finished)

	if(loser)
		loser.remove_stress(/datum/stressevent/graggar_culling_unfinished)
		loser.verbs -= /mob/living/carbon/human/proc/remember_culling
		to_chat(loser, span_boldred("You have FAILED Graggar for the LAST TIME!"))
		loser.gib()

	qdel(src)

/// Verb for the graggar's culling contestants to remember their targets
/mob/living/carbon/human/proc/remember_culling()
	set name = "Graggar's Culling"
	set category = "Memory"
	if(!mind)
		return
	mind.recall_culling(src)

/datum/round_event_control/graggar_culling
	name = "Graggar's Culling"
	track = EVENT_TRACK_INTERVENTION
	typepath = /datum/round_event/graggar_culling
	weight = 4
	earliest_start = 30 MINUTES
	max_occurrences = 1
	min_players = 45
	allowed_storytellers = list(/datum/storyteller/graggar)

/datum/round_event_control/graggar_culling/canSpawnEvent(players_amt, gamemode, fake_check)
	. = ..()
	if(!.)
		return FALSE
	if(GLOB.patron_follower_counts["Graggar"] < 3)
		return FALSE

/datum/round_event/graggar_culling/start()
	var/list/contenders = list()
	for(var/mob/living/carbon/human/human_mob in GLOB.player_list)
		if(!istype(human_mob) || human_mob.stat == DEAD || !human_mob.client)
			continue

		if(!human_mob.patron || !istype(human_mob.patron, /datum/patron/inhumen/graggar))
			continue

		var/obj/item/organ/heart/heart = human_mob.getorganslot(ORGAN_SLOT_HEART)
		if(!heart)
			continue

		contenders += human_mob

	if(length(contenders) < 2)
		return

	var/mob/living/carbon/human/first_chosen = pick_n_take(contenders)
	var/mob/living/carbon/human/second_chosen = pick_n_take(contenders)

	var/datum/culling_duel/new_duel = new(first_chosen, second_chosen)
	GLOB.graggar_cullings += new_duel

	first_chosen.add_stress(/datum/stressevent/graggar_culling_unfinished)
	first_chosen.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/extract_heart)
	first_chosen.verbs |= /mob/living/carbon/human/proc/remember_culling
	to_chat(first_chosen, span_red("Weak should feed the strong, that is Graggar's will. Prove that you are not weak by eating the heart of [span_notice(second_chosen.real_name)] and gain unimaginable power in turn. Fail, and you will be the one eaten."))
	to_chat(first_chosen, span_red("[span_notice(second_chosen.real_name)] is somewhere in the [span_notice(lowertext(get_area_name(second_chosen)))]. Eat their heart before they eat yours!"))
	SEND_SOUND(first_chosen, 'sound/magic/marked.ogg')

	second_chosen.add_stress(/datum/stressevent/graggar_culling_unfinished)
	second_chosen.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/extract_heart)
	second_chosen.verbs |= /mob/living/carbon/human/proc/remember_culling
	to_chat(second_chosen, span_red("Weak should feed the strong, that is Graggar's will. Prove that you are not weak by eating the heart of [span_notice(first_chosen.real_name)] and gain unimaginable power in turn. Fail, and you will be the one eaten."))
	to_chat(second_chosen, span_red("[span_notice(first_chosen.real_name)] is somewhere in the [span_notice(lowertext(get_area_name(first_chosen)))]. Eat their heart before they eat yours!"))
	SEND_SOUND(second_chosen, 'sound/magic/marked.ogg')
