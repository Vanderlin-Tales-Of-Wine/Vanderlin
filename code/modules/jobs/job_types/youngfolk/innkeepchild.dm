/datum/job/innkeep_son
	title = "Innkeepers Son"
	f_title = "Innkeepers Daughter"
	tutorial = "One nite the Innkeeper took you in during a harsh winter, \
	you've been thankful ever since." //rewrite probably?
	flag = INNKEEPCHILD
	department_flag = YOUNGFOLK
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_INNKEEP_CHILD
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	min_pq = -5
	bypass_lastclass = TRUE

	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_CHILD)
	allowed_races = RACES_PLAYER_ALL

	outfit = /datum/outfit/job/innkeep_son
	can_have_apprentices = FALSE
	cmode_music = 'sound/music/cmode/towner/CombatInn.ogg'

/datum/outfit/job/innkeep_son
	job_bitflag = BITFLAG_CONSTRUCTOR

/datum/outfit/job/innkeep_son/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/stealing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.change_stat(STATKEY_END, 1)
		H.change_stat(STATKEY_STR, -1)
		H.change_stat(STATKEY_CON, -1)
	pants = /obj/item/clothing/pants/tights/random
	shirt = /obj/item/clothing/shirt/shortshirt/random
	shoes = /obj/item/clothing/shoes/shortboots
	belt = /obj/item/storage/belt/leather
	beltl = /obj/item/storage/belt/pouch/coins/poor
	neck = /obj/item/storage/keyring/innkeep
	if(H.gender == MALE)
		cloak = /obj/item/clothing/cloak/apron/waist
	else
		armor = /obj/item/clothing/shirt/dress
