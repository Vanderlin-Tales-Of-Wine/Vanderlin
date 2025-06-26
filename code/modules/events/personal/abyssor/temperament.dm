/datum/round_event_control/abyssors_temperament
	name = "Abyssor's Temperament"
	track = EVENT_TRACK_PERSONAL
	typepath = /datum/round_event/abyssors_temperament
	weight = 10
	earliest_start = 5 MINUTES
	max_occurrences = 1
	min_players = 30

	tags = list(
		TAG_WATER,
		TAG_UNEXPECTED,
	)

/datum/round_event_control/abyssors_temperament/canSpawnEvent(players_amt, gamemode, fake_check)
	. = ..()
	if(!.)
		return FALSE

	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(!istype(H) || H.stat == DEAD || !H.client)
			continue
		if(!H.patron || !istype(H.patron, /datum/patron/divine/abyssor))
			continue
		return TRUE

	return FALSE

/datum/round_event/abyssors_temperament/start()
	var/list/valid_targets = list()

	for(var/mob/living/carbon/human/human_mob in GLOB.player_list)
		if(!istype(human_mob) || human_mob.stat == DEAD || !human_mob.client)
			continue
		if(!human_mob.patron || !istype(human_mob.patron, /datum/patron/divine/abyssor))
			continue
		valid_targets += human_mob

	if(!valid_targets.len)
		return

	var/mob/living/carbon/human/chosen_one = pick(valid_targets)
	var/datum/objective/abyssor_objective

	var/calm
	if(prob(50))
		abyssor_objective = new /datum/objective/abyssor_bath(owner = chosen_one.mind)
		calm = TRUE
	else
		abyssor_objective = new /datum/objective/abyssor_splash(owner = chosen_one.mind)
		calm = FALSE

	chosen_one.mind.add_personal_objective(abyssor_objective)

	to_chat(chosen_one, span_userdanger("YOU ARE ABYSSOR'S CHOSEN!"))
	if(calm)
		to_chat(chosen_one, span_notice("Sea takes and sea gives. Abyssor is calm at the moment, take a relaxing bath to share his mood!"))
	else
		to_chat(chosen_one, span_notice("Abyssor is RAGING like a storm! Splash an ingrate who forgot his name with a bucket full of water!"))
	chosen_one.playsound_local(chosen_one, 'sound/items/bucket_transfer (2).ogg', 100)

	chosen_one.mind.announce_personal_objectives()
