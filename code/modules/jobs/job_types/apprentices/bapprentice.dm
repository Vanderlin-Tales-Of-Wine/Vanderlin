/datum/job/bapprentice
	title = "Smithy Apprentice"
	tutorial = "Long hours and back-breaking work wouldnt even describe a quarter of what you do in a day for your Master. \
	Its exhausting, filthy and you dont get much freetime: \
	but someday youll get your own smithy, and youll have TWICE as many apprentices as your master does."
	flag = APPRENTICE
	department_flag = APPRENTICES
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	faction = FACTION_STATION
	total_positions = 2
	spawn_positions = 2

	allowed_races = RACES_PLAYER_ALL
	allowed_ages = list(AGE_CHILD, AGE_ADULT)


	outfit = /datum/outfit/job/bapprentice
	display_order = JDO_BAPP
	give_bank_account = TRUE
	min_pq = -10
	bypass_lastclass = TRUE

	can_have_apprentices = FALSE

/datum/outfit/job/bapprentice
	job_bitflag = BITFLAG_CONSTRUCTOR

/datum/outfit/job/bapprentice/pre_equip(mob/living/carbon/human/H)
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
		pants = /obj/item/clothing/pants/tights/random
		shoes = /obj/item/clothing/shoes/simpleshoes
		shirt = null
		belt = /obj/item/storage/belt/leather/rope
		beltr = /obj/item/key/blacksmith
		armor = /obj/item/clothing/armor/leather/vest
		backr = /obj/item/storage/backpack/satchel
		wrists = /obj/item/clothing/wrists/bracers/leather
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_SPD, 1)
	else
		armor = /obj/item/clothing/shirt/dress/gen/random
		shoes = /obj/item/clothing/shoes/simpleshoes
		shirt = /obj/item/clothing/shirt/undershirt
		belt = /obj/item/storage/belt/leather/rope
		beltr = /obj/item/key/blacksmith
		cloak = /obj/item/clothing/cloak/apron/brown
		backr = /obj/item/storage/backpack/satchel
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_SPD, 1)
	ADD_TRAIT(H, TRAIT_MALUMFIRE, TRAIT_GENERIC)
