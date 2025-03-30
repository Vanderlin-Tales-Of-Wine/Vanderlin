/datum/job/stonekeep/elder
	title = "Village Elder"
	flag = SK_ELDER
	department_flag = PEASANTS
	total_positions = 1
	spawn_positions = 1

	spells = list(/obj/effect/proc_holder/spell/self/convertrole/town_militia)
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Half-Elf",
		"Dwarf"
	)
	allowed_ages = list(AGE_OLD)
	tutorial = "The common folk look to you for leadership and guidance when the nobles fail. No spring chicken, the young ones should listen to your sage advice, according to you."
	outfit = /datum/outfit/job/stonekeep/elder
	display_order = ELDER_ORDER
	give_bank_account = 60

	selection_color = "#6c3e2f"
	cmode_music = 'sound/music/cmode/combat_guard.ogg'


/datum/outfit/job/stonekeep/elder/pre_equip(mob/living/carbon/human/H)
	..()
	pants = /obj/item/clothing/pants/trou/leather/heavy
	head = /obj/item/clothing/head/knitcap
	armor = /obj/item/clothing/armor/leather/vest/butcher
	shirt = /obj/item/clothing/shirt/tunic
	shoes = /obj/item/clothing/shoes/boots
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

