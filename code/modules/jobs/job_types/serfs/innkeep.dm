/datum/job/innkeep
	title = "Innkeep"
	tutorial = "Liquor, lodging, and lavish meals... your business is the beating heart of Vanderlin. \
	You're the one who provides the the hardworking townsfolk with a place to eat and drink their sorrows away, \
	and accommodations for weary travelers passing through."
	flag = INNKEEP
	department_flag = SERFS
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_INNKEEP
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	min_pq = -10
	bypass_lastclass = TRUE

	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Dark Elf",
		"Aasimar"
	)

	outfit = /datum/outfit/job/innkeep
	give_bank_account = 60
	cmode_music = 'sound/music/cmode/towner/CombatInn.ogg'

/datum/outfit/job/innkeep
	job_bitflag = BITFLAG_CONSTRUCTOR

/datum/outfit/job/innkeep/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/mathematics, 2, TRUE)
	if(H.gender == MALE)
		pants = /obj/item/clothing/pants/tights/random
		shirt = /obj/item/clothing/shirt/shortshirt/random
		shoes = /obj/item/clothing/shoes/shortboots
		belt = /obj/item/storage/belt/leather
		beltl = /obj/item/storage/belt/pouch/coins/mid
		beltr = /obj/item/reagent_containers/glass/bottle/beer/blackgoat
		neck = /obj/item/storage/keyring/innkeep
		cloak = /obj/item/clothing/cloak/apron/waist
		H.change_stat(STATKEY_STR, 1)
		H.change_stat(STATKEY_END, 1)
	else
		armor = /obj/item/clothing/shirt/dress
		shoes = /obj/item/clothing/shoes/shortboots
		neck = /obj/item/storage/belt/pouch/coins/mid
		belt = /obj/item/storage/belt/leather
		beltl = /obj/item/storage/keyring/innkeep
		beltr = /obj/item/reagent_containers/glass/bottle/beer/blackgoat
		H.change_stat(STATKEY_END, 1)
		H.change_stat(STATKEY_CON, 1)
