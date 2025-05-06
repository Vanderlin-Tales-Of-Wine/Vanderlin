/datum/round_event_control/abyssor_fish_release
	name = "Abyssor's Fish Release"
	track = EVENT_TRACK_MUNDANE
	typepath = /datum/round_event/abyssor_fish_release
	weight = 5
	earliest_start = 10 MINUTES
	max_occurrences = 1
	min_players = 15

/datum/round_event/abyssor_fish_release/start()
	var/mob/living/carbon/human/best_fisher

	for(var/mob/living/carbon/human/human_mob in GLOB.player_list)
		if(!istype(human_mob) || human_mob.stat == DEAD || !human_mob.client)
			continue
		if(!human_mob.patron || !istype(human_mob.patron, /datum/patron/divine/abyssor))
			continue
		if(!best_fisher)
			best_fisher = human_mob

	if(!best_fisher)
		return

	var/datum/objective/fish_release/new_objective = new(owner = best_fisher.mind)
	best_fisher.mind.add_personal_objective(new_objective)

	to_chat(best_fisher, span_biginfo("Abyssor demands mercy for the creatures of the deep! Release a rare or super rare fish back into the wild to earn Abyssor's favor!"))
	SEND_SOUND(best_fisher, 'sound/magic/marked.ogg')

	best_fisher.mind.announce_personal_objectives()
