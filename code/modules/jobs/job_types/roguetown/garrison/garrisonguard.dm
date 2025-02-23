/datum/job/roguetown/guardsman
	title = "City Watchmen"
	flag = GUARDSMAN
	department_flag = GARRISON
	faction = "Station"
	total_positions = 8
	spawn_positions = 8

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Aasimar"
	)
	allowed_races = list("Humen", "Half-Elf", "Elf", "Dwarf", "Aasimar")
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_IMMORTAL)
	tutorial = "You are a member of the City Watch. You've proven yourself worthy to the Captain and now you've got yourself a salary.. as long as you keep the peace that is."
	display_order = JDO_CITYWATCHMEN
	whitelist_req = FALSE
	bypass_lastclass = TRUE

	outfit = /datum/outfit/job/roguetown/guardsman	//Default outfit.
	advclass_cat_rolls = list(CTAG_GARRISON = 20)	//Handles class selection.
	give_bank_account = 30
	min_pq = 4

	cmode_music = 'sound/music/cmode/garrison/CombatGarrison.ogg'

/datum/job/roguetown/guardsman/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")
		if(istype(H.cloak, /obj/item/clothing/cloak/half/guard))
			var/obj/item/clothing/S = H.cloak
			var/index = findtext(H.real_name, " ")
			if(index)
				index = copytext(H.real_name, 1,index)
			if(!index)
				index = H.real_name
			S.name = "guard's half cloak ([index])"

//................. City Watchmen Base .............. //
/datum/outfit/job/roguetown/guardsman/pre_equip(mob/living/carbon/human/H)
	cloak = pick(/obj/item/clothing/cloak/half/guard, /obj/item/clothing/cloak/half/guardsecond)
	pants = pick(/obj/item/clothing/under/roguetown/tights/guard, /obj/item/clothing/under/roguetown/tights/guardsecond)
	wrists = /obj/item/rope/chain
	shoes = /obj/item/clothing/shoes/roguetown/boots
	belt = /obj/item/storage/belt/rogue/leather

// EVERY TOWN GUARD SHOULD HAVE AT LEAST THREE CLUB SKILL

//................. Axes, Maces, Swords, Shields .............. //
/datum/advclass/garrison/footman
	name = "City Watch Footman"
	tutorial = "You are a member of the City Watch. You are well versed in holding the line with a shield while wielding a trusty sword, axe, or mace in the other hand."
	outfit = /datum/outfit/job/roguetown/guardsman/footman
	category_tags = list(CTAG_GARRISON)

/datum/outfit/job/roguetown/guardsman/footman/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/townwatch
	neck = /obj/item/clothing/neck/roguetown/gorget
	armor = /obj/item/clothing/suit/roguetown/armor/cuirass
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
	gloves = /obj/item/clothing/gloves/roguetown/chain
	backr = /obj/item/rogueweapon/shield/heater
	backl = /obj/item/storage/backpack/rogue/satchel
	beltr = /obj/item/rogueweapon/sword/short
	beltl = /obj/item/rogueweapon/mace/cudgel
	backpack_contents = list(/obj/item/storage/keyring/guard, /obj/item/rogueweapon/knife/dagger/steel/special)
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 4, TRUE) // Main weapon
		H.mind?.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE) // Main off-hand weapon
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE) // Backup
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.change_stat(STATKEY_STR, 1)
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_CON, 1)
		ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)
		H.verbs |= /mob/proc/haltyell

//................. Archer .............. //
/datum/advclass/garrison/archer
	name = "City Watch Archer"
	tutorial = "You are a member of the City Watch. Your training with bows and crossbows makes you a formidable threat when perched atop the walls or rooftops, raining arrows or bolts down upon foes with impunity."
	outfit = /datum/outfit/job/roguetown/guardsman/archer
	category_tags = list(CTAG_GARRISON)

/datum/outfit/job/roguetown/guardsman/archer/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/townwatch/alt
	neck = /obj/item/clothing/neck/roguetown/chaincoif
	armor = /obj/item/clothing/suit/roguetown/armor/gambeson/heavy
	shirt = pick(/obj/item/clothing/suit/roguetown/shirt/undershirt/guard, /obj/item/clothing/suit/roguetown/shirt/undershirt/guardsecond)
	gloves = /obj/item/clothing/gloves/roguetown/leather
	backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
	backl = /obj/item/storage/backpack/rogue/satchel
	beltr = /obj/item/ammo_holder/quiver/arrows
	beltl = /obj/item/rogueweapon/mace/cudgel
	backpack_contents = list(/obj/item/storage/keyring/guard, /obj/item/rogueweapon/knife/dagger/steel/special)
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/bows, 4, TRUE) // Main Weapon
		H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE) // Backup
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.change_stat(STATKEY_PER, 2)
		H.change_stat(STATKEY_END, 1)
		H.change_stat(STATKEY_SPD, 2)
		ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)
		H.verbs |= /mob/proc/haltyell

/mob/proc/haltyell()
	set name = "HALT!"
	set category = "Noises"
	emote("haltyell")
