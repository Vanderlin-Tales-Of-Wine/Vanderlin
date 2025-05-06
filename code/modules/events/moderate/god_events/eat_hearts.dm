/datum/round_event_control/graggar_organs
	name = "Graggar's Feast"
	track = EVENT_TRACK_MODERATE
	typepath = /datum/round_event/graggar_organs
	weight = 5
	earliest_start = 20 MINUTES
	max_occurrences = 1
	min_players = 20

/datum/round_event/graggar_organs/start()
	var/list/valid_targets = list()

	for(var/mob/living/carbon/human/human_mob in GLOB.player_list)
		if(!istype(human_mob) || human_mob.stat == DEAD || !human_mob.client)
			continue
		if(!human_mob.patron || !istype(human_mob.patron, /datum/patron/inhumen/graggar))
			continue
		valid_targets += human_mob

	if(!valid_targets.len)
		return

	var/mob/living/carbon/human/chosen_one = pick(valid_targets)

	var/datum/objective/consume_organs/new_objective = new(owner = chosen_one.mind)
	chosen_one.mind.add_personal_objective(new_objective)

	if(!locate(/obj/effect/proc_holder/spell/invoked/extract_heart) in chosen_one.mind.spell_list)
		var/obj/effect/proc_holder/spell/invoked/extract_heart/heart_spell = new()
		chosen_one.mind.AddSpell(heart_spell)
		to_chat(chosen_one, span_notice("Graggar grants you the terrible power to extract hearts!"))

	to_chat(chosen_one, span_biginfo("Graggar hungers! [new_objective.explanation_text]"))
	SEND_SOUND(chosen_one, 'sound/magic/marked.ogg')

	chosen_one.mind.announce_personal_objectives()
