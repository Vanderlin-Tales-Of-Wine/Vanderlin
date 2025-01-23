/datum/job/roguetown/carpenter
	title = "Carpenter"
	tutorial = "Woodsmen and women that dedicate their lives to chopping wood \
	for profit, and expertly building things out of it."
	faction = "Station"
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
	total_positions = 6
	spawn_positions = 4
	flag = LUMBERJACK
	department_flag = PEASANTS
	display_order = JDO_CARPENTER
	outfit = /datum/outfit/job/roguetown/carpenter

/datum/outfit/job/roguetown/carpenter/pre_equip(mob/living/carbon/human/H)
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
		if(prob(5))
			H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/labor/lumberjacking, 4, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)

	head = /obj/item/clothing/head/roguetown/hatfur
	if(prob(50))
		head = /obj/item/clothing/head/roguetown/hatblu
	armor = /obj/item/clothing/suit/roguetown/armor/gambeson/light/striped
	pants = /obj/item/clothing/under/roguetown/trou
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
	backl = /obj/item/storage/backpack/rogue/backpack
	backpack_contents = list(/obj/item/flint = 1, /obj/item/rogueweapon/knife/villager = 1)
	H.change_stat("strength", 1)
	H.change_stat("intelligence", 1)
	H.change_stat("constitution", 1)
	H.change_stat("speed", -1)
