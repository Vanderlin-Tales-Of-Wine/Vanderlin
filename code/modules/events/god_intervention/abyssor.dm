/datum/round_event_control/abyssor_rage
	name = "Abyssor's Rage"
	track = EVENT_TRACK_INTERVENTION
	typepath = /datum/round_event/abyssor_rage
	weight = 8
	earliest_start = 10 MINUTES
	max_occurrences = 2
	min_players = 20
	allowed_storytellers = list(/datum/storyteller/abyssor)

/datum/round_event/abyssor_rage/start()
	SSmapping.add_world_trait(/datum/world_trait/abyssor_rage, 20 MINUTES)
