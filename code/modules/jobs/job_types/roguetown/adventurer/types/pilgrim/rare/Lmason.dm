//dwarf, master mason

/datum/advclass/pilgrim/rare/grandmastermason
	name = "Grandmaster Mason"
	tutorial = "A Grandmaster mason, you built castles and entire cities with your own hands. \
	There is nothing in this world that you can't build, your creed and hardwork has revealed all the secrets of the stone."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list("Dwarf")
	outfit = /datum/outfit/job/roguetown/adventurer/grandmastermason
	category_tags = list(CTAG_PILGRIM, CTAG_TOWNER)
	maximum_possible_slots = 1
	pickprob = 15
	apprentice_name = "Mason Apprentice"

/datum/outfit/job/roguetown/adventurer/grandmastermason/pre_equip(mob/living/carbon/human/H)
	..()

	H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/labor/mining, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 5, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/carpentry, 4, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/masonry, 6, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/engineering, 5, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/smelting, 6, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	head = /obj/item/clothing/head/roguetown/hatblu
	armor = /obj/item/clothing/suit/roguetown/armor/leather/vest
	cloak = /obj/item/clothing/cloak/apron/waist/bar
	pants = /obj/item/clothing/under/roguetown/trou
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/storage/belt/rogue/pouch/coins/mid
	beltl = /obj/item/rogueweapon/pick
	backr = /obj/item/rogueweapon/axe/steel
	backl = /obj/item/storage/backpack/rogue/backpack
	H.change_stat("strength", 1)
	H.change_stat("intelligence", 2)
	H.change_stat("endurance", 2)
	H.change_stat("constitution", 2)

	if(H.dna.species.name == "Dwarf")
		head = /obj/item/clothing/head/roguetown/helmet/leather/minershelm
