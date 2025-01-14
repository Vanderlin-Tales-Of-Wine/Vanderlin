//shield
/datum/advclass/combat/cleric
	name = "Cleric"
	tutorial = "Clerics are wandering warriors of the Gods, drawn from the ranks of temple acolytes who demonstrated martial talent. Protected by armor and zeal, they are a force to be reckoned with."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Dark Elf",
		"Aasimar"
	)
	vampcompat = FALSE
	outfit = /datum/outfit/job/roguetown/adventurer/cleric
	category_tags = list(CTAG_ADVENTURER)
	min_pq = 0
	maximum_possible_slots = 4

/datum/outfit/job/roguetown/adventurer/cleric
	allowed_patrons = ALL_CLERIC_PATRONS

/datum/outfit/job/roguetown/adventurer/cleric/pre_equip(mob/living/carbon/human/H)
	..()
	H.virginity = TRUE

	armor = /obj/item/clothing/suit/roguetown/armor/cuirass // Halfplate has been made heavy armor, billions must make due.
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/rogueweapon/mace
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor

	switch(H.patron?.type)
		if(/datum/patron/divine/astrata)
			wrists = /obj/item/clothing/neck/roguetown/psycross/silver/astrata
			cloak = /obj/item/clothing/cloak/stabard/templar/astrata
			neck = /obj/item/clothing/neck/roguetown/chaincoif
		if(/datum/patron/divine/dendor)	// good helmet but no money
			head = /obj/item/clothing/head/roguetown/helmet/heavy/dendorhelm
			neck = /obj/item/clothing/neck/roguetown/coif
			wrists = /obj/item/clothing/neck/roguetown/psycross/silver/dendor
			cloak = /obj/item/clothing/cloak/raincloak/furcloak
			beltr = /obj/item/rogueweapon/knife/stone
		if(/datum/patron/divine/necra)
			wrists = /obj/item/clothing/neck/roguetown/psycross/silver/necra
			cloak = /obj/item/clothing/cloak/stabard/templar/necra
			neck = /obj/item/clothing/neck/roguetown/gorget
		if(/datum/patron/divine/eora)
			wrists = /obj/item/clothing/neck/roguetown/psycross/silver/eora
			cloak = /obj/item/clothing/cloak/stabard/templar/eora
			neck = /obj/item/clothing/neck/roguetown/chaincoif/iron
			H.virginity = FALSE
		if(/datum/patron/divine/ravox)
			wrists = /obj/item/clothing/neck/roguetown/psycross/silver/ravox
			cloak =  /obj/item/clothing/cloak/stabard/templar/ravox
			neck = /obj/item/clothing/neck/roguetown/gorget
		if(/datum/patron/divine/noc)
			wrists = /obj/item/clothing/neck/roguetown/psycross/noc
			cloak = /obj/item/clothing/cloak/stabard/templar/noc
			neck = /obj/item/clothing/neck/roguetown/chaincoif
		if(/datum/patron/divine/pestra)
			wrists = /obj/item/clothing/neck/roguetown/psycross/silver/pestra
			cloak = /obj/item/clothing/cloak/stabard/templar/pestra
			neck = /obj/item/clothing/neck/roguetown/chaincoif/iron
		if(/datum/patron/divine/abyssor)
			wrists = /obj/item/clothing/neck/roguetown/psycross/silver/abyssor
			cloak = /obj/item/clothing/cloak/tabard/crusader
			neck = /obj/item/clothing/neck/roguetown/chaincoif/iron
		if(/datum/patron/divine/malum)
			wrists = /obj/item/clothing/neck/roguetown/psycross/silver/malum
			cloak = /obj/item/clothing/cloak/stabard/templar/malum
			neck = /obj/item/clothing/neck/roguetown/gorget
		if(/datum/patron/divine/xylix)
			wrists = /obj/item/clothing/neck/roguetown/psycross/silver/xylix
			cloak = /obj/item/clothing/cloak/tabard/crusader
			neck = /obj/item/clothing/neck/roguetown/chaincoif/iron
		else // Failsafe
			cloak = /obj/item/clothing/cloak/tabard/crusader // Give us a generic crusade tabard
			wrists = /obj/item/clothing/neck/roguetown/psycross/silver // Give us a silver psycross for protection against lickers
			neck = /obj/item/clothing/neck/roguetown/chaincoif/iron


	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/magic/holy, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		if(H.age == AGE_OLD)
			H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/magic/holy, 1, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("intelligence", 1)
		H.change_stat("constitution", 1)
		H.change_stat("endurance", 2)
		H.change_stat("speed", -1)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC) // Even if it has limited slots, it is a common drifter role available to anyone. Their armor also is not heavy, so medium armor training is enough
	var/datum/devotion/cleric_holder/C = new /datum/devotion/cleric_holder(H, H.patron)
	C.grant_spells_cleric(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)

