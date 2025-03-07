/datum/job/archivist
	title = "Archivist"
	tutorial = "A well-traveled and well-learned seeker of knowledge, the Archivist's mind has been touched by Noc himself. They settled in Vanderlin some time ago, coming to the Isle of Enigma with the hope of unraveling its mysteries. If they can expand their library and teach the masses, Psydonia may yet enter a new age of enlightenment."
	flag = ARCHIVIST
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	bypass_lastclass = TRUE

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Aasimar"
	)
	spells = list(/obj/effect/proc_holder/spell/self/learnspell, /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)

	outfit = /datum/outfit/job/archivist
	display_order = 19
	give_bank_account = 100
	min_pq = 1

/datum/outfit/job/archivist
	job_bitflag = BITFLAG_ROYALTY

/datum/outfit/job/archivist/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.dna.species.id == "Dwarf")
		shirt = /obj/item/clothing/shirt/undershirt/puritan
		armor = /obj/item/clothing/armor/leather/jacket/apothecary
		pants = /obj/item/clothing/pants/tights/black
	else
		if(H.gender == FEMALE)
			armor = /obj/item/clothing/shirt/robe/archivist
		else
			shirt = /obj/item/clothing/shirt/undershirt/puritan
			armor = /obj/item/clothing/shirt/robe/archivist
			pants = /obj/item/clothing/pants/tights/black
	H.virginity = TRUE
	shoes = /obj/item/clothing/shoes/boots
	belt = /obj/item/storage/belt/leather/plaquesilver
	beltl = /obj/item/storage/keyring/archivist
	backl = /obj/item/storage/backpack/satchel
	neck = /obj/item/clothing/neck/psycross/noc
	backpack_contents = list(/obj/item/literary/apprentice = 1)

	if(H.mind)
		if(H.patron != /datum/patron/divine/noc)
			H.set_patron(/datum/patron/divine/noc)

		H.grant_language(/datum/language/elvish)
		H.grant_language(/datum/language/dwarvish)
		H.grant_language(/datum/language/zybantine)
		H.grant_language(/datum/language/celestial)
		H.grant_language(/datum/language/hellspeak)
		H.grant_language(/datum/language/oldpsydonic)
		H.grant_language(/datum/language/orcish)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 6, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/alchemy, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/magic/arcane, 3, TRUE)
		if(H.age == AGE_OLD)
			H.mind?.adjust_skillrank(/datum/skill/magic/arcane, 2, TRUE)
		H.change_stat(STATKEY_STR, -1)
		H.change_stat(STATKEY_INT, 8)
		H.change_stat(STATKEY_CON, -1)
		H.change_stat(STATKEY_END, -1)
		H.change_stat(STATKEY_SPD, -1)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
