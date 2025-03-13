/datum/job/butler
	title = "Butler"
	flag = BUTLER
	department_flag = PEASANTS
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	f_title = "Maid"
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Dark Elf",
		"Aasimar"
	)
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD, AGE_IMMORTAL)
	tutorial = "Your blade is a charcuterie of artisanal cheeses and meat, your armor wit and classical training. You are part of the royal family now, and hold a distinguished position as the head of the royal household staff. You wear their colors and have a semblance of dignity, for without you and the servants under your command the court would have all starved to death."
	outfit = /datum/outfit/job/butler
	display_order = JDO_BUTLER
	bypass_lastclass = TRUE
	min_pq = 2
	give_bank_account = 30 // Along with the pouch, enough to purchase some ingredients from the farm and give hard working servants a silver here and there. Still need the assistance of the crown's coffers to do anything significant
	cmode_music = 'sound/music/cmode/towner/CombatInn.ogg'

/datum/outfit/job/butler/pre_equip(mob/living/carbon/human/H)
	..()
	backpack_contents = list(/obj/item/book/manners = 1)
	mask = /obj/item/clothing/face/spectacles
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE) // A well educated head of servants should at least have skilled literacy level
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/butchering, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/farming, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/music, pick(1,1,2,3), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE) // Privilege of living a life raising nobility. Knows the very basics about riding a mount
		H.change_stat(STATKEY_STR, -1)
		H.change_stat(STATKEY_INT, 2)
		H.change_stat(STATKEY_PER, 1)
		H.change_stat(STATKEY_END, 1)

	if(H.gender == MALE)
		pants = /obj/item/clothing/pants/tights
		shirt = /obj/item/clothing/shirt/undershirt/guard
		shoes = /obj/item/clothing/shoes/nobleboot
		belt = /obj/item/storage/belt/leather/plaquesilver
		beltr = /obj/item/storage/keyring/butler
		beltl = /obj/item/storage/belt/pouch/coins/mid
		armor = /obj/item/clothing/armor/leather/vest/butler
		backr = /obj/item/storage/backpack/satchel

	else
		armor = /obj/item/clothing/shirt/dress/gen/maid
		shirt = /obj/item/clothing/shirt/undershirt
		shoes = /obj/item/clothing/shoes/ridingboots
		cloak = /obj/item/clothing/cloak/apron
		belt = /obj/item/storage/belt/leather/cloth/lady
		beltr = /obj/item/storage/keyring/butler
		beltl = /obj/item/storage/belt/pouch/coins/mid
		backr = /obj/item/storage/backpack/satchel
