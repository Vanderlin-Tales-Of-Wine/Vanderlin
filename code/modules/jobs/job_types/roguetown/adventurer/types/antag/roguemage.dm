/datum/advclass/roguemage //mage class - like the adventurer mage, but more evil.
	name = "Rogue Mage"
	tutorial = "Those fools at the academy laughed at you and cast you from the ivory tower of higher learning and magickal practice. No matter - you will ascend to great power one day, but first you need wealth - vast amounts of it. Show those fools in the town what REAL magic looks like."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = ALL_PLAYER_RACES_BY_NAME
	outfit = /datum/outfit/job/roguetown/bandit/roguemage
	category_tags = list(CTAG_BANDIT)
	cmode_music = 'sound/music/cmode/antag/combat_bandit_mage.ogg'

/datum/outfit/job/roguetown/bandit/roguemage/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/black
	belt = /obj/item/storage/belt/rogue/leather/rope
	beltr = /obj/item/reagent_containers/glass/bottle/rogue/manapot
	backr = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/needle/thorn = 1, /obj/item/natural/cloth = 1)
	mask = /obj/item/clothing/mask/rogue/facemask/steel //idk if this makes it so they cant cast but i want all of the bandits to have the same mask
	neck = /obj/item/clothing/neck/roguetown/coif
	head = /obj/item/clothing/head/roguetown/helmet/leather/volfhelm

	r_hand = /obj/item/rogueweapon/polearm/woodstaff
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE) //needs climbing to get into hideout
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/alchemy, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, 3, TRUE)
		if(H.age == AGE_OLD)
			head = /obj/item/clothing/head/roguetown/wizhat/gen
			armor = /obj/item/clothing/suit/roguetown/shirt/robe
			H.mind.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)
			H.change_stat("speed", -1)
			H.change_stat("intelligence", 1)
			H.change_stat("perception", 1)
			H.mind.adjust_spellpoints(1)
		H.change_stat("strength", -1)
		H.change_stat("intelligence", 3)
		H.change_stat("constitution", 1)
		H.change_stat("endurance", -1)
		H.mind.adjust_spellpoints(1)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
