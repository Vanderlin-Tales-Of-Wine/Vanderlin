//human, master fisher

/datum/advclass/pilgrim/rare/fishermaster
	name = "Master Fisher"
	tutorial = "Seafarers who have mastered the tides, and are able to catch any fish with ease \
	no matter the body of water. They have learned to thrive off the gifts of Abyssor, not simply survive."
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
	outfit = /datum/outfit/job/roguetown/adventurer/fishermaster

	maximum_possible_slots = 1
	pickprob = 15
	category_tags = list(CTAG_PILGRIM, CTAG_TOWNER)
	apprentice_name = "Fisher Apprentice"

/datum/outfit/job/roguetown/adventurer/fishermaster/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/trou
		shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
		shoes = /obj/item/clothing/shoes/roguetown/boots/leather
		neck = /obj/item/storage/belt/rogue/pouch/coins/mid
		head = /obj/item/clothing/head/roguetown/fisherhat
		backr = /obj/item/storage/backpack/rogue/satchel
		armor = /obj/item/clothing/suit/roguetown/armor/leather/jacket/sea
		belt = /obj/item/storage/belt/rogue/leather
		backl = /obj/item/fishingrod/fisher
		beltr = /obj/item/cooking/pan
		beltl = /obj/item/rogueweapon/knife/hunting
		backpack_contents = list(/obj/item/natural/worms = 2,/obj/item/rogueweapon/shovel/small=1)
		if(H.mind)
			H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 5, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 3, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/labor/fishing, 5, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			if(H.age == AGE_OLD)
				H.mind?.adjust_skillrank(/datum/skill/labor/fishing, 1, TRUE)
				H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			H.change_stat("constitution", 2)
			H.change_stat("perception", 2)
	else
		pants = /obj/item/clothing/under/roguetown/trou
		shoes = /obj/item/clothing/shoes/roguetown/boots/leather
		shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
		neck = /obj/item/storage/belt/rogue/pouch/coins/mid
		head = /obj/item/clothing/head/roguetown/fisherhat
		backr = /obj/item/storage/backpack/rogue/satchel
		armor = /obj/item/clothing/suit/roguetown/armor/leather/jacket/sea
		belt = /obj/item/storage/belt/rogue/leather
		beltr = /obj/item/fishingrod
		beltl = /obj/item/rogueweapon/knife/hunting
		backpack_contents = list(/obj/item/natural/worms = 2,/obj/item/rogueweapon/shovel/small=1)
		if(H.mind)
			H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 5, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 3, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/labor/fishing, 5, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			if(H.age == AGE_OLD)
				H.mind?.adjust_skillrank(/datum/skill/labor/fishing, 1, TRUE)
				H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			H.change_stat("constitution", 2)
			H.change_stat("perception", 2)
