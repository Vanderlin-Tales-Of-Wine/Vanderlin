//master farmer

/datum/advclass/pilgrim/rare/stonekeep/farmermaster
	name = "Master Farmer"
	tutorial = "A veteran among the serfs that tend to cattle and fields of produce, \
	able to handle almost every single task there is to do on a fief."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Half-Elf",
		"Dwarf",
		"Aasimar"
	)
	outfit = /datum/outfit/job/stonekeep/adventurer/farmermaster
	maximum_possible_slots = 1
	pickprob = 15
	category_tags = list(CTAG_PILGRIM, CTAG_TOWNER)
	apprentice_name = "Handyman"

/datum/outfit/job/stonekeep/adventurer/farmermaster/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/swimming, pick(0,1,1), TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/labor/farming, 6, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/labor/butchering, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/tanning, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/labor/taming, 2, TRUE)

	belt = /obj/item/storage/belt/leather
	shirt = /obj/item/clothing/shirt/undershirt/random
	pants = /obj/item/clothing/pants/trou
	shoes = /obj/item/clothing/shoes/boots/leather
	backr = /obj/item/weapon/hoe
	wrists = /obj/item/clothing/wrists/bracers/leather
	backl = /obj/item/storage/backpack/backpack
	neck = /obj/item/clothing/neck/coif/cloth
	armor = /obj/item/clothing/armor/gambeson
	mouth = /obj/item/clothing/face/cigarette/pipe/westman
	beltl = /obj/item/weapon/sickle
	beltr = /obj/item/weapon/knife/hunting
	var/obj/item/weapon/pitchfork/P = new()
	H.put_in_hands(P, forced = TRUE)
	backpack_contents = list(/obj/item/neuFarm/seed/wheat=1,/obj/item/neuFarm/seed/apple=1,/obj/item/neuFarm/seed/cabbage=1,/obj/item/neuFarm/seed/potato=1,/obj/item/neuFarm/seed/onion=1,/obj/item/ash=2,/obj/item/flint=1,/obj/item/storage/belt/pouch/coins/mid=1)
	H.change_stat("strength", 2)
	H.change_stat("constitution", 1)
	H.change_stat("endurance", 2)
	H.change_stat("intelligence", -1)
	ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)	//Peasants probably smell terrible. (:
	ADD_TRAIT(H, TRAIT_SEEDKNOW, TRAIT_GENERIC)
