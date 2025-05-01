/datum/migrant_role/inquisitor
	name = "Episcopal Inquisitor"
	greet_text = "These lands have forfeited Psydon and the Ten. You have come to restore the True faith to these people and tear out the rot festering within."
	antag_datum = /datum/antagonist/purishep
	outfit = /datum/outfit/job/specialinquisitor
	allowed_races = RACES_PLAYER_GRENZ

/datum/outfit/job/specialinquisitor/pre_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	wrists = /obj/item/clothing/neck/psycross/silver
	neck = /obj/item/clothing/neck/bevor
	shirt = /obj/item/clothing/shirt/undershirt/fancy
	belt = /obj/item/storage/belt/leather/knifebelt/black/psydon
	shoes = /obj/item/clothing/shoes/otavan/inqboots
	pants = /obj/item/clothing/pants/trou/leather
	backr = /obj/item/storage/backpack/satchel
	head = /obj/item/clothing/head/leather/inqhat
	gloves = /obj/item/clothing/gloves/otavan/inqgloves
	beltr = /obj/item/storage/belt/pouch/coins/rich
	beltl = /obj/item/weapon/sword/rapier
	mask = /obj/item/clothing/face/spectacles/inqglasses
	armor = /obj/item/clothing/armor/medium/scale/inqcoat
	backpack_contents = list(/obj/item/weapon/knife/dagger/silver, /obj/item/flashlight/flare/torch/lantern/copper)
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/firearms, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)
		H.change_stat(STATKEY_INT, 2)
		H.change_stat(STATKEY_STR, 1)
		H.change_stat(STATKEY_PER, 2)
		H.change_stat(STATKEY_SPD, 2)
		H.change_stat(STATKEY_END, 1)
		if(!H.has_language(/datum/language/oldpsydonic))
			H.grant_language(/datum/language/oldpsydonic)
		if(H.mind.has_antag_datum(/datum/antagonist))
			return
		var/datum/antagonist/new_antag = new /datum/antagonist/purishep()
		H.mind.add_antag_datum(new_antag)
		H.set_patron(/datum/patron/psydon)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	H.verbs |= /mob/living/carbon/human/proc/torture_victim
	H.verbs |= /mob/living/carbon/human/proc/faith_test
	to_chat(H,span_info("I can speak Old Psydonic with ,m before my speech."))
	H.mind?.teach_crafting_recipe(/datum/repeatable_crafting_recipe/reading/confessional)

/datum/migrant_role/crusader
	name = "Crusader"
	greet_text = "Crusader of the true faith, you came from Grenzelhoft under the command of the Inquisitor. Obey them as they lead you to smite the heathens."
	outfit = /datum/outfit/job/adventurer/crusader
	allowed_races = RACES_PLAYER_GRENZ

/datum/migrant_wave/crusade
	name = "The Holy Crusade"
	shared_wave_type = /datum/migrant_wave/crusade
	downgrade_wave = /datum/migrant_wave/crusade_down_one
	weight = 5
	max_spawns = 1
	roles = list(
		/datum/migrant_role/inquisitor = 1,
		/datum/migrant_role/crusader = 4)
	greet_text = "These heathens, they have forsaken the teaching of everything that is good. We shan't let them insults the true Gods no more. The Inquisitor will lead us to make sure of that."

/datum/migrant_wave/crusade_down_one
	name = "The Holy Crusade"
	shared_wave_type = /datum/migrant_wave/crusade
	downgrade_wave = /datum/migrant_wave/crusade_down_two
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/inquisitor = 1,
		/datum/migrant_role/crusader = 3)
	greet_text = "These heathens, they have forsaken the teaching of everything that is good. We shan't let them insults the true Gods no more. The Inquisitor will lead us to make sure of that."

/datum/migrant_wave/crusade_down_two
	name = "The Holy Crusade"
	shared_wave_type = /datum/migrant_wave/crusade
	downgrade_wave = /datum/migrant_wave/crusade_down_three
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/inquisitor = 1,
		/datum/migrant_role/crusader = 2)
	greet_text = "These heathens, they have forsaken the teaching of everything that is good. We shan't let them insults the true Gods no more. The Inquisitor will lead us to make sure of that."

/datum/migrant_wave/crusade_down_three
	name = "The Holy Crusade"
	shared_wave_type = /datum/migrant_wave/crusade
	downgrade_wave = /datum/migrant_wave/crusade_down_four
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/inquisitor = 1,
		/datum/migrant_role/crusader = 1)
	greet_text = "These heathens, they have forsaken the teaching of everything that is good. We shan't let them insults the true Gods no more. The Inquisitor will lead us to make sure of that."

/datum/migrant_wave/crusade_down_four
	name = "The One-Man Crusade"
	shared_wave_type = /datum/migrant_wave/crusade
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/inquisitor = 1)
	greet_text = "These heathens, they have forsaken the teaching of everything that is good. I shan't let them insult the true Gods no more. I will make sure of that."
