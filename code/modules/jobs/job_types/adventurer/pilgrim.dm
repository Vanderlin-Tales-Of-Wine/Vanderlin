/datum/job/pilgrim
	title = "Pilgrim"
	tutorial = "Pilgrims begin far outside of the town and must reach it in order to ply their various trades. \
	Sometimes, they build their own settlements and enjoy the terrible nature."
	flag = ADVENTURER
	department_flag = PEASANTS
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_PILGRIM
	faction = FACTION_STATION
	total_positions = 20
	spawn_positions = 20
	min_pq = -20
	banned_leprosy = FALSE
	bypass_lastclass = TRUE

	allowed_races = ALL_PLAYER_RACES_BY_NAME

	outfit = null
	outfit_female = null
	advclass_cat_rolls = list(CTAG_PILGRIM = 15)

	same_job_respawn_delay = 0
	can_have_apprentices = FALSE

/datum/job/pilgrim/after_spawn(mob/living/spawned, client/player_client)
	..()
	if(advclass_cat_rolls)
		hugboxify_for_class_selection(spawned)
