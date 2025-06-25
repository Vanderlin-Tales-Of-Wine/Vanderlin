/datum/round_event_control/baothas_desire
	name = "Baotha's Desire"
	track = EVENT_TRACK_PERSONAL
	typepath = /datum/round_event/baothas_desire
	weight = 10
	earliest_start = 5 MINUTES
	max_occurrences = 1
	min_players = 20

	tags = list(
		TAG_INSANITY,
	)

/datum/round_event_control/baothas_desire/canSpawnEvent(players_amt, gamemode, fake_check)
	. = ..()
	if(!.)
		return FALSE

	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(!istype(H) || H.stat == DEAD || !H.client)
			continue
		if(!H.patron || !istype(H.patron, /datum/patron/inhumen/baotha))
			continue
		if(H.is_noble())
			continue
		return TRUE

	return FALSE

/datum/round_event/baothas_desire/start()
	var/list/valid_targets = list()

	for(var/mob/living/carbon/human/human_mob in GLOB.player_list)
		if(!istype(human_mob) || human_mob.stat == DEAD || !human_mob.client)
			continue
		if(!human_mob.patron || !istype(human_mob.patron, /datum/patron/inhumen/baotha))
			continue
		if(human_mob.is_noble())
			continue
		valid_targets += human_mob

	if(!valid_targets.len)
		return

	var/mob/living/carbon/human/chosen_one = pick(valid_targets)

	var/datum/objective/ass_slap/new_objective = new(owner = chosen_one.mind)
	chosen_one.mind.add_personal_objective(new_objective)

	to_chat(chosen_one, span_userdanger("BAOTHA DESIRES YOUR TOUCH!"))
	to_chat(chosen_one, span_notice("Slap 3 asses to satisfy Baotha's desires!"))
	chosen_one.playsound_local(chosen_one, 'sound/misc/gods/baotha_omen.ogg', 100)

	chosen_one.mind.announce_personal_objectives()
