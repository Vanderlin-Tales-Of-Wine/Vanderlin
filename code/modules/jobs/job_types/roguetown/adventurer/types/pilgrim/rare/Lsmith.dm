//master smith

/datum/advclass/pilgrim/rare/masterblacksmith
	name = "Master Blacksmith"
	tutorial = "Dwarves, and humen who trained extensively under them in the art of smithing, \
	become the most legendary smiths at their craft, gaining reputation beyond compare."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Dwarf"
	)
	outfit = /datum/outfit/job/roguetown/adventurer/masterblacksmith
	maximum_possible_slots = 1
	pickprob = 15
	category_tags = list(CTAG_PILGRIM)

/datum/outfit/job/roguetown/adventurer/masterblacksmith/pre_equip(mob/living/carbon/human/H)
	..()
	beltr = /obj/item/rogueweapon/hammer/iron
	backl = /obj/item/storage/backpack/rogue/backpack
	backr =	/obj/item/rogueweapon/hammer/sledgehammer
	pants = /obj/item/clothing/under/roguetown/trou
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
	neck = /obj/item/storage/belt/rogue/pouch/coins/mid
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/rogueweapon/knife/hunting
	cloak = /obj/item/clothing/cloak/apron/brown
	gloves = /obj/item/clothing/gloves/roguetown/leather
	backpack_contents = list(/obj/item/flint = 1, /obj/item/rogueweapon/tongs=1, /obj/item/rogueore/coal=1, /obj/item/rogueore/iron=1)

	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, pick(0,1,1), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, pick(1,1,2), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, pick(2,2,3), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/masonry, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/carpentry, pick(1,2,2), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, pick(1,1,2), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/engineering, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/traps, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, pick(0,1,1), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/carpentry, pick(0,1,1), TRUE) // 66% over 50% of normal smith
		H.mind?.adjust_skillrank(/datum/skill/craft/blacksmithing, 6, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/armorsmithing, 6, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/weaponsmithing, 6, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/smelting, 6, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, pick(1,2,2), TRUE)
		ADD_TRAIT(H, TRAIT_MALUMFIRE, TRAIT_GENERIC)
		if(H.age == AGE_OLD) // Wise still on every field, but gimped stats from age.
			H.change_stat("endurance", -1)
			H.change_stat("constitution", -1)
			H.change_stat("speed", -1)
			H.mind?.adjust_skillrank(/datum/skill/craft/engineering, 1, TRUE)
		else // The actual stats
			H.change_stat("strength", 1)
			H.change_stat("endurance", 1)
			H.change_stat("constitution", 1)
			H.change_stat("speed", -1)

	if(H.gender == MALE)
		shoes = /obj/item/clothing/shoes/roguetown/boots/leather
		shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
	else
		shoes = /obj/item/clothing/shoes/roguetown/shortboots
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/random
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
