/datum/migrant_role/acolytes
	name = "Acolytes"
	greet_text = "The words of the Tens are everything to you and this is why, you are on your way to the nearby populated area to help the local church."
	grant_lit_torch = TRUE
	outfit = /datum/outfit/job/monk
	allowed_races = RACES_PLAYER_NONHERETICAL

/datum/migrant_wave/acolytes
	name = "The Holy Voyage"
	shared_wave_type = /datum/migrant_wave/acolytes
	downgrade_wave = /datum/migrant_wave/acolytes_down
	weight = 40
	roles = list(
		/datum/migrant_role/acolytes = 4,
	)
	greet_text = "The Tens have decreed that this land needs additional persons of faith, so here you are."

/datum/migrant_wave/acolytes_down
	name = "The Holy Voyage"
	shared_wave_type = /datum/migrant_wave/acolytes
	downgrade_wave = /datum/migrant_wave/acolytes_down_one
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/acolytes = 3,
	)
	greet_text = "The Tens have decreed that this land needs additional persons of faith, so here you are."

/datum/migrant_wave/acolytes_down_one
	name = "The Holy Voyage"
	shared_wave_type = /datum/migrant_wave/acolytes
	downgrade_wave = /datum/migrant_wave/acolytes_down_two
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/acolytes = 2,
	)
	greet_text = "The Tens have decreed that this land needs additional persons of faith, so here you are."

/datum/migrant_wave/acolytes_down_two
	name = "The Holy Voyage"
	shared_wave_type = /datum/migrant_wave/acolytes
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/acolytes = 1,
	)
	greet_text = "The Tens have decreed that this land needs additional persons of faith, so here you are."
