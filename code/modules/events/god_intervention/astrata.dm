/datum/round_event_control/astrata_grandeur
	name = "Astrata's Grandeur"
	track = EVENT_TRACK_INTERVENTION
	typepath = /datum/round_event/astrata_grandeur
	weight = 8
	earliest_start = 15 MINUTES
	max_occurrences = 1
	min_players = 20
	todreq = list("dusk", "dawn", "day")
	allowed_storytellers = list(/datum/storyteller/astrata)

/datum/round_event_control/astrata_grandeur/canSpawnEvent(players_amt, gamemode, fake_check)
	. = ..()
	if(!.)
		return FALSE
	if(GLOB.patron_follower_counts["Astrata"] < 4)
		return FALSE

/datum/round_event/astrata_grandeur/start()
	for(var/mob/living/carbon/human/human_mob in GLOB.player_list)
		if(!istype(human_mob) || human_mob.stat == DEAD || !human_mob.client)
			continue

		if(!human_mob.patron || !istype(human_mob.patron, /datum/patron/divine/astrata))
			continue

		// Only for astratan clergy and nobles
		if(!(human_mob.mind?.assigned_role.title in GLOB.church_positions) && !human_mob.is_noble())
			continue

		human_mob.add_stress(/datum/stressevent/astrata_grandeur)

		to_chat(human_mob, span_notice("Astrata shines brightly todae - and just as she leads the Ten, so must you guide others with a firm hand. The Sun Queen demands no less from those who bask in her glory."))
		SEND_SOUND(human_mob, 'sound/magic/bless.ogg')
