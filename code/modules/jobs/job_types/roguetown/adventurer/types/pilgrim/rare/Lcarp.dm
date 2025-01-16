//master carpenter

/datum/advclass/pilgrim/rare/mastercarpenter
	name = "Master Carpenter"
	tutorial = "A true artisan in the field of woodcrafting, your skills honed by years in a formal guild. \
	As a master carpenter, you transform trees into anything from furniture to entire fortifications."

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Rakshari",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Dark Elf",
		"Aasimar",
		"Half-Orc"
	)
	outfit = /datum/outfit/job/roguetown/adventurer/mastercarpenter
	category_tags = list(CTAG_PILGRIM, CTAG_TOWNER)
	maximum_possible_slots = 1
	pickprob = 15
	apprentice_name = "Carpenter Apprentice"

/datum/outfit/job/roguetown/adventurer/mastercarpenter/pre_equip(mob/living/carbon/human/H)
	..()

	H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE) // They work at great heights.
	H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 4, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/carpentry, 6, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/engineering, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/labor/lumberjacking, 4, TRUE)

	head = pick(/obj/item/clothing/head/roguetown/hatfur, /obj/item/clothing/head/roguetown/hatblu, /obj/item/clothing/head/roguetown/brimmed)
	neck = /obj/item/clothing/neck/roguetown/coif
	armor = /obj/item/clothing/suit/roguetown/armor/leather/jacket
	pants = /obj/item/clothing/under/roguetown/trou
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/storage/belt/rogue/pouch/coins/mid
	beltl = /obj/item/rogueweapon/hammer/steel
	backl = /obj/item/storage/backpack/rogue/backpack
	backr = /obj/item/rogueweapon/polearm/halberd/bardiche/woodcutter // A specialist in cutting trees would carry an impressive axe
	backpack_contents = list(/obj/item/flint = 1, /obj/item/rogueweapon/knife/hunting = 1, /obj/item/key/artificer = 1)
	H.change_stat("strength", 2)
	H.change_stat("endurance", 2)
	H.change_stat("intelligence", 1)
	H.change_stat("constitution", 1)
