/datum/round_event_control/xylix_gamble
	name = "Xylix's Gamble"
	track = EVENT_TRACK_PERSONAL
	typepath = /datum/round_event/xylix_gamble
	weight = 10
	earliest_start = 5 MINUTES
	max_occurrences = 1
	min_players = 20

	tags = list(
		TAG_GAMBLE,
		TAG_TRICKERY,
		TAG_UNEXPECTED,
	)

/datum/round_event_control/xylix_gamble/canSpawnEvent(players_amt, gamemode, fake_check)
	. = ..()
	if(!.)
		return FALSE

	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(!istype(H) || H.stat == DEAD || !H.client)
			continue
		if(!H.patron || !istype(H.patron, /datum/patron/divine/xylix))
			continue
		if(H.is_noble())
			continue
		return TRUE

	return FALSE

/datum/round_event/xylix_gamble/start()
	var/list/valid_targets = list()

	for(var/mob/living/carbon/human/human_mob in GLOB.player_list)
		if(!istype(human_mob) || human_mob.stat == DEAD || !human_mob.client)
			continue
		if(!human_mob.patron || !istype(human_mob.patron, /datum/patron/divine/xylix))
			continue
		if(human_mob.is_noble())
			continue
		valid_targets += human_mob

	if(!valid_targets.len)
		return

	var/mob/living/carbon/human/chosen_one = pick(valid_targets)

	var/datum/objective/coin_flip/new_objective = new(owner = chosen_one.mind)
	chosen_one.mind.add_personal_objective(new_objective)

	to_chat(chosen_one, span_userdanger("XYLIX CHALLENGES YOU TO A GAMBLE!"))
	to_chat(chosen_one, span_notice("Flip a gold coin (zenar) and let fate decide your worth! Win the flip to prove your luck to Xylix!"))
	chosen_one.playsound_local(chosen_one, 'sound/misc/gods/xylix_omen_male_female.ogg', 100)

	chosen_one.mind.announce_personal_objectives()
