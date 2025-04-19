/datum/job/armorsmith
	title = "Armorer"
	tutorial = "You studied for many decades under your master with a few other apprentices to become an Armorer, \
	a trade that certainly has seen a boom in revenue in recent times with many a bannerlord\
	seeing the importance in maintaining a well-equipped army."
	flag = BLACKSMITH
	department_flag = SERFS
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	min_pq = 0
	bypass_lastclass = TRUE

	allowed_races = RACES_PLAYER_ALL

	outfit = /datum/outfit/job/armorsmith
	display_order = JDO_ARMORER
	give_bank_account = 30

/datum/outfit/job/armorsmith
	job_bitflag = BITFLAG_CONSTRUCTOR

/datum/outfit/job/armorsmith/pre_equip(mob/living/carbon/human/H)
	..()
	ring = /obj/item/clothing/ring/silver/makers_guild
	head = /obj/item/clothing/head/hatfur
	if(prob(50))
		head = /obj/item/clothing/head/hatblu
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/blacksmithing, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/armorsmithing, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/weaponsmithing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/smelting, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/engineering, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/traps, 2, TRUE) // For craftable beartraps
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/mathematics, 2, TRUE)
		ADD_TRAIT(H, TRAIT_MALUMFIRE, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_SEEPRICES, TRAIT_GENERIC)
		if(H.age == AGE_OLD)
			H.mind?.adjust_skillrank(/datum/skill/craft/blacksmithing, pick(1,2), TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/armorsmithing, pick(1,2), TRUE)
	if(H.gender == MALE)
		pants = /obj/item/clothing/pants/trou
		shoes = /obj/item/clothing/shoes/simpleshoes/buckle
		shirt = /obj/item/clothing/shirt/shortshirt
		belt = /obj/item/storage/belt/leather
		beltl = /obj/item/storage/belt/pouch/coins/poor
		beltr = /obj/item/key/blacksmith
		cloak = /obj/item/clothing/cloak/apron/brown
		H.change_stat(STATKEY_STR, 1)
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_SPD, -1)
	else
		pants = /obj/item/clothing/pants/trou
		armor = /obj/item/clothing/shirt/dress/gen/random
		shoes = /obj/item/clothing/shoes/shortboots
		belt = /obj/item/storage/belt/leather
		cloak = /obj/item/clothing/cloak/apron/brown
		beltl = /obj/item/storage/belt/pouch/coins/poor
		beltr = /obj/item/key/blacksmith
		backl =	/obj/item/weapon/hammer/sledgehammer
		H.change_stat(STATKEY_STR, 1)
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_SPD, -1)

/datum/job/weaponsmith
	title = "Weaponsmith"
	tutorial = "You studied for many decades under your master with a few other apprentices to become a Weaponsmith, \
	a trade that is as ancient as the secrets of steel itself! \
	You've repaired the blades of cooks, the cracked hoes of peasants and greased the spears of many soldiers into war."
	flag = BLACKSMITH
	department_flag = SERFS
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1

	allowed_races = RACES_PLAYER_ALL

	outfit = /datum/outfit/job/weaponsmith
	display_order = JDO_WSMITH
	give_bank_account = 30
	min_pq = 0

/datum/outfit/job/weaponsmith
	job_bitflag = BITFLAG_CONSTRUCTOR

/datum/outfit/job/weaponsmith/pre_equip(mob/living/carbon/human/H)
	..()
	ring = /obj/item/clothing/ring/silver/makers_guild
	head = /obj/item/clothing/head/hatfur
	if(prob(50))
		head = /obj/item/clothing/head/hatblu
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/blacksmithing, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/armorsmithing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/weaponsmithing, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/smelting, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/engineering, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/traps, 2, TRUE) // For craftable beartraps
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/mathematics, 2, TRUE)
		ADD_TRAIT(H, TRAIT_MALUMFIRE, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_SEEPRICES, TRAIT_GENERIC)
		if(H.age == AGE_OLD)
			H.mind?.adjust_skillrank(/datum/skill/craft/blacksmithing, pick(1,2), TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/weaponsmithing, pick(1,2), TRUE)
	if(H.gender == MALE)
		pants = /obj/item/clothing/pants/trou
		shoes = /obj/item/clothing/shoes/boots/leather
		shirt = /obj/item/clothing/shirt/shortshirt
		belt = /obj/item/storage/belt/leather
		beltl = /obj/item/storage/belt/pouch/coins/poor
		beltr = /obj/item/key/blacksmith
		cloak = /obj/item/clothing/cloak/apron/brown
		backl =	/obj/item/weapon/hammer/sledgehammer
		H.change_stat(STATKEY_STR, 1)
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_SPD, -1)
	else
		pants = /obj/item/clothing/pants/trou
		armor = /obj/item/clothing/shirt/dress/gen/random
		shoes = /obj/item/clothing/shoes/shortboots
		belt = /obj/item/storage/belt/leather
		cloak = /obj/item/clothing/cloak/apron/brown
		beltl = /obj/item/storage/belt/pouch/coins/poor
		beltr = /obj/item/key/blacksmith
		H.change_stat(STATKEY_STR, 1)
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_SPD, -1)
