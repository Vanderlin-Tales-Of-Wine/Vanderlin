#define MAX_POWER 4

/datum/team/vampires
	name = "\improper Vampires"
	member_name = "child of Kain"

	/// The Vampire Lord that commands this team. Can only ever be one, others will be relegated to thralls.
	var/datum/mind/lord
	/// The objective to protect the Lord.
	var/datum/objective/protect/lord_protect //! not an ideal variable but can't guarantee the Lord spawns first

	/// Lazy-list of vampire spawns.
	var/list/datum/mind/thralls = null
	/// Lazy-list of death knights.
	var/list/datum/mind/knights = null
	/// Lazy-List of spells to apply/remove from thralls.
	var/list/thrall_verbs = null

	/// The current power level of the Lord. Maximum is 4.
	var/power_level = 0
	var/obj/structure/vampire/bloodpool/vitae_pool

/datum/team/vampires/New(starting_members)
	vitae_pool = locate() in GLOB.vampire_objects
	if(vitae_pool.owner_team)
		message_admins("Why is there a second vampire team, admins? Did one of you do this? \n\
			The game is going to break now, I hope you're happy.")
	vitae_pool.owner_team = src

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

/datum/team/vampires/add_member(datum/mind/new_member)
	. = ..()
	var/datum/antagonist/vampire/vamp_datum = new_member.has_antag_datum(/datum/antagonist/vampire)
	var/datum/antagonist/skeleton/knight/knight_datum = new_member.has_antag_datum(/datum/antagonist/skeleton/knight)

	vamp_datum?.objectives |= objectives
	knight_datum?.objectives |= objectives
	new_member.current.verbs |= /mob/living/carbon/human/proc/vampire_telepathy

	if(istype(vamp_datum, /datum/antagonist/vampire/lord))
		if(lord)
			stack_trace("vampire team had two lords assigned, which should be impossible")
			to_chat(new_member, span_warning("Alas, I am not the Lord of this land. I will serve [lord.name]."))
		else
			//add new lord and state objectives
			lord = new_member
			lord_protect.target = lord
			lord.special_role = span_redtext("Vampire Lord") // Team member is added before antag datum is
			for(var/datum/mind/member as anything in members)
				member.announce_objectives()
			return

	//if we're still here then we're a minion, just show the objectives to ourselves
	new_member.announce_objectives()
	if(vamp_datum)
		LAZYOR(thralls, new_member)
		if(LAZYLEN(thrall_verbs))
			new_member.current.verbs |= thrall_verbs
	if(knight_datum)
		LAZYOR(knights, new_member)


/datum/team/vampires/remove_member(datum/mind/member)
	. = ..()
	var/datum/antagonist/vampire/vamp_datum = member.has_antag_datum(/datum/antagonist/vampire)
	var/datum/antagonist/skeleton/knight/knight_datum = member.has_antag_datum(/datum/antagonist/skeleton/knight)

	vamp_datum?.objectives -= objectives
	knight_datum?.objectives -= objectives
	member.current.verbs -= /mob/living/carbon/human/proc/vampire_telepathy

	LAZYREMOVE(thralls, member)
	member.current.verbs -= thrall_verbs
	LAZYREMOVE(knights, member)

/datum/team/vampires/proc/grow_in_power()
	if(power_level >= 4)
		return

	var/datum/antagonist/vampire/lord/lord_datum = lord.has_antag_datum(/datum/antagonist/vampire/lord)

	switch(++power_level)
		if(1)
			lord_datum.batform = new
			lord.current.AddSpell(lord_datum.batform)
			for(var/statkey in MOBSTATS)
				lord.current.change_stat(statkey, 2)
			to_chat(lord, "<font color='red'>I am refreshed and have grown stronger. The visage of the bat is once again available to me. I can also once again access my portals.</font>")

		if(2)
			lord.current.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/bloodsteal)
			lord.current.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/bloodlightning)
			lord.current.adjust_skillrank(/datum/skill/magic/blood, 2, TRUE)
			lord_datum.gas = new
			lord.current.AddSpell(lord_datum.gas)
			for(var/S in MOBSTATS)
				lord.current.change_stat(S, 2)
			to_chat(lord, "<font color='red'>My power is returning. I can once again access my spells. I have also regained usage of my mist form.</font>")

		if(3)
			lord.current.verbs |= /mob/living/carbon/human/proc/blood_strength
			lord.current.verbs |= /mob/living/carbon/human/proc/blood_celerity
			lord.current.RemoveSpell(/obj/effect/proc_holder/spell/targeted/transfix)
			lord.current.AddSpell(new /obj/effect/proc_holder/spell/targeted/transfix/master)
			for(var/S in MOBSTATS)
				lord.current.change_stat(S, 2)
			to_chat(lord, span_notice("My dominion over others minds and my own body returns to me. I am nearing perfection. The armies of the dead shall now answer my call."))
		if(4)
			lord.current.visible_message(\
				"<font color='red'>[lord.current] is enveloped in dark crimson, a horrific sound echoing in the area. They are evolved.</font>",\
				"<font color='red'>I AM ANCIENT, I AM THE LAND. EVEN THE SUN BOWS TO ME.</font>"\
			)
			lord_datum.ascended = TRUE
			SSmapping.retainer.ascended = TRUE

			LAZYINITLIST(thrall_verbs)
			thrall_verbs |= /mob/living/carbon/human/proc/blood_strength
			thrall_verbs |= /mob/living/carbon/human/proc/blood_celerity
			thrall_verbs |= /mob/living/carbon/human/proc/vamp_regenerate

			for(var/datum/mind/thrall in thralls)
				thrall.current.verbs |= thrall_verbs
				for(var/S in MOBSTATS)
					thrall.current.change_stat(S, 2)

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
	var/datum/team/vampires/vampire_team = team
	var/datum/antagonist/vampire/lord/lord_datum = vampire_team.lord?.has_antag_datum(/datum/antagonist/vampire/lord)
	return lord_datum?.ascended

/datum/objective/infiltrate
	abstract_type = /datum/objective/infiltrate
	triumph_count = 5
	var/list/jobs_to_check

/datum/objective/infiltrate/check_completion()
	for(var/datum/mind/mind as anything in team.members)
		return (mind.current.job in jobs_to_check)

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
	explanation_text = "Spread the Curse to 10 mortals."
	triumph_count = 5

/datum/objective/spread/check_completion()
	var/datum/team/vampires/vamp_team = team

	return (LAZYLEN(vamp_team?.thralls) >= 10)

#undef MAX_POWER
