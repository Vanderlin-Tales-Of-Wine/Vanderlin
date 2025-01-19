/datum/job/roguetown/steward
	title = "Steward"
	flag = STEWARD
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf"
	)
	allowed_sexes = list(MALE, FEMALE)
	display_order = JDO_STEWARD
	bypass_lastclass = TRUE
	tutorial = "Coin, Coin, Coin! Oh beautiful coin: Youre addicted to it, and you hold the position as the King's personal treasurer of both coin and information. You know the power silver and gold has on a man's mortal soul, and you know just what lengths theyll go to in order to get even more. Keep your festering economy and your rats alive, theyre the only two things you can weigh any trust into anymore."
	outfit = /datum/outfit/job/roguetown/steward
	give_bank_account = 100
	min_pq = 2
	cmode_music = 'sound/music/cmode/nobility/combat_noble.ogg'

/datum/outfit/job/roguetown/steward/pre_equip(mob/living/carbon/human/H)
	..()
	H.virginity = TRUE
	if(H.gender == FEMALE)
		shirt = /obj/item/clothing/suit/roguetown/shirt/dress/stewarddress
	else
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/fancy
		pants = /obj/item/clothing/under/roguetown/trou/leathertights

	ADD_TRAIT(H, TRAIT_SEEPRICES, type)
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes/buckle
	head = /obj/item/clothing/head/roguetown/stewardtophat
	cloak = /obj/item/clothing/cloak/raincloak/furcloak
	armor = /obj/item/clothing/suit/roguetown/armor/gambeson/steward
	belt = /obj/item/storage/belt/rogue/leather/plaquesilver
	beltr = /obj/item/storage/keyring/steward
	beltl = /obj/item/rogueweapon/knife/dagger/steel
	backr = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/storage/belt/rogue/pouch/coins/rich = 1, /obj/item/lockpickring/mundane = 1)

	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 6, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking, 6, TRUE)
		H.change_stat("strength", -2)
		H.change_stat("intelligence", 8)
		H.change_stat("constitution", -2)
		H.change_stat("speed", -2)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
