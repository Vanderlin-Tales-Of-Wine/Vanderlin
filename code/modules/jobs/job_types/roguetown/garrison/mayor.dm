/datum/job/roguetown/mayor
	title = "Town Elder"
	flag = MAYOR
	department_flag = GARRISON
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	spells = list(/obj/effect/proc_holder/spell/self/convertrole/town_militia)
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Aasimar"
	)
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD, AGE_IMMORTAL)
	tutorial = "The crown may lead officially, but the townsfolk of Vanderlin look to you to manage the settlement and solve lesser issues. Remember the old ways of the law... not everything must end in bloodshed, but do what is necessary to maintain the peace."
	whitelist_req = FALSE
	bypass_lastclass = TRUE
	outfit = /datum/outfit/job/roguetown/mayor
	display_order = JDO_CHIEF
	give_bank_account = 80
	min_pq = 2

	cmode_music = 'sound/music/cmode/towner/CombatMayor.ogg'
	can_have_apprentices = FALSE

/datum/outfit/job/roguetown/mayor
	name = "Town Elder"
	jobtype = /datum/job/roguetown/mayor

/datum/outfit/job/roguetown/mayor/pre_equip(mob/living/carbon/human/H)
	..()
	pants = /obj/item/clothing/under/roguetown/trou/leather
	head = /obj/item/clothing/head/roguetown/brimmed
	armor = /obj/item/clothing/suit/roguetown/armor/leather/jacket
	shirt = /obj/item/clothing/suit/roguetown/shirt/tunic
	shoes = /obj/item/clothing/shoes/roguetown/boots
	cloak = /obj/item/clothing/cloak/half
	neck = /obj/item/storage/belt/rogue/pouch/coins/rich
	belt = /obj/item/storage/belt/rogue/leather/black
	beltr = /obj/item/storage/keyring/mayor
	beltl = /obj/item/flashlight/flare/torch/lantern
	r_hand = /obj/item/rogueweapon/polearm/woodstaff/quarterstaff
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
		if(H.age == AGE_OLD)
			H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
			H.change_stat("strength", 1)
			H.change_stat("perception", 1)
			H.change_stat("intelligence", 2)
		else
			H.change_stat("strength", 2)
			H.change_stat("endurance", 1)
			H.change_stat("intelligence", 2)
	H.verbs |= /mob/proc/haltyell

/obj/effect/proc_holder/spell/self/convertrole/town_militia
	name = "Recruit Militia"
	new_role = "Town Militiaman"
	overlay_state = "recruit_guard"
	recruitment_faction = "Garrison"
	recruitment_message = "Join the Town Militia, %RECRUIT!"
	accept_message = "I swear fealty to protect the town!"
	refuse_message = "I refuse."

/datum/job/roguetown/militia //just used to change the title
	title = "Town Militiaman"
	f_title = "Town Militiawoman"
	flag = GUARDSMAN
	department_flag = GARRISON
	faction = "Station"
	total_positions = 0
	spawn_positions = 0
	display_order = JDO_GARRISONGUARD
