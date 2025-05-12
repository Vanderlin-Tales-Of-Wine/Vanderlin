/datum/round_event_control/noc_baptism
	name = "Baptism Desire"
	track = EVENT_TRACK_PERSONAL
	typepath = /datum/round_event/noc_baptism
	weight = 7
	earliest_start = 10 MINUTES
	max_occurrences = 1
	min_players = 30

	tags = list(
		TAG_MAGIC,
		TAG_BOON,
	)

/datum/round_event_control/noc_baptism/canSpawnEvent(players_amt, gamemode, fake_check)
	. = ..()
	if(!.)
		return FALSE

	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(!istype(H) || H.stat == DEAD || !H.client)
			continue
		if(!H.patron || !istype(H.patron, /datum/patron/divine/noc))
			continue
		if(H.mana_pool && H.mana_pool.intrinsic_recharge_sources == NONE)
			return TRUE
	return FALSE

/datum/round_event/noc_baptism/start()
	var/list/valid_targets = list()

	for(var/mob/living/carbon/human/human_mob in GLOB.player_list)
		if(!istype(human_mob) || human_mob.stat == DEAD || !human_mob.client)
			continue
		if(!human_mob.patron || !istype(human_mob.patron, /datum/patron/divine/noc))
			continue
		if(human_mob.mana_pool && human_mob.mana_pool.intrinsic_recharge_sources == NONE)
			valid_targets += human_mob

	if(!valid_targets.len)
		return

	var/mob/living/carbon/human/chosen_one = pick(valid_targets)

	var/datum/objective/baptism/new_objective = new(owner = chosen_one.mind)
	chosen_one.mind.add_personal_objective(new_objective)

	to_chat(chosen_one, span_userdanger("YOU ARE GOD'S CHOSEN!"))
	to_chat(chosen_one, span_notice("Noc demands that you learn the ways of the arcane! Seek baptism in the mana fountain to earn Noc's favor!"))
	SEND_SOUND(chosen_one, 'sound/ambience/noises/mystical (4).ogg')

	chosen_one.mind.announce_personal_objectives()
