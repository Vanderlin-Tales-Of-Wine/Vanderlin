/datum/round_event_control/dendors_demand
	name = "Dendor's Demand"
	track = EVENT_TRACK_PERSONAL
	typepath = /datum/round_event/dendors_demand
	weight = 10
	earliest_start = 5 MINUTES
	max_occurrences = 1
	min_players = 20

	tags = list(
		TAG_NATURE,
	)

/datum/round_event_control/dendors_demand/canSpawnEvent(players_amt, gamemode, fake_check)
	. = ..()
	if(!.)
		return FALSE

	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(!istype(H) || H.stat == DEAD || !H.client)
			continue
		if(!H.patron || !istype(H.patron, /datum/patron/divine/dendor))
			continue
		return TRUE

	return FALSE

/datum/round_event/dendors_demand/start()
	var/list/valid_targets = list()

	for(var/mob/living/carbon/human/human_mob in GLOB.player_list)
		if(!istype(human_mob) || human_mob.stat == DEAD || !human_mob.client)
			continue
		if(!human_mob.patron || !istype(human_mob.patron, /datum/patron/divine/dendor))
			continue
		valid_targets += human_mob

	if(!valid_targets.len)
		return

	var/mob/living/carbon/human/chosen_one = pick(valid_targets)

	var/datum/objective/butcher_animals/new_objective = new(owner = chosen_one.mind)
	chosen_one.mind.add_personal_objective(new_objective)

	to_chat(chosen_one, span_userdanger("DENDOR DEMANDS YOUR HUNT!"))
	to_chat(chosen_one, span_notice("Butcher at least 2 animals to satisfy Dendor!"))
	chosen_one.playsound_local(chosen_one, 'sound/magic/barbroar.ogg', 100)

	chosen_one.mind.announce_personal_objectives()
