/datum/round_event_control/eora_marriage
	name = "Marriage Broker"
	track = EVENT_TRACK_PERSONAL
	typepath = /datum/round_event/eora_marriage
	weight = 5
	earliest_start = 10 MINUTES
	max_occurrences = 1
	min_players = 30

	tags = list(
		TAG_BOON,
		TAG_WIDESPREAD,
	)

/datum/round_event_control/eora_marriage/canSpawnEvent(players_amt, gamemode, fake_check)
	. = ..()
	if(!.)
		return FALSE

	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(!istype(H) || H.stat == DEAD || !H.client)
			continue
		if(!H.patron || !istype(H.patron, /datum/patron/divine/eora))
			continue
		return TRUE

	return FALSE

/datum/round_event/eora_marriage/start()
	var/list/valid_targets = list()

	for(var/mob/living/carbon/human/human_mob in GLOB.player_list)
		if(!istype(human_mob) || human_mob.stat == DEAD || !human_mob.client)
			continue
		if(!human_mob.patron || !istype(human_mob.patron, /datum/patron/divine/eora))
			continue
		valid_targets += human_mob

	if(!valid_targets.len)
		return

	var/mob/living/carbon/human/chosen_one = pick(valid_targets)

	var/datum/objective/marriage_broker/new_objective = new(owner = chosen_one.mind)
	chosen_one.mind.add_personal_objective(new_objective)

	to_chat(chosen_one, span_userdanger("YOU ARE GOD'S CHOSEN!"))
	to_chat(chosen_one, span_notice("Eora wishes to see love blossom! Arrange a marriage between any two people to earn Eora's favor!"))
	SEND_SOUND(chosen_one, 'sound/vo/female/gen/giggle (1).ogg')

	chosen_one.mind.announce_personal_objectives()
