/datum/job/bandit //pysdon above there's like THREE bandit.dms now I'm so sorry. This one is latejoin bandits, the one in villain is the antag datum, and the one in the 'antag' folder is an old adventurer class we don't use. Good luck!
	title = "Bandit"
	tutorial = "Long ago you did a crime \
	worthy of your bounty being hung on the wall outside of the local inn. \
	You now live with your fellow free men in the bog, and generally get up to no good."
	flag = BANDIT
	department_flag = PEASANTS
	job_flags = (NONE)
	display_order = JDO_BANDIT
	faction = FACTION_STATION
	total_positions = 0
	spawn_positions = 0
	min_pq = 4
	antag_job = TRUE

	allowed_races = ALL_PLAYER_RACES_BY_NAME

	outfit = null
	outfit_female = null

	advclass_cat_rolls = list(CTAG_BANDIT = 20)

	wanderer_examine = TRUE
	job_reopens_slots_on_death = FALSE //no endless stream of bandits, unless the migration waves deem it so
	same_job_respawn_delay = 30 MINUTES

	can_have_apprentices = FALSE
	cmode_music = 'sound/music/cmode/antag/combat_bandit2.ogg'


<<<<<<<< HEAD:code/modules/jobs/job_types/adventurer/bandit.dm
/datum/job/bandit/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
========
/datum/job/roguetown/bandit/after_spawn(mob/living/spawned, client/player_client)
>>>>>>>> b1eb9db47 (oh my god):code/modules/jobs/job_types/roguetown/villains/bandit.dm
	..()
	var/mob/living/carbon/human/H = spawned
	if(!H.mind)
		return
	H.advsetup = 1
	H.invisibility = INVISIBILITY_MAXIMUM
	H.become_blind("advsetup")
	H.ambushable = FALSE

/datum/outfit/job/bandit/post_equip(mob/living/carbon/human/H)
	..()
	var/datum/antagonist/new_antag = new /datum/antagonist/bandit()
	H.mind.add_antag_datum(new_antag)
	addtimer(CALLBACK(H, TYPE_PROC_REF(/mob/living/carbon/human, choose_name_popup), "BANDIT"), 5 SECONDS)
