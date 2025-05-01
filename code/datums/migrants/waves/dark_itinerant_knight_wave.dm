/datum/migrant_role/dark_itinerant_knight
	name = "Drow Knight"
	greet_text = "You are an evil itinerant Knight, you have embarked alongside your squire on a voyage to engulf chaos within these lands."
	outfit = /datum/outfit/job/dark_itinerant_knight
	antag_datum = /datum/antagonist/zizocultist
	allowed_sexes = list(FEMALE)
	allowed_races = list("Dark Elf")
	grant_lit_torch = TRUE

/datum/outfit/job/dark_itinerant_knight/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/rare/elfplate
	cloak = /obj/item/clothing/cloak/half/shadowcloak
	gloves = /obj/item/clothing/gloves/chain/iron/shadowgauntlets
	pants = /obj/item/clothing/pants/trou/shadowpants
	shirt = /obj/item/clothing/shirt/shadowshirt
	armor = /obj/item/clothing/armor/rare/elfplate
	shoes = /obj/item/clothing/shoes/boots/rare/elfplate
	beltl = /obj/item/flashlight/flare/torch/lantern
	belt = /obj/item/storage/belt/leather/steel
	backr = /obj/item/storage/backpack/satchel
	backl = /obj/item/weapon/sword/long/greatsword/elfgsword

	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/whipsflails, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)
		H.change_stat(STATKEY_STR, 3)
		H.change_stat(STATKEY_PER, 1)
		H.change_stat(STATKEY_INT, 3)
		H.change_stat(STATKEY_CON, 2)
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_SPD, -1)
	H.dna.species.soundpack_m = new /datum/voicepack/male/knight()
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	H.cmode_music = 'sound/music/cmode/antag/CombatThrall.ogg'

/datum/migrant_role/dark_itinerant_squire
	name = "Underling Squire"
	greet_text = "You are the squire of an evil knight, they have taken you under their custody as you were the only one who didn't object to their dubious ethics."
	outfit = /datum/outfit/job/dark_itinerant_squire
	antag_datum = /datum/antagonist/zizocultist
	allowed_sexes = list(FEMALE)
	allowed_races = list("Dark Elf")
	grant_lit_torch = TRUE

/datum/outfit/job/dark_itinerant_squire/pre_equip(mob/living/carbon/human/H)
	..()
	shirt = /obj/item/clothing/shirt/dress/gen/black
	pants = /obj/item/clothing/pants/chainlegs/iron
	shoes = /obj/item/clothing/shoes/boots
	belt = /obj/item/storage/belt/leather
	beltr = /obj/item/ammo_holder/quiver/bolts
	armor = /obj/item/clothing/armor/chainmail
	backl = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
	gloves = /obj/item/clothing/gloves/leather
	wrists = /obj/item/clothing/wrists/bracers/leather
	backr = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/weapon/knife/dagger/steel = 1, /obj/item/storage/belt/pouch/coins/poor = 1, /obj/item/clothing/neck/chaincoif = 1, /obj/item/weapon/hammer/iron = 1,)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/weaponsmithing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/armorsmithing, 2, TRUE)
		H.change_stat(STATKEY_PER, 2)
		H.change_stat(STATKEY_CON, 2)
		H.change_stat(STATKEY_INT, -1)
		H.change_stat(STATKEY_SPD, 2)
	if(H.gender == MALE && H.dna?.species)
		H.dna.species.soundpack_m = new /datum/voicepack/male/squire()
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	H.cmode_music = 'sound/music/cmode/antag/CombatThrall.ogg'

/datum/migrant_wave/evil_knight
	name = "The Unknightly journey"
	max_spawns = 1
	shared_wave_type = /datum/migrant_wave/evil_knight
	downgrade_wave = /datum/migrant_wave/evil_knight_down
	weight = 8
	roles = list(
		/datum/migrant_role/dark_itinerant_knight = 1,
		/datum/migrant_role/dark_itinerant_squire = 1,
	)
	greet_text = "These lands have insulted once more Zizo, you are here to remind them of her prowess."

/datum/migrant_wave/evil_knight_down
	name = "The Unknightly journey"
	shared_wave_type = /datum/migrant_wave/evil_knight
	can_roll = FALSE
	weight = 35
	roles = list(
		/datum/migrant_role/dark_itinerant_knight = 1,
	)
	greet_text = "These lands have insulted once more Zizo, you are here to remind them of her prowess."
