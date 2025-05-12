/datum/round_event_control/malum_crafting
	name = "Crafting Request"
	track = EVENT_TRACK_PERSONAL
	typepath = /datum/round_event/malum_crafting
	weight = 10
	earliest_start = 10 MINUTES
	max_occurrences = 1
	min_players = 15

	tags = list(
		TAG_WORK,
	)

/datum/round_event_control/malum_crafting/canSpawnEvent(players_amt, gamemode, fake_check)
	. = ..()
	if(!.)
		return FALSE

	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(!istype(H) || H.stat == DEAD || !H.client)
			continue
		if(!H.patron || !istype(H.patron, /datum/patron/divine/malum))
			continue
		if(H.mind?.get_skill_level(/datum/skill/craft/crafting) < 3)
			continue
		return TRUE

	return FALSE

/datum/round_event/malum_crafting/start()
	var/list/valid_targets = list()

	for(var/mob/living/carbon/human/human_mob in GLOB.player_list)
		if(!istype(human_mob) || human_mob.stat == DEAD || !human_mob.client)
			continue
		if(!human_mob.patron || !istype(human_mob.patron, /datum/patron/divine/malum))
			continue
		if(human_mob.mind?.get_skill_level(/datum/skill/craft/crafting) < 3)
			continue
		valid_targets += human_mob

	if(!valid_targets.len)
		return

	var/mob/living/carbon/human/chosen_one = pick(valid_targets)

	var/datum/objective/craft_shrine/new_objective = new(owner = chosen_one.mind)
	chosen_one.mind.add_personal_objective(new_objective)

	to_chat(chosen_one, span_userdanger("YOU ARE GOD'S CHOSEN!"))
	to_chat(chosen_one, span_notice("Malum demands a physical manifestation of devotion! Build 2 sacred pantheon crosses to earn Malum's favor!"))
	SEND_SOUND(chosen_one, 'sound/magic/dwarf_chant01.ogg')

	chosen_one.mind.announce_personal_objectives()
