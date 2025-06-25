/datum/round_event_control/malums_demand
	name = "Malum's Demand"
	track = EVENT_TRACK_PERSONAL
	typepath = /datum/round_event/malums_demand
	weight = 10
	earliest_start = 5 MINUTES
	max_occurrences = 1
	min_players = 20

	tags = list(
		TAG_WORK,
	)

/datum/round_event_control/malums_demand/canSpawnEvent(players_amt, gamemode, fake_check)
	. = ..()
	if(!.)
		return FALSE

	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(!istype(H) || H.stat == DEAD || !H.client)
			continue
		if(!H.patron || !istype(H.patron, /datum/patron/divine/malum))
			continue
		return TRUE

	return FALSE

/datum/round_event/malums_demand/start()
	var/list/valid_targets = list()

	for(var/mob/living/carbon/human/human_mob in GLOB.player_list)
		if(!istype(human_mob) || human_mob.stat == DEAD || !human_mob.client)
			continue
		if(!human_mob.patron || !istype(human_mob.patron, /datum/patron/divine/malum))
			continue
		valid_targets += human_mob

	if(!valid_targets.len)
		return

	var/mob/living/carbon/human/chosen_one = pick(valid_targets)

	var/datum/objective/energy_expenditure/new_objective = new(owner = chosen_one.mind)
	chosen_one.mind.add_personal_objective(new_objective)

	to_chat(chosen_one, span_userdanger("MALUM DEMANDS YOUR LABOR!"))
	to_chat(chosen_one, span_notice("Spend at least 100 energy points working to satisfy Malum!"))
	chosen_one.playsound_local(chosen_one, 'sound/magic/dwarf_chant01.ogg', 100)

	chosen_one.mind.announce_personal_objectives()
