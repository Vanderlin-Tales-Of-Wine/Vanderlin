/datum/job/stonekeep/veteran
	title = "Veteran"
	flag = SK_VETERAN
	department_flag = GARRISON
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	spells = list(/obj/effect/proc_holder/spell/self/convertrole/town_militia)
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Half-Elf",
		"Dwarf"
	)
	tutorial = "You've known combat your entire life. There isn't a way to kill a man you havent practiced in the tapestries of war itself. You wouldn't call yourself a hero--those belong to the men left rotting in the fields where you honed your ancient trade. You don't sleep well at night anymore, you don't like remembering what you've had to do to survive. Trading adventure for stable pay was the only logical solution, and maybe someday you'll get to lay down the blade and rest your weary body..."
	allowed_ages = list(AGE_OLD)
	advclass_cat_rolls = list(CTAG_VETERAN = 20)
	display_order = VETERAN_ORDER
	give_bank_account = 35
	min_pq = 0
	can_have_apprentices = FALSE
	outfit = /datum/outfit/job/stonekeep/veteran

/datum/job/stonekeep/veteran/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	. = ..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		if(istype(H.cloak, /obj/item/clothing/cloak/half/vet))
			var/obj/item/clothing/S = H.cloak
			var/index = findtext(H.real_name, " ")
			if(index)
				index = copytext(H.real_name, 1,index)
			if(!index)
				index = H.real_name
			S.name = "veteran cloak ([index])"


/datum/outfit/job/stonekeep/veteran/pre_equip(mob/living/carbon/human/H)
	head = /obj/item/clothing/head/helmet/nasal
	neck = /obj/item/clothing/neck/coif/cloth
	armor = /obj/item/clothing/armor/chainmail
	shirt = /obj/item/clothing/armor/gambeson/heavy
	pants = /obj/item/clothing/pants/trou/leather
	shoes = /obj/item/clothing/shoes/boots/armor/light
	beltl = /obj/item/flashlight/flare/torch/metal
	beltr = /obj/item/key/veteran
	cloak = /obj/item/clothing/cloak/half/vet
	belt = /obj/item/storage/belt/leather
	H.cmode_music = 'sound/music/cmode/adventurer/CombatWarrior.ogg'
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.change_stat("perception", 1)
		H.change_stat("intelligence", 2)
		H.change_stat("endurance", 1)
		H.change_stat("constitution", 1)
		H.change_stat("strength", 1)

	H.verbs |= /mob/proc/haltyell
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)

	H.adjust_blindness(-3)
	var/weapons = list("Godendag","Longsword","Shield & Sword", "Crossbow & Axe")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Godendag")
			r_hand = /obj/item/weapon/mace/goden
			H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		if("Longsword")
			r_hand = /obj/item/weapon/sword/long
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		if("Shield & Sword")
			backr = /obj/item/weapon/shield/heater
			beltr = /obj/item/weapon/sword/scimitar/messer
			H.mind.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
		if("Crossbow & Axe")
			backr = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
			backr = /obj/item/ammo_holder/quiver/bolts
			beltr = /obj/item/weapon/axe/iron
			H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)


