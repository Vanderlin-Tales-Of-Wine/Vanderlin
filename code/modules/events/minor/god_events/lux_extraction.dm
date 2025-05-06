/datum/round_event_control/pestra_lux
	name = "Pestra's Lux Extraction"
	track = EVENT_TRACK_MUNDANE
	typepath = /datum/round_event/pestra_lux
	weight = 5
	earliest_start = 10 MINUTES
	max_occurrences = 1
	min_players = 25

/datum/round_event/pestra_lux/start()
	var/list/valid_targets = list()

	for(var/mob/living/carbon/human/human_mob in GLOB.player_list)
		if(!istype(human_mob) || human_mob.stat == DEAD || !human_mob.client)
			continue
		if(!human_mob.patron || !istype(human_mob.patron, /datum/patron/divine/pestra))
			continue
		valid_targets += human_mob

	if(!valid_targets.len)
		return

	var/mob/living/carbon/human/chosen_one = pick(valid_targets)

	var/datum/objective/lux_extraction/new_objective = new(owner = chosen_one.mind)
	chosen_one.mind.add_personal_objective(new_objective)

	to_chat(chosen_one, span_biginfo("Pestra demands the essence of life! Extract lux from a living being to earn Pestra's favor!"))
	SEND_SOUND(chosen_one, 'sound/magic/marked.ogg')

	chosen_one.mind.announce_personal_objectives()
