// This mode will become the main basis for the typical roguetown round. Based off of chaos mode.
GLOBAL_LIST_INIT(roguegamemodes, list(
	"Rebellion",
	"Vampires and Werewolves",
	"Vampires",
	"Werewolves",
	"None",
	"Aspirants",
	"Bandits",
	"Maniac",
	"Cultists",
	"Lich",
	"CANCEL"))

/datum/game_mode/chaosmode
	name = "roguemode"
	config_tag = "roguemode"
	report_type = "roguemode"
	false_report_weight = 0
	required_players = 0
	required_enemies = 0
	recommended_enemies = 0
	enemy_minimum_age = 0

	announce_span = "danger"
	announce_text = "The"

	var/allmig = FALSE
	var/roguefight = FALSE
	var/redscore = 0
	var/greenscore = 0

	var/list/allantags = list()

// DEBUG
	var/list/forcedmodes = list()
	var/mob/living/carbon/human/vlord = null
	var/mob/living/carbon/human/species/werewolf = null
// GAMEMODE SPECIFIC
	var/banditcontrib = 0
	var/banditgoal = 1
	var/delfcontrib = 0
	var/delfgoal = 1

	var/skeletons = FALSE

	var/headrebdecree = FALSE
	var/reb_end_time = 0

	var/check_for_lord = TRUE
	var/next_check_lord = 0
	var/missing_lord_time = FALSE

	var/kingsubmit = FALSE
	var/deathknightspawn = FALSE
	var/ascended = FALSE
	var/cultascended = FALSE

/datum/game_mode/chaosmode/proc/reset_skeletons()
	skeletons = FALSE

/datum/game_mode/chaosmode/check_finished()
	var/ttime = world.time - SSticker.round_start_time
	if(roguefight)
		if(ttime >= 30 MINUTES)
			return TRUE
		if((redscore >= 100) || (greenscore >= 100))
			return TRUE
		return FALSE

	if(allmig)
		return FALSE

	if(ttime >= GLOB.round_timer)
		if(roundvoteend)
			if(ttime >= round_ends_at)
				for(var/mob/living/carbon/human/H in GLOB.human_list)
					if(H.stat != DEAD)
						if(H.allmig_reward)
							H.adjust_triumphs(H.allmig_reward)
							H.allmig_reward = 0
				return TRUE
		else
			if(!SSvote.mode)
				SSvote.initiate_vote("endround", pick("Zlod", "Sun King", "Gaia", "Moon Queen", "Aeon", "Gemini", "Aries"))

	if(headrebdecree)
		if(reb_end_time == 0)
			to_chat(world, span_boldannounce("The peasant rebels took control of the throne, hail the new community!"))
			if(ttime >= INITIAL_ROUND_TIMER)
				reb_end_time = ttime + 15 MINUTES
				to_chat(world, span_boldwarning("The round will end in 15 minutes."))
			else
				reb_end_time = INITIAL_ROUND_TIMER
				to_chat(world, span_boldwarning("The round will end at the 2:30 hour mark."))
		if(ttime >= reb_end_time)
			return TRUE

	check_for_lord()
/*
	if(ttime > 180 MINUTES) //3 hour cutoff
		return TRUE*/

/datum/game_mode/chaosmode/proc/check_for_lord(forced = FALSE)
	if(!forced && world.time < next_check_lord)
		return
	next_check_lord = world.time + 1 MINUTES
	var/lord_found = FALSE
	var/lord_dead = FALSE
	for(var/mob/living/carbon/human/H in GLOB.human_list)
		if(H.mind)
			if(H.job == "Monarch")
				lord_found = TRUE
				if(H.stat == DEAD)
					lord_dead = TRUE
				else
					if(lord_dead)
						lord_dead = FALSE
					break
	if(lord_dead || !lord_found)
		if(!missing_lord_time)
			missing_lord_time = world.time
		if(world.time > missing_lord_time + 10 MINUTES)
			missing_lord_time = world.time
			addomen(OMEN_NOLORD)
		return FALSE
	else
		return TRUE

/datum/game_mode/chaosmode/pre_setup()
	if(allmig || roguefight)
		return TRUE
	for(var/A in GLOB.special_roles_rogue)
		allantags |= get_players_for_role(A)

	return TRUE

/datum/game_mode/proc/after_DO()
	return

/datum/game_mode/chaosmode/after_DO()
	if(allmig || roguefight)
		return TRUE
	if(SSticker.manualmodes)
		forcedmodes |= SSticker.manualmodes

	if(forcedmodes.len)
		message_admins("Manual gamemodes selected.")
		for(var/G in forcedmodes)
			switch(G)
				if("Rebellion")
					pick_rebels()
					message_admins("The Peasant Rebellion has been force selected to spawn.")
					log_game("Major Antagonist: Rebellion")
				if("Vampires and Werewolves")
					pick_vampires()
					pick_werewolves()
					message_admins("Vampires and Werewolves have been force selected to spawn.")
					log_game("Major Antagonist: Vampires and Werewolves")
				if("Vampires")
					pick_vampires()
					log_game("Major Antagonist: Vampires")
				if("Werewolves")
					pick_werewolves()
					log_game("Major Antagonist: Werewolves")
				if("Bandits")
					pick_bandits()
					message_admins("Bandits have been force selected to spawn.")
					log_game("Minor Antagonist: Bandit")
				if("Aspirants")
					pick_aspirants()
					message_admins("The Aspirant has been force selected to spawn.")
					log_game("Minor Antagonist: Aspirant")
				if("Maniac")
					pick_maniac()
					message_admins("The Maniac has been force selected to spawn.")
					log_game("Minor Antagonist: Maniac")
				if("Lich")
					pick_lich()
					message_admins("The Lich has been force selected to spawn.")
					log_game("Minor Antagonist: Lich")
				if("Cultists")
					pick_cultist()
					message_admins("The Zizoid cult has been foce selected to spawn.")
					log_game("Major Antagonist: Cultists")
				if("None")
					message_admins("No antagonist will be selected.")
					log_game("Major Antagonist: None")
		return TRUE

	var/major_roll = pick(1,2,3,4,5,6,7)
	switch(major_roll)
		if(1)
			pick_rebels()
			message_admins("The Peasnat Rebellion has been selected as a major antagonist.")
			log_game("Major Antagonist: Peasant Rebellion")
		if(2)
			pick_cultist()
			message_admins ("The Zizoid cult has been selected as a major antagonist.")
			log_game("Major Antagonist: Cultists")
		if(3)
			//WWs and Vamps now normally roll together
			message_admins("Werewolves against Vampire has been selected as the major antagonists.")
			pick_vampires()
			pick_werewolves()
			log_game("Major Antagonist: Vampires and Werewolves")
		if(4)
			pick_vampires()
			log_game("Major Antagonist: Vampires")
		if(5)
			pick_werewolves()
			log_game("Major Antagonist: Werewolves")
		if(6)
			pick_lich()
			log_game("Major Antagonist: Lich")
		if(7)
			log_game("Major Antagonist: None")

	if(prob(80))
		pick_bandits()
		message_admins("Bandits have been selected as a minor antagonist.")
		log_game("Minor Antagonist: Bandit")

	if(prob(45))
		pick_aspirants()
		message_admins("Aspirants have been selected as a minor antagonist.")
		log_game("Minor Antagonist: Aspirant")

	if(prob(10))
		pick_maniac()
		message_admins("The Maniac has been selected as a minor antagonist.")
		log_game("Minor Antagonist: Maniac")

	return TRUE

/datum/game_mode/chaosmode/proc/pick_bandits()
	//BANDITS
	banditgoal = rand(200,400)
	restricted_jobs = list("Monarch",
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
	"Veteran")

	var/num_bandits = 0
	if(num_players() >= 12)
		// 1 bandit per 12 players,
		num_bandits = round(num_players() / 12)
		if(num_bandits >= 8)	//caps bandits at 8
			num_bandits = 8
		var/datum/job/bandit_job = SSjob.GetJob("Bandit")
		bandit_job.total_positions = num_bandits
		bandit_job.spawn_positions = num_bandits
		banditgoal += (num_bandits * rand(200,400))


	if(num_bandits)
		//antag_candidates = get_players_for_role(ROLE_BANDIT, pre_do=TRUE) //pre_do checks for their preferences since they don't have a job yet
		/*
			Lets go over some things here to whomever sees this from my observations (which may be incorrect).

			The other modes (that aren't this) choose antags in pre_setup() which makes the restricted_jobs list work as its checked in DivideOccupations()
			DivideOccupations() occurs and checks it right after the current mode pre_setup() call on SSticker
			Then we call this brand new after_DO() proc AFTER the jobs have been assigned to the mind/checks occur on SSticker via DivideOccupations()
			In after_DO() we go through all the mode/antag selection instructions linking into these pick_antag() procs
			All the characters are made and equipped in the instruction sets between now and post_setup()
			Then the post_setup() proc which is called on SSticker doles out the antag datums from anything stuck into the pre_antag lists here
			Both pre_setup() and post_setup() get called within the Setup() proc in SSticker at earlier and later timings.

			Also the pre_do param only checks to see if a job preference is set to HIGH,
			so if it was working a medium priority duke would still get shunted into a bandit.
			Along with that every person who has a restricted job set to HIGH would also just get rejected from it.

			Also to note, we check the restricted jobs list on the mind in get_players_for_role() too
			Except all these pick procs also set the list after the assignment/use of it too.
			And the get_players_for_role in pre_setup to put them into the allantags list to be sorted in the pick procs also has no restricted_jobs list on mind at that point also

		*/
		antag_candidates = get_players_for_role(ROLE_BANDIT)
		if(antag_candidates.len)
			for(var/i = 0, i < num_bandits, ++i)
				var/datum/mind/candidate = pick_n_take(antag_candidates)
				if(!candidate) // no candidates left as it cuts the list and sends something back
					break
				if(!(candidate in allantags)) // We don't want to double dip... I guess? Two birds one stone tho, A already bandit check would check pre_bandits
					continue
				if(candidate.assigned_role in GLOB.noble_positions) // Job cat string stoppers
					continue
				if(candidate.assigned_role in GLOB.church_positions) // Many of these guys vanishing would suck
					continue
				if(candidate.assigned_role in GLOB.garrison_positions)
					continue

				allantags -= candidate
				pre_bandits += candidate

				SSjob.AssignRole(candidate.current, "Bandit")

				candidate.restricted_roles = restricted_jobs.Copy() // For posterities sake
				testing("[key_name(candidate)] has been selected as a bandit")
				log_game("[key_name(candidate)] has been selected as a bandit")
			for(var/antag in pre_bandits)
				GLOB.pre_setup_antags |= antag
			restricted_jobs = list() // We empty it here, but its also getting a new list on every relevant other pick proc rn so lol


/datum/game_mode/chaosmode/proc/pick_aspirants()
	var/list/possible_jobs_aspirants = list("Consort" ,"Hand" ,"Prince" ,"Captain", "Steward", "Court Magician","Archivist","Town Elder")
	var/list/possible_jobs_helpers = list("Consort" ,"Hand" ,"Prince" ,"Captain" ,"Steward" ,"Court Magician ","Archivist", "Royal Knight", "Town Elder","Veteran")
	var/list/rolesneeded = list("Aspirant","Loyalist","Supporter")

	antag_candidates = get_players_for_role(ROLE_ASPIRANT)
	for(var/R in rolesneeded)
		for(var/datum/mind/couper in antag_candidates) // Aspirant first
			switch(R)
				if("Aspirant")
					if(couper.assigned_role in possible_jobs_aspirants)
						antag_candidates -= couper
						pre_aspirants += couper
						couper.special_role = ROLE_ASPIRANT
						rolesneeded -= R
						testing("[key_name(couper)] has been selected as an Aspirant")
						message_admins("The Aspirant has selected.")
						log_game("[key_name(couper)] has been selected as a Aspirant")
					else continue
				if("Supporter")
					if(couper.assigned_role in possible_jobs_helpers)
						antag_candidates -= couper
						pre_aspirants += couper
						couper.special_role = "Supporter"
						rolesneeded -= R
						testing("[key_name(couper)] has been selected as a Supporter")
						message_admins("The Aspirant supports have been selected.")
						log_game("[key_name(couper)] has been selected as a Supporter")
					else continue
				if("Loyalist")
					if(couper.assigned_role in possible_jobs_helpers)
						antag_candidates -= couper
						pre_aspirants += couper
						couper.special_role = "Loyalist"
						rolesneeded -= R
						testing("[key_name(couper)] has been selected as a Loyalist")
						message_admins("The Loyalists have been selected.")
						log_game("[key_name(couper)] has been selected as a Loyalist")
					else continue


/datum/game_mode/chaosmode/proc/pick_rebels()
	restricted_jobs = list() //handled after picking
	var/num_rebels = 0
	if(num_players() >= 10)
		num_rebels = CLAMP(round(num_players() / 3), 1, 3)
	if(num_rebels)
		antag_candidates = get_players_for_role(ROLE_PREBEL)
		if(antag_candidates.len)
			for(var/i = 0, i < num_rebels, ++i)
				var/datum/mind/rebelguy = pick_n_take(antag_candidates)
				if(!rebelguy)
					continue
				var/blockme = FALSE
				if(!(rebelguy in allantags))
					blockme = TRUE
				if(rebelguy.assigned_role in GLOB.garrison_positions)
					blockme = TRUE
				if(rebelguy.assigned_role in GLOB.noble_positions)
					blockme = TRUE
				if(rebelguy.assigned_role in GLOB.church_positions)
					blockme = TRUE
				if(blockme)
					continue
				allantags -= rebelguy
				pre_rebels += rebelguy
				rebelguy.special_role = "Peasant Rebel"
				testing("[key_name(rebelguy)] has been selected as a Peasant Rebel")
				log_game("[key_name(rebelguy)] has been selected as a Peasant Rebel")
	for(var/antag in pre_rebels)
		GLOB.pre_setup_antags |= antag
	restricted_jobs = list()

/datum/game_mode/chaosmode/proc/pick_maniac()
	restricted_jobs = list("Monarch",
	"Consort")
	antag_candidates = get_players_for_role(ROLE_VILLAIN)
	var/datum/mind/villain = pick_n_take(antag_candidates)
	if(villain)
		var/blockme = FALSE
		if(!(villain in allantags))
			blockme = TRUE
		if(blockme)
			return
		allantags -= villain
		pre_villains += villain
		villain.special_role = ROLE_VILLAIN
		villain.restricted_roles = restricted_jobs.Copy()
		testing("[key_name(villain)] has been selected as the [villain.special_role]")
		log_game("[key_name(villain)] has been selected as the [villain.special_role]")
	for(var/antag in pre_villains)
		GLOB.pre_setup_antags |= antag
	restricted_jobs = list()

/datum/game_mode/chaosmode/proc/pick_cultist()
	var/remaining = 3 // 1 heresiarch, 2 cultists
	restricted_jobs = list("Monarch",
	"Bandit",
	"Assasin",
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
	"Veteran",
	"Templar",
	"Acolytes",
	"Apothecary")
	antag_candidates = get_players_for_role(ROLE_ZIZOIDCULTIST)
	antag_candidates = shuffle(antag_candidates)
	for(var/datum/mind/villain in antag_candidates)
		if(!remaining)
			break
		var/blockme = FALSE
		if(!(villain in allantags))
			blockme = TRUE
		if(blockme)
			return
		allantags -= villain
		pre_cultists += villain
		villain.special_role = "cultist"
		villain.restricted_roles = restricted_jobs.Copy()
		testing("[key_name(villain)] has been selected as the [villain.special_role]")
		log_game("[key_name(villain)] has been selected as the [villain.special_role]")
		antag_candidates.Remove(villain)
		remaining -= 1
	for(var/antag in pre_cultists)
		GLOB.pre_setup_antags |= antag
	restricted_jobs = list()

/datum/game_mode/chaosmode/proc/pick_lich()

	restricted_jobs = list(
	"Monarch",
	"Consort",
	"Dungeoneer",
	"Inquisitor",
	"Men-at-arms",
	"Priest",
	"Acolyte",
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
	"Dungeoneer",
	"Forest Warden",
	"Adepts",
	"Forest Guard",
	"Squire",
	"Veteran",
	"Mercenary",
	"Apothecary"
	)
	antag_candidates = get_players_for_role(ROLE_LICH)
	var/datum/mind/lichman = pick_n_take(antag_candidates)
	if(lichman)
		var/blockme = FALSE
		if(!(lichman in allantags))
			blockme = TRUE
		if(blockme)
			return
		allantags -= lichman
		pre_liches += lichman
		lichman.special_role = ROLE_LICH
		lichman.restricted_roles = restricted_jobs.Copy()
		testing("[key_name(lichman)] has been selected as the [lichman.special_role]")
		log_game("[key_name(lichman)] has been selected as the [lichman.special_role]")
	for(var/antag in pre_liches)
		GLOB.pre_setup_antags |= antag
	restricted_jobs = list()

/datum/game_mode/chaosmode/proc/pick_vampires()
	var/vampsremaining = 3
	restricted_jobs = list(
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
	"Apothecary")

	antag_candidates = get_players_for_role(ROLE_NBEAST)
	antag_candidates = shuffle(antag_candidates)
	for(var/datum/mind/vampire in antag_candidates)
		if(!vampsremaining)
			break
		var/blockme = FALSE
		if(!(vampire in allantags))
			blockme = TRUE
		if(vampire.assigned_role in GLOB.noble_positions)
			continue
		if(blockme)
			continue

		allantags -= vampire
		pre_vampires += vampire
		vampire.special_role = "vampire"
		vampire.assigned_role = "vampire" // This is a tricky way to prevent double-spawning for the spawn as multiple jobs.
		vampire.restricted_roles = restricted_jobs.Copy()
		testing("[key_name(vampire)] has been selected as a VAMPIRE")
		log_game("[key_name(vampire)] has been selected as a [vampire.special_role]")
		antag_candidates.Remove(vampire)
		vampsremaining -= 1
	for(var/antag in pre_vampires)
		GLOB.pre_setup_antags |= antag
	restricted_jobs = list()

/datum/game_mode/chaosmode/proc/pick_werewolves()
	// Ideally we want adventurers/pilgrims/towners to roll it
	restricted_jobs = list(
	"Monarch",
	"Consort",
	"Dungeoneer",
	"Inquisitor",
	"Men-at-Arms",
	"Priest",
	"Acolyte",
	"Adepts",
	"Templar",
	"Mercenary",
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
	"Priest",
	"Royal Knight",
	"Garrison Guard",
	"Jailor",
	"Court Magician",
	"Men-at-arms",
	"Forest Warden",
	"Inquisitor",
	"Adepts",
	"Forest Guard",
	"Squire",
	"Veteran",
	"Apothecary")

	var/num_werewolves = rand(1,2)
	antag_candidates = get_players_for_role(ROLE_WEREWOLF)
	antag_candidates = shuffle(antag_candidates)

	for(var/datum/mind/werewolf in antag_candidates)
		if(!num_werewolves)
			break
		var/blockme = FALSE
		if(!(werewolf in allantags))
			blockme = TRUE
		if(werewolf.assigned_role in GLOB.noble_positions)
			continue
		if(blockme)
			return
		allantags -= werewolf
		pre_werewolves += werewolf
		werewolf.special_role = ROLE_WEREWOLF
		//werewolf.assigned_role = ROLE_WEREWOLF
		werewolf.restricted_roles = restricted_jobs.Copy()
		testing("[key_name(werewolf)] has been selected as a WEREWOLF")
		log_game("[key_name(werewolf)] has been selected as a [werewolf.special_role]")
		antag_candidates.Remove(werewolf)
		num_werewolves -= 1
	for(var/antag in pre_werewolves)
		GLOB.pre_setup_antags |= antag
	restricted_jobs = list()

/datum/game_mode/chaosmode/post_setup()
	set waitfor = FALSE
///////////////// VILLAINS
	for(var/datum/mind/traitor in pre_villains)
		var/datum/antagonist/new_antag = new /datum/antagonist/maniac()
		addtimer(CALLBACK(traitor, TYPE_PROC_REF(/datum/mind, add_antag_datum), new_antag), rand(10,100))
		GLOB.pre_setup_antags -= traitor
		villains += traitor

///////////////// CULTIST

	pre_cultists = shuffle(pre_cultists)
	var/cultlordpicked = FALSE
	for(var/datum/mind/cultist in pre_cultists)
		if(!cultlordpicked)
			var/datum/antagonist/new_antag = new /datum/antagonist/zizocultist/leader()
			addtimer(CALLBACK(cultist, TYPE_PROC_REF(/datum/mind, add_antag_datum), new_antag), rand(10,100))
			GLOB.pre_setup_antags -= cultist
			cultists += cultist
			cultlordpicked = TRUE
		else
			var/datum/antagonist/new_antag = new /datum/antagonist/zizocultist()
			addtimer(CALLBACK(cultist, TYPE_PROC_REF(/datum/mind, add_antag_datum), new_antag), rand(10,100))
			GLOB.pre_setup_antags -= cultist
			cultists += cultist

///////////////// LICH
	for(var/datum/mind/lichman in pre_liches)
		var/datum/antagonist/new_antag = new /datum/antagonist/lich()
		addtimer(CALLBACK(lichman, TYPE_PROC_REF(/datum/mind, add_antag_datum), new_antag), rand(10,100))
		GLOB.pre_setup_antags -= lichman
		liches += lichman

///////////////// WWOLF
	for(var/datum/mind/werewolf in pre_werewolves)
		var/datum/antagonist/new_antag = new /datum/antagonist/werewolf()
		//addtimer(CALLBACK(werewolf, TYPE_PROC_REF(/datum/mind, add_antag_datum), new_antag), rand(10,100))
		werewolf.add_antag_datum(new_antag)
		GLOB.pre_setup_antags -= werewolf
		werewolves += werewolf

///////////////// VAMPIRES
	pre_vampires = shuffle(pre_vampires)
	var/vamplordpicked = FALSE
	for(var/datum/mind/vampire in pre_vampires)
		if(!vamplordpicked)
			var/datum/antagonist/new_antag = new /datum/antagonist/vampirelord()
			addtimer(CALLBACK(vampire, TYPE_PROC_REF(/datum/mind, add_antag_datum), new_antag), rand(10,100))
			GLOB.pre_setup_antags -= vampire
			vampires += vampire
			vamplordpicked = TRUE
		else
			var/datum/antagonist/new_antag = new /datum/antagonist/vampirelord/lesser()
			addtimer(CALLBACK(vampire, TYPE_PROC_REF(/datum/mind, add_antag_datum), new_antag), rand(10,100))
			GLOB.pre_setup_antags -= vampire
			vampires += vampire
///////////////// BANDIT
	for(var/datum/mind/bandito in pre_bandits)
		GLOB.pre_setup_antags -= bandito
		bandits += bandito
		SSrole_class_handler.bandits_in_round = TRUE
///////////////// ASPIRANTS
	for(var/datum/mind/rogue in pre_aspirants) // Do the aspirant first, so the suppporter works right.
		if(rogue.special_role == ROLE_ASPIRANT)
			var/datum/antagonist/new_asp = new /datum/antagonist/aspirant()
			rogue.add_antag_datum(new_asp)
			aspirants += rogue
			pre_aspirants -= rogue
	for(var/datum/mind/rogue in pre_aspirants)
		switch(rogue.special_role)
			if("Loyalist")
				var/datum/antagonist/new_asp = new /datum/antagonist/aspirant/loyalist()
				rogue.add_antag_datum(new_asp)
				aspirants += rogue
				pre_aspirants -= rogue
			if("Supporter")
				var/datum/antagonist/new_asp = new /datum/antagonist/aspirant/supporter()
				rogue.add_antag_datum(new_asp)
				aspirants += rogue
				pre_aspirants -= rogue
	var/mob/living/duke = SSticker.rulermob
	if(duke)
		var/datum/antagonist/ruler = new /datum/antagonist/aspirant/ruler() // Do the duke last.
		duke.mind.add_antag_datum(ruler)

///////////////// REBELS
	for(var/datum/mind/rebelguy in pre_rebels)
		var/datum/antagonist/new_antag = new /datum/antagonist/prebel/head()
		rebelguy.add_antag_datum(new_antag)
		GLOB.pre_setup_antags -= rebelguy

	..()
	//We're not actually ready until all traitors are assigned.
	gamemode_ready = FALSE
	addtimer(VARSET_CALLBACK(src, gamemode_ready, TRUE), 101)
	return TRUE

/datum/game_mode/chaosmode/make_antag_chance(mob/living/carbon/human/character) //klatejoin
	return
	/*
	var/num_villains = round((num_players() * 0.30)+1, 1)
	if((villains.len + pre_villains.len) >= num_villains) //Upper cap for number of latejoin antagonists
		return
	if(ROLE_VILLAIN in character.client.prefs.be_special)
		if(!is_antag_banned(character.ckey, ROLE_VILLAIN) && !QDELETED(character))
			if(age_check(character.client))
				if(!(character.job in restricted_jobs))
					if(prob(66))
						add_latejoin_villain(character.mind)
	*/

/datum/game_mode/chaosmode/proc/vampire_werewolf()
	var/vampyr = 0
	var/wwoelf = 0
	for(var/mob/living/carbon/human/player in GLOB.human_list)
		if(player.mind)
			if(player.stat != DEAD)
				if(isbrain(player)) //also technically dead
					continue
				if(is_in_roguetown(player))
					var/datum/antagonist/D = player.mind.has_antag_datum(/datum/antagonist/werewolf)
					if(D && D.increase_votepwr)
						wwoelf++
						continue
					D = player.mind.has_antag_datum(/datum/antagonist/vampire)
					if(D && D.increase_votepwr)
						vampyr++
						continue
	if(vampyr)
		if(!wwoelf)
			return "vampire"
	if(wwoelf)
		if(!vampyr)
			return "werewolf"

/datum/game_mode/chaosmode/proc/add_latejoin_villain(datum/mind/character)
	var/datum/antagonist/maniac/new_antag = new /datum/antagonist/maniac()
	character.add_antag_datum(new_antag)
