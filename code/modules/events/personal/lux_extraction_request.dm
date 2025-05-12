/datum/round_event_control/pestra_lux
	name = "Lux Extraction Demand"
	track = EVENT_TRACK_PERSONAL
	typepath = /datum/round_event/pestra_lux
	weight = 10
	earliest_start = 10 MINUTES
	max_occurrences = 1
	min_players = 25

	tags = list(
		TAG_MEDICAL,
		TAG_BLOOD,
	)

/datum/round_event_control/pestra_lux/canSpawnEvent(players_amt, gamemode, fake_check)
	. = ..()
	if(!.)
		return FALSE

	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(!istype(H) || H.stat == DEAD || !H.client)
			continue
		if(!H.patron || !istype(H.patron, /datum/patron/divine/pestra))
			continue
		if(H.mind?.get_skill_level(/datum/skill/misc/medicine) < 3)
			continue
		return TRUE

	return FALSE

/datum/round_event/pestra_lux/start()
	var/list/valid_targets = list()

	for(var/mob/living/carbon/human/human_mob in GLOB.player_list)
		if(!istype(human_mob) || human_mob.stat == DEAD || !human_mob.client)
			continue
		if(!human_mob.patron || !istype(human_mob.patron, /datum/patron/divine/pestra))
			continue
		if(human_mob.mind?.get_skill_level(/datum/skill/misc/medicine) < 3)
			continue
		valid_targets += human_mob

	if(!valid_targets.len)
		return

	var/mob/living/carbon/human/chosen_one = pick(valid_targets)

	var/datum/objective/lux_extraction/new_objective = new(owner = chosen_one.mind)
	chosen_one.mind.add_personal_objective(new_objective)

	to_chat(chosen_one, span_userdanger("YOU ARE GOD'S CHOSEN!"))
	to_chat(chosen_one, span_notice("Pestra demands the essence of life! Extract lux from a living being to earn Pestra's favor!"))
	SEND_SOUND(chosen_one, 'sound/magic/cosmic_expansion.ogg')

	chosen_one.mind.announce_personal_objectives()
