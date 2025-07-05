/datum/round_event_control/pain_relief
	name = "Pain Relief"
	track = EVENT_TRACK_PERSONAL
	typepath = /datum/round_event/pain_relief
	weight = 5
	earliest_start = 5 MINUTES
	max_occurrences = 1
	min_players = 30

	tags = list(
		TAG_MEDICAL,
	)

/datum/round_event_control/pain_relief/canSpawnEvent(players_amt, gamemode, fake_check)
	. = ..()
	if(!.)
		return FALSE

	var/recipient_found = FALSE
	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(!istype(H) || H.stat == DEAD || !H.client)
			continue
		if(!H.patron || !istype(H.patron, /datum/patron/divine/pestra))
			continue
		recipient_found = TRUE

	if(recipient_found)
		return TRUE

	return FALSE

/datum/round_event/pain_relief/start()
	var/list/valid_targets = list()

	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(!istype(H) || H.stat == DEAD || !H.client)
			continue
		if(!H.patron || !istype(H.patron, /datum/patron/divine/pestra))
			continue
		valid_targets += H

	if(!length(valid_targets))
		return

	var/mob/living/carbon/human/chosen_one = pick(valid_targets)

	var/datum/objective/take_pain/new_objective = new(owner = chosen_one.mind)
	chosen_one.mind.add_personal_objective(new_objective)

	var/obj/effect/proc_holder/spell/invoked/transfer_pain/pain_spell = new
	chosen_one.mind.AddSpell(pain_spell)

	to_chat(chosen_one, span_userdanger("YOU ARE PESTRA'S CHOSEN!"))
	to_chat(chosen_one, span_notice("Pestra calls you to ease the suffering of others! Find those in pain and take their suffering upon yourself."))
	chosen_one.playsound_local(chosen_one, 'sound/magic/cosmic_expansion.ogg', 100)

	chosen_one.mind.announce_personal_objectives()
