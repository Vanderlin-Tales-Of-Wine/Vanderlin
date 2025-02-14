/datum/round_event_control/antagonist/solo/vampires
	name = "Vampires"
	tags = list(
		TAG_COMBAT,
		TAG_HAUNTED,
		TAG_VILLIAN,
	)
	roundstart = TRUE
	antag_flag = ROLE_NBEAST
	shared_occurence_type = SHARED_HIGH_THREAT

	weight = 12

	base_antags = 1
	maximum_antags = 3

	earliest_start = 0 SECONDS

	typepath = /datum/round_event/antagonist/solo/vampire
	antag_datum = /datum/antagonist/vampirelord

	restricted_roles = list(
		"Monarch",
		"Consort",
		"Dungeoneer",
		"Inquisitor",
		"Men-at-arms",
		"Merchant",
		"Priest",
		"Acolyte",
		"Adepts",
		"Templar",
		"Bandit",
		"Prince",
		"Princess",
		"Hand",
		"Steward",
		"Feldsher",
		"Town Elder",
		"Captain",
		"Archivist",
		"Merchant",
		"Royal Knight",
		"Garrison Guard",
		"Jailor",
		"Court Magician",
		"Forest Warden",
		"Inquisitor",
		"Adepts",
		"Forest Guard",
		"Squire",
		"Veteran",
		"Apothecary"
	)

/datum/round_event/antagonist/solo/vampire
	var/leader = FALSE

/datum/round_event/antagonist/solo/vampire/add_datum_to_mind(datum/mind/antag_mind)
	. = ..()
	if(!leader)
		antag_mind.add_antag_datum(antag_datum)
		leader = TRUE
	else
		antag_mind.add_antag_datum(/datum/antagonist/vampirelord/lesser)
