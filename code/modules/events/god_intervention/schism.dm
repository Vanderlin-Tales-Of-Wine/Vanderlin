GLOBAL_LIST_EMPTY(tennite_schisms)

/datum/tennite_schism
	var/datum/weakref/challenger_god
	var/datum/weakref/astrata_god
	var/list/supporters_astrata = list()
	var/list/supporters_challenger = list()
	var/list/neutrals = list()

/datum/tennite_schism/New(datum/patron/challenger)
	. = ..()
	src.challenger_god = WEAKREF(challenger)
	src.astrata_god = WEAKREF(GLOB.patronlist[/datum/patron/divine/astrata])
	GLOB.tennite_schisms += src

/datum/tennite_schism/Destroy()
	UnregisterSignal(SSdcs, COMSIG_GLOB_JOB_AFTER_SPAWN)
	GLOB.tennite_schisms -= src
	return ..()

/datum/tennite_schism/proc/announce()
	var/datum/patron/challenger = challenger_god.resolve()
	if(!challenger)
		return

	priority_announce("[challenger.name] challenges Astrata's leadeship! The outcome of this conflict will be decided in less than 2 daes by a sheer number of their supporters. [challenger.name] promises great rewards to the faithful if victorious, while Astrata swears revenge to any who dare to defy her. Choose your side, or stand aside...", "Schism within the Ten", 'sound/magic/marked.ogg')
	for(var/mob/living/carbon/human/H in GLOB.human_list)
		setup_mob(H)

	RegisterSignal(SSdcs, COMSIG_GLOB_JOB_AFTER_SPAWN, PROC_REF(handle_latejoin))

/datum/tennite_schism/proc/handle_latejoin(datum/source, datum/job/job, mob/living/spawned, client/player_client)
	SIGNAL_HANDLER
	if(!istype(spawned, /mob/living/carbon/human))
		return

	var/mob/living/carbon/human/H = spawned
	var/datum/patron/challenger = challenger_god?.resolve()
	if(!challenger)
		return

	to_chat(H, span_notice("There is an active schism within the Ten! [challenger.name] has challenged Astrata's leadership!"))
	setup_mob(H)

/datum/tennite_schism/proc/setup_mob(mob/living/carbon/human/H)
	if(!istype(H) || H.stat == DEAD || !H.mind)
		return

	H.mind.AddSpell(new /obj/effect/proc_holder/spell/self/choose_schism_side)
	if(!is_tennite(H))
		to_chat(H, span_notice("Even though you are not a tennite and won't matter in the ultimate resolution of this conflict, you may pretend to be one and use the schism to further your own goals..."))

/datum/tennite_schism/proc/process_winner()
	var/datum/patron/challenger = challenger_god.resolve()
	var/datum/patron/astrata = astrata_god.resolve()

	if(!challenger || !astrata)
		return

	var/astrata_count = 0
	var/challenger_count = 0

	for(var/datum/weakref/supporter_ref in supporters_astrata)
		var/mob/living/carbon/human/supporter = supporter_ref.resolve()
		if(supporter && supporter.stat != DEAD && is_tennite(supporter))
			astrata_count++

	for(var/datum/weakref/supporter_ref in supporters_challenger)
		var/mob/living/carbon/human/supporter = supporter_ref.resolve()
		if(supporter && supporter.stat != DEAD && is_tennite(supporter))
			challenger_count++

	if(astrata_count >= challenger_count)
		priority_announce("Astrata's light prevails over the challenge of [challenger.name]! The Sun Queen confirms her status as a true heir of Psydon!", "Astrata is VICTORIOUS!", 'sound/magic/ahh2.ogg')
		adjust_storyteller_influence("Astrata", 300)

		for(var/datum/weakref/supporter_ref in supporters_astrata)
			var/mob/living/carbon/human/supporter = supporter_ref.resolve()
			if(supporter && supporter.patron == astrata)
				to_chat(supporter, span_notice("Astrata's light prevails! Your steadfast devotion is rewarded with many triumphs."))
				supporter.adjust_triumphs(3)
			else if(supporter)
				to_chat(supporter, span_notice("Astrata's light prevails over the challenge of [challenger.name]! The Sun Queen expected no less than your total support."))

		for(var/datum/weakref/supporter_ref in supporters_challenger)
			var/mob/living/carbon/human/supporter = supporter_ref.resolve()
			if(supporter)
				to_chat(supporter, span_userdanger("NEVER DEFY ME AGAIN!"))
				supporter.electrocute_act(5, astrata)

	else if(challenger_count > astrata_count)
		priority_announce("[challenger.name]'s challenge succeeds against Astrata's tyranny! The Sun Queen is grudgingly forced to share power with [challenger.name]...", "[challenger.name] RULES!", 'sound/magic/inspire_02.ogg')
		adjust_storyteller_influence(challenger.name, 300)

		for(var/datum/weakref/supporter_ref in supporters_challenger)
			var/mob/living/carbon/human/supporter = supporter_ref.resolve()
			if(supporter && supporter.patron == challenger)
				to_chat(supporter, span_notice("[challenger.name]'s challenge succeeds! Your persistent faith is rewarded with triumphs."))
				supporter.adjust_triumphs(2)
			else if(supporter)
				to_chat(supporter, span_notice("[challenger.name]'s challenge succeeds against Astrata's tyranny! Your support is rewarded with a triumph."))
				supporter.adjust_triumphs(1)

		var/mob/living/carbon/human/selected_priest = null
		var/was_supporter = FALSE
		var/was_clergy = FALSE

		// First try to find a challenger supporter who is also clergy
		for(var/datum/weakref/supporter_ref in supporters_challenger)
			var/mob/living/carbon/human/human_mob = supporter_ref.resolve()
			if(human_mob && human_mob.stat != DEAD && human_mob.client && (human_mob.mind?.assigned_role.title in GLOB.church_positions) && human_mob.patron == challenger)
				selected_priest = human_mob
				was_supporter = TRUE
				was_clergy = TRUE
				break

		// If no supporter found, fall back to any clergy member who has the challenger as his patron
		if(!selected_priest)
			for(var/mob/living/carbon/human/human_mob in GLOB.player_list)
				if(human_mob.stat != DEAD && human_mob.client && (human_mob.mind?.assigned_role.title in GLOB.church_positions) && human_mob.patron == challenger)
					selected_priest = human_mob
					was_clergy = TRUE
					break

		// As a last resort, pick someone who has the challenger as his patron, is nonheretical species, is adult and is not a noble, garrison or a migrant
		if(!selected_priest)
			for(var/datum/weakref/supporter_ref in supporters_challenger)
				var/mob/living/carbon/human/human_mob = supporter_ref.resolve()
				if(human_mob && human_mob.stat != DEAD && human_mob.client && human_mob.patron == challenger && (human_mob.dna?.species in RACES_PLAYER_NONHERETICAL) && !human_mob.is_noble() && human_mob.age != AGE_CHILD && !(human_mob.mind?.assigned_role.title in GLOB.garrison_positions) && !(human_mob.mind?.assigned_role.title in GLOB.allmig_positions))
					selected_priest = human_mob
					was_supporter = TRUE
					break

		// Promote the selected priest if we found one
		if(selected_priest)
			var/male
			if(selected_priest.gender == FEMALE)
				selected_priest.job = "Vice Priestess"
				selected_priest.advjob = "Vice Priestess"
				male = FALSE
			else
				selected_priest.job = "Vice Priest"
				selected_priest.advjob = "Vice Priest"
				male = TRUE
			selected_priest.migrant_type = null
			if(!was_clergy)
				var/datum/devotion/cleric_holder/C = new /datum/devotion/cleric_holder(selected_priest, selected_priest.patron)
				C.grant_spells(selected_priest)
				selected_priest.verbs |= /mob/living/carbon/human/proc/devotionreport
				selected_priest.verbs |= /mob/living/carbon/human/proc/clericpray
			selected_priest.verbs |= /mob/living/carbon/human/proc/churchexcommunicate
			selected_priest.verbs |= /mob/living/carbon/human/proc/churchcurse
			selected_priest.verbs |= /mob/living/carbon/human/proc/churchannouncement

			if(was_supporter)
				to_chat(selected_priest, span_green("[challenger.name] smiles upon you! Your faithful support during the schism has been rewarded with the position of a [male ? "Vice Priest" : "Vice Priestess"]!"))
			else
				to_chat(selected_priest, span_green("Though you did not openly support [challenger.name] during the schism, you have been chosen to serve as a [male ? "Vice Priest" : "Vice Priestess"]!"))

			priority_announce("[challenger.name] has selected [selected_priest.real_name] as a [male ? "Vice Priest" : "Vice Priestess"]! Power sharing begins!", "[male ? "Vice Priest" : "Vice Priestess"] rises")

		for(var/datum/weakref/supporter_ref in supporters_astrata)
			var/mob/living/carbon/human/supporter = supporter_ref.resolve()
			if(supporter)
				to_chat(supporter, span_userdanger("INCOMPETENT IMBECILES!"))
				supporter.electrocute_act(5, astrata)

	for(var/mob/living/carbon/human/H in GLOB.human_list)
		if(!H.mind)
			continue
		H.mind.RemoveSpell(/obj/effect/proc_holder/spell/self/choose_schism_side)

	qdel(src)

/// Announces the current standings in the schism
/datum/tennite_schism/proc/announce_standings()
	var/datum/patron/challenger = challenger_god.resolve()
	var/datum/patron/astrata = astrata_god.resolve()

	if(!challenger || !astrata)
		return

	var/astrata_count = 0
	var/challenger_count = 0

	for(var/datum/weakref/supporter_ref in supporters_astrata)
		var/mob/living/carbon/human/supporter = supporter_ref.resolve()
		if(supporter && supporter.stat != DEAD && is_tennite(supporter))
			astrata_count++

	for(var/datum/weakref/supporter_ref in supporters_challenger)
		var/mob/living/carbon/human/supporter = supporter_ref.resolve()
		if(supporter && supporter.stat != DEAD && is_tennite(supporter))
			challenger_count++

	if(astrata_count >= challenger_count)
		priority_announce("Astrata is leading in the schism! She will have her revenge soon enough...", "Schism Rages On", 'sound/magic/marked.ogg')
	else if(challenger_count > astrata_count)
		priority_announce("[challenger.name] is leading in the schism! Astrata will soon be forced to yield...", "Schism Rages On", 'sound/magic/marked.ogg')

/datum/tennite_schism/proc/change_side(mob/living/carbon/human/user, new_side)
	supporters_astrata -= WEAKREF(user)
	supporters_challenger -= WEAKREF(user)
	neutrals -= WEAKREF(user)

	switch(new_side)
		if("astrata")
			supporters_astrata += WEAKREF(user)
			to_chat(user, span_notice("You have declared your allegiance to Astrata!"))
		if("challenger")
			supporters_challenger += WEAKREF(user)
			var/datum/patron/challenger = challenger_god.resolve()
			if(challenger)
				to_chat(user, span_notice("You have declared your allegiance to [challenger.name]!"))
		if("neutral")
			neutrals += WEAKREF(user)
			to_chat(user, span_notice("You have declared neutrality in the schism."))

/obj/effect/proc_holder/spell/self/choose_schism_side
	name = "Choose your side"
	overlay_state = "limb_attach"
	recharge_time = 20 SECONDS
	var/uses_remaining = 2

/obj/effect/proc_holder/spell/self/choose_schism_side/cast(mob/living/carbon/human/user)
	if(!length(GLOB.tennite_schisms))
		to_chat(user, span_warning("There is no active schism to participate in."))
		return

	var/datum/tennite_schism/current_schism = GLOB.tennite_schisms[1]
	var/datum/patron/challenger = current_schism.challenger_god.resolve()

	if(uses_remaining <= 0)
		to_chat(user, span_warning("You've already finalized your allegiance in the schism."))
		return

	var/list/options = list()
	options["Astrata"] = "astrata"
	options["Neutral"] = "neutral"
	if(challenger)
		options["[challenger.name]"] = "challenger"


	var/choice = input(user, "Choose your allegiance in the schism, you can change your side [uses_remaining] more time\s", "Choose your side") as null|anything in options
	if(!choice || !current_schism)
		return

	var/current_side
	var/datum/weakref/user_ref = WEAKREF(user)
	if(user_ref in current_schism.supporters_astrata)
		current_side = "astrata"
	else if(user_ref in current_schism.supporters_challenger)
		current_side = "challenger"
	else
		current_side = "neutral"

	if(options[choice] == current_side)
		to_chat(user, span_notice("You're already supporting this side!"))
		return

	uses_remaining--
	current_schism.change_side(user, options[choice])

	if(uses_remaining <= 0)
		if(action)
			action.UpdateButtonIcon()
		to_chat(user, span_boldnotice("Your allegiance in the schism is now final."))
	return TRUE

/datum/round_event_control/schism_within_ten
	name = "Schism within the Ten"
	track = EVENT_TRACK_INTERVENTION
	typepath = /datum/round_event/schism_within_ten
	weight = 1
	max_occurrences = 1
	min_players = 50
	earliest_start = 25 MINUTES
	allowed_storytellers = list(/datum/storyteller/noc, /datum/storyteller/ravox, /datum/storyteller/necra, /datum/storyteller/xylix, /datum/storyteller/pestra, /datum/storyteller/abyssor, /datum/storyteller/dendor, /datum/storyteller/eora, /datum/storyteller/malum)

/datum/round_event_control/schism_within_ten/canSpawnEvent(players_amt, gamemode, fake_check)
	. = ..()
	if(!.)
		return FALSE

	var/alternative_events = FALSE
	for(var/datum/round_event_control/E in SSevents.control)
		if(E.track != EVENT_TRACK_INTERVENTION)
			continue
		if(E == src)
			continue
		if(E.canSpawnEvent(players_amt, gamemode, fake_check))
			alternative_events = TRUE
			break

	if(!alternative_events)
		return FALSE

	var/datum/patron/astrata = GLOB.patronlist[/datum/patron/divine/astrata]
	if(!astrata)
		return FALSE

	var/astrata_followers = GLOB.patron_follower_counts["Astrata"] || 0
	var/astrata_influence = get_storyteller_influence("Astrata") || 0

	for(var/type in subtypesof(/datum/patron/divine) - /datum/patron/divine/astrata)
		var/datum/patron/divine/god = GLOB.patronlist[type]
		if(!god)
			continue

		var/god_followers = GLOB.patron_follower_counts[god.name] || 0
		var/god_influence = get_storyteller_influence(god.name) || 0

		if(god_followers > astrata_followers && god_influence > astrata_influence)
			return TRUE

	return FALSE

/datum/round_event/schism_within_ten/start()
	if(LAZYLEN(GLOB.tennite_schisms) > 0)
		return

	var/datum/patron/strongest_challenger = find_strongest_challenger()
	if(!strongest_challenger)
		return

	// Notify challenger god's followers
	for(var/mob/living/carbon/human/human_mob in GLOB.player_list)
		if(!istype(human_mob) || human_mob.stat == DEAD || !human_mob.client)
			continue

		if(human_mob.patron == strongest_challenger)
			to_chat(human_mob, span_notice("You hear a divine calling from your patron - the time has come to challenge Astrata's authority! Prepare for the coming schism!"))
			SEND_SOUND(human_mob, 'sound/magic/marked.ogg')

	new /datum/tennite_schism(strongest_challenger)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(announce_schism_start)), 2 MINUTES)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(announce_schism_standings)), 16 MINUTES)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(announce_schism_end)), 33 MINUTES)

/// Officially starts the schism with an announcement and ability to choose sides
/proc/announce_schism_start()
	for(var/datum/tennite_schism/schism in GLOB.tennite_schisms)
		schism.announce()

/// Announces current standings in the schism
/proc/announce_schism_standings()
	for(var/datum/tennite_schism/schism in GLOB.tennite_schisms)
		schism.announce_standings()

/// Officially ends the schism and declares the winner of it
/proc/announce_schism_end()
	for(var/datum/tennite_schism/schism in GLOB.tennite_schisms)
		schism.process_winner()

/// Checks if the mob has any divine pantheon god as their patron
/proc/is_tennite(mob/living/carbon/human/human_mob)
	if(!human_mob.patron)
		return FALSE
	return istype(human_mob.patron, /datum/patron/divine)

/// Finds strongest divine pantheon to challenge Astrata
/proc/find_strongest_challenger()
	var/datum/patron/strongest_challenger
	var/most_followers = 0

	for(var/type in subtypesof(/datum/patron/divine) - /datum/patron/divine/astrata)
		var/datum/patron/divine/god = GLOB.patronlist[type]
		if(!god)
			continue

		var/current_followers = GLOB.patron_follower_counts[god.name] || 0
		if(current_followers > most_followers)
			most_followers = current_followers
			strongest_challenger = god

	return strongest_challenger
