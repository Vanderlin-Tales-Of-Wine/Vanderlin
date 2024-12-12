/datum/job/roguetown/niteman
	title = "Apothecary"
	flag = NIGHTMAN
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	f_title = "Apothecary"

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

	tutorial = "You are a dealer of all things drugs. You operate on the dark side of town, a necessary evil to maintain sanity. Having moved into an old bathhouse, you have set up shop to trade substances... whether you import them or concoct them yourself."

	allowed_sexes = list(MALE, FEMALE)
	outfit = /datum/outfit/job/roguetown/niteman
	display_order = JDO_NITEMAN
	give_bank_account = 100
	min_pq = 1
	bypass_lastclass = TRUE
	cmode_music = 'sound/music/cmode/towner/CombatBeggar.ogg'

/datum/outfit/job/roguetown/niteman/pre_equip(mob/living/carbon/human/H)
	..()
	armor = /obj/item/clothing/suit/roguetown/armor/leather/jacket/niteman
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	belt = /obj/item/storage/belt/rogue/leather/rope
	beltr = /obj/item/keyring/niteman
	beltl = /obj/item/storage/belt/rogue/pouch/coins/mid
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
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
		H.mind?.adjust_skillrank(/datum/skill/labor/farming, 3, TRUE)
		H.change_stat("strength", -1)
		H.change_stat("intelligence", 1)

	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/trou/leather
		armor = /obj/item/clothing/suit/roguetown/armor/leather/jacket/niteman
		if(H.dna?.species)
			if(H.dna.species.id == "human")
				H.dna.species.soundpack_m = new /datum/voicepack/male/zeth()
			if(H.dna.species.id == "elf")
				armor = /obj/item/clothing/suit/roguetown/armor/leather/jacket/sea
			if(H.dna.species.id == "dwarf")
				armor = /obj/item/clothing/suit/roguetown/armor/leather/jacket/sea
	else
		pants = /obj/item/clothing/under/roguetown/tights
