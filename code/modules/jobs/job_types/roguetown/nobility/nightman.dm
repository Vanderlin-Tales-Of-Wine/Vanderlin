/datum/job/roguetown/apothecary
	title = "Apothecary"
	flag = NIGHTMAN
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_races = list(
		"Humen",
		"Dwarf",
		"Elf",
		"Half-Elf",
		"Tiefling",
		"Dark Elf",
		"Aasimar",
		"Half-Orc"
	)

	tutorial = "You know every plant growing on these grounds and in the woods like the back of your hand. You are tasked with mixing tinctures and supplying the town and Feldsher with medicine for pain... or pleasure. For a price, of course. You have been known to kill men who cross you or your work-partner."

	allowed_sexes = list(MALE, FEMALE)
	outfit = /datum/outfit/job/roguetown/apothecary
	display_order = JDO_APOTHECARY
	give_bank_account = 100
	min_pq = 1
	bypass_lastclass = TRUE
	cmode_music = 'sound/music/cmode/towner/CombatBeggar.ogg'

/datum/outfit/job/roguetown/apothecary/pre_equip(mob/living/carbon/human/H)
	..()
	armor = /obj/item/clothing/suit/roguetown/armor/gambeson/apothecary
	shoes = /obj/item/clothing/shoes/roguetown/apothboots
	shirt = /obj/item/clothing/suit/roguetown/shirt/apothshirt
	pants = /obj/item/clothing/under/roguetown/trou/apothecary
	gloves = /obj/item/clothing/gloves/roguetown/leather/apothecary
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/storage/keyring/niteman
	beltl = /obj/item/storage/belt/rogue/pouch/coins/mid
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_LEGENDARY_ALCHEMIST, TRAIT_GENERIC)
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/stealing, 5, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/alchemy, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/farming, 3, TRUE)
		H.change_stat("strength", -1)
		H.change_stat("intelligence", 1)

	if(H.gender == MALE)
		if(H.dna?.species)
			if(H.dna.species.id == "human")
				H.dna.species.soundpack_m = new /datum/voicepack/male/zeth()
