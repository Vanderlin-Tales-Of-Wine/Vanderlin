/datum/job/roguetown/templar
	title = "Templar"
	department_flag = CHURCHMEN
	faction = "Station"
	tutorial = "Templars are warriors who have forsaken wealth and title in lieu of service to the church, due to either zealotry or a past shame. They guard the church and its priest, while keeping a watchful eye against heresy and nite-creechers. Within troubled dreams, they wonder if the blood they shed makes them holy or stained."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Elf",
		"Dwarf",
		"Aasimar",
		"Half-Elf",
	)
	allowed_patrons = ALL_TEMPLAR_PATRONS
	outfit = /datum/outfit/job/roguetown/templar
	total_positions = 1
	spawn_positions = 1
	display_order = JDO_TEMPLAR
	give_bank_account = 0
	min_pq = 2

/datum/outfit/job/roguetown/templar
	name = "Templar"
	jobtype = /datum/job/roguetown/templar
	allowed_patrons = ALL_TEMPLAR_PATRONS

/datum/outfit/job/roguetown/templar/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/heavy/bucket
	cloak = /obj/item/clothing/cloak/tabard/crusader/tief
	switch(H.patron.name)
		if("Astrata")
			neck = /obj/item/clothing/neck/roguetown/psycross/silver/astrata
			head = /obj/item/clothing/head/roguetown/helmet/heavy/necked/astrata
			cloak = /obj/item/clothing/cloak/stabard/templar/astrata
		if("Noc")
			neck = /obj/item/clothing/neck/roguetown/psycross/noc
			head = /obj/item/clothing/head/roguetown/helmet/heavy/necked/noc
			cloak = /obj/item/clothing/cloak/stabard/templar/noc
		if("Dendor")
			neck = /obj/item/clothing/neck/roguetown/psycross/silver/dendor
			head = /obj/item/clothing/head/roguetown/helmet/heavy/dendorhelm
			cloak = /obj/item/clothing/cloak/stabard/templar/dendor
		if("Necra")
			neck = /obj/item/clothing/neck/roguetown/psycross/silver/necra
			head = /obj/item/clothing/head/roguetown/helmet/heavy/necked/necra
			cloak = /obj/item/clothing/cloak/stabard/templar/necra
		if("Pestra")
			wrists = /obj/item/clothing/neck/roguetown/psycross/silver/pestra
			head = /obj/item/clothing/head/roguetown/helmet/heavy/pestrahelm
			cloak = /obj/item/clothing/cloak/stabard/templar/pestra
		if("Eora")
			head = /obj/item/clothing/head/roguetown/helmet/sallet/eoran
			wrists = /obj/item/clothing/neck/roguetown/psycross/silver/eora
			neck = /obj/item/clothing/neck/roguetown/chaincoif
			cloak = /obj/item/clothing/cloak/stabard/templar/eora
			H.virginity = FALSE
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	pants = /obj/item/clothing/under/roguetown/chainlegs
	shoes = /obj/item/clothing/shoes/roguetown/boots
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/storage/keyring/priest = 1)
	backr = /obj/item/rogueweapon/shield/tower/metal
	belt = /obj/item/storage/belt/rogue/leather/black
	beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
	beltr = /obj/item/rogueweapon/sword/long
	id = /obj/item/clothing/ring/silver
	gloves = /obj/item/clothing/gloves/roguetown/chain
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/magic/holy, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("constitution", 2)
		H.change_stat("endurance", 2)
		H.change_stat("speed", -1)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)

	var/datum/devotion/cleric_holder/C = new /datum/devotion/cleric_holder(H, H.patron)
	//Max devotion limit - Templars are stronger but cannot pray to gain more abilities beyond t1
	C.grant_spells_templar(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)
	if(H.dna?.species)
		if(H.dna.species.id == "humen")
			H.dna.species.soundpack_m = new /datum/voicepack/male/knight()



