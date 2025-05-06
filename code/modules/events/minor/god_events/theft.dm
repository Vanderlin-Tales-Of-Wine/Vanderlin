/datum/round_event_control/matthios_theft
	name = "Matthios' Thieving Task"
	track = EVENT_TRACK_MUNDANE
	typepath = /datum/round_event/matthios_theft
	weight = 5
	earliest_start = 10 MINUTES
	max_occurrences = 1
	min_players = 15

/datum/round_event/matthios_theft/start()
	var/list/valid_targets = list()

	for(var/mob/living/carbon/human/human_mob in GLOB.player_list)
		if(!istype(human_mob) || human_mob.stat == DEAD || !human_mob.client)
			continue
		if(!human_mob.patron || !istype(human_mob.patron, /datum/patron/inhumen/matthios))
			continue
		valid_targets += human_mob

	if(!valid_targets.len)
		return

	var/mob/living/carbon/human/chosen_one = pick(valid_targets)

	var/datum/objective/steal_items/new_objective = new(owner = chosen_one.mind)
	chosen_one.mind.add_personal_objective(new_objective)

	to_chat(chosen_one, span_biginfo("Matthios demands you prove your cunning! Steal valuables to earn Matthios' favor!"))
	SEND_SOUND(chosen_one, 'sound/magic/marked.ogg')

	chosen_one.mind.announce_personal_objectives()
