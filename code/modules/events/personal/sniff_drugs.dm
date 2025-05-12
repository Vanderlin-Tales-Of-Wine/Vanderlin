/datum/round_event_control/baotha_sniffing
	name = "Drug Desire"
	track = EVENT_TRACK_PERSONAL
	typepath = /datum/round_event/baotha_sniffing
	weight = 10
	earliest_start = 5 MINUTES
	max_occurrences = 1
	min_players = 15

	tags = list(
		TAG_INSANITY,
		TAG_ALCHEMY,
	)

/datum/round_event_control/baotha_sniffing/canSpawnEvent(players_amt, gamemode, fake_check)
	. = ..()
	if(!.)
		return FALSE

	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(!istype(H) || H.stat == DEAD || !H.client)
			continue
		if(!H.patron || !istype(H.patron, /datum/patron/inhumen/baotha))
			continue
		return TRUE

	return FALSE

/datum/round_event/baotha_sniffing/start()
	var/list/valid_targets = list()

	for(var/mob/living/carbon/human/human_mob in GLOB.player_list)
		if(!istype(human_mob) || human_mob.stat == DEAD || !human_mob.client)
			continue
		if(!human_mob.patron || !istype(human_mob.patron, /datum/patron/inhumen/baotha))
			continue
		valid_targets += human_mob

	if(!valid_targets.len)
		return

	var/mob/living/carbon/human/chosen_one = pick(valid_targets)

	var/datum/objective/sniff_drugs/new_objective = new(owner = chosen_one.mind)
	chosen_one.mind.add_personal_objective(new_objective)

	to_chat(chosen_one, span_userdanger("YOU ARE GOD'S CHOSEN!"))
	to_chat(chosen_one, span_notice("Baotha demands chemical ecstasy! Sniff drugs to earn Baotha's favor!"))
	SEND_SOUND(chosen_one, 'sound/ambience/noises/genspooky (1).ogg')

	chosen_one.mind.announce_personal_objectives()
