/// Tracks culling pairings
GLOBAL_LIST_EMPTY(graggar_cullings)

/datum/culling_duel
	var/datum/weakref/challenger
	var/datum/weakref/target
	var/completed = FALSE

/datum/culling_duel/New(mob/challenger, mob/target)
	. = ..()
	src.challenger = WEAKREF(challenger)
	src.target = WEAKREF(target)

/datum/round_event_control/graggar_culling
	name = "Graggar's Culling"
	track = EVENT_TRACK_INTERVENTION
	typepath = /datum/round_event/graggar_culling
	weight = 4
	earliest_start = 40 MINUTES
	max_occurrences = 1
	min_players = 50
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

		contenders += human_mob

	if(length(contenders) < 2)
		return

	var/mob/living/carbon/human/first_chosen = pick_n_take(contenders)
	var/mob/living/carbon/human/second_chosen = pick_n_take(contenders)

	var/datum/culling_duel/new_duel = new(first_chosen, second_chosen)
	GLOB.graggar_cullings += new_duel

	first_chosen.add_stress(/datum/stressevent/graggar_culling_unfinished)
	to_chat(first_chosen, span_boldred("Weak should feed the strong, that is Graggar's will. Prove that you are not weak by eating the heart of [second_chosen.real_name] and gain unimaginable power in turn. Fail, and you will be the one eaten."))
	to_chat(first_chosen, span_boldred("[second_chosen.real_name] is somewhere in the [lowertext(get_area_name(second_chosen))]. Eat his heart before he eats yours!"))
	SEND_SOUND(first_chosen, 'sound/magic/marked.ogg')

	second_chosen.add_stress(/datum/stressevent/graggar_culling_unfinished)
	to_chat(second_chosen, span_boldred("Weak should feed the strong, that is Graggar's will. Prove that you are not weak by eating the heart of [first_chosen.real_name] and gain unimaginable power in turn. Fail, and you will be the one eaten."))
	to_chat(second_chosen, span_boldred("[first_chosen.real_name] is somewhere in the [lowertext(get_area_name(first_chosen))]. Eat his heart before he eats yours!"))
	SEND_SOUND(second_chosen, 'sound/magic/marked.ogg')
