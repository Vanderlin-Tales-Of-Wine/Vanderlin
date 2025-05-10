/datum/job/merchant
	title = "Merchant"
	tutorial = "Born a wastrel in the dirt, you clawed your way up. Either by luck or, gods forbid, effort to earn a place in the Merchant's Guild.\
	Now, you are either a ruthless economist or a disgraced steward from distant lands. Where you came from no longer matters.\
	What matters now is you make sure the fools around you keep buying what you sell. Everything has a price, and you shall be the beating heart of this economy."
	flag = MERCHANT
	department_flag = COMPANY
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE )
	display_order = JDO_MERCHANT
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	min_pq = 1
	bypass_lastclass = TRUE
	selection_color = "#192bc2"

	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Dark Elf",
		"Aasimar",
		"Rakshari",
		"Hollow-Kin",
	)

	outfit = /datum/outfit/job/merchant
	give_bank_account = 100

/datum/outfit/job/merchant/pre_equip(mob/living/carbon/human/H)
	..()

	neck = /obj/item/clothing/neck/horus
	backr = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/storage/belt/pouch/coins/veryrich = 1, /obj/item/merctoken = 1)
	beltr = /obj/item/weapon/sword/rapier
	belt = /obj/item/storage/belt/leather/plaquesilver
	beltl = /obj/item/storage/keyring/merchant
	armor = /obj/item/clothing/shirt/robe/merchant
	head = /obj/item/clothing/head/chaperon/greyscale/silk/random
	ring = /obj/item/clothing/ring/gold/guild_mercator

	if(H.gender == MALE)
		shirt = /obj/item/clothing/shirt/undershirt/sailor
		pants = /obj/item/clothing/pants/tights/sailor
		shoes = /obj/item/clothing/shoes/boots/leather
	else
		shirt = /obj/item/clothing/shirt/tunic/blue
		shoes = /obj/item/clothing/shoes/gladiator

	ADD_TRAIT(H, TRAIT_SEEPRICES, type)

	H.change_stat(STATKEY_INT, 2)
	H.change_stat(STATKEY_PER, 1)
	H.change_stat(STATKEY_STR, -1)

	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/stealing, 6, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/mathematics, 5, TRUE)
