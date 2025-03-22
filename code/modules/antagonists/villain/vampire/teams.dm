/datum/team/vampire
	name = "\improper Vampires"
	member_name = "child of Kain"

	var/datum/mind/lord
	var/datum/objective/protect/lord_protect //not an ideal variable

	var/power_level
	var/obj/structure/vampire/bloodpool/vitae_pool

/datum/team/vampire/New(starting_members)
	vitae_pool = locate() in GLOB.vampire_objects

	lord_protect = new()
	lord_protect.triumph_count = 3
	lord_protect.target_role_type = TRUE
	add_objective(lord_protect)

	var/primary_objective = pick(
		/datum/objective/ascend, \
		/datum/objective/conquer, \
		/datum/objective/dominate/vampire \
	)
	add_objective(new primary_objective)
	var/secondary_objective = pick(
		/datum/objective/infiltrate/church, \
		/datum/objective/infiltrate/royalty, \
		/datum/objective/spread \
	)
	add_objective(new secondary_objective)

	. = ..()

/datum/team/vampire/add_member(datum/mind/new_member)
	. = ..()
	var/datum/antagonist/vampire/vamp_datum = new_member.has_antag_datum(/datum/antagonist/vampire)

	vamp_datum.objectives |= objectives

	if(istype(vamp_datum, /datum/antagonist/vampire/lord))
		if(lord)
			stack_trace("vampire team had two lords assigned, which should be impossible")
			to_chat(new_member, span_warning("Alas, I am not the Lord of these lands. I will serve [lord.name]."))
			var/datum/antagonist/vampire/lord/our_datum = vamp_datum
			var/datum/antagonist/vampire/lord/their_datum = lord.has_antag_datum(/datum/antagonist/vampire/lord)
			our_datum.vamplevel = their_datum.vamplevel
		else
			//add new lord and state objectives
			lord = new_member
			lord_protect.target = lord
			for(var/datum/mind/member as anything in members)
				member.announce_objectives()
			return

	//if we're still here then we're a minion, just show the objectives to ourselves
	new_member.announce_objectives()

/datum/antagonist/vampire/create_team(datum/team/vampire/new_team)
	var/static/datum/team/vampire/vampire_team //only one team for now
	if(!vampire_team)
		vampire_team = new()
	if(istype(new_team) && (new_team != vampire_team))
		message_admins("[owner.name] just revealed that a second vampire team exists, this is pretty bad, should notify coders")
		stack_trace("two vampire teams were created, and the wrong one tried to be assigned")
		new_team = null

	team = vampire_team

/datum/antagonist/vampire/get_team()
	return team

/* --- OBJECTIVES --- */

/datum/objective/conquer
	name = "conquer"
	explanation_text = "Make the Ruler of this land bow to the will of the Lord."
	triumph_count = 5

/datum/objective/conquer/check_completion()
	if(SSmapping.retainer.king_submitted)
		return TRUE

/datum/objective/ascend
	name = "vampire ascend"
	explanation_text = "Astrata has spurned us long enough. The Lord must conquer the Sun."
	triumph_count = 5

/datum/objective/ascend/check_completion()
	var/datum/team/vampire/vampire_team = team
	var/datum/antagonist/vampire/lord/lord_datum = vampire_team.lord?.has_antag_datum(/datum/antagonist/vampire/lord)
	if(lord_datum?.ascended)
		return TRUE

/datum/objective/infiltrate
	abstract_type = /datum/objective/infiltrate
	triumph_count = 5
	var/list/jobs_to_check

/datum/objective/infiltrate/check_completion()
	for(var/datum/mind/mind as anything in team.members)
		if(mind.current.job in jobs_to_check)
			return TRUE

/datum/objective/infiltrate/church
	name = "infiltrate church"
	explanation_text = "Curse a member of the Church."
	jobs_to_check = list(
		/datum/job/priest::title,
		/datum/job/monk::title,
		/datum/job/churchling::title,
		/datum/job/templar::title,
		// /datum/advclass/combat/cleric::name, // not really a member of the church, though they are holy
		// "Crusader",
		/datum/job/inquisitor::title,
	)

/datum/objective/infiltrate/royalty
	name = "infiltrate royalty"
	explanation_text = "Curse a member of the Royal Family."
	jobs_to_check = list(
		/datum/job/lord::title,
		/datum/job/consort::title,
		/datum/job/prince::title,
		/datum/job/hand::title,
	)

/datum/objective/spread
	name = "spread"
	explanation_text = "Spread this Curse to 10 mortals."
	triumph_count = 5

/datum/objective/spread/check_completion()
	if(length(team.members) >= 10)
		return TRUE

/datum/objective/vampire/stock
	name = "stock"
	explanation_text = "Have a crimson crucible with 30000 vitae."
	triumph_count = 1
