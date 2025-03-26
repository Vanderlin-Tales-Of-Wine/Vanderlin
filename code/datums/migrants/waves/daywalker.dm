/datum/migrant_role/daywalker
	name = "Daywalker"
	greet_text = "Some knaves are always trying to wade upstream. You witnessed your entire village be consumed by a subservient vampiric horde - the local Priest grabbed you, and brought you to a remote Monastery; ever since then you've sworn revenge against the restless dead. The Templars showed you everything you needed to know. You walk in the day, so that the undead may only walk in the night."
	outfit = /datum/outfit/job/daywalker
	antag_datum = /datum/antagonist/daywalker
	allowed_races = list("Humen")
	grant_lit_torch = TRUE


/datum/outfit/job/daywalker/pre_equip(mob/living/carbon/human/H)
	..()
	mask = /obj/item/clothing/face/spectacles
	neck = /obj/item/clothing/neck/psycross/silver/astrata
	armor = /obj/item/clothing/armor/leather/jacket/apothecary
	shirt = /obj/item/clothing/armor/chainmail // Motherfucker are you outta yo damn mind?
	gloves = /obj/item/clothing/gloves/angle
	pants = /obj/item/clothing/pants/tights/black
	shoes = /obj/item/clothing/shoes/boots
	backr = /obj/item/storage/backpack/satchel
	backl = /obj/item/weapon/sword/long/forgotten
	belt = /obj/item/storage/belt/leather/steel
	beltl = /obj/item/flashlight/flare/torch/lantern
	id = /obj/item/clothing/ring/silver
	H.virginity = TRUE

	if(H.mind)
		if(H.patron != /datum/patron/divine/astrata)
			H.set_patron(/datum/patron/divine/astrata)

		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/firearms, 3, TRUE) // Blade 3 Trinity
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE) // can you guys help me, there's so many vampires
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 4, TRUE) // some motherfuckers are always trying to ice skate uphill		H.change_stat(STATKEY_STR, 1)
		H.change_stat(STATKEY_CON, 2)
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_PER, 2)
		H.change_stat(STATKEY_SPD, 2)
	H.dna.species.soundpack_m = new /datum/voicepack/male/knight()
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)

/datum/migrant_wave/daywalker
	name = "Astrata's Daywalker"
	max_spawns = 1
	shared_wave_type = /datum/migrant_wave/daywalker
	weight = 8
	//gets set to true in the presence of a vampire lord
	can_roll = FALSE

	roles = list(
		/datum/migrant_role/daywalker = 1,
	)
	greet_text = "There are worse things out there than vampires. You."
