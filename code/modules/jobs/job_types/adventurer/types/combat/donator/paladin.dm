/datum/advclass/combat/paladin
	name = "Paladin"
	tutorial = "Paladins are former noblemen and clerics who have dedicated themselves to great combat prowess. Often, they were promised redemption for past sins if they crusaded in the name of the gods."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_PLAYER_NONDISCRIMINATED
	outfit = /datum/outfit/job/adventurer/paladin
	maximum_possible_slots = 1
	min_pq = 2
	pickprob = 15
	category_tags = list(CTAG_ADVENTURER)

/datum/outfit/job/adventurer/paladin/pre_equip(mob/living/carbon/human/H)
	..()
	H.virginity = TRUE

	switch(H.patron?.type)
		if(/datum/patron/psydon, /datum/patron/psydon/progressive)
			head = /obj/item/clothing/head/helmet/heavy/bucket/gold
			wrists = /obj/item/clothing/neck/psycross/g
			H.cmode_music = 'sound/music/cmode/church/CombatInquisitor.ogg'
		if(/datum/patron/divine/astrata)
			head = /obj/item/clothing/head/helmet/heavy/necked/astrata
			wrists = /obj/item/clothing/neck/psycross/silver/astrata
			H.cmode_music = 'sound/music/cmode/church/CombatAstrata.ogg'
		if(/datum/patron/divine/noc)
			head = /obj/item/clothing/head/helmet/heavy/necked/noc
			wrists = /obj/item/clothing/neck/psycross/noc
			H.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'
		if(/datum/patron/divine/dendor)
			head = /obj/item/clothing/head/helmet/heavy/necked/dendorhelm
			wrists = /obj/item/clothing/neck/psycross/silver/dendor
			H.cmode_music = 'sound/music/cmode/garrison/CombatForestGarrison.ogg'
		if(/datum/patron/divine/abyssor)
			head = /obj/item/clothing/head/helmet/heavy/necked // Placeholder
			wrists = /obj/item/clothing/neck/psycross/silver/abyssor
			H.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'
		if(/datum/patron/divine/necra)
			head = /obj/item/clothing/head/helmet/heavy/necked/necra
			wrists = /obj/item/clothing/neck/psycross/silver/necra
			H.cmode_music = 'sound/music/cmode/church/CombatGravekeeper.ogg'
		if(/datum/patron/divine/ravox)
			head = /obj/item/clothing/head/helmet/heavy/necked/ravox
			wrists = /obj/item/clothing/neck/psycross/silver/ravox
			H.cmode_music = 'sound/music/cmode/adventurer/CombatOutlander2.ogg'
		if(/datum/patron/divine/xylix)
			head = /obj/item/clothing/head/helmet/heavy/necked // Placeholder
			wrists = /obj/item/clothing/neck/psycross/silver/xylix
			H.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'
		if(/datum/patron/divine/pestra)
			head = /obj/item/clothing/head/helmet/heavy/necked/pestrahelm
			wrists = /obj/item/clothing/neck/psycross/silver/pestra
			H.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'
		if(/datum/patron/divine/malum)
			head = /obj/item/clothing/head/helmet/heavy/necked/malumhelm
			wrists = /obj/item/clothing/neck/psycross/silver/malum
			H.cmode_music = 'sound/music/cmode/adventurer/CombatOutlander2.ogg'
		if(/datum/patron/divine/eora)
			head = /obj/item/clothing/head/helmet/sallet/eoran
			wrists = /obj/item/clothing/neck/psycross/silver/eora
			H.cmode_music = 'sound/music/cmode/church/CombatEora.ogg'
			H.virginity = FALSE
			ADD_TRAIT(H, TRAIT_BEAUTIFUL, TRAIT_GENERIC)
		if(/datum/patron/inhumen/graggar) // Heretical Patrons
			head = /obj/item/clothing/head/helmet/heavy/sinistar
			H.cmode_music = 'sound/music/cmode/antag/combat_werewolf.ogg'
			H.change_stat(STATKEY_LCK, -2)
			GLOB.heretical_players += H.real_name
		if(/datum/patron/inhumen/graggar_zizo)
			head = /obj/item/clothing/head/helmet/heavy/sinistar
			H.cmode_music = 'sound/music/cmode/antag/combat_werewolf.ogg'
		if(/datum/patron/inhumen/zizo)
			head = /obj/item/clothing/head/helmet/skullcap/cult
			H.cmode_music = 'sound/music/cmode/antag/combat_cult.ogg'
			H.change_stat(STATKEY_LCK, -2)
			GLOB.heretical_players += H.real_name
		if(/datum/patron/inhumen/matthios)
			head = /obj/item/clothing/head/helmet/heavy/rust
			H.cmode_music = 'sound/music/cmode/antag/CombatBandit1.ogg'
			H.change_stat(STATKEY_LCK, -2)
			GLOB.heretical_players += H.real_name
		if(/datum/patron/inhumen/baotha)
			head = /obj/item/clothing/head/crown/circlet
			mask = /obj/item/clothing/face/spectacles/sglasses
			H.cmode_music = 'sound/music/cmode/antag/CombatBaotha.ogg'
			H.change_stat(STATKEY_LCK, -2)
			GLOB.heretical_players += H.real_name
		if(/datum/patron/godless)
			head = /obj/item/clothing/head/roguehood/green
			H.cmode_music = 'sound/music/cmode/church/CombatInquisitor.ogg'
			H.change_stat(STATKEY_LCK, -2)
			GLOB.heretical_players += H.real_name
		else // Failsafe
			head = /obj/item/clothing/head/helmet/heavy/bucket
			wrists = /obj/item/clothing/neck/psycross/silver
			H.cmode_music = 'sound/music/cmode/church/CombatInquisitor.ogg'

	armor = /obj/item/clothing/armor/plate
	shirt = /obj/item/clothing/armor/chainmail
	pants = /obj/item/clothing/pants/platelegs
	shoes = /obj/item/clothing/shoes/boots/armor
	belt = /obj/item/storage/belt/leather/steel
	beltl = /obj/item/storage/belt/pouch/coins/mid
	ring = /obj/item/clothing/ring/silver/toper
	cloak = /obj/item/clothing/cloak/tabard/crusader
	neck = /obj/item/clothing/neck/chaincoif
	gloves = /obj/item/clothing/gloves/plate
	backl = /obj/item/weapon/sword/long/judgement
	if(H.mind)
		H.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.adjust_skillrank(/datum/skill/magic/holy, 2, TRUE)
		H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)
		H.change_stat(STATKEY_STR, 2)
		H.change_stat(STATKEY_PER, 2)
		H.change_stat(STATKEY_INT, 2)
		H.change_stat(STATKEY_CON, 1)
		H.change_stat(STATKEY_END, 1)
		H.change_stat(STATKEY_SPD, -2)
		H.change_stat(STATKEY_LCK, 1)
		if(!H.has_language(/datum/language/celestial)) // For discussing church matters with the other Clergy
			H.grant_language(/datum/language/celestial)
			to_chat(H, "<span class='info'>I can speak Celestial with ,c before my speech.</span>")
	if(H.dna?.species)
		if(H.dna.species.id == "human")
			H.dna.species.soundpack_m = new /datum/voicepack/male/knight()
	var/datum/devotion/cleric_holder/C = new /datum/devotion/cleric_holder(H, H.patron)
	//Paladins, while devout warriors spent WAY too much time studying the blade. No more acolyte+
	C.grant_spells_templar(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)

	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
