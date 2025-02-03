/datum/job/roguetown/cook
	title = "Cook"
	flag = COOK
	department_flag = PEASANTS
	faction = "Station"
	total_positions = 3
	spawn_positions = 3

	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Dark Elf",
		"Aasimar"
	)
	tutorial = "Slice, chop, and into the pot... you work closely with the innkeep to prepare meals for all the hungry mouths of Vanderlin. You've spent more nites than you can count cutting meat and vegetables until your fingers are bloody and raw, but it's honest work."

	outfit = /datum/outfit/job/roguetown/cook
	display_order = JDO_COOK
	bypass_lastclass = TRUE
	min_pq = -20
	give_bank_account = 8
	cmode_music = 'sound/music/cmode/towner/CombatInn.ogg'

/datum/outfit/job/roguetown/cook/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/butchering, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/taming, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
		if(H.age == AGE_OLD)
			H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	belt = /obj/item/storage/belt/rogue/leather/rope
	beltl = /obj/item/key/tavern
	beltr = /obj/item/rogueweapon/knife/villager
	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/tights/random
		shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
		shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
		cloak = /obj/item/clothing/cloak/apron/cook
		head = /obj/item/clothing/head/roguetown/cookhat
		neck = /obj/item/storage/belt/rogue/pouch/coins/poor
		H.change_stat("constitution", 2)
	else
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/lowcut
		armor = /obj/item/clothing/suit/roguetown/armor/corset
		pants = /obj/item/clothing/under/roguetown/skirt/red
		cloak = /obj/item/clothing/cloak/apron/cook
		head = /obj/item/clothing/head/roguetown/cookhat
		shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
		neck = /obj/item/storage/belt/rogue/pouch/coins/poor
		H.change_stat("constitution", 2)
