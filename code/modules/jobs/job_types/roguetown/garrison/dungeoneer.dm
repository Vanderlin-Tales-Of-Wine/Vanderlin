/datum/job/roguetown/dungeoneer
	title = "Dungeoneer"
	flag = DUNGEONEER
	department_flag = GARRISON // we should move this to the keep since that is where they now work, tending to the prisoners.
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_races = list(
		"Humen",
		"Elf",		// Elsewhere lore suggests ancient elves were cannibals, so why not. N.
		"Half-Elf",	// Half-elves are often the unwanted dregs of society. N.
		"Dwarf",
		"Tiefling",
		"Dark Elf",
		"Aasimar",
		"Half-Orc"
	)
	allowed_sexes = list(MALE, FEMALE)

	display_order = JDO_DUNGEONEER

	tutorial = "Be you an instrument of sadism for the King or the guarantor of his merciful hospitality, your duties are a service paid for most handsomely. Perhaps you were promoted from the garrison down to these cells to get your brutality off the town streets where cracked skulls caused outcries, or maybe your soft-hearted lord wanted to be sure his justice was done without malice. In either case, your little world is the lowest office in the Realm; from it your guests see only hell." // changed to reduce dictation of character. Nikov.

	outfit = /datum/outfit/job/roguetown/dungeoneer
	give_bank_account = 50
	min_pq = 6

	cmode_music = 'sound/music/cmode/nobility/CombatDungeoneer.ogg'

/datum/outfit/job/roguetown/dungeoneer/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/menacing
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor	// Small storage. N.
	pants = /obj/item/clothing/under/roguetown/trou
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	cloak = /obj/item/clothing/cloak/stabard/dungeon
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/rogueweapon/whip/antique
	beltl = /obj/item/storage/keyring/dungeoneer
	backr = /obj/item/storage/backpack/rogue/satchel	// lack of satchel requires dealing with the merchant to correct, which requires entering town; not ideal. N.

	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE) // Allow reading notes passed to the literate noble prisoner, or writing reports. N. See peasants\prisoner.dm.
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/traps, 3, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("intelligence", -2)
		H.change_stat("endurance", 2)
		H.change_stat("constitution", 1)
		H.change_stat("speed", -1)
		H.change_stat("perception", -1)
	if(H.dna?.species)
		if(H.dna.species.id == "human")
			H.dna.species.soundpack_m = new /datum/voicepack/male/warrior()
	H.verbs |= /mob/living/carbon/human/proc/torture_victim
