
/datum/round_event_control/zizo_shrines
	name = "Zizo's Profane Construction"
	track = EVENT_TRACK_PERSONAL
	typepath = /datum/round_event/zizo_shrines
	weight = 10
	earliest_start = 20 MINUTES
	max_occurrences = 1
	min_players = 25

	tags = list(
		TAG_CORRUPTION,
		TAG_WORK,
	)

/datum/round_event_control/zizo_shrines/canSpawnEvent(players_amt, gamemode, fake_check)
	. = ..()
	if(!.)
		return FALSE

	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(!istype(H) || H.stat == DEAD || !H.client)
			continue
		if(!H.patron || !istype(H.patron, /datum/patron/inhumen/zizo))
			continue
		return TRUE

	return FALSE

/datum/round_event/zizo_shrines/start()
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

	var/datum/objective/build_zizo_shrine/new_objective = new(owner = chosen_one.mind)
	chosen_one.mind.add_personal_objective(new_objective)

	to_chat(chosen_one, span_userdanger("ZIZO DEMANDS CORRUPTION BE SPREAD!"))
	to_chat(chosen_one, span_notice("Construct [new_objective.target_count] profane shrines using your new knowledge to complete Zizo's will!"))
	SEND_SOUND(chosen_one, 'sound/ambience/noises/genspooky (1).ogg')

	chosen_one.mind.announce_personal_objectives()
