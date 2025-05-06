/datum/round_event_control/noc_baptism
	name = "Noc's Baptism"
	track = EVENT_TRACK_MUNDANE
	typepath = /datum/round_event/noc_baptism
	weight = 5
	earliest_start = 20 MINUTES
	max_occurrences = 1
	min_players = 20

/datum/round_event_control/noc_baptism/canSpawnEvent(players_amt, gamemode, fake_check)
	. = ..()
	if(!.)
		return FALSE
	if(GLOB.patron_follower_counts["Noc"] < 1)
		return FALSE

/datum/round_event/noc_baptism/start()
	var/list/valid_targets = list()

	for(var/mob/living/carbon/human/human_mob in GLOB.player_list)
		if(!istype(human_mob) || human_mob.stat == DEAD || !human_mob.client)
			continue
		if(!human_mob.patron || !istype(human_mob.patron, /datum/patron/divine/noc))
			continue
		valid_targets += human_mob

	if(!valid_targets.len)
		return

	var/mob/living/carbon/human/chosen_one = pick(valid_targets)

	var/datum/objective/baptism/new_objective = new(owner = chosen_one.mind)
	chosen_one.mind.add_personal_objective(new_objective)

	to_chat(chosen_one, span_biginfo("Noc demands new followers! Baptize someone into the faith to earn Noc's favor!"))
	SEND_SOUND(chosen_one, 'sound/magic/marked.ogg')

	chosen_one.mind.announce_personal_objectives()
