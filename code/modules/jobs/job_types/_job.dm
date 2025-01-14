/datum/job
	//The name of the job , used for preferences, bans and more. Make sure you know what you're doing before changing this.
	var/title = "NOPE"

	//Job access. The use of minimal_access or access is determined by a config setting: config.jobs_have_minimal_access
	var/list/minimal_access = list()		//Useful for servers which prefer to only have access given to the places a job absolutely needs (Larger server population)
	var/list/access = list()				//Useful for servers which either have fewer players, so each person needs to fill more than one role, or servers which like to give more access, so players can't hide forever in their super secure departments (I'm looking at you, chemistry!)

	//Determines who can demote this position
	var/department_head = list()

	//Tells the given channels that the given mob is the new department head. See communications.dm for valid channels.
	var/list/head_announce = null

	//Bitflags for the job
	var/flag = NONE //Deprecated
	var/department_flag = NONE //Deprecated
	var/auto_deadmin_role_flags = NONE

	//Players will be allowed to spawn in as jobs that are set to "Station"
	var/faction = "None"

	//How many players can be this job
	var/total_positions = 0

	//How many players can spawn in as this job
	var/spawn_positions = 0

	//How many players have this job
	var/current_positions = 0

	//Whether this job clears a slot when you get a rename prompt.
	var/antag_job = FALSE

	//Supervisors, who this person answers to directly
	var/supervisors = ""

	//Sellection screen color
	var/selection_color = "#dbdce3"


	//If this is set to 1, a text is printed to the player when jobs are assigned, telling him that he should let admins know that he has to disconnect.
	var/req_admin_notify

	//If you have the use_age_restriction_for_jobs config option enabled and the database set up, this option will add a requirement for players to be at least minimal_player_age days old. (meaning they first signed in at least that many days before.)
	var/minimal_player_age = 0

	var/outfit = null
	var/outfit_female = null

	var/exp_requirements = 0

	var/exp_type = ""
	var/exp_type_department = ""

	//The amount of good boy points playing this role will earn you towards a higher chance to roll antagonist next round
	//can be overridden by antag_rep.txt config
	var/antag_rep = 10

	var/paycheck = PAYCHECK_MINIMAL
	var/paycheck_department = ACCOUNT_CIV

	var/list/mind_traits // Traits added to the mind of the mob assigned this job

	var/display_order = JOB_DISPLAY_ORDER_DEFAULT


	///Levels unlocked at roundstart in physiology
	var/list/roundstart_experience

	//allowed sex/race for picking
	var/list/allowed_sexes = list(MALE,FEMALE)
	var/list/allowed_races
	var/list/allowed_patrons
	var/list/allowed_ages = ALL_AGES_LIST

	/// Innate skill levels unlocked at roundstart. Format is list(/datum/skill/foo = SKILL_EXP_NOVICE) with exp as an integer or as per code/_DEFINES/skills.dm
	var/list/skills

	var/list/spells

	var/list/jobstats
	var/list/jobstats_f

	var/f_title = null

	var/job_greet_text = TRUE
	var/tutorial = null

	var/whitelist_req = FALSE

	var/banned_leprosy = TRUE
	var/banned_lunatic = TRUE

	var/bypass_lastclass = FALSE

	var/list/peopleiknow = list()
	var/list/peopleknowme = list()

	var/plevel_req = 0
	var/min_pq = -999

	var/show_in_credits = TRUE

	var/announce_latejoin = TRUE

	var/give_bank_account = FALSE

	var/can_random = TRUE

	/// Some jobs have unique combat mode music, because why not?
	var/cmode_music

	/// This job always shows on latechoices
	var/always_show_on_latechoices = FALSE

	/// This job has a cooldown if you died in it and attempt to rejoin as it
	var/same_job_respawn_delay = FALSE

	/// This job re-opens slots if someone dies as it
	var/job_reopens_slots_on_death = FALSE

/*
	How this works, its CTAG_DEFINE = amount_to_attempt_to_role
	EX: advclass_cat_rolls = list(CTAG_PILGRIM = 5, CTAG_ADVENTURER = 5)
	You will still need to contact the subsystem though
*/
	var/list/advclass_cat_rolls

	var/wanderer_examine = FALSE

	var/datum/charflaw/forced_flaw

	var/shows_in_list = TRUE

	///can we have apprentices?
	var/can_have_apprentices = TRUE
	///the skills and % of xp they should transfer over to apprentices as they are trained.
	var/list/trainable_skills = list()
	///the maximum amount of apprentices that the owner can have
	var/max_apprentices = 1
	///if this is set its the name bestowed to the new apprentice otherwise its just name the [job_name] apprentice.
	var/apprentice_name

/datum/job/proc/special_job_check(mob/dead/new_player/player)
	return TRUE

/client/proc/job_greet(datum/job/greeting_job)
	if(mob.job == greeting_job.title)
		greeting_job.greet(mob)

/datum/job/proc/greet(mob/player)
	if(player?.mind?.assigned_role != title)
		return
	if(!job_greet_text)
		return
	to_chat(player, span_notice("You are the <b>[title]</b>"))
	if(tutorial)
		to_chat(player, span_notice("*-----------------*"))
		to_chat(player, span_notice(tutorial))

//Only override this proc
//H is usually a human unless an /equip override transformed it
/datum/job/proc/after_spawn(mob/living/H, mob/M, latejoin = FALSE)
	//do actions on H but send messages to M as the key may not have been transferred_yet
	if(mind_traits)
		for(var/t in mind_traits)
			ADD_TRAIT(H.mind, t, JOB_TRAIT)
	var/list/roundstart_experience

	if(!ishuman(H))
		return

	if(can_have_apprentices)
		H.mind.apprentice_training_skills = trainable_skills.Copy()
		H.mind.max_apprentices = max_apprentices
		H.mind.apprentice_name = apprentice_name

	roundstart_experience = skills

	if(roundstart_experience)
		var/mob/living/carbon/human/experiencer = H
		for(var/i in roundstart_experience)
			experiencer.mind.adjust_experience(i, roundstart_experience[i], TRUE)

	add_spells(H)

	if(H.gender == FEMALE)
		if(jobstats_f)
			for(var/S in jobstats_f)
				H.change_stat(S, jobstats_f[S])
		else
			for(var/S in jobstats)
				H.change_stat(S, jobstats[S])
	else
		for(var/S in jobstats)
			H.change_stat(S, jobstats[S])

	for(var/X in peopleknowme)
		for(var/datum/mind/MF in get_minds(X))
			H.mind.person_knows_me(MF)
	for(var/X in peopleiknow)
		for(var/datum/mind/MF in get_minds(X))
			H.mind.i_know_person(MF)

	if(H.islatejoin && show_in_credits)
		var/used_title = title
		if((H.gender == FEMALE) && f_title)
			used_title = f_title
		scom_announce("[H.real_name] the [used_title] arrives from Kingsfield.")

	if(give_bank_account)
		if(give_bank_account > 1)
			SStreasury.create_bank_account(H, give_bank_account)
		else
			SStreasury.create_bank_account(H)

	if(show_in_credits)
		SScrediticons.processing += H

	if(cmode_music)
		H.cmode_music = cmode_music

/datum/job/proc/add_spells(mob/living/H)
	if(spells && H.mind)
		for(var/S in spells)
			if(H.mind.has_spell(S))
				continue
			H.mind.AddSpell(new S)

/datum/job/proc/remove_spells(mob/living/H)
	if(spells && H.mind)
		for(var/S in spells)
			if(!H.mind.has_spell(S))
				continue
			H.mind.RemoveSpell(S)

/mob/living/carbon/human/proc/add_credit()
	if(!mind || !client)
		return
	var/thename = "[real_name]"
	var/datum/job/J = SSjob.GetJob(mind.assigned_role)
	var/used_title
	if(J)
		used_title = J.title
		if(gender == FEMALE && J.f_title)
			used_title = J.f_title
	if(used_title)
		thename = "[real_name] the [used_title]"
	GLOB.credits_icons[thename] = list()
	var/client/C = client
	var/datum/preferences/P = C.prefs
	if(!P)
		return
	var/icon/I = get_flat_human_icon(null, J, P, DUMMY_HUMAN_SLOT_MANIFEST, list(SOUTH))
	if(I)
		var/icon/female_s = icon("icon"='icons/mob/clothing/under/masking_helpers.dmi', "icon_state"="credits")
		I.Blend(female_s, ICON_MULTIPLY)
		I.Scale(96,96)
		GLOB.credits_icons[thename]["icon"] = I
		GLOB.credits_icons[thename]["vc"] = voice_color

/datum/job/proc/announce(mob/living/carbon/human/H)

/datum/job/proc/override_latejoin_spawn(mob/living/carbon/human/H)		//Return TRUE to force latejoining to not automatically place the person in latejoin shuttle/whatever.
	return FALSE

//Used for a special check of whether to allow a client to latejoin as this job.
/datum/job/proc/special_check_latejoin(client/C)
	return TRUE

/datum/job/proc/GetAntagRep()
	. = CONFIG_GET(keyed_list/antag_rep)[lowertext(title)]
	if(. == null)
		return antag_rep

//Don't override this unless the job transforms into a non-human (Silicons do this for example)
/datum/job/proc/equip(mob/living/carbon/human/H, visualsOnly = FALSE, announce = TRUE, latejoin = FALSE, datum/outfit/outfit_override = null, client/preference_source)
	if(!H)
		return FALSE
	if(!visualsOnly)
		var/datum/bank_account/bank_account = new(H.real_name, src)
		bank_account.payday(STARTING_PAYCHECKS, TRUE)
		H.account_id = bank_account.account_id

	//Equip the rest of the gear
	H.dna.species.before_equip_job(src, H, visualsOnly)
	if(H.gender == FEMALE)
		if(outfit_override || outfit_female)
			H.equipOutfit(outfit_override ? outfit_override : outfit_female, visualsOnly)
		else if(outfit)
			H.equipOutfit(outfit, visualsOnly)
	else
		if(outfit_override || outfit)
			H.equipOutfit(outfit_override ? outfit_override : outfit, visualsOnly)

	H.dna.species.after_equip_job(src, H, visualsOnly)

	if(!visualsOnly && announce)
		announce(H)

/datum/job/proc/get_access()
	if(!config)	//Needed for robots.
		return src.minimal_access.Copy()

	. = list()

//If the configuration option is set to require players to be logged as old enough to play certain jobs, then this proc checks that they are, otherwise it just returns 1
/datum/job/proc/player_old_enough(client/C)
	if(available_in_days(C) == 0)
		return TRUE	//Available in 0 days = available right now = player is old enough to play.
	return FALSE


/datum/job/proc/available_in_days(client/C)
	if(!C)
		return 0
	if(!CONFIG_GET(flag/use_age_restriction_for_jobs))
		return 0
	if(!SSdbcore.Connect())
		return 0 //Without a database connection we can't get a player's age so we'll assume they're old enough for all jobs
	if(!isnum(minimal_player_age))
		return 0

	return max(0, minimal_player_age - C.player_age)

/datum/job/proc/config_check()
	return TRUE

/datum/job/proc/map_check()
	return TRUE

/datum/outfit/job
	name = "Standard Gear"

	var/jobtype = null

	back = /obj/item/storage/backpack


/datum/outfit/job/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/datum/job/J = SSjob.GetJobType(jobtype)
	if(!J)
		J = SSjob.GetJob(H.job)
