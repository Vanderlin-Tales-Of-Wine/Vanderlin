/datum/job/monk
	title = "Acolyte"
	flag = MONK
	department_flag = CHURCHMEN
	faction = "Station"
	total_positions = 4
	spawn_positions = 4

	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Dark Elf",
		"Aasimar"
	)
	tutorial = "Chores, exercise, prayer... and more chores. You are a humble acolyte at the temple in Vanderlin, not yet a trained guardian or an ordained priest. But who else would keep the fires lit and the floors clean?"
	allowed_patrons = ALL_TEMPLE_PATRONS
	outfit = /datum/outfit/job/monk

	display_order = JDO_MONK
	give_bank_account = TRUE
	min_pq = -10
	bypass_lastclass = TRUE

/datum/outfit/job/monk
	name = "Acolyte"
	jobtype = /datum/job/monk
	allowed_patrons = ALL_TEMPLE_PATRONS
	job_bitflag = BITFLAG_CHURCH

/datum/outfit/job/monk/pre_equip(mob/living/carbon/human/H)
	..()
	H.virginity = TRUE
	belt = /obj/item/storage/belt/leather/rope
	beltr = /obj/item/storage/belt/pouch/coins/poor
	beltl = /obj/item/key/church
	backl = /obj/item/weapon/polearm/woodstaff/quarterstaff
	backpack_contents = list(/obj/item/needle)
	switch(H.patron?.type)
		if(/datum/patron/divine/astrata)
			head = /obj/item/clothing/head/roguehood/astrata
			neck = /obj/item/clothing/neck/psycross/silver/astrata
			wrists = /obj/item/clothing/wrists/wrappings
			shoes = /obj/item/clothing/shoes/sandals
			armor = /obj/item/clothing/shirt/robe/astrata
			H.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'
		if(/datum/patron/divine/necra) //Necra acolytes are now gravetenders
			head = /obj/item/clothing/head/padded/deathshroud
			neck = /obj/item/clothing/neck/psycross/silver/necra
			shoes = /obj/item/clothing/shoes/boots
			pants = /obj/item/clothing/pants/trou/leather/mourning
			armor = /obj/item/clothing/shirt/robe/necra
			H.cmode_music = 'sound/music/cmode/church/CombatGravekeeper.ogg'
		if(/datum/patron/divine/eora)
			head = /obj/item/clothing/head/padded/operavisage
			neck = /obj/item/clothing/neck/psycross/silver/eora
			shoes = /obj/item/clothing/shoes/sandals
			armor = /obj/item/clothing/shirt/robe/eora
			H.cmode_music = 'sound/music/cmode/church/CombatEora.ogg'
			ADD_TRAIT(H, TRAIT_BEAUTIFUL, TRAIT_GENERIC)
			H.virginity = FALSE
		if(/datum/patron/divine/noc)
			head = /obj/item/clothing/head/roguehood/nochood
			neck = /obj/item/clothing/neck/psycross/noc
			wrists = /obj/item/clothing/wrists/nocwrappings
			shoes = /obj/item/clothing/shoes/sandals
			armor = /obj/item/clothing/shirt/robe/noc
			H.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'
		if(/datum/patron/divine/pestra)
			head = /obj/item/clothing/head/padded/pestra
			neck = /obj/item/clothing/neck/psycross/silver/pestra
			shoes = /obj/item/clothing/shoes/sandals
			armor = /obj/item/clothing/shirt/robe/pestra
			H.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'
		if(/datum/patron/divine/dendor)
			head = /obj/item/clothing/head/padded/briarthorns
			neck = /obj/item/clothing/neck/psycross/silver/dendor
			shoes = /obj/item/clothing/shoes/sandals
			armor = /obj/item/clothing/shirt/robe/dendor
			H.cmode_music = 'sound/music/cmode/garrison/CombatForestGarrison.ogg'
		if(/datum/patron/divine/abyssor)
			head = /obj/item/clothing/head/roguehood/random
			neck = /obj/item/clothing/neck/psycross/silver/abyssor
			shoes = /obj/item/clothing/shoes/boots
			armor = /obj/item/clothing/shirt/robe/plain
			H.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'
			H.mind?.adjust_skillrank(/datum/skill/labor/fishing, 1, TRUE)
		if(/datum/patron/divine/ravox)
			head = /obj/item/clothing/head/roguehood/random
			neck = /obj/item/clothing/neck/psycross/silver/ravox
			shoes = /obj/item/clothing/shoes/boots
			armor = /obj/item/clothing/shirt/robe/plain
			H.cmode_music = 'sound/music/cmode/adventurer/CombatOutlander2.ogg'
			H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		if(/datum/patron/divine/xylix)
			head = /obj/item/clothing/head/roguehood/random
			neck = /obj/item/clothing/neck/psycross/silver/xylix
			shoes = /obj/item/clothing/shoes/boots
			armor = /obj/item/clothing/shirt/robe/plain
			H.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'
			H.mind?.adjust_skillrank(/datum/skill/misc/stealing, 1, TRUE)
		if(/datum/patron/divine/malum)
			head = /obj/item/clothing/head/roguehood/random
			neck = /obj/item/clothing/neck/psycross/silver/malum
			shoes = /obj/item/clothing/shoes/boots
			armor = /obj/item/clothing/shirt/robe/plain
			backpack_contents += /obj/item/weapon/hammer/iron
			H.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'
		else // Failsafe
			head = /obj/item/clothing/head/roguehood/random
			neck = /obj/item/clothing/neck/psycross/silver
			shoes = /obj/item/clothing/shoes/boots
			armor = /obj/item/clothing/shirt/robe/plain
			H.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'


	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE) // They get this and a wooden staff to defend themselves
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/magic/holy, 3, TRUE)
		if(H.age == AGE_OLD)
			H.mind?.adjust_skillrank(/datum/skill/magic/holy, 1, TRUE)
		H.change_stat(STATKEY_INT, 1)
		H.change_stat(STATKEY_END, 2) // For casting lots of spells, and working long hours without sleep at the church
		H.change_stat(STATKEY_PER, -1)

	var/datum/devotion/cleric_holder/C = new /datum/devotion/cleric_holder(H, H.patron)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)
	C.grant_spells(H)
