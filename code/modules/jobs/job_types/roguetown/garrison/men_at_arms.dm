/datum/job/roguetown/men_at_arms
	title = "Men-at-arms"
	flag = WATCHMAN
	department_flag = GARRISON
	display_order = JDO_WATCHMAN
	faction = "Station"
	total_positions = 4
	spawn_positions = 4
	tutorial = "The Monarch has hired you to guard their Keep, man the gates, patrol the keep insure any intruders are not within the boundaries of your liege's domain."
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Aasimar"
	)
	allowed_sexes = list(MALE, FEMALE)

	outfit = /datum/outfit/job/roguetown/watchman
	advclass_cat_rolls = list(CTAG_MENATARMS = 20)
	bypass_lastclass = TRUE
	cmode_music = 'sound/music/cmode/garrison/CombatGarrison.ogg'
	give_bank_account = 15
	min_pq = 6

/datum/outfit/job/roguetown/watchman/pre_equip(mob/living/carbon/human/H)
	shirt = /obj/item/clothing/suit/roguetown/armor/gambeson/light
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shoes = /obj/item/clothing/shoes/roguetown/boots
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/storage/keyring/manorguard

/datum/job/roguetown/men_at_arms/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")

/datum/advclass/menatarms/watchman_ranger
	name = "Archer Men-At-Arms"
	tutorial = "The Monarch has hired you to guard their keep, you'll do it at a safe distance."
	outfit = /datum/outfit/job/roguetown/watchman/ranger

	category_tags = list(CTAG_MENATARMS)

/datum/outfit/job/roguetown/watchman/ranger/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/kettle
	cloak = /obj/item/clothing/cloak/stabard/guard
	armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
	beltr = /obj/item/rogueweapon/mace/cudgel
	neck = /obj/item/clothing/neck/roguetown/chaincoif/iron
	backpack_contents = list(/obj/item/rogueweapon/knife/dagger/steel/special)
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/bows, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("perception", 2)
		H.change_stat("endurance", -3)
		H.change_stat("speed", -1)
		H.verbs |= /mob/proc/haltyell
		ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)
		var/weapontypec = pickweight(list("Bow" = 6, "Crossbow" = 4)) // Rolls for either a bow or a Crossbow
		switch(weapontypec)
			if("Bow")
				backl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
				backr = /obj/item/ammo_holder/quiver/arrows
			if("Crossbow")
				backl = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
				backr = /obj/item/ammo_holder/quiver/bolts

/datum/advclass/menatarms/watchman_pikeman
	name = "Pikeman Men-At-Arms"
	tutorial = "The Monarch has hired you to guard their keep, unlike your peers you'll be on the frontline."
	outfit = /datum/outfit/job/roguetown/watchman/pikeman

	category_tags = list(CTAG_MENATARMS)

/datum/outfit/job/roguetown/watchman/pikeman/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/kettle
	cloak = /obj/item/clothing/cloak/stabard/guard
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail
	neck = /obj/item/clothing/neck/roguetown/chaincoif/iron
	gloves = /obj/item/clothing/gloves/roguetown/chain
	beltr = /obj/item/rogueweapon/sword/arming
	backr = /obj/item/rogueweapon/polearm/spear
	backpack_contents = list(/obj/item/rogueweapon/knife/dagger/steel/special)
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("perception", -1)
		H.change_stat("endurance", -1)
		H.change_stat("constitution", 1)
		H.change_stat("speed", 1)
		H.verbs |= /mob/proc/haltyell
		ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
