/datum/round_event_control/antagonist/solo/bandits
	name = "Bandits"
	tags = list(
		TAG_VILLIAN,
	)
	roundstart = TRUE
	antag_flag = ROLE_BANDIT
	shared_occurence_type = SHARED_MINOR_THREAT
	minor_roleset = TRUE

	restricted_roles = list(
		"Monarch",
		"Consort",
		"Prince",
		"Princess",
		"Hand",
		"Steward",
		"Feldsher",
		"Town Elder",
		"Captain",
		"Archivist",
		"Merchant",
		"Priest",
		"Templar",
		"Acolytes",
		"Royal Knight",
		"Garrison Guard",
		"Jailor",
		"Court Magician",
		"Men-at-arms",
		"Dungeoneer",
		"Forest Warden",
		"Inquisitor",
		"Adepts",
		"Forest Guard",
		"Squire",
		"Veteran"
	)

	base_antags = 1
	maximum_antags = 8

	earliest_start = 0 SECONDS

	weight = 8

	typepath = /datum/round_event/antagonist/solo/bandits

/datum/round_event/antagonist/solo/bandits
	var/leader = FALSE

/datum/round_event/antagonist/solo/bandits/start()
	var/datum/job/bandit_job = SSjob.GetJob("Bandit")
	bandit_job.total_positions = length(setup_minds)
	bandit_job.spawn_positions = length(setup_minds)
	SSmapping.retainer.bandit_goal = rand(200,400) + (length(setup_minds) * rand(200,400))
	for(var/datum/mind/antag_mind as anything in setup_minds)
		SSjob.AssignRole(antag_mind.current, "Bandit")
		SSmapping.retainer.bandits |= antag_mind.current

	SSrole_class_handler.bandits_in_round = TRUE
