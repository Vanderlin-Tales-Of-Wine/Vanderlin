/datum/job/pilgrim
	title = "Pilgrim"
	flag = SK_PILGRIM	// STONEKEEP EDIT
	department_flag = OUTSIDERS	// STONEKEEP EDIT
	faction = "Station"
//	total_positions = -1	// STONEKEEP EDIT
	total_positions = 20
	spawn_positions = 20
	allowed_races = ALL_STONEKEEP_PLAYER_RACES	// STONEKEEP EDIT
	tutorial = "Pilgrims begin far outside of the town and must reach it in order to ply their various trades. Sometimes, they build their own settlements and enjoy the terrible nature."

	outfit = null
	outfit_female = null
	banned_leprosy = FALSE
	advclass_cat_rolls = list(CTAG_PILGRIM = 15)

	display_order = PILGRIM_ORDER	// STONEKEEP EDIT
	min_pq = -20
	always_show_on_latechoices = TRUE
	same_job_respawn_delay = 0
	bypass_lastclass = TRUE
	can_have_apprentices = FALSE


/datum/job/pilgrim/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		if(advclass_cat_rolls)
			hugboxify_for_class_selection(H)
