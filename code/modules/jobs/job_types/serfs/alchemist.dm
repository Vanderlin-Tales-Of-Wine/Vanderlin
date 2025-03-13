/datum/job/alchemist
	title = "Alchemist"
	flag = ALCHEMIST
	department_flag = SERFS
	faction = "Station"
	total_positions = 0
	spawn_positions = 0

	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Aasimar"
	)

	tutorial = "You came to Vanderlin either to seek knowledge or riches."

	outfit = /datum/outfit/job/alchemist
	display_order = 6
	give_bank_account = 12
	bypass_lastclass = TRUE

/datum/outfit/job/alchemist
	name = "Alchemist"
	jobtype = /datum/job/alchemist

/datum/outfit/job/alchemist/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/alchemy, pick(2,5), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.change_stat(STATKEY_INT, 3)
		H.change_stat(STATKEY_SPD, -1)
		if(H.age == AGE_OLD)
			H.mind?.adjust_skillrank(/datum/skill/craft/alchemy, pick(4,6), TRUE)
//Requires a lot of sprites, so this is just a placeholder
	if(H.gender == MALE)
		pants = /obj/item/clothing/pants/trou
		shoes = /obj/item/clothing/shoes/boots/leather
		shirt = /obj/item/clothing/shirt/shortshirt
		belt = /obj/item/storage/belt/leather
		beltl = /obj/item/storage/belt/pouch/coins/poor
		cloak = /obj/item/clothing/cloak/apron/brown
	else
		pants = /obj/item/clothing/pants/trou
		shoes = /obj/item/clothing/shoes/boots/leather
		shirt = /obj/item/clothing/shirt/shortshirt
		belt = /obj/item/storage/belt/leather
		beltl = /obj/item/storage/belt/pouch/coins/poor
		cloak = /obj/item/clothing/cloak/apron/brown

