/datum/round_event_control/antagonist/migrant_wave/werewolf
	name = "Exiled Werewolf"
	wave_type = /datum/migrant_wave/werewolf

	weight = 4
	max_occurrences = 2

	earliest_start = 25 MINUTES

	tags = list(
		TAG_HAUNTED,
		TAG_VILLIAN,
		TAG_COMBAT,
	)

/datum/migrant_wave/werewolf
	name = "Exiled Adventurer (Verevolf)"
	roles = list(
		/datum/migrant_role/werewolf = 1,
	)
	can_roll = FALSE

/datum/migrant_role/werewolf
	name = "Adventurer"
	antag_datum = /datum/antagonist/werewolf
	advclass_cat_rolls = list(CTAG_ADVENTURER = 5)

/datum/round_event_control/antagonist/migrant_wave/vampire
	name = "Exiled Vampire"
	wave_type = /datum/migrant_wave/vampire

	weight = 4
	max_occurrences = 2

	earliest_start = 25 MINUTES

	tags = list(
		TAG_HAUNTED,
		TAG_COMBAT,
		TAG_VILLIAN,
	)

/datum/migrant_wave/vampire
	name = "Exiled Adventurer (Vampire)"
	roles = list(
		/datum/migrant_role/vampire = 1,
	)
	can_roll = FALSE

/datum/migrant_role/vampire
	name = "Adventurer"
	antag_datum = /datum/antagonist/vampirelord/lesser/migrant
	advclass_cat_rolls = list(CTAG_ADVENTURER = 5)

/datum/antagonist/vampirelord/lesser/migrant/move_to_spawnpoint()
	return
