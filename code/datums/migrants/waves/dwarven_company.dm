/datum/migrant_role/dwarven_company/captain
	name = "Captain"
	greet_text = "You are the captain of a dwarven's expedition, following the tracks of Matthios's influence you shall lead your party in Malum's name."
	outfit = /datum/outfit/job/dwarven_company/captain

	allowed_races = list("Dwarf")
	grant_lit_torch = TRUE

/datum/outfit/job/dwarven_company/captain/pre_equip(mob/living/carbon/human/H)
	..()
	armor = /obj/item/clothing/armor/cuirass
	cloak = /obj/item/clothing/cloak/raincloak/furcloak
	shirt = /obj/item/clothing/armor/chainmail
	neck = /obj/item/clothing/neck/gorget
	head = /obj/item/clothing/head/helmet/coppercap
	backr = /obj/item/weapon/shield/wood
	belt = /obj/item/storage/belt/leather
	beltr = /obj/item/flashlight/flare/torch/lantern
	beltl = /obj/item/weapon/pick/paxe
	pants = /obj/item/clothing/pants/trou
	shoes = /obj/item/clothing/shoes/simpleshoes/buckle
	backl = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/storage/belt/pouch/coins/poor)
	H.change_stat(STATKEY_STR, 3)
	H.change_stat(STATKEY_PER, 2)
	H.change_stat(STATKEY_INT, 1)
	H.change_stat(STATKEY_CON, 2)
	H.change_stat(STATKEY_END, 2)
	H.change_stat(STATKEY_SPD, 1)

	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/shields, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/blacksmithing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/armorsmithing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/weaponsmithing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/smelting, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/engineering, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/traps, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		ADD_TRAIT(H, TRAIT_MALUMFIRE, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)

/datum/migrant_role/dwarven_company/weaponsmith
	name = "Weapon Smith"
	greet_text = " You are the weaponsmith of a dwarven expedition, obey your foremand as they lead you in Malum's name into the tomb of Matthios."
	outfit = /datum/outfit/job/dwarven_company/weaponsmith

	allowed_races = list("Dwarf")
	grant_lit_torch = TRUE

/datum/outfit/job/dwarven_company/weaponsmith/pre_equip(mob/living/carbon/human/H)
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
		H.mind?.adjust_skillrank(/datum/skill/craft/traps, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		ADD_TRAIT(H, TRAIT_MALUMFIRE, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
		if(H.age == AGE_OLD)
			H.mind?.adjust_skillrank(/datum/skill/craft/blacksmithing, pick(1,2), TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/weaponsmithing, pick(1,2), TRUE)
	if(H.gender == MALE)
		pants = /obj/item/clothing/pants/trou
		shoes = /obj/item/clothing/shoes/boots/leather
		shirt = /obj/item/clothing/shirt/shortshirt
		armor = /obj/item/clothing/armor/leather/splint
		belt = /obj/item/storage/belt/leather
		beltl = /obj/item/storage/belt/pouch/coins/poor
		cloak = /obj/item/clothing/cloak/apron/brown
		backl =	/obj/item/weapon/hammer/sledgehammer
		backr = /obj/item/weapon/axe/steel
		H.change_stat(STATKEY_STR, 1)
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_SPD, -1)
	else
		pants = /obj/item/clothing/pants/trou
		shirt = /obj/item/clothing/shirt/dress/gen/random
		armor = /obj/item/clothing/armor/leather/splint
		shoes = /obj/item/clothing/shoes/shortboots
		belt = /obj/item/storage/belt/leather
		cloak = /obj/item/clothing/cloak/apron/brown
		beltl = /obj/item/storage/belt/pouch/coins/poor
		backr = /obj/item/weapon/axe/steel
		backl = /obj/item/weapon/pick/paxe
		H.change_stat(STATKEY_STR, 1)
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_SPD, -1)

/datum/migrant_role/dwarven_company/armorsmith
	name = "Armor Smith"
	greet_text = " You are the armorsmith of a dwarven expedition, obey your foremand as they lead you in Malum's name into the tomb of Matthios."
	outfit = /datum/outfit/job/dwarven_company/armorsmith

	allowed_races = list("Dwarf")
	grant_lit_torch = TRUE

/datum/outfit/job/dwarven_company/armorsmith/pre_equip(mob/living/carbon/human/H)
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
		H.mind?.adjust_skillrank(/datum/skill/craft/traps, 2, TRUE) //
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		ADD_TRAIT(H, TRAIT_MALUMFIRE, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
		if(H.age == AGE_OLD)
			H.mind?.adjust_skillrank(/datum/skill/craft/blacksmithing, pick(1,2), TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/armorsmithing, pick(1,2), TRUE)
	if(H.gender == MALE)
		pants = /obj/item/clothing/pants/trou
		shoes = /obj/item/clothing/shoes/simpleshoes/buckle
		armor = /obj/item/clothing/armor/chainmail
		shirt = /obj/item/clothing/shirt/shortshirt
		belt = /obj/item/storage/belt/leather
		beltl = /obj/item/storage/belt/pouch/coins/poor
		cloak = /obj/item/clothing/cloak/apron/brown
		backr = /obj/item/weapon/axe/steel
		backl = /obj/item/weapon/pick/paxe
		H.change_stat(STATKEY_STR, 1)
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_SPD, -1)
	else
		pants = /obj/item/clothing/pants/trou
		shirt = /obj/item/clothing/shirt/dress/gen/random
		armor = /obj/item/clothing/armor/chainmail
		shoes = /obj/item/clothing/shoes/shortboots
		belt = /obj/item/storage/belt/leather
		cloak = /obj/item/clothing/cloak/apron/brown
		beltl = /obj/item/storage/belt/pouch/coins/poor
		backl =	/obj/item/weapon/hammer/sledgehammer
		backr = /obj/item/weapon/axe/steel
		H.change_stat(STATKEY_STR, 1)
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_SPD, -1)

/datum/migrant_wave/dwarven_company
	name = "Dwarven Expedition"
	max_spawns = 4
	shared_wave_type = /datum/migrant_wave/dwarven_company
	downgrade_wave = /datum/migrant_wave/dwarven_company_down
	weight = 15
	roles = list(
		/datum/migrant_role/dwarven_company/captain = 1,
		/datum/migrant_role/dwarven_company/weaponsmith = 2,
		/datum/migrant_role/dwarven_company/armorsmith = 2
	)
	greet_text = "The way to Matthios's tomb is opened. Malum has called for all dwarves bold enough to go in, and we shall answer."

/datum/migrant_wave/dwarven_company_down
	name = "Dwarven Expedition"
	max_spawns = 4
	shared_wave_type = /datum/migrant_wave/dwarven_company
	downgrade_wave = /datum/migrant_wave/dwarven_company_down_one
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/dwarven_company/captain = 1,
		/datum/migrant_role/dwarven_company/armorsmith = 1,
		/datum/migrant_role/dwarven_company/weaponsmith = 1
	)
	greet_text = "The way to Matthios's tomb is opened. Malum has called for all dwarves bold enough to go in, and we shall answer."

/datum/migrant_wave/dwarven_company_down_one
	name = "Dwarven Expedition"
	max_spawns = 4
	shared_wave_type = /datum/migrant_wave/dwarven_company
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/dwarven_company/captain = 1,
	)
	greet_text = "The way to Matthios's tomb is opened. Malum has called for all dwarves bold enough to go in, and we shall answer."


