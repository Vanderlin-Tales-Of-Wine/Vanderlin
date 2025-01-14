/datum/job/roguetown/servant
	title = "Servant"
	flag = SERVANT
	department_flag = APPRENTICES
	faction = "Station"
	total_positions = 4
	spawn_positions = 4

	allowed_races = list(
		"Humen",
		"Rakshari",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Dark Elf",
		"Aasimar",
		"Half-Orc"
	)
	allowed_ages = list(AGE_ADULT, AGE_IMMORTAL)

	tutorial = "You are the faceless, nameless labor that keeps the royal court fed, washed, and attended to. You work your fingers to the bone nearly every dae, and have naught to show for it but boney fingers. Perhaps this week you will finally be recognized, or allowed some respite?"

	outfit = /datum/outfit/job/roguetown/servant
	display_order = JDO_SERVANT
	give_bank_account = TRUE
	min_pq = -20
	bypass_lastclass = TRUE

	can_have_apprentices = FALSE


/datum/outfit/job/roguetown/servant/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/butchering, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/music, pick(0,1,1), TRUE)
		H.change_stat("speed", 1)
		H.change_stat("endurance", 1)
		shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
		pants = /obj/item/clothing/under/roguetown/tights/uncolored
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/uncolored
		belt = /obj/item/storage/belt/rogue/leather/rope
		beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
		neck = /obj/item/key/manor
		if(H.gender == MALE)
			armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/black
		else
			cloak = /obj/item/clothing/cloak/apron
