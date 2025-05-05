/datum/round_event_control/xylix_mocking
	name = "Xylix's Mockery (Monarch)"
	track = EVENT_TRACK_MODERATE
	typepath = /datum/round_event/xylix_mocking
	weight = 5
	earliest_start = 20 MINUTES
	max_occurrences = 1
	min_players = 20

/datum/round_event_control/xylix_mocking/canSpawnEvent(players_amt, gamemode, fake_check)
	. = ..()
	if(!.)
		return FALSE
	if(GLOB.patron_follower_counts["Xylix"] < 1)
		return FALSE

/datum/round_event/xylix_mocking/start()
	var/list/valid_targets = list()

	for(var/mob/living/carbon/human/human_mob in GLOB.player_list)
		if(!istype(human_mob) || human_mob.stat == DEAD || !human_mob.client)
			continue
		if(!human_mob.patron || !istype(human_mob.patron, /datum/patron/divine/xylix))
			continue
		valid_targets += human_mob

	if(!valid_targets.len)
		return

	var/mob/living/carbon/human/chosen_one = pick(valid_targets)

	var/datum/objective/mock/monarch/new_objective = new(owner = chosen_one.mind)
	chosen_one.mind.add_personal_objective(new_objective)

	to_chat(chosen_one, span_biginfo("Xylix demands great entertainment! Seek out and viciously mock the monarch to prove your devotion and earn Xylix's favor!"))
	SEND_SOUND(chosen_one, 'sound/vo/male/evil/laugh (1).ogg')

	if(!is_type_in_list(/obj/effect/proc_holder/spell/invoked/mockery, chosen_one.mind.spell_list))
		var/obj/effect/proc_holder/spell/invoked/mockery/mock_spell = new()
		chosen_one.mind.AddSpell(mock_spell)
		to_chat(chosen_one, span_notice("Xylix has granted you the gift of savage mockery! Use it to ridicule your target."))

	chosen_one.mind.announce_personal_objectives()
