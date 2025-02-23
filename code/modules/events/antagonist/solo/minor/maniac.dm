/datum/round_event_control/antagonist/solo/maniac
	name = "Maniacs"
	tags = list(
		TAG_VILLIAN,
		TAG_HAUNTED
	)
	antag_datum = /datum/antagonist/maniac
	roundstart = TRUE
	antag_flag = ROLE_VILLAIN
	shared_occurence_type = SHARED_MINOR_THREAT
	minor_roleset = TRUE

	restricted_roles = list(
		"Monarch",
		"Consort"
	)

	base_antags = 1
	maximum_antags = 2

	earliest_start = 0 SECONDS

	weight = 6

	typepath = /datum/round_event/antagonist/solo/maniac

/datum/round_event/antagonist/solo/maniac
