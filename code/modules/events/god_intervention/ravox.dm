/datum/round_event_control/ravox_resolve
	name = "Ravox's Resolve"
	track = EVENT_TRACK_INTERVENTION
	typepath = /datum/round_event/ravox_resolve
	weight = 8
	earliest_start = 25 MINUTES
	max_occurrences = 1
	min_players = 30
	allowed_storytellers = list(/datum/storyteller/ravox)

/datum/round_event_control/ravox_resolve/canSpawnEvent(players_amt, gamemode, fake_check)
	. = ..()
	if(!.)
		return FALSE
	if(GLOB.patron_follower_counts["Ravox"] < 3)
		return FALSE

/datum/round_event/ravox_resolve/start()
	var/mob/living/carbon/human/weakest
	var/weakest_stat
	for(var/mob/living/carbon/human/human_mob in GLOB.player_list)
		if(!istype(human_mob) || human_mob.stat == DEAD || !human_mob.client)
			continue

		if(!human_mob.patron || !istype(human_mob.patron, /datum/patron/divine/ravox))
			continue

		if(!weakest)
			weakest_stat = human_mob.get_stat_level(STATKEY_STR)
			weakest = human_mob

		var/mob_stat_level = human_mob.get_stat_level(STATKEY_STR)
		if(mob_stat_level < weakest_stat)
			weakest = human_mob
		else if(mob_stat_level == weakest_stat && prob(50))
			weakest = human_mob

	if(!weakest)
		return

	weakest.set_stat_modifier("ravox_resolve", STATKEY_STR, 1)
	weakest.set_stat_modifier("ravox_resolve", STATKEY_END, 1)
	weakest.set_stat_modifier("ravox_resolve", STATKEY_CON, 1)
	to_chat(weakest, span_green("You may be weak compared to your fellow warriors of justice, but still you persevere. Ravox honors those who fight even when victory seems impossible. Let his gift of strength be your whetstone — now strike!"))
	SEND_SOUND(weakest, 'sound/vo/male/knight/rage (6).ogg')
