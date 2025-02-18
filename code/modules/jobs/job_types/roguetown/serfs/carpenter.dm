/datum/job/roguetown/carpenter
	title = "Carpenter"
	tutorial = "Others may regard your work as crude and demeaning, but you understand deep in your soul the beauty of woodchopping. \
	For it is by your axe that the great trees of forests are felled, and it is by your hands from which the shining beacon of civilization is built."
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
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/carpentry, 5, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, pick(3,3,4), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/lumberjacking, 3, TRUE)
		if(prob(5))
			H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/labor/lumberjacking, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)

	head = pick(/obj/item/clothing/head/roguetown/hatfur, /obj/item/clothing/head/roguetown/hatblu, /obj/item/clothing/head/roguetown/brimmed)
	neck = /obj/item/clothing/neck/roguetown/coif
	armor = /obj/item/clothing/suit/roguetown/armor/gambeson/light/striped
	pants = /obj/item/clothing/under/roguetown/trou
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
	beltl = /obj/item/rogueweapon/hammer/steel
	backr = /obj/item/rogueweapon/axe/iron
	backl = /obj/item/storage/backpack/rogue/backpack
	backpack_contents = list(/obj/item/flint = 1, /obj/item/rogueweapon/knife/villager = 1)
	H.change_stat(STATKEY_STR, 1)
	H.change_stat(STATKEY_END, 1) // Tree chopping builds endurance
	H.change_stat(STATKEY_INT, 1)
	H.change_stat(STATKEY_CON, 1)
	H.change_stat(STATKEY_SPD, -1)
