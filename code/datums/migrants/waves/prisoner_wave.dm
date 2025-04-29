/datum/migrant_role/gaoler
	name = "Gaoler"
	greet_text = "The lords of Vanderlins sent you to Heartfelt to rappatriate some prisoners that were in their prison, you are now on your way back."
	allowed_sexes = list(MALE, FEMALE)
	grant_lit_torch = TRUE
	outfit = /datum/outfit/job/gaoler
	is_foreigner = FALSE
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Dark Elf",
		"Aasimar",
		"Half-Orc")


/datum/outfit/job/gaoler/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/menacing
	neck = /obj/item/storage/belt/pouch/coins/poor
	pants = /obj/item/clothing/pants/trou
	shoes = /obj/item/clothing/shoes/simpleshoes
	wrists = /obj/item/clothing/wrists/bracers/leather
	cloak = /obj/item/clothing/cloak/stabard/dungeon
	belt = /obj/item/storage/belt/leather
	beltr = /obj/item/weapon/whip/antique
	beltl = /obj/item/flashlight/flare/torch/lantern
	backr = /obj/item/storage/backpack/satchel
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
		H.change_stat(STATKEY_STR, 2)
		H.change_stat(STATKEY_INT, -2)
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_CON, 1)
		H.change_stat(STATKEY_SPD, -1)
		H.change_stat(STATKEY_PER, -1)
	if(H.dna?.species)
		if(H.dna.species.id == "human")
			H.dna.species.soundpack_m = new /datum/voicepack/male/warrior()
	H.cmode_music = 'sound/music/cmode/nobility/CombatDungeoneer.ogg'
	H.verbs |= /mob/living/carbon/human/proc/torture_victim

/datum/migrant_role/mig_prisoner
	name = "Prisoner"
	greet_text = "You had fled Vanderlin, took refuge in Heartfelt yet the lords over there caught you and thus handed you over to those who seeked you before."
	outfit = /datum/outfit/job/mig_prisoner

/datum/outfit/job/mig_prisoner/pre_equip(mob/living/carbon/human/H)
	..()
	pants = /obj/item/clothing/pants/loincloth/brown
	mask = /obj/item/clothing/face/facemask/prisoner
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
		H.change_stat(STATKEY_STR, -1)
		H.change_stat(STATKEY_PER, 2)
		H.change_stat(STATKEY_INT, 2)
		H.change_stat(STATKEY_SPD, -1)
		H.change_stat(STATKEY_CON, -1)
		H.change_stat(STATKEY_END, -1)
	H.cmode_music = 'sound/music/cmode/towner/CombatTowner.ogg'

/datum/migrant_role/prisoner_guard
	name = "Guard"
	greet_text = "You are apart of a convoy returning prisoners to Vanderlin. Obey the gaoler and ensure the prisoners get back to the dungeons."
	outfit = /datum/outfit/job/mig_guard
	allowed_races = RACES_PLAYER_NONDISCRIMINATED
	grant_lit_torch = TRUE
	is_foreigner = FALSE

/datum/outfit/job/mig_guard/pre_equip(mob/living/carbon/human/H)
	..()
	armor = /obj/item/clothing/armor/cuirass
	shirt = /obj/item/clothing/armor/chainmail
	neck = /obj/item/clothing/neck/gorget
	head = /obj/item/clothing/head/helmet/nasal
	backr = /obj/item/weapon/shield/wood
	beltr = /obj/item/weapon/sword/scimitar/messer
	beltl = /obj/item/weapon/mace
	pants = /obj/item/clothing/pants/trou/leather
	cloak = /obj/item/clothing/cloak/stabard/guard
	shoes = /obj/item/clothing/shoes/boots
	belt = /obj/item/storage/belt/leather
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
		H.change_stat(STATKEY_STR, 1)
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_CON, 1)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)
	H.cmode_music = 'sound/music/cmode/garrison/CombatGarrison.ogg'
	H.verbs |= /mob/proc/haltyell

/datum/migrant_wave/prisoner_convoy
	name = "The Prisoners' Convoy"
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
	name = "The Prisoners' Convoy"
	shared_wave_type = /datum/migrant_wave/prisoner_convoy
	downgrade_wave = /datum/migrant_wave/prisoner_convoy_down_two
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/gaoler = 1,
		/datum/migrant_role/prisoner_guard = 1,
		/datum/migrant_role/mig_prisoner = 3,
	)
	greet_text = "Nobody escape the rule of Vanderlin's monarchs. Some have fled to the neighbouring kingdom, Heartfelt and got caught, they are now on their way back."

/datum/migrant_wave/prisoner_convoy_down_two
	name = "The Prisoner Convoy"
	shared_wave_type = /datum/migrant_wave/prisoner_convoy
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/gaoler = 1,
		/datum/migrant_role/mig_prisoner = 1,
	)
	greet_text = "Nobody escape the rule of Vanderlin's monarchs. Some have fled to the neighbouring kingdom, Heartfelt and got caught, they are now on their way back."
