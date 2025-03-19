/datum/job/physicker
	title = "Physicker"
	tutorial =  "Those who fail their studies, or are exiled from the towns they take \
				residence as feldshers in, often end up becoming wandering physickers. \
				Capable doctors nonetheless, they journey from place to place offering \
				their services."
	flag = PHYSICKER
	department_flag = SERFS
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_PHYSICKER
	faction = FACTION_STATION
	total_positions = 2
	spawn_positions = 2

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Dark Elf",
		"Aasimar",
		"Half-Orc"
	)

	outfit = /datum/outfit/job/physicker
	cmode_music = 'sound/music/cmode/nobility/combat_physician.ogg'

/datum/outfit/job/physicker/pre_equip(mob/living/carbon/human/H)
	..()
	mask = /obj/item/clothing/face/phys
	head = /obj/item/clothing/head/roguehood/phys
	shoes = /obj/item/clothing/shoes/boots/leather
	shirt = /obj/item/clothing/shirt/undershirt/black
	backr = /obj/item/storage/backpack/satchel
	backpack_contents =list(/obj/item/storage/keyring/physicker = 1)
	pants = /obj/item/clothing/pants/tights/random
	gloves = /obj/item/clothing/gloves/leather/phys
	armor = /obj/item/clothing/shirt/robe/phys
	neck = /obj/item/clothing/neck/phys
	r_hand = /obj/item/storage/backpack/satchel/surgbag

	H.mind?.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
	if(H.age == AGE_OLD)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
	H.change_stat(STATKEY_INT, 2)
	H.change_stat(STATKEY_SPD, 1)
	ADD_TRAIT(H, TRAIT_EMPATH, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
	H?.mind?.AddSpell(new /obj/effect/proc_holder/spell/invoked/diagnose/secular)
