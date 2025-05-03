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
	GLOB.tennite_schisms -= src
	return ..()

/datum/tennite_schism/proc/announce()
	var/datum/patron/challenger = challenger_god.resolve()
	if(!challenger)
		return

	priority_announce("[challenger.name] challenges Astrata's leadeship! The outcome of this conflict will be decided in less than 2 daes by a sheer number of their supporters. [challenger.name] offers great rewards to all faithful if victorious, while Astrata promises revenge for those who dare to defy her. Choose your side, or stand aside...", "Schism within the Ten", 'sound/magic/marked.ogg')

	for(var/mob/living/carbon/human/human_mob in GLOB.player_list)
		if(!istype(human_mob) || human_mob.stat == DEAD || !human_mob.client)
			continue

		human_mob.mind.AddSpell(new /obj/effect/proc_holder/spell/self/choose_schism_side)
		if(!is_tennite(human_mob))
			to_chat(human_mob, span_notice("Even though you are not a Tennite and won't matter in its ultimate outcome, you may pretend and use the schism to further your own goals..."))

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
		adjust_storyteller_influence("Astrata", 150)

		for(var/datum/weakref/supporter_ref in supporters_astrata)
			var/mob/living/carbon/human/supporter = supporter_ref.resolve()
			if(supporter && supporter.patron == astrata)
				to_chat(supporter, span_notice("Astrata's light prevails! Your steadfast devotion is rewarded with many triumphs."))
				supporter.adjust_triumphs(3)
			else if(supporter)
				to_chat(supporter, span_notice("Astrata's light prevails over the challenge of [challenger.name]! The Sun Queen expected no less than your total support."))

		priority_announce("Astrata's light prevails over the challenge of [challenger.name]! The Sun Queen confirms her status as a true heir of Psydon!", "Astrata is VICTORIOUS!", 'sound/magic/ahh2.ogg')

	else if(challenger_count > astrata_count)
		adjust_storyteller_influence(challenger.name, 150)

		for(var/datum/weakref/supporter_ref in supporters_challenger)
			var/mob/living/carbon/human/supporter = supporter_ref.resolve()
			if(supporter && supporter.patron == challenger)
				to_chat(supporter, span_notice("[challenger.name]'s challenge succeeds! Your persistent faith is rewarded with triumphs."))
				supporter.adjust_triumphs(2)
			else if(supporter)
				to_chat(supporter, span_notice("[challenger.name]'s challenge succeeds against Astrata's tyranny! Your support is rewarded with a triumph."))
				supporter.adjust_triumphs(1)

		priority_announce("[challenger.name]'s challenge succeeds against Astrata's tyranny! The Sun Queen is grudgingly forced to listen...", "[challenger.name] RULES!", 'sound/magic/inspire_02.ogg')

	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(!H.mind)
			continue
		H.mind.RemoveSpell(/obj/effect/proc_holder/spell/self/choose_schism_side)

	qdel(src)

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
	desc = "Declare your allegiance in the schism within the Ten."
	overlay_state = "limb_attach"
	cooldown_min = 1 MINUTES
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
		name = "[initial(name)] (Finalized)"
		if(action)
			action.UpdateButtonIcon()
		to_chat(user, span_boldnotice("Your allegiance in the schism is now final."))

/datum/round_event_control/schism_within_ten
	name = "Schism within the Ten"
	track = EVENT_TRACK_INTERVENTION
	typepath = /datum/round_event/schism_within_ten
	weight = 2
	max_occurrences = 1
	min_players = 50
	earliest_start = 35 MINUTES
	allowed_storytellers = list(/datum/storyteller/noc, /datum/storyteller/ravox, /datum/storyteller/necra, /datum/storyteller/xylix, /datum/storyteller/pestra, /datum/storyteller/abyssor, /datum/storyteller/dendor, /datum/storyteller/eora, /datum/storyteller/malum)

/datum/round_event_control/schism_within_ten/canSpawnEvent(players_amt, gamemode, fake_check)
	. = ..()
	if(!.)
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
	var/datum/patron/strongest_challenger = find_strongest_challenger()
	if(!strongest_challenger)
		return

	// Notify challenger god's patrons
	for(var/mob/living/carbon/human/human_mob in GLOB.player_list)
		if(!istype(human_mob) || human_mob.stat == DEAD || !human_mob.client)
			continue

		if(human_mob.patron == strongest_challenger)
			to_chat(human_mob, span_notice("You hear a divine calling from your patron - the time has come to challenge Astrata's authority! Prepare for the coming schism!"))
			SEND_SOUND(human_mob, 'sound/magic/marked.ogg')

	new /datum/tennite_schism(strongest_challenger)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(announce_schism_start)), 3 MINUTES)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(announce_schism_end)), 33 MINUTES)

/proc/announce_schism_start()
	for(var/datum/tennite_schism/schism in GLOB.tennite_schisms)
		schism.announce()

/proc/announce_schism_end()
	for(var/datum/tennite_schism/schism in GLOB.tennite_schisms)
		schism.process_winner()

/proc/adjust_storyteller_influence(god_name, amount)
	for(var/storyteller_type in SSgamemode.storytellers)
		var/datum/storyteller/S = SSgamemode.storytellers[storyteller_type]
		if(S.name == god_name)
			S.bonus_points += amount
			break

/proc/is_tennite(mob/living/carbon/human/human_mob)
	if(!human_mob.patron)
		return FALSE
	return istype(human_mob.patron, /datum/patron/divine)

/proc/get_storyteller_influence(god_name)
	for(var/storyteller_type in SSgamemode.storytellers)
		var/datum/storyteller/S = SSgamemode.storytellers[storyteller_type]
		if(S.name == god_name)
			return SSgamemode.calculate_storyteller_influence(S.type)
	return 0

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
