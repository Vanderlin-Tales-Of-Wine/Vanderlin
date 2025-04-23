/datum/job/cook
	title = "Cook"
	tutorial = "Slice, chop, and into the pot... \
	you work closely with the innkeep to prepare meals for all the hungry mouths of Vanderlin. \
	You've spent more nites than you can count cutting meat and vegetables until your fingers are bloody and raw, but it's honest work."
	flag = COOK
	department_flag = PEASANTS
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	faction = FACTION_STATION
	total_positions = 3
	spawn_positions = 3
	min_pq = -20
	bypass_lastclass = TRUE

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Dark Elf",
		"Aasimar"
	)

	outfit = /datum/outfit/job/cook
	display_order = JDO_COOK
	give_bank_account = 8
	cmode_music = 'sound/music/cmode/towner/CombatInn.ogg'

/datum/outfit/job/cook
	job_bitflag = BITFLAG_CONSTRUCTOR

/datum/outfit/job/cook/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/butchering, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/taming, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
		if(H.age == AGE_OLD)
			H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	belt = /obj/item/storage/belt/leather/rope
	beltl = /obj/item/key/tavern
	beltr = /obj/item/weapon/knife/villager
	if(H.gender == MALE)
		pants = /obj/item/clothing/pants/tights/random
		shirt = /obj/item/clothing/shirt/shortshirt/random
		shoes = /obj/item/clothing/shoes/simpleshoes
		cloak = /obj/item/clothing/cloak/apron/cook
		head = /obj/item/clothing/head/cookhat
		neck = /obj/item/storage/belt/pouch/coins/poor
		H.change_stat(STATKEY_CON, 2)
	else
		shirt = /obj/item/clothing/shirt/undershirt/lowcut
		armor = /obj/item/clothing/armor/corset
		pants = /obj/item/clothing/pants/skirt/red
		cloak = /obj/item/clothing/cloak/apron/cook
		head = /obj/item/clothing/head/cookhat
		shoes = /obj/item/clothing/shoes/simpleshoes
		neck = /obj/item/storage/belt/pouch/coins/poor
		H.change_stat(STATKEY_CON, 2)
