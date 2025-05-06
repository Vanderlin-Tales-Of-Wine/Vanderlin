/datum/round_event_control/dendor_taming
	name = "Dendor's Taming Challenge"
	track = EVENT_TRACK_MODERATE
	typepath = /datum/round_event/dendor_taming
	weight = 5
	earliest_start = 20 MINUTES
	max_occurrences = 1
	min_players = 20

/datum/round_event/dendor_taming/start()
	var/list/valid_targets = list()

	for(var/mob/living/carbon/human/human_mob in GLOB.player_list)
		if(!istype(human_mob) || human_mob.stat == DEAD || !human_mob.client)
			continue
		if(!human_mob.patron || !istype(human_mob.patron, /datum/patron/divine/dendor))
			continue
		valid_targets += human_mob

	if(!valid_targets.len)
		return

	var/mob/living/carbon/human/chosen_one = pick(valid_targets)

	var/datum/objective/tame_animal/new_objective = new(owner = chosen_one.mind)
	chosen_one.mind.add_personal_objective(new_objective)

	to_chat(chosen_one, span_biginfo("Dendor commands you to bond with nature! Tame an animal to earn Dendor's favor!"))
	SEND_SOUND(chosen_one, 'sound/magic/marked.ogg')

	chosen_one.mind.announce_personal_objectives()
