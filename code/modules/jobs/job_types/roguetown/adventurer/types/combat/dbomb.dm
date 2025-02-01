/datum/advclass/combat/dbomb
	name = "Dwarven Bombardier"
	tutorial = "Tinkering Dwarves that like to blow things up."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list("Dwarf")
	outfit = /datum/outfit/job/roguetown/adventurer/dbomb
	min_pq = 0
	category_tags = list(CTAG_ADVENTURER)

/datum/outfit/job/roguetown/adventurer/dbomb/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/horned
	pants = /obj/item/clothing/under/roguetown/trou
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	backl = /obj/item/storage/backpack/rogue/backpack
	beltl = /obj/item/rogueweapon/pick
	beltr = /obj/item/rogueweapon/hammer/iron
	backpack_contents = list(/obj/item/bomb = 1, /obj/item/flint = 1)
	H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/labor/mining, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/engineering, 5, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/bombs, 4, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/smelting, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.change_stat("strength", 1)
	H.change_stat("endurance", 1)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	switch(pick(1,2))
		if (1)
			shoes = /obj/item/clothing/shoes/roguetown/boots/leather
		if (2)
			shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
