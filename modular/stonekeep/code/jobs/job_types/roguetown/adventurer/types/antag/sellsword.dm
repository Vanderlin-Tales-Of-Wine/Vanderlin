/datum/advclass/sellsword	// flexible melee, polearm or shield, got heavy training. More armor but more weakspots.
	name = "Sellsword"
	tutorial = "Perhaps a mercenary, perhaps a deserter - at one time, you killed for a master in return for gold. Now you live with no such master over your head - and take what you please."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Aasimar",
		"Dark Elf"
	)
	outfit = /datum/outfit/job/roguetown/bandit/sellsword
	category_tags = list(CTAG_BANDIT)
	cmode_music = 'sound/music/cmode/antag/combat_bandit2.ogg'

/datum/outfit/job/roguetown/bandit/sellsword/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind?.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	belt = /obj/item/storage/belt/leather
	pants = /obj/item/clothing/under/trou
	shoes = /obj/item/clothing/shoes/boots
	backr = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/needle/thorn = 1, /obj/item/natural/cloth = 1)
	shirt = /obj/item/clothing/armor/gambeson
	armor = /obj/item/clothing/armor/chainmail/iron
	H.change_stat(STATKEY_STR, 1)
	H.change_stat(STATKEY_END, 2)
	H.change_stat(STATKEY_CON, 2)
	H.change_stat(STATKEY_SPD, 1)
	H.change_stat(STATKEY_INT, -1)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	H.adjust_blindness(-3)
	var/weapons = list("Former Town Watch","Former Mercenary")
	var/weapon_choice = input("Choose your background.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Former Town Watch") //Deserter watchman.
			r_hand = /obj/item/weapon/polearm/spear/billhook
			head = /obj/item/clothing/head/helmet/kettle/slit
			mask = /obj/item/clothing/face/shepherd/rag
			neck = /obj/item/clothing/neck/chaincoif/iron
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		if("Former Mercenary") //Mercenary on the wrong side of the law
			backl= /obj/item/weapon/shield/tower/buckleriron
			beltr = /obj/item/weapon/sword //steel sword like literally every adventurer gets
			head = /obj/item/clothing/head/helmet/sallet
			mask = /obj/item/clothing/face/facemask
			neck = /obj/item/clothing/neck/coif/cloth
			H.mind.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)
