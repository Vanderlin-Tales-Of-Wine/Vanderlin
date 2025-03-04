/datum/job/roguetown/elder
	title = "Village Elder"
	flag = MAYOR
	department_flag = PEASANTS
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	spells = list(/obj/effect/proc_holder/spell/self/convertrole/town_militia)
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Half-Elf",
		"Dwarf",
		"Aasimar"
	)
	allowed_ages = list(AGE_OLD, AGE_IMMORTAL)
	tutorial = "The common folk look to you for leadership and guidance when the nobles fail. No spring chicken, the young ones should listen to your sage advice, according to you."
	whitelist_req = FALSE
	bypass_lastclass = TRUE
	outfit = /datum/outfit/job/roguetown/elder
	display_order = JDO_CHIEF
	give_bank_account = 80
	min_pq = 0

	cmode_music = 'sound/music/cmode/towner/CombatMayor.ogg'
	can_have_apprentices = FALSE

/datum/outfit/job/roguetown/elder/pre_equip(mob/living/carbon/human/H)
	..()
	pants = /obj/item/clothing/pants/trou/leather
	head = /obj/item/clothing/head/brimmed
	armor = /obj/item/clothing/armor/leather/jacket
	shirt = /obj/item/clothing/shirt/tunic
	shoes = /obj/item/clothing/shoes/boots
	cloak = /obj/item/clothing/cloak/half
	neck = /obj/item/storage/belt/pouch/coins/mid
	backl = /obj/item/storage/backpack/satchel
	belt = /obj/item/storage/belt/leather/black
	beltr = /obj/item/key/elder
	beltl = /obj/item/weapon/axe/iron
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/taming, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/tanning, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/butchering, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("perception", 1)
		H.change_stat("intelligence", 2)
	H.verbs |= /mob/proc/haltyell

