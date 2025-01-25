/datum/job/roguetown/guildmaster
	title = "Guild Master"
	flag = GUILDMASTER
	department_flag = PEASANTS
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_races = ALL_PLAYER_RACES_BY_NAME
	//I say we let all races be the Guild Master, this is job concerns the adventurers guild, and those come in all types and sizes, it makes it feel more like "it could've been anyone, but you got me"
	tutorial = "N/A"

	display_order = JDO_GUILDMASTER
	bypass_lastclass = TRUE

	outfit = /datum/outfit/job/roguetown/guildmaster
	bypass_lastclass = TRUE
	give_bank_account = 100
	min_pq = 0
	selection_color = "#cc2609"

/datum/outfit/job/roguetown/guildmaster/pre_equip(mob/living/carbon/human/H)
	..()

	neck = /obj/item/clothing/neck/roguetown/horus
	backr = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/storage/belt/rogue/pouch/coins/veryrich = 1, /obj/item/merctoken = 1)
	beltr = /obj/item/rogueweapon/sword/rapier
	belt = /obj/item/storage/belt/rogue/leather/plaquesilver
	beltl = /obj/item/storage/keyring/merchant
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/merchant
	head = /obj/item/clothing/head/roguetown/chaperon
	id = /obj/item/clothing/ring/gold/guild_mercator

	if(H.gender == MALE)
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/sailor
		pants = /obj/item/clothing/under/roguetown/tights/sailor
		shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	else
		shirt = /obj/item/clothing/suit/roguetown/shirt/tunic/blue
		shoes = /obj/item/clothing/shoes/roguetown/gladiator

	ADD_TRAIT(H, TRAIT_SEEPRICES, type)


	H.change_stat("intelligence", 2)
	H.change_stat("perception", 1)
	H.change_stat("strength", 1)

	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/mathematics, 4, TRUE) // don't think this is used anywhere
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
