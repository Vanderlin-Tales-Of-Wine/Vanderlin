/datum/advclass/combat/sk/amazon
	name = "Amazon"
	tutorial = "Amazons are savage and deft warrior-women from the mysterious isle of Issa. They hunt for prey amid the treetops and pick fights for sport, just to prove their worth."
	allowed_sexes = list(FEMALE)
	allowed_races = list("Humen")
	outfit = /datum/outfit/job/sk/adventurer/amazon
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)
	min_pq = -10
	category_tags = list(CTAG_ADVENTURER)
	cmode_music = 'sound/music/cmode/adventurer/CombatOutlander.ogg'

/datum/outfit/job/sk/adventurer/amazon/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/tanning, 1, TRUE)

	belt = /obj/item/storage/belt/leather/rope
	shoes = /obj/item/clothing/shoes/gladiator
	wrists = /obj/item/clothing/wrists/bracers/leather
	armor = /obj/item/clothing/armor/amazon_chainkini
	shoes = /obj/item/clothing/shoes/boots

	H.change_stat("strength", 2)
	H.change_stat("intelligence", -1)
	H.change_stat("endurance", 2)
	H.change_stat("constitution", 1)
	H.change_stat("speed", 1)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOPAINSTUN, TRAIT_GENERIC)
	H.adjust_blindness(-3)
	var/weapons = list("Spear & Blowgun", "Bow & Sword")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Spear & Blowgun")
			r_hand = /obj/item/weapon/polearm/spear
			neck = /obj/item/storage/belt/pouch/pdarts
			beltl = /obj/item/gun/ballistic/revolver/grenadelauncher/blowgun
		if("Bow & Sword")
			r_hand = /obj/item/weapon/sword/iron
			backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
			beltl = /obj/item/ammo_holder/quiver/arrows

