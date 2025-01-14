/datum/job/roguetown/tester
	title = "Tester"
	flag = GRAVETENDER
	department_flag = PEASANTS
	faction = "Station"
#ifdef TESTSERVER
	total_positions = 99
	spawn_positions = 99
#else
	total_positions = 0
	spawn_positions = 0
#endif
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
	tutorial = ""
	outfit = /datum/outfit/job/roguetown/tester
	plevel_req = 0
	display_order = JDO_MERCENARY

/datum/outfit/job/roguetown/tester/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/gambeson/arming
	if(prob(50))
		armor = /obj/item/clothing/suit/roguetown/armor/gambeson
	neck = /obj/item/key/mercenary
	beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
	beltr = /obj/item/rogueweapon/sword/sabre
	if(prob(50))
		beltr = /obj/item/rogueweapon/sword/arming
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/merc
	pants = /obj/item/clothing/under/roguetown/trou/leather
	neck = /obj/item/clothing/neck/roguetown/gorget
	if(H.gender == FEMALE)
		pants = /obj/item/clothing/under/roguetown/tights/black
		beltr = /obj/item/rogueweapon/sword/sabre
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, rand(1,5), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, rand(1,5), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, rand(1,5), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, rand(1,5), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/bows, rand(1,5), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, rand(1,5), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, rand(1,5), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, rand(1,5), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, rand(1,5), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/polearms, rand(1,5), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/whipsflails, rand(1,5), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, rand(1,5), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, rand(1,5), TRUE)
		H.change_stat("strength", 1)
