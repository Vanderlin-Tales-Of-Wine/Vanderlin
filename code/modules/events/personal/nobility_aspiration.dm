/datum/round_event_control/astrata_nobility
	name = "Nobility Aspiration"
	track = EVENT_TRACK_PERSONAL
	typepath = /datum/round_event/astrata_nobility
	weight = 7
	earliest_start = 5 MINUTES
	max_occurrences = 1
	min_players = 20

	tags = list(
		TAG_BOON,
	)

/datum/round_event_control/astrata_nobility/canSpawnEvent(players_amt, gamemode, fake_check)
	. = ..()
	if(!.)
		return FALSE

	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(!istype(H) || H.stat == DEAD || !H.client)
			continue
		if(!H.patron || !istype(H.patron, /datum/patron/divine/astrata))
			continue
		if(H.is_noble() || (H.mind?.assigned_role.title in GLOB.church_positions))
			continue
		return TRUE

	return FALSE

/datum/round_event/astrata_nobility/start()
	var/list/valid_targets = list()

	for(var/mob/living/carbon/human/human_mob in GLOB.player_list)
		if(!istype(human_mob) || human_mob.stat == DEAD || !human_mob.client)
			continue
		if(!human_mob.patron || !istype(human_mob.patron, /datum/patron/divine/astrata))
			continue
		if(human_mob.is_noble())
			continue
		valid_targets += human_mob

	if(!valid_targets.len)
		return

	var/mob/living/carbon/human/chosen_one = pick(valid_targets)

	var/datum/objective/nobility/new_objective = new(owner = chosen_one.mind)
	chosen_one.mind.add_personal_objective(new_objective)

	to_chat(chosen_one, span_userdanger("YOU ARE GOD'S CHOSEN!"))
	to_chat(chosen_one, span_notice("Astrata wishes you to ascend in status! Become a part of the nobility to earn Astrata's favor!"))
	SEND_SOUND(chosen_one, 'sound/magic/bless.ogg')

	chosen_one.mind.announce_personal_objectives()
