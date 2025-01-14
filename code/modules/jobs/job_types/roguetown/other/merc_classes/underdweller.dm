/datum/advclass/mercenary/underdweller
	name = "Underdweller"
	tutorial = "A member of the Underdwellers, you've taken many of the deadliest contracts known to man in literal underground circles. Drow or Dwarf, you've put your differences aside for coin and adventure."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Dwarf",
		"Dark Elf"
	)
	outfit = /datum/outfit/job/roguetown/mercenary/underdweller
	category_tags = list(CTAG_MERCENARY)
	maximum_possible_slots = 5

/datum/outfit/job/roguetown/mercenary/underdweller/pre_equip(mob/living/carbon/human/H)
	..()
	pants = /obj/item/clothing/under/roguetown/trou/leather
	armor = /obj/item/clothing/suit/roguetown/armor/cuirass/iron
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/sailor/red
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes/buckle
	belt = /obj/item/storage/belt/rogue/leather/mercenary
	beltr = /obj/item/rogueweapon/knife/hunting
	neck = /obj/item/clothing/neck/roguetown/chaincoif/iron
	backl = /obj/item/storage/backpack/rogue/backpack
	backpack_contents = list(/obj/item/storage/belt/rogue/pouch/coins/poor=1)
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/labor/mining, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/engineering, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.change_stat("fortune", 1)
		H.change_stat("endurance", 1)
		H.change_stat("strength", 1)

	if(H.dna.species.id == "dwarf")
		H.cmode_music = 'sound/music/cmode/adventurer/CombatOutlander2.ogg'
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
		head = /obj/item/clothing/head/roguetown/helmet/leather/minershelm
		beltl = /obj/item/rogueweapon/pick/paxe // Dorfs get a pick as their primary weapon and axes/maces to use it
		backr = /obj/item/rogueweapon/shield/wood
	else // No miner's helm for Delves as they haven nitevision now.
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)

		beltl = /obj/item/rogueweapon/sword/sabre // Dark elves get a sabre as their primary weapon and swords skill, who woulda thought

	H.merctype = 3

	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
