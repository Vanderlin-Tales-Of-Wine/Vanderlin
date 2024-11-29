/datum/job/roguetown/veteran
	title = "Veteran"
	flag = GUARDSMAN
	department_flag = GARRISON
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Aasimar"
	)
	tutorial = "You've known combat your entire life. There isn't a way to kill a man you haven't practiced in the tapestries of war itself. \
				You wouldn't call yourself a hero, those belong to the men left rotting in the fields of where you practiced your ancient trade. \
				Trading adventure for stable pay was the only logical solution, and maybe someday you'll get to lay down the blade for good..."
	allowed_ages = list(AGE_OLD, AGE_IMMORTAL)
	display_order = JDO_VET
	whitelist_req = FALSE
	bypass_lastclass = TRUE
	selection_color = "#920909"

	outfit = /datum/outfit/job/roguetown/veteran
	give_bank_account = 50
	min_pq = 1

	cmode_music = 'sound/music/combat_guard.ogg'

	forced_flaw = /datum/charflaw/noeyerandom

/datum/outfit/job/roguetown/veteran/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/leather
	pants = /obj/item/clothing/under/roguetown/trou/leather
	cloak = /obj/item/clothing/cloak/half/vet
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/guardsecond
	armor = /obj/item/clothing/suit/roguetown/armor/medium/scale
	neck = /obj/item/clothing/neck/roguetown/gorget
	shoes = /obj/item/clothing/shoes/roguetown/boots
	beltl = /obj/item/keyring/veteran
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/rogueweapon/sword/arming
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/rogueweapon/knife/dagger/steel/special = 1, /obj/item/signal_horn = 1)
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 5, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 6, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/shields, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
		if(H.age == AGE_OLD)
			H.change_stat("strength", 3)
			H.change_stat("perception", 1)
			H.change_stat("intelligence", 2)
			H.change_stat("endurance", 2)
			H.change_stat("speed", 1)
		else
			H.change_stat("strength", 2)
			H.change_stat("intelligence", 2)
			H.change_stat("endurance", 2)
			// Aasimar veterans have higher strength but much lower perception and intelligence bonuses overall

	H.verbs |= /mob/proc/haltyell
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC) // Desensitized through thousand campaigns
