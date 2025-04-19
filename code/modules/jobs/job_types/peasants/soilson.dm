/datum/job/farmer
	title = "Soilson"
	f_title = "Soilbride"
	tutorial = "It is a simple life you live. \
	Your basic understanding of life is something many would be envious of if they knew how perfect it was. \
	You know a good day's work, the sweat on your brow is yours: \
	Famines and plague may take its toll, but you know how to celebrate life well. \
	Till the soil and produce fresh food for those around you, and maybe you'll be more than an unsung hero someday."
	flag = FARMER
	department_flag = PEASANTS
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_SOILSON
	faction = FACTION_STATION
	total_positions = 11
	spawn_positions = 11
	min_pq = -100
	bypass_lastclass = TRUE
	selection_color = "#553e01"

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_PLAYER_ALL

	outfit = /datum/outfit/job/farmer
	give_bank_account = 20
	cmode_music = 'sound/music/cmode/towner/CombatTowner.ogg'

/datum/outfit/job/farmer
	job_bitflag = BITFLAG_CONSTRUCTOR

/datum/outfit/job/farmer/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, pick(2,3), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/farming, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/taming, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE) // TODO! A way for them to operate submission holes without reading skill. Soilsons shouldn't be able to read.
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		if(prob(5))
			H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/swimming, pick(0,1,1), TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/labor/farming, 2, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/labor/butchering, 2, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/tanning, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/labor/taming, 2, TRUE)
			H.change_stat(STATKEY_STR, 1)
			H.change_stat(STATKEY_END, 1)
		H.change_stat(STATKEY_STR, 1)
		H.change_stat(STATKEY_CON, 1)
		H.change_stat(STATKEY_END, 1)
		H.change_stat(STATKEY_INT, -1)
		ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_SEEDKNOW, TRAIT_GENERIC)

	neck = /obj/item/storage/belt/pouch/coins/poor
	if(H.gender == MALE)
		head = /obj/item/clothing/head/roguehood/random
		if(prob(50))
			head = /obj/item/clothing/head/strawhat
		pants = /obj/item/clothing/pants/tights/random
		armor = /obj/item/clothing/armor/gambeson/light/striped
		shirt = /obj/item/clothing/shirt/undershirt/random
		shoes = /obj/item/clothing/shoes/simpleshoes
		belt = /obj/item/storage/belt/leather/rope
		beltr = /obj/item/key/soilson
		beltl = /obj/item/weapon/knife/villager
	else
		head = /obj/item/clothing/head/armingcap
		armor = /obj/item/clothing/shirt/dress/gen/random
		shirt = /obj/item/clothing/shirt/undershirt
		shoes = /obj/item/clothing/shoes/simpleshoes
		belt = /obj/item/storage/belt/leather/rope
		beltr = /obj/item/key/soilson
		beltl = /obj/item/weapon/knife/villager
