/datum/advclass/mercenary/blackoak
	name = "Black Oak's Guardian"
	tutorial = "A shady guardian of the Black Oaks, a mercenary band in all but offical name. Commonly taking caravan contracts through the thickest of forests."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_PLAYER_ELF
	outfit = /datum/outfit/job/mercenary/blackoak
	category_tags = list(CTAG_MERCENARY)
	maximum_possible_slots = 5

/datum/outfit/job/mercenary/blackoak/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/boots/leather
	cloak = /obj/item/clothing/cloak/half/red
	head = /obj/item/clothing/head/helmet/sallet/elven
	gloves = /obj/item/clothing/gloves/angle
	belt = /obj/item/storage/belt/leather/mercenary/black
	armor = /obj/item/clothing/armor/cuirass/elven
	backl = /obj/item/storage/backpack/satchel
	beltl = /obj/item/weapon/knife/dagger/steel/special
	shirt = /obj/item/clothing/shirt/undershirt/black
	pants = /obj/item/clothing/pants/trou/leather
	neck = /obj/item/clothing/neck/chaincoif
	backpack_contents = list(/obj/item/storage/belt/pouch/coins/poor)
	if(H.mind)
		H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)

		H.merctype = 4

		H.change_stat(STATKEY_END, 3)
		H.change_stat(STATKEY_STR, 1)
		H.change_stat(STATKEY_SPD, 1)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	var/weapons = list("Spear","Regal Elven Club")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	switch(weapon_choice)
		if("Spear")
			backr = /obj/item/weapon/polearm/spear
			H.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
		if("Regal Elven Club")
			beltr = /obj/item/weapon/mace/elvenclub/steel
			H.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)


