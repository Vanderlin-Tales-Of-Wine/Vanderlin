/datum/round_event_control/dead_whispers
	name = "Whispers of the Dead"
	track = EVENT_TRACK_PERSONAL
	typepath = /datum/round_event/dead_whispers
	weight = 7
	earliest_start = 15 MINUTES
	max_occurrences = 1
	min_players = 20

	tags = list(
		TAG_HAUNTED,
	)

/datum/round_event_control/dead_whispers/canSpawnEvent(players_amt, gamemode, fake_check)
	. = ..()
	if(!.)
		return FALSE

	if(length(GLOB.last_messages) < 10)
		return FALSE

	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(!istype(H) || H.stat == DEAD || !H.client)
			continue
		if(!H.patron || !istype(H.patron, /datum/patron/divine/necra))
			continue
		return TRUE

	return FALSE

/datum/round_event/dead_whispers/start()
	if(length(GLOB.last_messages) < 10)
		return FALSE

	var/list/valid_targets = list()
	for(var/mob/living/carbon/human/human_mob in GLOB.player_list)
		if(!istype(human_mob) || human_mob.stat == DEAD || !human_mob.client)
			continue
		if(!human_mob.patron || !istype(human_mob.patron, /datum/patron/divine/necra))
			continue
		valid_targets += human_mob

	if(!length(valid_targets))
		return

	var/mob/living/carbon/human/chosen_one = pick(valid_targets)

	var/datum/objective/listen_whispers/new_objective = new(owner = chosen_one.mind)
	chosen_one.mind.add_personal_objective(new_objective)

	to_chat(chosen_one, span_userdanger("YOU ARE NECRA'S CHOSEN!"))
	to_chat(chosen_one, span_notice("You must understand death better to be able to prepare for it. For that purpose, go to the church and listen to the whispers of the dead while wearing amulet of Necra."))
	chosen_one.playsound_local(chosen_one, 'sound/ambience/noises/genspooky (1).ogg', 100)

	chosen_one.mind.announce_personal_objectives()
