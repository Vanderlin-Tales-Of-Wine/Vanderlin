/datum/round_event_control/xylix_mocking_nobles
	name = "Xylix's Mockery (Nobles)"
	track = EVENT_TRACK_MUNDANE
	typepath = /datum/round_event/xylix_mocking_nobles
	weight = 5
	earliest_start = 10 MINUTES
	max_occurrences = 1
	min_players = 20

/datum/round_event_control/xylix_mocking_nobles/canSpawnEvent(players_amt, gamemode, fake_check)
	. = ..()
	if(!.)
		return FALSE

	var/mockers = 0
	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(!istype(H) || H.stat == DEAD || !H.client || !istype(H.patron, /datum/patron/divine/xylix))
			continue
		if(is_type_in_list(/obj/effect/proc_holder/spell/invoked/mockery, H.mind.spell_list))
			mockers++
			if(mockers >= 1)
				return TRUE
	return FALSE

/datum/round_event/xylix_mocking_nobles/start()
	var/list/valid_targets = list()

	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(!istype(H) || H.stat == DEAD || !H.client || !istype(H.patron, /datum/patron/divine/xylix))
			continue
		if(is_type_in_list(/obj/effect/proc_holder/spell/invoked/mockery, H.mind.spell_list))
			valid_targets += H

	if(!valid_targets.len)
		return

	var/mob/living/carbon/human/chosen_one = pick(valid_targets)

	var/datum/objective/mock/noble/new_objective = new(owner = chosen_one)
	chosen_one.mind.add_personal_objective(new_objective)

	to_chat(chosen_one, span_biginfo("Xylix demands entertainment! Mock [new_objective.required_count] nobles to prove your wit and earn Xylix's favor!"))
	SEND_SOUND(chosen_one, 'sound/vo/male/evil/laugh (1).ogg')

	chosen_one.mind.announce_personal_objectives()
