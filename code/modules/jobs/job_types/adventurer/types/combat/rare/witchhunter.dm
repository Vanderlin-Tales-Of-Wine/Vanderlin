
/datum/advclass/combat/puritan
	name = "Witch Hunter"
	tutorial = "Witch Hunters dedicate their lives to the eradication of the varied evils infesting Psydonia. They know the vile sorcery of the necromancer, the insidious nature of the cultist and monstrousness of vampires and werevolfs. They also know how best to end them."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_PLAYER_NONEXOTIC
	outfit = /datum/outfit/job/adventurer/puritan
	maximum_possible_slots = 1
	pickprob = 15
	category_tags = list(CTAG_ADVENTURER)
	min_pq = 2
	cmode_music = 'sound/music/cmode/church/CombatInquisitor.ogg'

/datum/outfit/job/adventurer/puritan/pre_equip(mob/living/carbon/human/H)
	..()
	shirt = /obj/item/clothing/shirt/undershirt/puritan
	belt = /obj/item/storage/belt/leather
	shoes = /obj/item/clothing/shoes/boots
	pants = /obj/item/clothing/pants/tights/black
	armor = /obj/item/clothing/armor/leather/vest/winterjacket
	beltr = /obj/item/storage/belt/pouch/coins/mid
	head = /obj/item/clothing/head/helmet/leather/inquisitor
	gloves = /obj/item/clothing/gloves/angle
	beltl = /obj/item/weapon/sword/rapier/silver
	neck = /obj/item/clothing/neck/chaincoif

	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/whipsflails, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.change_stat(STATKEY_INT, 1)
		H.change_stat(STATKEY_STR, 1)
		H.change_stat(STATKEY_PER, 2)
		H.change_stat(STATKEY_CON, 2)
		switch(H.patron?.name)
			if("Astrata")
				wrists = /obj/item/clothing/neck/psycross/silver/astrata
			if("Necra")
				wrists = /obj/item/clothing/neck/psycross/silver/necra
			if("Pestra")
				wrists = /obj/item/clothing/neck/psycross/silver/pestra
			else
				wrists = /obj/item/clothing/wrists/bracers/leather
	H.verbs |= /mob/living/carbon/human/proc/torture_victim
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)		//If they have torture variables, they shouldn't be effected by stuff.
