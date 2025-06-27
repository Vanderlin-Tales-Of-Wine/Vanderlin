/datum/round_event_control/forbidden_slap
	name = "Forbidden Slap"
	track = EVENT_TRACK_PERSONAL
	typepath = /datum/round_event/forbidden_slap
	weight = 10
	earliest_start = 10 MINUTES
	max_occurrences = 1
	min_players = 25

	tags = list(
		TAG_INSANITY,
	)

/datum/round_event_control/forbidden_slap/canSpawnEvent(players_amt, gamemode, fake_check)
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

/datum/round_event/forbidden_slap/start()
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

	var/datum/objective/ass_slap/new_objective = new(owner = chosen_one.mind)
	chosen_one.mind.add_personal_objective(new_objective)

	to_chat(chosen_one, span_userdanger("YOU ARE BAOTHA'S CHOSEN!"))
	to_chat(chosen_one, span_notice("Let no depravity be your limit! Slap asses to satisfy Baotha's desire!"))
	chosen_one.playsound_local(chosen_one, 'sound/misc/gods/baotha_omen.ogg', 100)

	chosen_one.mind.announce_personal_objectives()
