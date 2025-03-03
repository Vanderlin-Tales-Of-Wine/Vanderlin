/datum/job/roguetown/armorsmith
	title = "Blacksmith"
	flag = BLACKSMITH
	department_flag = SERFS
	faction = "Station"
	total_positions = 2
	spawn_positions = 2

	allowed_races = ALL_PLAYER_RACES_BY_NAME

	tutorial = "Yours is a busy life, a churning forge, the ring of hammer on anvil, the hiss of quenched steel, \
				these are the sounds you live by. You will never starve as the armies of the world tear themselves apart."

	outfit = /datum/outfit/job/roguetown/blacksmith
	display_order = JDO_ARMORER
	bypass_lastclass = TRUE
	give_bank_account = 30
	min_pq = -25

/datum/outfit/job/roguetown/blacksmith/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/blacksmithing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/armorsmithing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/weaponsmithing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/smelting, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/engineering, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/traps, 2, TRUE) // For craftable beartraps
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
		ADD_TRAIT(H, TRAIT_MALUMFIRE, TRAIT_GENERIC)
		if(H.age == AGE_OLD)
			H.mind.adjust_skillrank(/datum/skill/craft/blacksmithing, pick(0,1), TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/weaponsmithing, pick(0,1), TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/armorsmithing, pick(0,1), TRUE)
	id = /obj/item/clothing/ring/silver/makers_guild
	head = /obj/item/clothing/head/headband/makers
	pants = /obj/item/clothing/pants/tights/makers
	shoes = /obj/item/clothing/shoes/shortboots
	belt = /obj/item/storage/belt/leather
	cloak = /obj/item/clothing/cloak/apron/makers
	backl =	/obj/item/weapon/hammer/sledgehammer
	beltr = /obj/item/storage/keyring/armorsmith
	shirt = /obj/item/clothing/shirt/shortshirt/makers
	switch(H.patron?.type)
		if(/datum/patron/divine/malum)
			neck = /obj/item/clothing/neck/psycross/silver/malum_steel
			backpack_contents = list(/obj/item/storage/belt/pouch/coins/mid)
		else
			neck = /obj/item/storage/belt/pouch/coins/mid
	H.change_stat("strength", 1)
	H.change_stat("endurance", 2)
	H.change_stat("speed", -1)
	if(!H.has_language(/datum/language/dwarvish))
		H.grant_language(/datum/language/dwarvish)
		to_chat(H, "<span class='info'>My life has been shaped by working for the Dwarf-dominated Maker's Guild. I can speak Dwarvish with ,d before my speech.</span>")
/*
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
		ADD_TRAIT(H, TRAIT_MALUMFIRE, TRAIT_GENERIC)
		if(H.age == AGE_OLD)
			H.mind?.adjust_skillrank(/datum/skill/craft/blacksmithing, pick(1,2), TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/weaponsmithing, pick(1,2), TRUE)
	if(H.gender == MALE)
		pants = /obj/item/clothing/under/trou
		shoes = /obj/item/clothing/shoes/boots/leather
		shirt = /obj/item/clothing/shirt/shortshirt
		belt = /obj/item/storage/belt/leather
		beltl = /obj/item/storage/belt/pouch/coins/poor
		beltr = /obj/item/storage/keyring/weaponsmith
		cloak = /obj/item/clothing/cloak/apron/brown
		backl =	/obj/item/weapon/hammer/sledgehammer
		H.change_stat("strength", 1)
		H.change_stat("endurance", 2)
		H.change_stat("speed", -1)
	else
		pants = /obj/item/clothing/under/trou
		armor = /obj/item/clothing/shirt/dress/gen/random
		shoes = /obj/item/clothing/shoes/shortboots
		belt = /obj/item/storage/belt/leather
		cloak = /obj/item/clothing/cloak/apron/brown
		beltl = /obj/item/storage/belt/pouch/coins/poor
		beltr = /obj/item/storage/keyring/weaponsmith
		H.change_stat("strength", 1)
		H.change_stat("endurance", 2)
		H.change_stat("speed", -1)
*/
