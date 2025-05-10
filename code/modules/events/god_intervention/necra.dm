/datum/round_event_control/necra_requiem
	name = "Necra's Requiem"
	track = EVENT_TRACK_INTERVENTION
	typepath = /datum/round_event/necra_requiem
	weight = 8
	earliest_start = 15 MINUTES
	max_occurrences = 2
	min_players = 20
	allowed_storytellers = list(/datum/storyteller/necra)

/datum/round_event/necra_requiem/start()
	SSmapping.add_world_trait(/datum/world_trait/necra_requiem, 15 MINUTES)
