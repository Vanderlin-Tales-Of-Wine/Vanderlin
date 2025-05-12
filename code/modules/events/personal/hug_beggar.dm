/datum/round_event_control/eora_compassion
	name = "Beggar Compassion"
	track = EVENT_TRACK_PERSONAL
	typepath = /datum/round_event/eora_compassion
	weight = 7
	earliest_start = 5 MINUTES
	max_occurrences = 1
	min_players = 20

	tags = list(
		TAG_BOON,
	)

/datum/round_event_control/eora_compassion/canSpawnEvent(players_amt, gamemode, fake_check)
	. = ..()
	if(!.)
		return FALSE

	var/beggar_count = 0
	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(!istype(H) || H.stat == DEAD || !H.client)
			continue
		if(H.job == "Beggar" || istype(H.mind?.assigned_role, /datum/job/vagrant))
			beggar_count++
			if(beggar_count >= 2)
				break

	if(beggar_count < 2)
		return FALSE

	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(!istype(H) || H.stat == DEAD || !H.client)
			continue
		if(H.patron && istype(H.patron, /datum/patron/divine/eora))
			return TRUE

	return FALSE

/datum/round_event/eora_compassion/start()
	var/list/valid_targets = list()

	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(!istype(H) || H.stat == DEAD || !H.client)
			continue
		if(H.patron && istype(H.patron, /datum/patron/divine/eora))
			valid_targets += H

	if(!length(valid_targets))
		return

	var/mob/living/carbon/human/chosen_one = pick(valid_targets)
	var/datum/objective/hug_beggar/new_objective = new(owner = chosen_one.mind)
	chosen_one.mind.add_personal_objective(new_objective)

	to_chat(chosen_one, span_userdanger("YOU ARE GOD'S CHOSEN!"))
	to_chat(chosen_one, span_notice("Eora wishes to see compassion! Show kindness to the less fortunate by hugging a beggar to earn Eora's favor!"))
	SEND_SOUND(chosen_one, 'sound/vo/female/gen/giggle (1).ogg')

	chosen_one.mind.announce_personal_objectives()
