/datum/migrant_role/ratcatcher
	name = "Ratcatcher"
	greet_text = "You've been on the street for as long as you can remember. Still are, and you still will be so long as \
	you live in this shitpit. Regrettably, the universe sought to make your life a divine comedy. Instead of begging for \
	coin, the nobility sought it grand to give you a royal title - Ratcatcher. Please, for the love of Necra, just LET IT END!"
	outfit = /datum/outfit/job/ratcatcher

/datum/outfit/job/ratcatcher/pre_equip(mob/living/carbon/human/H)
	..()
	r_hand = /obj/item/weapon/pitchfork
	l_hand = /obj/item/flint
	armor = /obj/item/clothing/armor/gambeson/light
	shirt = /obj/item/clothing/shirt/undershirt/vagrant
	neck = /obj/item/clothing/neck/coif/cloth
	head = /obj/item/clothing/head/helmet/leather
	gloves = /obj/item/clothing/gloves/fingerless
	pants = /obj/item/clothing/pants/tights/vagrant
	shoes = /obj/item/clothing/shoes/boots
	belt = /obj/item/storage/belt/leather
	beltr = /obj/item/flashlight/flare/torch/lantern
	beltl = /obj/item/storage/belt/pouch/coins/poor

	if(H.mind)
		H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE) // Polearm user
		H.adjust_skillrank(/datum/skill/misc/climbing, 2)
		H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE) // For fleeing
		H.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.change_stat(STATKEY_SPD, -2)
		H.change_stat(STATKEY_END, 2) // Polearm user
		H.change_stat(STATKEY_CON, 1) // No dodge, shit skills. Pity point
		H.change_stat(STATKEY_INT, -3) // IDIOT
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	H.cmode_music = 'sound/music/cmode/towner/CombatTowner2.ogg'

/datum/migrant_wave/ratcatcher
	name = "The Ratcatcher"
	max_spawns = 1
	shared_wave_type = /datum/migrant_wave/ratcatcher
	weight = 10
	roles = list(
		/datum/migrant_role/ratcatcher = 1,
	)
	greet_text = "A peasant comes in to sit at the table. He looks depressed, horribly depressed."
