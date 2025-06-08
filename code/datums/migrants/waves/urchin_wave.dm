/datum/migrant_role/urchinbrain
	name = "Urchin Leader"
	greet_text = "Without you, your friends would be dead in a ditch. You're the boss, that's why you've got a nice hat. \
	Preform stick-ups, lurk in the alleys, and make sure your siblings don't invoke the ire of the Matron. She doesn't \
	deserve the headache you give her."
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_CHILD)
	grant_lit_torch = TRUE
	is_foreigner = FALSE
	outfit = /datum/outfit/job/urchinbrain


/datum/outfit/job/urchinbrain/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/fancyhat
	shirt = /obj/item/clothing/shirt/undershirt/vagrant
	neck = /obj/item/storage/belt/pouch/coins/poor
	armor = /obj/item/clothing/shirt/rags
	pants = /obj/item/clothing/pants/tights/vagrant
	shoes = /obj/item/clothing/shoes/simpleshoes
	belt = /obj/item/storage/belt/leather
	beltr = /obj/item/weapon/knife/dagger
	backr = /obj/item/storage/backpack/satchel
	if(H.mind)
		H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/wrestling, pick(1,2,3), TRUE)
		H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.adjust_skillrank(/datum/skill/labor/mathematics, 4, TRUE)
		H.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
		H.adjust_skillrank(/datum/skill/misc/stealing, 5, TRUE)
		H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.change_stat(STATKEY_CON, -2)
		H.change_stat(STATKEY_END, -1)
		H.change_stat(STATKEY_STR, -1)
		H.change_stat(STATKEY_SPD, -1)
		H.change_stat(STATKEY_INT, 3)
		ADD_TRAIT(H, TRAIT_ORPHAN, TRAIT_GENERIC)
	H.cmode_music = 'sound/music/cmode/towner/CombatInn.ogg'

/datum/migrant_role/urchinbrawn
	name = "Urchin"
	greet_text = "Life in the orphanage is detestable, nobody ever brought you into a family. A child denied love will burn \
	down his village for warmth - that's what's happening. Listen to your boss, and stack coin; be the little shit this town \
	deserves... Don't overdo it, though - lest the Matron put an end to this scheme you lot have going."
	outfit = /datum/outfit/job/urchinbrawn

/datum/outfit/job/urchinbrawn/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/storage/belt/pouch/coins/poor
	shirt = /obj/item/clothing/shirt/undershirt/vagrant
	armor = /obj/item/clothing/shirt/rags
	pants = /obj/item/clothing/pants/tights/vagrant
	shoes = /obj/item/clothing/shoes/simpleshoes
	belt = /obj/item/storage/belt/leather
	beltr = /obj/item/weapon/mace/cudgel
	if(H.mind)
		H.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/stealing, 4, TRUE)
		H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/unarmed, pick(1,2), TRUE)
		H.change_stat(STATKEY_STR, 1)
		H.change_stat(STATKEY_CON, -1)
		H.change_stat(STATKEY_END, -1)
		H.change_stat(STATKEY_INT, -2)
		H.change_stat(STATKEY_SPD, -2)
		ADD_TRAIT(H, TRAIT_ORPHAN, TRAIT_GENERIC)
	H.cmode_music = 'sound/music/cmode/towner/CombatInn.ogg'

/datum/migrant_wave/urchin_wave
	name = "Urchin Gang"
	max_spawns = 1
	shared_wave_type = /datum/migrant_wave/urchin_wave
	downgrade_wave = /datum/migrant_wave/urchin_wave_down
	weight = 8
	roles = list(
		/datum/migrant_role/urchinbrain = 1,
		/datum/migrant_role/urchinbrawn = 2,
	)
	greet_text = "There's two rules - one, you give the Boss your coin. Two, you don't mess with the boss. Three, I can't count that good..."

/datum/migrant_wave/urchin_wave_down
	name = "Urchin Gang"
	shared_wave_type = /datum/migrant_wave/urchin_wave
	downgrade_wave = /datum/migrant_wave/urchin_wave_down_two
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/urchinbrain = 1,
		/datum/migrant_role/urchinbrawn = 1,
	)
	greet_text = "There's two rules - one, you give the Boss your coin. Two, you don't mess with the boss. Three, I can't count that good..."

/datum/migrant_wave/urchin_wave_down_two
	name = "The Urchin"
	shared_wave_type = /datum/migrant_wave/urchin_wave
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/urchinbrain = 1,
	)
	greet_text = "You're tired of eating gruel, time for something completely different."
