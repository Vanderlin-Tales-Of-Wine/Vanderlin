/datum/round_event_control/zizo_torture
	name = "Zizo's Cruel Demand"
	track = EVENT_TRACK_MODERATE
	typepath = /datum/round_event/zizo_torture
	weight = 5
	earliest_start = 20 MINUTES
	max_occurrences = 1
	min_players = 20

/datum/round_event/zizo_torture/start()
	var/list/valid_targets = list()

	for(var/mob/living/carbon/human/human_mob in GLOB.player_list)
		if(!istype(human_mob) || human_mob.stat == DEAD || !human_mob.client)
			continue
		if(!human_mob.patron || !istype(human_mob.patron, /datum/patron/inhumen/zizo))
			continue
		valid_targets += human_mob

	if(!valid_targets.len)
		return

	var/mob/living/carbon/human/chosen_one = pick(valid_targets)

	var/datum/objective/torture/new_objective = new(owner = chosen_one.mind)
	chosen_one.mind.add_personal_objective(new_objective)

	to_chat(chosen_one, span_biginfo("Zizo demands suffering! Torture someone to earn Zizo's favor!"))
	SEND_SOUND(chosen_one, 'sound/magic/marked.ogg')

	chosen_one.mind.announce_personal_objectives()
