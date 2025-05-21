/datum/round_event_control/malum_craft_skills
	name = "Hone Craft"
	track = EVENT_TRACK_PERSONAL
	typepath = /datum/round_event/malum_craft_skills
	weight = 10
	earliest_start = 5 MINUTES
	max_occurrences = 1
	min_players = 15

	tags = list(
		TAG_WORK,
	)

/datum/round_event_control/malum_craft_skills/canSpawnEvent(players_amt, gamemode, fake_check)
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

/datum/round_event/malum_craft_skills/start()
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

	var/datum/objective/improve_craft/new_objective = new(owner = chosen_one.mind)
	chosen_one.mind.add_personal_objective(new_objective)

	to_chat(chosen_one, span_userdanger("YOU ARE GOD'S CHOSEN!"))
	to_chat(chosen_one, span_notice("Malum wants you to hone your craft! Improve your crafting skills to earn Malum's favor!"))
	chosen_one.playsound_local(chosen_one, 'sound/magic/dwarf_chant01.ogg', 100)

	chosen_one.mind.announce_personal_objectives()
