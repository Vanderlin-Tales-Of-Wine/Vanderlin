/datum/advclass/combat/rogue
	name = "Rogue"
	tutorial = "A wandering thief, capable of breaking in and out of just about any secure location, and born to meet the sharp end of the guillotine. Just remember, murder is the mark of an amateur."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Dark Elf",
		"Aasimar"
	)
	outfit = /datum/outfit/job/roguetown/adventurer/rogue
	min_pq = 0
	category_tags = list(CTAG_ADVENTURER)
	cmode_music = 'sound/music/cmode/adventurer/CombatRogue.ogg'

/datum/outfit/job/roguetown/adventurer/rogue/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/boots
	H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/swords, pick(0,0,1), TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/reading, pick(0,1,1), TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 5, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/stealing, 4, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/traps, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/alchemy, 1, TRUE)
	pants = /obj/item/clothing/under/roguetown/trou/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
	gloves = /obj/item/clothing/gloves/roguetown/leather
	if(prob(30))
		gloves = /obj/item/clothing/gloves/roguetown/fingerless
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather
	cloak = /obj/item/clothing/cloak/raincloak/mortus
	backl = /obj/item/storage/backpack/rogue/satchel
	beltr = /obj/item/rogueweapon/mace/cudgel
	backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
	beltl = /obj/item/quiver/arrows
	neck = /obj/item/clothing/neck/roguetown/coif
	backpack_contents = list(/obj/item/lockpick = 1, /obj/item/rogueweapon/knife/dagger/steel)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_THIEVESGUILD, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_LIGHT_STEP, TRAIT_GENERIC)
	H.change_stat(STATKEY_STR, -1)
	H.change_stat(STATKEY_PER, 2)
	H.change_stat(STATKEY_SPD, 2)

	H.grant_language(/datum/language/thievescant)
	to_chat(H, "<span class='info'>I can gesture in thieves' cant with ,t before my speech.</span>")
