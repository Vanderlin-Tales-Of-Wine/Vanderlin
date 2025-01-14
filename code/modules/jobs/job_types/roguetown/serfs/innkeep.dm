/datum/job/roguetown/innkeep
	title = "Innkeep"
	flag = INNKEEP
	department_flag = SERFS
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Dark Elf",
		"Aasimar"
	)

	tutorial = "Liquor, lodging, and lavish meals... your business is the beating heart of Vanderlin. You're the one who provides the the hardworking townsfolk with a place to eat and drink their sorrows away, and accommodations for weary travelers passing through."

	outfit = /datum/outfit/job/roguetown/innkeep
	display_order = JDO_INNKEEP
	bypass_lastclass = TRUE
	give_bank_account = 60
	min_pq = -10
	cmode_music = 'sound/music/cmode/towner/CombatInn.ogg'

/datum/outfit/job/roguetown/innkeep/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/tights/random
		shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
		shoes = /obj/item/clothing/shoes/roguetown/shortboots
		belt = /obj/item/storage/belt/rogue/leather
		beltl = /obj/item/storage/belt/rogue/pouch/coins/mid
		beltr = /obj/item/reagent_containers/glass/bottle/rogue/beer/blackgoat
		neck = /obj/item/storage/keyring/innkeep
		cloak = /obj/item/clothing/cloak/apron/waist
		H.change_stat("strength", 1)
		H.change_stat("endurance", 1)
	else
		armor = /obj/item/clothing/suit/roguetown/shirt/dress
		shoes = /obj/item/clothing/shoes/roguetown/shortboots
		neck = /obj/item/storage/belt/rogue/pouch/coins/mid
		belt = /obj/item/storage/belt/rogue/leather
		beltl = /obj/item/storage/keyring/innkeep
		beltr = /obj/item/reagent_containers/glass/bottle/rogue/beer/blackgoat
		H.change_stat("endurance", 1)
		H.change_stat("constitution", 1)
