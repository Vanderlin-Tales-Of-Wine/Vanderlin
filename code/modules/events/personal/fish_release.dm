/datum/round_event_control/abyssor_fish_release
	name = "Fish Release Request"
	track = EVENT_TRACK_PERSONAL
	typepath = /datum/round_event/abyssor_fishing
	weight = 10
	earliest_start = 10 MINUTES
	max_occurrences = 1
	min_players = 15

	tags = list(
		TAG_WATER,
		TAG_NATURE,
	)

/datum/round_event_control/abyssor_fishing/canSpawnEvent(players_amt, gamemode, fake_check)
	. = ..()
	if(!.)
		return FALSE

	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(!istype(H) || H.stat == DEAD || !H.client)
			continue
		if(!H.patron || !istype(H.patron, /datum/patron/divine/abyssor))
			continue
		if(H.get_skill_level(/datum/skill/labor/fishing) < 2)
			continue
		return TRUE

	return FALSE

/datum/round_event/abyssor_fishing/start()
	var/list/valid_targets = list()

	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(!istype(H) || H.stat == DEAD || !H.client)
			continue
		if(!H.patron || !istype(H.patron, /datum/patron/divine/abyssor))
			continue
		if(H.get_skill_level(/datum/skill/labor/fishing) < 2)
			continue
		valid_targets += H

	if(!valid_targets.len)
		return

	var/mob/living/carbon/human/chosen_one = pick(valid_targets)

	var/datum/objective/release_fish/new_objective = new(owner = chosen_one.mind)
	chosen_one.mind.add_personal_objective(new_objective)

	to_chat(chosen_one, span_userdanger("YOU ARE GOD'S CHOSEN!"))
	to_chat(chosen_one, span_notice("Abyssor demands respite for the creatures of the deep! Any rare fish returned to the water will please him!"))
	chosen_one.playsound_local(chosen_one, 'sound/items/bucket_transfer (2).ogg', 100)

	chosen_one.mind.announce_personal_objectives()
