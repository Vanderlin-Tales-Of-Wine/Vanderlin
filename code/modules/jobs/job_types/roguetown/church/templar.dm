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
	total_positions = 2
	spawn_positions = 2
	display_order = JDO_TEMPLAR
	give_bank_account = 0
	min_pq = 4

/datum/outfit/job/roguetown/templar
	name = "Templar"
	jobtype = /datum/job/roguetown/templar
	allowed_patrons = ALL_TEMPLAR_PATRONS

/datum/outfit/job/roguetown/templar/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/heavy/bucket
	cloak = /obj/item/clothing/cloak/tabard/crusader/tief
	switch(H.patron?.type)
		if(/datum/patron/divine/astrata)
			neck = /obj/item/clothing/neck/roguetown/psycross/silver/astrata
			head = /obj/item/clothing/head/roguetown/helmet/heavy/necked/astrata
			cloak = /obj/item/clothing/cloak/stabard/templar/astrata
			H.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'
		if(/datum/patron/divine/noc)
			neck = /obj/item/clothing/neck/roguetown/psycross/noc
			head = /obj/item/clothing/head/roguetown/helmet/heavy/necked/noc
			cloak = /obj/item/clothing/cloak/stabard/templar/noc
			H.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'
		if(/datum/patron/divine/dendor)
			neck = /obj/item/clothing/neck/roguetown/psycross/silver/dendor
			head = /obj/item/clothing/head/roguetown/helmet/heavy/dendorhelm
			cloak = /obj/item/clothing/cloak/stabard/templar/dendor
			H.cmode_music = 'sound/music/cmode/garrison/CombatForestGarrison.ogg'
		if(/datum/patron/divine/necra)
			neck = /obj/item/clothing/neck/roguetown/psycross/silver/necra
			head = /obj/item/clothing/head/roguetown/helmet/heavy/necked/necra
			cloak = /obj/item/clothing/cloak/stabard/templar/necra
			H.cmode_music = 'sound/music/cmode/church/CombatGravekeeper.ogg'
		if(/datum/patron/divine/pestra)
			wrists = /obj/item/clothing/neck/roguetown/psycross/silver/pestra
			head = /obj/item/clothing/head/roguetown/helmet/heavy/pestrahelm
			cloak = /obj/item/clothing/cloak/stabard/templar/pestra
			H.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'
		if(/datum/patron/divine/eora)
			head = /obj/item/clothing/head/roguetown/helmet/sallet/eoran
			wrists = /obj/item/clothing/neck/roguetown/psycross/silver/eora
			neck = /obj/item/clothing/neck/roguetown/chaincoif
			cloak = /obj/item/clothing/cloak/stabard/templar/eora
			H.cmode_music = 'sound/music/cmode/church/CombatEora.ogg'
			H.virginity = FALSE
		if(/datum/patron/divine/ravox)
			wrists = /obj/item/clothing/neck/roguetown/psycross/silver/ravox
			head = /obj/item/clothing/head/roguetown/helmet/heavy/ravox
			cloak = /obj/item/clothing/cloak/stabard/templar/ravox
			H.cmode_music = 'sound/music/cmode/adventurer/CombatOutlander2.ogg'
		if(/datum/patron/divine/malum)
			wrists = /obj/item/clothing/neck/roguetown/psycross/silver/malum
			head = /obj/item/clothing/head/roguetown/helmet/heavy/malumhelm
			cloak = /obj/item/clothing/cloak/stabard/templar/malum
			H.cmode_music = 'sound/music/cmode/adventurer/CombatOutlander2.ogg'
		if(/datum/patron/divine/abyssor)
			wrists = /obj/item/clothing/neck/roguetown/psycross/silver/abyssor
			H.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'
			H.mind?.adjust_skillrank(/datum/skill/labor/fishing, 1, TRUE)


	armor = /obj/item/clothing/suit/roguetown/armor/chainmail/hauberk
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson
	pants = /obj/item/clothing/under/roguetown/chainlegs
	shoes = /obj/item/clothing/shoes/roguetown/boots
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/storage/keyring/priest = 1)
	backr = /obj/item/rogueweapon/shield/tower/metal
	belt = /obj/item/storage/belt/rogue/leather/black
	beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
	id = /obj/item/clothing/ring/silver
	gloves = /obj/item/clothing/gloves/roguetown/chain
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
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
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
	switch(H.patron?.type)
		if(/datum/patron/divine/malum)
			H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 4, TRUE)
			beltr = /obj/item/rogueweapon/mace/warhammer/steel
		else
			H.mind?.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
			beltr = /obj/item/rogueweapon/sword/long
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
