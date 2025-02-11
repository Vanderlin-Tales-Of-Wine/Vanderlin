/datum/job/roguetown/forestguard
	title = "Forest Guard"
	flag = FORGUARD
	department_flag = GARRISON
	faction = "Station"
	total_positions = 3
	spawn_positions = 3
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD)
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
	)
	tutorial = "You've been keeping the streets clean of neer-do-wells and taffers for most of your time in the garrison.\
			You've been through the wringer - having been a soldier in the short-lived Goblin Wars. You've emerged through it, beaten to hell.\
			Alive, but you wouldn't call it living. A fellow soldier had been given the title of Forest Warden for his valorant\
			efforts,and he's plucked you from one dangerous position into another. Atleast with the battle-brothers by your side, you will never die alone."
	display_order = JDO_FORGUARD
	whitelist_req = FALSE
	bypass_lastclass = TRUE
	selection_color = "#0d6929"
	give_bank_account = 30
	min_pq = 5
	cmode_music = 'sound/music/cmode/garrison/CombatForestGarrison.ogg'

	outfit = /datum/outfit/job/roguetown/forestguard
	advclass_cat_rolls = list(CTAG_FORGARRISON = 20)

/datum/outfit/job/roguetown/forestguard/pre_equip(mob/living/carbon/human/H)
	..()
	cloak = /obj/item/clothing/cloak/raincloak/green
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shoes = /obj/item/clothing/shoes/roguetown/boots/furlinedboots
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	gloves = /obj/item/clothing/gloves/roguetown/leather
	belt = /obj/item/storage/belt/rogue/leather
	backl = /obj/item/storage/backpack/rogue/satchel

/datum/job/roguetown/forestguard/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")

// Axes Maces and Swords
/datum/advclass/forestguard/infantry
	name = "Forest Infantry"
	tutorial = "In the goblin wars you were deployed to the front lines, you caved in thier skulls and chopped thier legs off."
	outfit = /datum/outfit/job/roguetown/forestguard/infantry
	category_tags = list(CTAG_FORGARRISON)

/datum/outfit/job/roguetown/forestguard/infantry/pre_equip(mob/living/carbon/human/H)
	..()
	armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
	head = /obj/item/clothing/head/roguetown/helmet/leather/advanced
	neck = /obj/item/clothing/neck/roguetown/gorget
	beltl = /obj/item/rogueweapon/mace/steel/morningstar
	beltr = /obj/item/rogueweapon/axe/iron
	backpack_contents = list(/obj/item/rogueweapon/knife/hunting = 1, /obj/item/rope/chain = 1, /obj/item/key/forrestgarrison = 1, /obj/item/storage/belt/rogue/pouch/coins/poor)
	H.verbs |= /mob/proc/haltyell
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/lumberjacking, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/tanning, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("endurance", 1)
		H.change_stat("speed", 1)
		ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)

// Bows and Knives
/datum/advclass/forestguard/ranger
	name = "Forest Ranger"
	tutorial = "In the goblin wars you were always one of the fastest aswell as one of the weakest in the platoon. Your trusty bow has served you well."
	outfit = /datum/outfit/job/roguetown/forestguard/ranger
	category_tags = list(CTAG_FORGARRISON)

/datum/outfit/job/roguetown/forestguard/ranger/pre_equip(mob/living/carbon/human/H)
	..()
	armor = /obj/item/clothing/suit/roguetown/armor/leather/advanced
	head = /obj/item/clothing/head/roguetown/roguehood/green
	neck = /obj/item/clothing/neck/roguetown/chaincoif
	beltl = /obj/item/rogueweapon/knife/cleaver/combat
	beltr = /obj/item/ammo_holder/quiver/arrows
	backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/long
	backpack_contents = list(/obj/item/rogueweapon/knife/hunting = 1, /obj/item/rope/chain = 1, /obj/item/key/forrestgarrison = 1, /obj/item/storage/belt/rogue/pouch/coins/poor)
	H.verbs |= /mob/proc/haltyell
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/lumberjacking, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/tanning, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/bows, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.change_stat("strength", -2)
		H.change_stat("endurance", 1)
		H.change_stat("speed", 3)
		ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)

// Hand to Hand
/datum/advclass/forestguard/brawler
	name = "Forest Brawler"
	tutorial = "In the goblin wars you took an oath to never wield a weapon, you just enjoy getting your hands dirty too much..."
	outfit = /datum/outfit/job/roguetown/forestguard/brawler
	category_tags = list(CTAG_FORGARRISON)

/datum/outfit/job/roguetown/forestguard/brawler/pre_equip(mob/living/carbon/human/H)
	..()
	armor = /obj/item/clothing/suit/roguetown/armor/leather/advanced
	head = /obj/item/clothing/head/roguetown/roguehood/green
	neck = /obj/item/clothing/neck/roguetown/chaincoif
	beltl = /obj/item/rogueweapon/mace/steel/morningstar
	beltr = /obj/item/rogueweapon/axe/iron
	backpack_contents = list(/obj/item/rogueweapon/knife/hunting = 1, /obj/item/rope/chain = 1, /obj/item/key/forrestgarrison = 1, /obj/item/storage/belt/rogue/pouch/coins/poor)
	H.verbs |= /mob/proc/haltyell
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/lumberjacking, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/tanning, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
		H.change_stat("strength", 4)
		H.change_stat("constitution", 3)
		H.change_stat("endurance", 2)
		H.change_stat("speed", -1)
		ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
