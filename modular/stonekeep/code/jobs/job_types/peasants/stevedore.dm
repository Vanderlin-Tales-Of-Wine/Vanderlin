/datum/job/grabber
	title = "Stevedore"
	flag = SK_STEVEDORE
	department_flag = PEASANTS
	total_positions = 3
	spawn_positions = 3

	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Dark Elf",
		"Aasimar"
	)

	tutorial = "Being a stevedore is one of the lowest yet most needed positions in town, as they are expected to aid the Merchant, Steward, Masons, and Blacksmiths in hauling materials and goods while keeping a guarding eye on the town's warehouses for the safety of the items stashed within."

	outfit = /datum/outfit/job/stonekeep/stevedore
	give_bank_account = TRUE
	min_pq = -50
	display_order = STEVEDORE_ORDER
	cmode_music = 'sound/music/cmode/combat_bum.ogg'

/datum/job/grabber/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
/datum/outfit/job/stonekeep/stevedore/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/headband/red
	wrists = /obj/item/storage/keyring/stevedore
	beltr = /obj/item/weapon/mace/cudgel
	beltl = /obj/item/storage/belt/pouch/coins/poor
	belt = /obj/item/storage/belt/leather/rope
	pants = /obj/item/clothing/pants/tights/sailor
	armor = /obj/item/clothing/armor/leather/jacket/sea
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE) // You get a cudgel for nonlethal self defense and that's it.
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)//they can use the merchant machine and that's it
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.change_stat("strength", 1)
	if(H.gender == MALE)
		shoes = /obj/item/clothing/shoes/boots/leather
		shirt = /obj/item/clothing/shirt/undershirt/sailor/red
		H.change_stat("endurance", 1)
		H.change_stat("constitution", 1)
		H.change_stat("strength", 1)//thug bodytype
	else
		shoes = /obj/item/clothing/shoes/gladiator
		shirt = /obj/item/clothing/shirt/undershirt/sailor
		H.change_stat("endurance", 1)
		H.change_stat("intelligence", 1)
		H.change_stat("speed", 1)
	ADD_TRAIT(H, TRAIT_CRATEMOVER, type)
	if(HAS_TRAIT(H, TRAIT_KAIZOKU))
		if(H.patron == /datum/patron/divine/abyssor) //Abyssanctum have combative edge as well, but only for those culturally bound to fog islands. The gods are the same, but the religion is not.
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
