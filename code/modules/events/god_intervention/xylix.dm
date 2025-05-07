/datum/round_event_control/xylix_fortune
	name = "Xylix's Fortune"
	track = EVENT_TRACK_INTERVENTION
	typepath = /datum/round_event/xylix_fortune
	weight = 8
	earliest_start = 20 MINUTES
	max_occurrences = 1
	min_players = 30
	allowed_storytellers = list(/datum/storyteller/xylix)

/datum/round_event_control/xylix_fortune/canSpawnEvent(players_amt, gamemode, fake_check)
	. = ..()
	if(!.)
		return FALSE
	if(GLOB.patron_follower_counts["Xylix"] < 2)
		return FALSE

/datum/round_event/xylix_fortune/start()
	for(var/mob/living/carbon/human/human_mob in GLOB.player_list)
		if(!istype(human_mob) || human_mob.stat == DEAD || !human_mob.client)
			continue

		if(!human_mob.patron || !istype(human_mob.patron, /datum/patron/divine/xylix))
			continue

		var/luck_roll = rand(-1, 2)
		human_mob.set_stat_modifier("xylix_fortune", STATKEY_LCK, luck_roll)

		to_chat(human_mob, span_biginfo("You have caught Xylix's attention! Whether you'll laugh or weep about that later... well, that's part of the fun!"))
		SEND_SOUND(human_mob, 'sound/vo/male/evil/laugh (1).ogg')
