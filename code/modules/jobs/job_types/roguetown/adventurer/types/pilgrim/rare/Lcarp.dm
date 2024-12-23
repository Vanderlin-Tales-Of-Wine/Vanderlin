//master carpenter

/datum/advclass/pilgrim/rare/mastercarpenter
	name = "Master Carpenter"
	tutorial = "A true artisan in the field of woodcraft, likely having been formally trained by a guild. \
	A master carpenter knows well how to transform wood into anything from furniture, fortifications, to entire structures."

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
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
	apprentice_name = "Carpenter"

/datum/outfit/job/roguetown/adventurer/mastercarpenter/pre_equip(mob/living/carbon/human/H)
	..()

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

	head = /obj/item/clothing/head/roguetown/hatfur
	armor = /obj/item/clothing/suit/roguetown/armor/leather/jacket
	pants = /obj/item/clothing/under/roguetown/trou
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/storage/belt/rogue/pouch/coins/mid
	beltl = /obj/item/rogueweapon/hammer/claw
	backl = /obj/item/storage/backpack/rogue/backpack
	backr = /obj/item/rogueweapon/polearm/halberd/bardiche/woodcutter // A specialist in cutting trees would carry an impressive axe
	backpack_contents = list(/obj/item/flint = 1, /obj/item/rogueweapon/knife/hunting = 1)
	H.change_stat("strength", 2)
	H.change_stat("endurance", 2)
	H.change_stat("intelligence", 1)
