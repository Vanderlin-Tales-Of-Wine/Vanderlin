/datum/advclass/carpenter
	name = "Carpenter"
	tutorial = "Woodsmen and women that dedicate their lives to chopping wood \
	for profit, and expertly building things out of it."
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
	outfit = /datum/outfit/job/roguetown/adventurer/carpenter

	category_tags = list(CTAG_PILGRIM, CTAG_TOWNER)
	apprentice_name = "Carpenter"

/datum/outfit/job/roguetown/adventurer/carpenter/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/carpentry, 5, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, pick(2,2,3), TRUE)
	head = /obj/item/clothing/head/roguetown/hatfur
	if(prob(50))
		head = /obj/item/clothing/head/roguetown/hatblu
	armor = /obj/item/clothing/suit/roguetown/armor/gambeson/light/striped
	pants = /obj/item/clothing/under/roguetown/trou
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
	beltl = /obj/item/rogueweapon/hammer/claw
	backl = /obj/item/storage/backpack/rogue/backpack
	backpack_contents = list(/obj/item/flint = 1, /obj/item/rogueweapon/knife/villager = 1)
	H.change_stat("strength", 1)
	H.change_stat("intelligence", 1)
	H.change_stat("constitution", 1)
	H.change_stat("speed", -1)
