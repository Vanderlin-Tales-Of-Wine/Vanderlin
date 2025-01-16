/datum/job/roguetown/feldsher
	title = "Feldsher"
	flag = FELDSHER
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	outfit = /datum/outfit/job/roguetown/feldsher
	display_order = JDO_FELDSHER
	tutorial = "You have seen countless wounds over your time. Stitched the sores of blades, sealed honey over the bubous of plague. \
	A thousand deaths stolen from the Carriagemen, yet these people will still call you a charlatan. At least the Apothecary understands you."
	give_bank_account = 100
	min_pq = 2

	//Reason all races allowed is you are basically a very talented court physician; even 'lower races' would find this to be one of the only ways to obtain a sort of nobility.
	allowed_races = list(
		"Humen",
		"Rakshari",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Dark Elf",
		"Aasimar",
		"Half-Orc"
	)
	allowed_sexes = list(MALE, FEMALE)

	cmode_music = 'sound/music/cmode/nobility/combat_physician.ogg'

/datum/outfit/job/roguetown/feldsher/pre_equip(mob/living/carbon/human/H)
	..()
	H.virginity = TRUE
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/red
	backr = /obj/item/storage/backpack/rogue/satchel
	backl = /obj/item/storage/backpack/rogue/satchel/surgbag
	pants = /obj/item/clothing/under/roguetown/tights/random
	gloves = /obj/item/clothing/gloves/roguetown/leather/feld
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/feld
	head = /obj/item/clothing/head/roguetown/roguehood/feld
	mask = /obj/item/clothing/mask/rogue/feld
	neck = /obj/item/clothing/neck/roguetown/feld
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/storage/keyring/doctor

	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 5, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/alchemy, 3, TRUE)

		if(H.age == AGE_OLD)
			H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	H.change_stat("strength", -1)
	H.change_stat("intelligence", 4)
	H.change_stat("constitution", -1)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_EMPATH, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_LEGENDARY_ALCHEMIST, TRAIT_GENERIC)
	H?.mind?.AddSpell(new /obj/effect/proc_holder/spell/invoked/diagnose/secular)
