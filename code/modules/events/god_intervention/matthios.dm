/datum/round_event_control/matthios_fingers
	name = "Matthios' Fingers"
	track = EVENT_TRACK_INTERVENTION
	typepath = /datum/round_event/matthios_fingers
	weight = 8
	earliest_start = 0 SECONDS
	max_occurrences = 2
	min_players = 20
	allowed_storytellers = list(/datum/storyteller/matthios)

/datum/round_event/matthios_fingers/start()
	SSmapping.add_world_trait(/datum/world_trait/matthios_fingers, 20 MINUTES)
