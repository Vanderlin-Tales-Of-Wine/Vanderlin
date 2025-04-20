/datum/round_event_control/antagonist/solo/werewolf
	name = "Verevolfs"
	tags = list(
		TAG_COMBAT,
		TAG_HAUNTED,
		TAG_VILLIAN,
	)
	roundstart = TRUE
	antag_flag = ROLE_WEREWOLF
	shared_occurence_type = SHARED_HIGH_THREAT

	denominator = 80

	base_antags = 1
	maximum_antags = 2

	weight = 12

	earliest_start = 0 SECONDS

	typepath = /datum/round_event/antagonist/solo/werewolf
	antag_datum = /datum/antagonist/werewolf

	restricted_roles = list(
		"Monarch",
		"Consort",
		"Hand",
		"Captain",
		"Prince",
		"Priest",
		"Merchant",
		"Forest Warden",
		"Inquisitor",
		"Adept",
		"Royal Knight",
		"Templar",
	)

/datum/round_event/antagonist/solo/werewolf
