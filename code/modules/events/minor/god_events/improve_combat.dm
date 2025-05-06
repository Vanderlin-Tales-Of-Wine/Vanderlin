/datum/round_event_control/ravox_combat
	name = "Ravox's Combat Trial"
	track = EVENT_TRACK_MUNDANE
	typepath = /datum/round_event/ravox_combat
	weight = 5
	earliest_start = 10 MINUTES
	max_occurrences = 1
	min_players = 15

/datum/round_event/ravox_combat/start()
	var/list/valid_targets = list()

	for(var/mob/living/carbon/human/human_mob in GLOB.player_list)
		if(!istype(human_mob) || human_mob.stat == DEAD || !human_mob.client)
			continue
		if(!human_mob.patron || !istype(human_mob.patron, /datum/patron/divine/ravox))
			continue
		valid_targets += human_mob

	if(!valid_targets.len)
		return

	var/mob/living/carbon/human/chosen_one = pick(valid_targets)

	var/datum/objective/improve_combat/new_objective = new(owner = chosen_one.mind)
	chosen_one.mind.add_personal_objective(new_objective)

	to_chat(chosen_one, span_biginfo("Ravox demands you prove your might! Improve your combat skills to earn Ravox's favor!"))
	SEND_SOUND(chosen_one, 'sound/magic/marked.ogg')

	chosen_one.mind.announce_personal_objectives()
