/datum/round_event_control/antagonist/solo/vampires_and_werewolves
	name = "Vampires and Verevolves"
	tags = list(
		TAG_COMBAT,
		TAG_HAUNTED,
		TAG_VILLIAN,
	)
	roundstart = TRUE
	antag_flag = ROLE_NBEAST
	shared_occurence_type = SHARED_HIGH_THREAT
	denominator = 80

	base_antags = 2
	maximum_antags = 4

	earliest_start = 0 SECONDS

	weight = 8

	typepath = /datum/round_event/antagonist/solo/vampires_and_werewolves

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

/datum/round_event/antagonist/solo/vampires_and_werewolves
	var/leader = FALSE

/datum/round_event/antagonist/solo/vampires_and_werewolves/start()
	var/vampire = TRUE
	for(var/datum/mind/antag_mind as anything in setup_minds)
		if(vampire)
			add_vampire(antag_mind)
		else
			add_werewolf(antag_mind, antag_mind.current)
		vampire = !vampire

/datum/round_event/antagonist/solo/vampires_and_werewolves/proc/add_werewolf(datum/mind/antag_mind)
	if(!antag_mind)
		CRASH("add_werewolf was called without an antag datum!")
	antag_mind.add_antag_datum(/datum/antagonist/werewolf)

/datum/round_event/antagonist/solo/vampires_and_werewolves/proc/add_vampire(datum/mind/antag_mind)
	if(!antag_mind)
		CRASH("add_vampire was called without an antag datum!")
	if(ishuman(antag_mind.current))
		var/mob/living/carbon/human/vampire = antag_mind.current
		vampire.adv_hugboxing_cancel() // workaround for pilgrims and adventurers being in the adv_class pick menu
	if(!leader)
		var/datum/job/J = SSjob.GetJob(antag_mind.current?.job)
		J?.adjust_current_positions(-1)
		antag_mind.current.unequip_everything()
		antag_mind.add_antag_datum(/datum/antagonist/vampire/lord)
		leader = TRUE
		return
	else
		if(!antag_mind.has_antag_datum(/datum/antagonist/vampire))
			var/datum/job/J = SSjob.GetJob(antag_mind.current?.job)
			J?.adjust_current_positions(-1)
			antag_mind.current.unequip_everything()
			antag_mind.add_antag_datum(/datum/antagonist/vampire/lesser)
		return
