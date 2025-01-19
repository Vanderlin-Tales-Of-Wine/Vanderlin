/datum/migrant_role/gaoler
	name = "Gaoler"
	greet_text = "The lords of Vanderlins sent you to Heartfelt to rappatriate some prisoners that were in their prison, you are now on your way back."
	allowed_sexes = list(MALE, FEMALE)
	grant_lit_torch = TRUE
	outfit = /datum/outfit/job/roguetown/gaoler
	show_wanderer_examine = FALSE
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Dark Elf",
		"Aasimar",
		"Half-Orc")


/datum/outfit/job/roguetown/gaoler/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/menacing
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	pants = /obj/item/clothing/under/roguetown/trou
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	cloak = /obj/item/clothing/cloak/stabard/dungeon
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/rogueweapon/whip/antique
	beltl = /obj/item/flashlight/flare/torch/lantern
	backr = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/storage/keyring/dungeoneer = 1, /obj/item/rope/chain = 1)
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/traps, 3, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("intelligence", -2)
		H.change_stat("endurance", 2)
		H.change_stat("constitution", 1)
		H.change_stat("speed", -1)
		H.change_stat("perception", -1)
	if(H.dna?.species)
		if(H.dna.species.id == "human")
			H.dna.species.soundpack_m = new /datum/voicepack/male/warrior()
	H.cmode_music = 'sound/music/cmode/garrison/CombatJailor.ogg'
	H.verbs |= /mob/living/carbon/human/proc/torture_victim

/datum/migrant_role/mig_prisoner
	name = "Prisoner"
	greet_text = "You had fled Vanderlin, took refuge in Heartfelt yet the lords over there caught you and thus handed you over to those who seeked you before."
	outfit = /datum/outfit/job/roguetown/mig_prisoner
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Dark Elf",
		"Aasimar",
		"Half-Orc")

/datum/outfit/job/roguetown/mig_prisoner/pre_equip(mob/living/carbon/human/H)
	..()
	pants = /obj/item/clothing/under/roguetown/loincloth/brown
	mask = /obj/item/clothing/mask/rogue/facemask/prisoner
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
		H.change_stat("strength", -1)
		H.change_stat("perception", 2)
		H.change_stat("intelligence", 2)
		H.change_stat("speed", -1)
		H.change_stat("constitution", -1)
		H.change_stat("endurance", -1)
	H.cmode_music = 'sound/music/cmode/towner/CombatTowner.ogg'

/datum/migrant_role/prisoner_guard
	name = "Guard"
	greet_text = "You are apart of a convoy returning prisoners to Vanderlin. Obey the gaoler and ensure the prisoners get back to the dungeons."
	outfit = /datum/outfit/job/roguetown/mig_guard
	allowed_races = list("Humen","Dwarf","Aasimar")
	grant_lit_torch = TRUE
	show_wanderer_examine = FALSE

/datum/outfit/job/roguetown/mig_guard/pre_equip(mob/living/carbon/human/H)
	..()
	armor = /obj/item/clothing/suit/roguetown/armor/cuirass
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
	neck = /obj/item/clothing/neck/roguetown/gorget
	head = /obj/item/clothing/head/roguetown/helmet/nasal
	backr = /obj/item/rogueweapon/shield/wood
	beltr = /obj/item/rogueweapon/sword/scimitar/messer
	beltl = /obj/item/rogueweapon/mace
	pants = /obj/item/clothing/under/roguetown/trou/leather
	cloak = /obj/item/clothing/cloak/stabard/guard
	shoes = /obj/item/clothing/shoes/roguetown/boots
	belt = /obj/item/storage/belt/rogue/leather
	backpack_contents = list(/obj/item/storage/keyring/guard, /obj/item/rope/chain = 1)
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("endurance", 2)
		H.change_stat("constitution", 1)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)
	H.cmode_music = 'sound/music/cmode/garrison/CombatGarrison.ogg'
	H.verbs |= /mob/proc/haltyell

/datum/migrant_wave/prisoner_convoy
	name = "The prisoners convoy"
	max_spawns = 3
	shared_wave_type = /datum/migrant_wave/prisoner_convoy
	downgrade_wave = /datum/migrant_wave/prisoner_convoy_down
	weight = 45
	roles = list(
		/datum/migrant_role/gaoler = 1,
		/datum/migrant_role/prisoner_guard = 2,
		/datum/migrant_role/mig_prisoner = 4,
	)
	greet_text = "Nobody escape the rule of Vanderlin's monarchs. Some have fled to the neighbouring kingdom, Heartfelt and got caught, they are now on their way back."

/datum/migrant_wave/prisoner_convoy_down
	name = "The prisoners convoy"
	max_spawns = 3
	shared_wave_type = /datum/migrant_wave/prisoner_convoy
	downgrade_wave = /datum/migrant_wave/prisoner_convoy_down_two
	weight = 45
	roles = list(
		/datum/migrant_role/gaoler = 1,
		/datum/migrant_role/prisoner_guard = 1,
		/datum/migrant_role/mig_prisoner = 3,
	)
	greet_text = "Nobody escape the rule of Vanderlin's monarchs. Some have fled to the neighbouring kingdom, Heartfelt and got caught, they are now on their way back."

/datum/migrant_wave/prisoner_convoy_down_two
	name = "The prisoners convoy"
	max_spawns = 3
	shared_wave_type = /datum/migrant_wave/prisoner_convoy
	weight = 45
	roles = list(
		/datum/migrant_role/gaoler = 1,
		/datum/migrant_role/mig_prisoner = 1,
	)
	greet_text = "Nobody escape the rule of Vanderlin's monarchs. Some have fled to the neighbouring kingdom, Heartfelt and got caught, they are now on their way back."
