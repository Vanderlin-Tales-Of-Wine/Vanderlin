
/datum/migrant_role/dwarven_company/after_spawn(mob/living/carbon/human/character)
	. = ..()
	character.forceMove(pick(GLOB.bogroad_starts))

/datum/migrant_role/dwarven_company/mountaineer
	name = "Mountaineer"
	greet_text = "You are a member of a dwarven's expedition, here to make contact with your kin in the Outpost northeast of the hamlet, and help secure your clans influence in the region."
	outfit = /datum/outfit/job/sk_migration/dwarven_company/mountaineer

	allowed_races = list("Dwarf")
	grant_lit_torch = TRUE
	is_foreigner = FALSE

/datum/outfit/job/sk_migration/dwarven_company/mountaineer/pre_equip(mob/living/carbon/human/H)
	..()
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
	head = /obj/item/clothing/head/helmet/ironpot
	armor = /obj/item/clothing/armor/leather/splint
	if(H.gender == MALE)
		pants = /obj/item/clothing/pants/trou
		shoes = /obj/item/clothing/shoes/boots/leather
		shirt = /obj/item/clothing/shirt/shortshirt

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


