/datum/advclass/adventurer/qatil
	name = "Qatil"
	tutorial = "Hailing from Zybantine lands, you are a killer for hire that is trained both in murdering unseen and seen with your trusty knife."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Tiefling",
		"Dark Elf",
	)
	outfit = /datum/outfit/job/roguetown/adventurer/qatil
	maximum_possible_slots = 1
	min_pq = 0
	pickprob = 25
	category_tags = list(CTAG_ADVENTURER)

	cmode_music = 'sound/music/cmode/adventurer/CombatOutlander3.ogg'

/datum/outfit/job/roguetown/adventurer/qatil/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/traps, 1, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("speed", 2)
		H.change_stat("endurance", 1)

	pants = /obj/item/clothing/under/roguetown/trou/leather
	beltr = /obj/item/rogueweapon/knife/dagger/steel/special
	shoes = /obj/item/clothing/shoes/roguetown/shalal
	gloves = /obj/item/clothing/gloves/roguetown/angle
	belt = /obj/item/storage/belt/rogue/leather/shalal
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/red
	armor = /obj/item/clothing/suit/roguetown/armor/leather/splint
	backl = /obj/item/storage/backpack/rogue/satchel
	head = /obj/item/clothing/neck/roguetown/keffiyeh/red
	backpack_contents = list(/obj/item/storage/belt/rogue/pouch/coins/poor, /obj/item/lockpick)
	if(!H.has_language(/datum/language/zybantine))
		H.grant_language(/datum/language/zybantine)
		to_chat(H, "<span class='info'>I can speak Zybean with ,z before my speech.</span>")

	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
