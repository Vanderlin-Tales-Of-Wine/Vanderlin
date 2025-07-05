/datum/round_event_control/xylix_mocking
	name = "Mockery (Monarch)"
	track = EVENT_TRACK_PERSONAL
	typepath = /datum/round_event/xylix_mocking
	weight = 7
	earliest_start = 15 MINUTES
	max_occurrences = 1
	min_players = 25

	tags = list(
		TAG_TRICKERY,
		TAG_UNEXPECTED,
	)

/datum/round_event_control/xylix_mocking/canSpawnEvent(players_amt, gamemode, fake_check)
	. = ..()
	if(!.)
		return FALSE

	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(!istype(H) || H.stat == DEAD || !H.client || is_lord_job(H.mind?.assigned_role))
			continue
		if(!H.patron || !istype(H.patron, /datum/patron/divine/xylix))
			continue
		if(locate(/obj/effect/proc_holder/spell/invoked/mockery) in H.mind.spell_list)
			continue
		return TRUE

	return FALSE

/datum/round_event/xylix_mocking/start()
	var/list/valid_targets = list()

	for(var/mob/living/carbon/human/human_mob in GLOB.player_list)
		if(!istype(human_mob) || human_mob.stat == DEAD || !human_mob.client || is_lord_job(human_mob.mind?.assigned_role))
			continue
		if(!human_mob.patron || !istype(human_mob.patron, /datum/patron/divine/xylix))
			continue
		if(locate(/obj/effect/proc_holder/spell/invoked/mockery) in human_mob.mind.spell_list)
			continue
		valid_targets += human_mob

	if(!length(valid_targets))
		return

	var/mob/living/carbon/human/chosen_one = pick(valid_targets)

	var/datum/objective/mock/monarch/new_objective = new(owner = chosen_one.mind)
	chosen_one.mind.add_personal_objective(new_objective)

	to_chat(chosen_one, span_userdanger("YOU ARE XYLIX'S CHOSEN!"))
	to_chat(chosen_one, span_biginfo("Xylix demands great entertainment! Seek out and viciously mock the monarch to prove your devotion and earn Xylix's favor!"))
	chosen_one.playsound_local(chosen_one, 'sound/misc/gods/xylix_omen_male_female.ogg', 100)

	var/obj/effect/proc_holder/spell/invoked/mockery/mock_spell = new()
	chosen_one.mind.AddSpell(mock_spell)
	to_chat(chosen_one, span_notice("Xylix has granted you the gift of savage mockery! Use it to ridicule your target."))

	chosen_one.mind.announce_personal_objectives()
