/datum/job/pilgrim
	title = "Pilgrim"
	tutorial = "As a Pilgrim, you begin far outside the safety of the city and must reach it in order to ply your trade. \
	Alternatively, you can build your own settlement and enjoy the terrible dangers nature has to offer."
	flag = ADVENTURER
	department_flag = OUTSIDERS
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_PILGRIM
	faction = FACTION_STATION
	total_positions = 20
	spawn_positions = 20
	min_pq = -20
	banned_leprosy = FALSE
	bypass_lastclass = TRUE

	allowed_races = RACES_PLAYER_ALL

	outfit = null
	outfit_female = null
	advclass_cat_rolls = list(CTAG_PILGRIM = 15)

	same_job_respawn_delay = 0
	can_have_apprentices = FALSE
	selection_color = "#a33096"

/datum/job/pilgrim/after_spawn(mob/living/spawned, client/player_client)
	..()
	if(advclass_cat_rolls)
		hugboxify_for_class_selection(spawned)
