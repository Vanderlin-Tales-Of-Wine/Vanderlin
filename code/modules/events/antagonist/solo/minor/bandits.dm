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

	base_antags = 4
	maximum_antags = 12
	denominator = 10

	earliest_start = 0 SECONDS

	weight = 8

	typepath = /datum/round_event/antagonist/solo/bandits

/datum/round_event/antagonist/solo/bandits
	var/leader = FALSE

/datum/round_event/antagonist/solo/bandits/start()
	var/datum/job/bandit_job = SSjob.GetJobType(/datum/job/bandit)
	bandit_job.total_positions = length(setup_minds)
	bandit_job.spawn_positions = length(setup_minds)
	SSmapping.retainer.bandit_goal = rand(200,400) + (length(setup_minds) * rand(200,400))
	for(var/datum/mind/antag_mind as anything in setup_minds)
		if(SSjob.AssignRole(antag_mind.current, bandit_job)) // could be job banned or something
			var/datum/job/J = SSjob.GetJob(antag_mind.current?.job)
			J?.adjust_current_positions(-1)

			antag_mind.current.unequip_everything()
			SSmapping.retainer.bandits |= antag_mind.current
			antag_mind.add_antag_datum(/datum/antagonist/bandit)

			SSrole_class_handler.setup_class_handler(antag_mind.current, list(CTAG_BANDIT = 20))
			antag_mind.current:advsetup = TRUE // runtime index :(
			antag_mind.current.hud_used?.set_advclass()

	SSrole_class_handler.bandits_in_round = TRUE
