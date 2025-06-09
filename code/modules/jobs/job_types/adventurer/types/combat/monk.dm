/datum/advclass/combat/monk
	name = "Monk"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_PLAYER_NONHERETICAL
	allowed_patrons = ALL_TEMPLE_PATRONS
	tutorial = "A traveling monk of the Ten, unmatched in the unarmed arts and with an unwavering devotion to their patron God's Justice."


	outfit = /datum/outfit/job/adventurer/monk
	min_pq = 0
	category_tags = list(CTAG_ADVENTURER)
	cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'
	vampcompat = FALSE

/datum/outfit/job/adventurer/monk
	allowed_patrons = ALL_TEMPLE_PATRONS  //randomize patron if not in ten

/datum/outfit/job/adventurer/monk/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguehood/brown
	shoes = /obj/item/clothing/shoes/shortboots
	cloak = /obj/item/clothing/cloak/raincloak/furcloak/brown
	armor = /obj/item/clothing/shirt/robe/plain
	wrists = /obj/item/clothing/wrists/bracers/leather
	belt = /obj/item/storage/belt/leather/rope
	beltr = /obj/item/storage/belt/pouch/coins/poor
	backl = /obj/item/storage/backpack/backpack
	backr = /obj/item/weapon/polearm/woodstaff
	neck = /obj/item/clothing/neck/psycross/silver
	switch(H.patron?.type)
		if(/datum/patron/divine/astrata)
			neck = /obj/item/clothing/neck/psycross/silver/astrata
		if(/datum/patron/divine/necra) //Necra acolytes are now gravetenders
			neck = /obj/item/clothing/neck/psycross/silver/necra
		if(/datum/patron/divine/eora)
			neck = /obj/item/clothing/neck/psycross/silver/eora
		if(/datum/patron/divine/noc)
			neck = /obj/item/clothing/neck/psycross/noc
		if(/datum/patron/divine/pestra)
			neck = /obj/item/clothing/neck/psycross/silver/pestra
		if(/datum/patron/divine/dendor)
			neck = /obj/item/clothing/neck/psycross/silver/dendor
		if(/datum/patron/divine/abyssor)
			neck = /obj/item/clothing/neck/psycross/silver/abyssor
		if(/datum/patron/divine/ravox)
			neck = /obj/item/clothing/neck/psycross/silver/ravox
		if(/datum/patron/divine/xylix)
			neck = /obj/item/clothing/neck/psycross/silver/xylix
		if(/datum/patron/divine/malum)
			neck = /obj/item/clothing/neck/psycross/silver/malum

	if(H.dna.species.id == "elf")
		H.change_stat(STATKEY_SPD, -1)
	if(H.dna.species.id == "harpy")
		H.change_stat(STATKEY_SPD, -1)
		H.change_stat(STATKEY_STR, 1) //harpies are possible monks but have -4 strength per default... I'm going to let them have at least some decent dodging bonuses.
	if(H.dna.species.id == "kobold")
		H.change_stat(STATKEY_STR, 2) //Go, my child. Destroy their ankles.
		H.change_stat(STATKEY_SPD, -1)


	var/datum/devotion/cleric_holder/C = new /datum/devotion/cleric_holder(H, H.patron)
	C.grant_spells_churchling(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)

	if(H.mind)


		H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/unarmed, 5, TRUE)
		H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.adjust_skillrank(/datum/skill/combat/polearms, pick(1,1,2), TRUE) // Wood staff
		H.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.adjust_skillrank(/datum/skill/misc/athletics, pick(2,2,3), TRUE)

		H.change_stat(STATKEY_STR, 2)
		H.change_stat(STATKEY_CON, 2)
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_PER, -1)
		H.change_stat(STATKEY_SPD, 2)

	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)


