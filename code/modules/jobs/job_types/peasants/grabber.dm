/datum/job/grabber
	title = "Stevedore"
	tutorial = "Being a stevedore is one of the lowest yet most needed positions in town, \
	as they are expected to aid the Merchant, Steward, Masons, and Blacksmiths \
	in hauling materials and goods while keeping a guarding eye on the town's warehouses \
	for the safety of the items stashed within."
	flag = GRABBER
	department_flag = PEASANTS
	display_order = JDO_GRABBER
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	faction = FACTION_STATION
	total_positions = 6
	spawn_positions = 6
	min_pq = -50
	bypass_lastclass = TRUE

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Dark Elf",
		"Aasimar",
		"Half-Orc"
	)

	outfit = /datum/outfit/job/grabber
	give_bank_account = TRUE
	cmode_music = 'sound/music/cmode/towner/CombatTowner.ogg'

/datum/outfit/job/grabber/pre_equip(mob/living/carbon/human/H)
	..()

	wrists = /obj/item/storage/keyring/stevedore
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE) // You get a cudgel for nonlethal self defense and that's it.
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)//they can use the merchant machine and that's it
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.change_stat(STATKEY_STR, 1)
	if(H.gender == MALE)
		shoes = /obj/item/clothing/shoes/boots/leather
		pants = /obj/item/clothing/pants/tights/sailor
		head = /obj/item/clothing/head/headband/red
		beltr = /obj/item/weapon/mace/cudgel
		beltl = /obj/item/storage/belt/pouch/coins/poor
		belt = /obj/item/storage/belt/leather/rope
		armor = /obj/item/clothing/armor/leather/jacket/sea
		shirt = /obj/item/clothing/shirt/undershirt/sailor/red
		H.change_stat(STATKEY_END, 1)
		H.change_stat(STATKEY_CON, 1)
		H.change_stat(STATKEY_STR, 1)//thug bodytype
	else
		shoes = /obj/item/clothing/shoes/gladiator
		pants = /obj/item/clothing/pants/tights/sailor
		beltr = /obj/item/weapon/mace/cudgel
		beltl = /obj/item/storage/belt/pouch/coins/poor
		belt = /obj/item/storage/belt/leather/rope
		shirt = /obj/item/clothing/shirt/undershirt/sailor
		armor = /obj/item/clothing/armor/leather/jacket/sea
		head = /obj/item/clothing/head/headband
		H.change_stat(STATKEY_END, 1)
		H.change_stat(STATKEY_INT, 1)
		H.change_stat(STATKEY_SPD, 1)
	ADD_TRAIT(H, TRAIT_CRATEMOVER, type)
