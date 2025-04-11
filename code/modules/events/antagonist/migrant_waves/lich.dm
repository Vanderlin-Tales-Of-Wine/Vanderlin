/datum/round_event_control/antagonist/migrant_wave/lich
	name = "Wanderling Lich"
	wave_type = /datum/migrant_wave/lich

	weight = 6 //temp disabled 6
	max_occurrences = 2

	earliest_start = 15 MINUTES

	tags = list(
		TAG_HAUNTED,
		TAG_COMBAT,
		TAG_VILLIAN,
	)

/datum/migrant_wave/lich
	name = "Wandering Lich"
	roles = list(
		/datum/migrant_role/lich = 1,
	)
	can_roll = FALSE

/datum/migrant_role/lich
	name = "Lich"
	antag_datum = /datum/antagonist/lich
