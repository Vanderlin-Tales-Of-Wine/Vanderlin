/datum/job/roguetown/armorsmith
	title = "Armorer"
	flag = BLACKSMITH
	department_flag = SERFS
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_races = ALL_PLAYER_RACES_BY_NAME

	tutorial = "You studied for many decades under your master with a few other apprentices to become an Armorer, a trade that certainly has seen a boom in revenue in recent times with many a bannerlord seeing the importance in maintaining a well-equipped army."

	outfit = /datum/outfit/job/roguetown/armorsmith
	display_order = JDO_ARMORER
	bypass_lastclass = TRUE
	give_bank_account = 30
	min_pq = 0

/datum/outfit/job/roguetown/armorsmith/pre_equip(mob/living/carbon/human/H)
	..()
	id = /obj/item/clothing/ring/silver/makers_guild
	head = /obj/item/clothing/head/roguetown/hatfur
	if(prob(50))
		head = /obj/item/clothing/head/roguetown/hatblu
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
		ADD_TRAIT(H, TRAIT_MALUMFIRE, TRAIT_GENERIC)
		if(H.age == AGE_OLD)
			H.mind?.adjust_skillrank(/datum/skill/craft/blacksmithing, pick(1,2), TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/armorsmithing, pick(1,2), TRUE)
	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/trou
		shoes = /obj/item/clothing/shoes/roguetown/simpleshoes/buckle
		shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
		belt = /obj/item/storage/belt/rogue/leather
		beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
		beltr = /obj/item/storage/keyring/armorsmith
		cloak = /obj/item/clothing/cloak/apron/brown
		H.change_stat(STATKEY_STR, 1)
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_SPD, -1)
	else
		pants = /obj/item/clothing/under/roguetown/trou
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/random
		shoes = /obj/item/clothing/shoes/roguetown/shortboots
		belt = /obj/item/storage/belt/rogue/leather
		cloak = /obj/item/clothing/cloak/apron/brown
		beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
		beltr = /obj/item/storage/keyring/armorsmith
		backl =	/obj/item/rogueweapon/hammer/sledgehammer
		H.change_stat(STATKEY_STR, 1)
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_SPD, -1)

/datum/job/roguetown/weaponsmith
	title = "Weaponsmith"
	flag = BLACKSMITH
	department_flag = SERFS
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_races = ALL_PLAYER_RACES_BY_NAME

	tutorial = "You studied for many decades under your master with a few other apprentices to become a Weaponsmith, a trade that is as ancient as the secrets of steel itself! You've repaired the blades of cooks, the cracked hoes of peasants and greased the spears of many soldiers into war."

	outfit = /datum/outfit/job/roguetown/weaponsmith
	display_order = JDO_WSMITH
	give_bank_account = 30
	min_pq = 0

/datum/outfit/job/roguetown/weaponsmith/pre_equip(mob/living/carbon/human/H)
	..()
	id = /obj/item/clothing/ring/silver/makers_guild
	head = /obj/item/clothing/head/roguetown/hatfur
	if(prob(50))
		head = /obj/item/clothing/head/roguetown/hatblu
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
		ADD_TRAIT(H, TRAIT_MALUMFIRE, TRAIT_GENERIC)
		if(H.age == AGE_OLD)
			H.mind?.adjust_skillrank(/datum/skill/craft/blacksmithing, pick(1,2), TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/weaponsmithing, pick(1,2), TRUE)
	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/trou
		shoes = /obj/item/clothing/shoes/roguetown/boots/leather
		shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
		belt = /obj/item/storage/belt/rogue/leather
		beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
		beltr = /obj/item/storage/keyring/weaponsmith
		cloak = /obj/item/clothing/cloak/apron/brown
		backl =	/obj/item/rogueweapon/hammer/sledgehammer
		H.change_stat(STATKEY_STR, 1)
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_SPD, -1)
	else
		pants = /obj/item/clothing/under/roguetown/trou
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/random
		shoes = /obj/item/clothing/shoes/roguetown/shortboots
		belt = /obj/item/storage/belt/rogue/leather
		cloak = /obj/item/clothing/cloak/apron/brown
		beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
		beltr = /obj/item/storage/keyring/weaponsmith
		H.change_stat(STATKEY_STR, 1)
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_SPD, -1)
