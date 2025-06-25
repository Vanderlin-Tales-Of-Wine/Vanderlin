/datum/round_event_control/ravoxs_gift
	name = "Ravox's Ultimate Sacrifice"
	track = EVENT_TRACK_PERSONAL
	typepath = /datum/round_event/ravoxs_gift
	weight = 10
	earliest_start = 5 MINUTES
	max_occurrences = 1
	min_players = 20

	tags = list(
		TAG_HAUNTED,
		TAG_MEDICAL,
	)

/datum/round_event_control/ravoxs_gift/canSpawnEvent(players_amt, gamemode, fake_check)
	. = ..()
	if(!.)
		return FALSE

	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(!istype(H) || H.stat == DEAD || !H.client)
			continue
		if(!H.patron || !istype(H.patron, /datum/patron/divine/ravox))
			continue
		if(H.age == AGE_CHILD)
			continue
	return FALSE

/datum/round_event/ravoxs_gift/start()
	var/list/valid_targets = list()

	for(var/mob/living/carbon/human/human_mob in GLOB.player_list)
		if(!istype(human_mob) || human_mob.stat == DEAD || !human_mob.client)
			continue
		if(!human_mob.patron || !istype(human_mob.patron, /datum/patron/divine/ravox))
			continue
		if(human_mob.age == AGE_CHILD)
			continue

	if(!valid_targets.len)
		return

	var/mob/living/carbon/human/chosen_one = pick(valid_targets)

	var/datum/objective/ultimate_sacrifice/new_objective = new(owner = chosen_one.mind)
	chosen_one.mind.add_personal_objective(new_objective)

	to_chat(chosen_one, span_userdanger("RAVOX GRANTS YOU THE ULTIMATE GIFT!"))
	to_chat(chosen_one, span_notice("You have been granted the Ultimate Sacrifice - the power to give your life to revive another!"))
	chosen_one.playsound_local(chosen_one, 'sound/vo/male/knight/rage (6).ogg', 70)

	chosen_one.mind.announce_personal_objectives()
