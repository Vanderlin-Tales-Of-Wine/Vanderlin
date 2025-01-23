/datum/job/roguetown/physicker
	title = "Physicker"
	tutorial =  "Those who fail their studies, or are exiled from the towns they take \
				residence as feldshers in, often end up becoming wandering physickers. \
				Capable doctors nonetheless, they journey from place to place offering \
				their services."
	faction = "Station"
	flag = PHYSICKER
	department_flag = SERFS
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
	display_order = JDO_PHYSICKER
	total_positions = 2
	spawn_positions = 2
	outfit = /datum/outfit/job/roguetown/physicker

/datum/outfit/job/roguetown/physicker/pre_equip(mob/living/carbon/human/H)
	..()
	mask = /obj/item/clothing/mask/rogue/phys
	head = /obj/item/clothing/head/roguetown/roguehood/phys
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
	backr = /obj/item/storage/backpack/rogue/satchel
	backpack_contents =list(/obj/item/storage/keyring/physicker = 1)
	pants = /obj/item/clothing/under/roguetown/tights/random
	gloves = /obj/item/clothing/gloves/roguetown/leather/phys
	armor = /obj/item/clothing/suit/roguetown/shirt/robe/phys
	neck = /obj/item/clothing/neck/roguetown/phys
	r_hand = /obj/item/storage/backpack/rogue/satchel/surgbag

	H.mind?.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
	if(H.age == AGE_OLD)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
	H.change_stat("intelligence", 2)
	H.change_stat("speed", 1)
	ADD_TRAIT(H, TRAIT_EMPATH, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
	H?.mind?.AddSpell(new /obj/effect/proc_holder/spell/invoked/diagnose/secular)
