GLOBAL_LIST_EMPTY(billagerspawns)

GLOBAL_VAR_INIT(adventurer_hugbox_duration, 30 SECONDS)
GLOBAL_VAR_INIT(adventurer_hugbox_duration_still, 3 MINUTES)

/datum/job/roguetown/adventurer
	title = "Adventurer"
	flag = ADVENTURER
	department_flag = PEASANTS
	faction = "Station"
	total_positions = 14
	spawn_positions = 14
	allowed_races = ALL_PLAYER_RACES_BY_NAME
	tutorial = "Hero of nothing, adventurer by trade. Whatever led you to this fate is up to the wind to decide, and you've never fancied yourself for much other than the thrill. Someday your pride is going to catch up to you, and you're going to find out why most men don't end up in the annals of history."


	outfit = null
	outfit_female = null

	var/isvillager = FALSE
	var/ispilgrim = FALSE
	display_order = JDO_ADVENTURER
	show_in_credits = FALSE
	min_pq = 2
	always_show_on_latechoices = TRUE
	job_reopens_slots_on_death = TRUE
	same_job_respawn_delay = 15 MINUTES
	bypass_lastclass = TRUE
	advclass_cat_rolls = list(CTAG_ADVENTURER = 15)

	wanderer_examine = TRUE
	can_have_apprentices = FALSE


/datum/job/roguetown/adventurer/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		if(advclass_cat_rolls)
			hugboxify_for_class_selection(H)
