/datum/job/stonekeep/soilson
	title = "Soilson"
	flag = SK_SOILSON
	department_flag = PEASANTS
	total_positions = 4
	spawn_positions = 4
	display_order = SOILSON_ORDER
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Dark Elf",
		"Aasimar",
	)
	tutorial = "It is a simple life you live, your basic understanding of life is something many would be envious of if they knew how perfect it was. You know a good day's work, the sweat on your brow is yours: Famines and plague may take its toll, but you know how to celebrate life well. Till the soil and produce fresh food for those around you, and maybe youll be more than an unsung hero someday."
	cmode_music = 'sound/music/cmode/towner/CombatTowner.ogg'

	f_title = "Soilbride"
	outfit = /datum/outfit/job/stonekeep/soilson
	give_bank_account = 20
	min_pq = -50
	selection_color = "#553e01"

/datum/outfit/job/stonekeep/soilson/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, pick(2,3), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/farming, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/butchering, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/taming, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/carpentry, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.change_stat("strength", 1)
		if(prob(10))
			H.change_stat("strength", 1)
		H.change_stat("constitution", 1)
		H.change_stat("endurance", 1)
		if(prob(10))
			H.change_stat("endurance", 1)
		H.change_stat("intelligence", -1)
		ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_SEEDKNOW, TRAIT_GENERIC)

	neck = /obj/item/storage/belt/pouch/coins/poor
	if(H.gender == MALE)
		head = /obj/item/clothing/head/roguehood/random
		if(prob(70))
			head = /obj/item/clothing/head/strawhat
		pants = /obj/item/clothing/pants/tights/random
		armor = /obj/item/clothing/armor/gambeson/light/striped
		shirt = /obj/item/clothing/shirt/undershirt/random
		shoes = /obj/item/clothing/shoes/simpleshoes
		belt = /obj/item/storage/belt/leather/rope
		beltr = /obj/item/key/soilson
		beltl = /obj/item/weapon/knife/villager
	else
		head = /obj/item/clothing/head/armingcap
		if(prob(50))
			head = /obj/item/clothing/head/shawl
		armor = /obj/item/clothing/shirt/dress/gen/random
		shirt = /obj/item/clothing/shirt/undershirt
		shoes = /obj/item/clothing/shoes/simpleshoes
		belt = /obj/item/storage/belt/leather/rope
		beltr = /obj/item/key/soilson
		beltl = /obj/item/weapon/knife/villager

