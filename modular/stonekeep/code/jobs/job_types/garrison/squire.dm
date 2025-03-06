/datum/job/roguetown/squire
	title = "Squire"
	flag = SK_SQUIRE
	department_flag = GARRISON
	faction = "Station"
	total_positions = 2
	spawn_positions = 2

	allowed_races = list(
		"Humen",
		"Half-Elf",
		"Dwarf"
	)
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT)

	tutorial = "You've always had greater aspirations than the simple life of a peasant. You and your friends practiced the basics, swordfighting with sticks and loosing arrows into hay bale targets. The Captain took notice of your potential, and recruited you as a personal ward. Learn from the garrison and train hard... maybe one dae you will be honored with knighthood."

	outfit = /datum/outfit/job/roguetown/squire
	display_order = SQUIRE_ORDER
	give_bank_account = TRUE
	min_pq = -15
	bypass_lastclass = TRUE
	selection_color = "#304529"
	can_have_apprentices = FALSE

/datum/outfit/job/roguetown/squire/pre_equip(mob/living/carbon/human/H)
	neck = /obj/item/clothing/neck/coif/cloth
	armor = /obj/item/clothing/armor/gambeson
	cloak = /obj/item/clothing/cloak/stabard/guard
	shirt = /obj/item/clothing/shirt/undershirt/guard
	pants = /obj/item/clothing/pants/tights/guard
	shoes = /obj/item/clothing/shoes/boots
	belt = /obj/item/storage/belt/leather
	beltl = /obj/item/storage/keyring/mguard
	beltr = /obj/item/storage/belt/pouch/coins/poor

	if(H.gender == MALE && H.dna?.species)
		H.dna.species.soundpack_m = new /datum/voicepack/male/squire()

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/weaponsmithing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/armorsmithing, 1, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("perception", 1)
		H.change_stat("constitution", 1)
		H.change_stat("intelligence", 1)
		H.change_stat("speed", 1)

	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)

	H.adjust_blindness(-3)
	var/weapons = list("Spear","Shield & Sword")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Spear")
			r_hand = /obj/item/weapon/polearm/spear
			H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		if("Shield & Sword")
			backr = /obj/item/weapon/shield/wood
			beltr = /obj/item/weapon/sword

