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
	outfit = /datum/outfit/job/roguetown/forestguard
	give_bank_account = 50
	min_pq = 5
	cmode_music = 'sound/music/cmode/garrison/CombatForestGarrison.ogg'

/datum/outfit/job/roguetown/forestguard/pre_equip(mob/living/carbon/human/H)
	..()
	cloak = /obj/item/clothing/cloak/raincloak/green
	armor = /obj/item/clothing/suit/roguetown/armor/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shoes = /obj/item/clothing/shoes/roguetown/boots/furlinedboots
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	neck = /obj/item/key/forrestgarrison
	belt = /obj/item/storage/belt/rogue/leather
	backpack_contents = list(/obj/item/rogueweapon/knife/dagger/steel/special = 1, /obj/item/rope/chain = 1)
	beltl = /obj/item/rogueweapon/mace/steel/morningstar
	beltr = /obj/item/storage/belt/rogue/pouch/coins/poor
	backl = /obj/item/storage/backpack/rogue/satchel
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("endurance", 1)
		H.change_stat("speed", 1)
	H.verbs |= /mob/proc/haltyell
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_LEECHIMMUNE, TRAIT_GENERIC) // Women fear me. Leeches fear me. Men turn their eyes away from me as I walk. No creechers dare make a sound in my presence. I am alone in these barren woods.
