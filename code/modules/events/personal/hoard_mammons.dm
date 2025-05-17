/datum/round_event_control/matthios_hoard
	name = "Golden Demand"
	track = EVENT_TRACK_PERSONAL
	typepath = /datum/round_event/matthios_hoard
	weight = 10
	earliest_start = 5 MINUTES
	max_occurrences = 1
	min_players = 20

	tags = list(
		TAG_LOOT,
	)

/datum/round_event_control/matthios_hoard/canSpawnEvent(players_amt, gamemode, fake_check)
	. = ..()
	if(!.)
		return FALSE

	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(!istype(H) || H.stat == DEAD || !H.client)
			continue
		if(!H.patron || !istype(H.patron, /datum/patron/inhumen/matthios))
			continue
		return TRUE

	return FALSE

/datum/round_event/matthios_hoard/start()
	var/list/valid_targets = list()

	for(var/mob/living/carbon/human/human_mob in GLOB.player_list)
		if(!istype(human_mob) || human_mob.stat == DEAD || !human_mob.client)
			continue
		if(!human_mob.patron || !istype(human_mob.patron, /datum/patron/inhumen/matthios))
			continue
		valid_targets += human_mob

	if(!valid_targets.len)
		return

	var/mob/living/carbon/human/chosen_one = pick(valid_targets)

	var/datum/objective/hoard_mammons/new_objective = new(owner = chosen_one.mind)
	chosen_one.mind.add_personal_objective(new_objective)

	to_chat(chosen_one, span_userdanger("YOU ARE GOD'S CHOSEN!"))
	to_chat(chosen_one, span_notice("Accumulate [new_objective.target_amount] mammons to prove your devotion to commerce and wealth!"))
	SEND_SOUND(chosen_one, 'sound/items/matidol2.ogg')

	chosen_one.mind.announce_personal_objectives()
