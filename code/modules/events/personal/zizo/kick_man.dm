/datum/round_event_control/zizos_demand
	name = "Zizo's Demand"
	track = EVENT_TRACK_PERSONAL
	typepath = /datum/round_event/zizos_demand
	weight = 10
	earliest_start = 5 MINUTES
	max_occurrences = 1
	min_players = 20

	tags = list(
		TAG_BATTLE,
	)

/datum/round_event_control/zizos_demand/canSpawnEvent(players_amt, gamemode, fake_check)
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

/datum/round_event/zizos_demand/start()
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

	var/datum/objective/kick_groin/new_objective = new(owner = chosen_one.mind)
	chosen_one.mind.add_personal_objective(new_objective)

	to_chat(chosen_one, span_userdanger("ZIZO DEMANDS PAIN!"))
	to_chat(chosen_one, span_notice("Kick a male in the groin to satisfy Zizo's cruel desires!"))
	chosen_one.playsound_local(chosen_one, 'sound/misc/gods/zizo_omen.ogg', 100)

	chosen_one.mind.announce_personal_objectives()
