/datum/round_event_control/pestra_mercy
	name = "Pestra's Mercy"
	track = EVENT_TRACK_INTERVENTION
	typepath = /datum/round_event/pestra_mercy
	weight = 8
	earliest_start = 0 SECONDS
	max_occurrences = 2
	min_players = 10
	allowed_storytellers = list(/datum/storyteller/pestra)

/datum/round_event/pestra_mercy/start()
	SSmapping.add_world_trait(/datum/world_trait/pestra_mercy, 20 MINUTES)
