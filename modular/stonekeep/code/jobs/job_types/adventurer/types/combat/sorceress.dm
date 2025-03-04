/datum/advclass/combat/sk_sorceress
	name = "Sorceress"
	tutorial = "In some places in Psydonia, women are banned from the study of magic. Those that do even then are afforded the title Sorceress in honor of their resolve."
	allowed_sexes = list(FEMALE)
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Dark Elf",
		"Aasimar"
	)
	outfit = /datum/outfit/job/roguetown/adventurer/sk_sorceress
	maximum_possible_slots = 2
	min_pq = -10
	category_tags = list(CTAG_ADVENTURER)
	cmode_music = 'sound/music/cmode/adventurer/CombatSorcerer.ogg'

/datum/outfit/job/roguetown/adventurer/sk_sorceress/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/simpleshoes
	armor = /obj/item/clothing/shirt/robe/mage
	belt = /obj/item/storage/belt/leather/rope
	backr = /obj/item/storage/backpack/satchel
	beltl = /obj/item/reagent_containers/glass/bottle/manapot
	r_hand = /obj/item/weapon/polearm/woodstaff
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/magic/arcane, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/alchemy, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		if(H.age == AGE_OLD)
			H.mind?.adjust_skillrank(/datum/skill/magic/arcane, 2, TRUE)
		H.change_stat("strength", -1)
		H.change_stat("intelligence", 3)
		H.change_stat("constitution", -1)
		H.change_stat("endurance", -1)
		H.change_stat("speed", -2)
		H.mind.adjust_spellpoints(7)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/self/learnspell)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
