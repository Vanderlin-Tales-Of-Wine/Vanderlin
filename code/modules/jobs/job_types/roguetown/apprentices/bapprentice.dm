/datum/job/roguetown/bapprentice
	title = "Smithy Apprentice"
	flag = APPRENTICE
	department_flag = APPRENTICES
	faction = "Station"
	total_positions = 2
	spawn_positions = 2

	allowed_races = ALL_PLAYER_RACES_BY_NAME
	allowed_ages = list(AGE_CHILD, AGE_ADULT)

	tutorial = "Long hours and back-breaking work wouldnt even describe a quarter of what you do in a day for your Master. Its exhausting, filthy and you dont get much freetime: but someday youll get your own smithy, and youll have TWICE as many apprentices as your master does."

	outfit = /datum/outfit/job/roguetown/bapprentice
	display_order = JDO_BAPP
	give_bank_account = TRUE
	min_pq = -10
	bypass_lastclass = TRUE

	can_have_apprentices = FALSE

/datum/outfit/job/roguetown/bapprentice/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/blacksmithing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/armorsmithing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/weaponsmithing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/smelting, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/tights/random
		shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
		shirt = null
		belt = /obj/item/storage/belt/rogue/leather/rope
		beltr = /obj/item/key/blacksmith
		armor = /obj/item/clothing/suit/roguetown/armor/leather/vest
		backr = /obj/item/storage/backpack/rogue/satchel
		wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
		H.change_stat("endurance", 2)
		H.change_stat("speed", 1)
	else
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/random
		shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
		belt = /obj/item/storage/belt/rogue/leather/rope
		beltr = /obj/item/key/blacksmith
		cloak = /obj/item/clothing/cloak/apron/brown
		backr = /obj/item/storage/backpack/rogue/satchel
		H.change_stat("endurance", 2)
		H.change_stat("speed", 1)
	ADD_TRAIT(H, TRAIT_MALUMFIRE, TRAIT_GENERIC)
