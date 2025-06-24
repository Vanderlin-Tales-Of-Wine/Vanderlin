//rapier/sabre

/datum/advclass/combat/swashbuckler
	name = "Swashbuckler"
	tutorial = "Woe the Sea King! You awake, dazed from a true festivity of revelry and feasting. The last thing you remember? Your mateys dumping you over the side of the boat as a joke. Now on some Gods foresaken rock, Abyssor will present you with booty and fun, no doubt."
	allowed_races = list(\
		RACE_ID_HUMEN,\
		RACE_ID_ELF,\
		RACE_ID_HALF_ELF,\
		RACE_ID_TIEFLING,\
		RACE_ID_AASIMAR,\
		RACE_ID_HALF_ORC,\
		RACE_ID_RAKSHARI,\
	)
	outfit = /datum/outfit/job/adventurer/swashbuckler
	maximum_possible_slots = 1
	min_pq = 0
	pickprob = 30
	category_tags = list(CTAG_ADVENTURER)

/datum/outfit/job/adventurer/swashbuckler
	head = /obj/item/clothing/head/helmet/leather/headscarf
	pants = /obj/item/clothing/pants/tights/sailor
	belt = /obj/item/storage/belt/leather
	armor = /obj/item/clothing/armor/leather/jacket/sea
	backl = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/natural/worms/leech = 2, /obj/item/storage/belt/pouch/coins/mid)
	backr = /obj/item/fishingrod/fisher
	beltl = /obj/item/weapon/sword/sabre/cutlass
	beltr = /obj/item/weapon/knife/dagger
	shoes = /obj/item/clothing/shoes/boots
	neck = /obj/item/clothing/neck/psycross/silver/abyssor

/datum/outfit/job/adventurer/swashbuckler/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		if(H.patron != /datum/patron/divine/abyssor)
			H.set_patron(/datum/patron/divine/abyssor)

		H.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.adjust_skillrank(/datum/skill/labor/fishing, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/swimming, 4, TRUE)
		H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.adjust_skillrank(/datum/skill/craft/traps, 2, TRUE)

	shirt = pick(/obj/item/clothing/shirt/undershirt/sailor, /obj/item/clothing/shirt/undershirt/sailor/red)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	H.change_stat(STATKEY_STR, 1)
	H.change_stat(STATKEY_PER, 1)
	H.change_stat(STATKEY_CON, 1)
	H.change_stat(STATKEY_END, 3)
	H.change_stat(STATKEY_SPD, 2)
