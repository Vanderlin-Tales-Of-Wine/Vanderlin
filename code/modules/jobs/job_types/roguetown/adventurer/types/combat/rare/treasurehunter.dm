//dagger and huntknife
/datum/advclass/combat/gravedigger
	name = "Treasure Hunter"
	tutorial = "Grave robbers sell themselves as treasure hunters, but be sure to wipe that \
	necrotic flesh off of that trinket you found."
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
	outfit = /datum/outfit/job/roguetown/adventurer/gravedigger
	min_pq = 0
	category_tags = list(CTAG_ADVENTURER)
	cmode_music = 'sound/music/cmode/church/CombatGravekeeper.ogg'

/datum/outfit/job/roguetown/adventurer/gravedigger/pre_equip(mob/living/carbon/human/H)
	..()
	pants = /obj/item/clothing/under/roguetown/tights/black
	armor = /obj/item/clothing/suit/roguetown/armor/leather/vest/black
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
	backl = /obj/item/storage/backpack/rogue/satchel
	belt = /obj/item/storage/belt/rogue/leather/rope
	backpack_contents = list(/obj/item/rogueweapon/pick = 1, /obj/item/rogueweapon/knife/hunting = 1, /obj/item/lockpickring/mundane)
	gloves = /obj/item/clothing/gloves/roguetown/fingerless
	cloak = /obj/item/clothing/cloak/raincloak/mortus
	armor = /obj/item/clothing/suit/roguetown/armor/leather
	shoes = /obj/item/clothing/shoes/roguetown/boots/leather
	beltr = /obj/item/flashlight/flare/torch/lantern
	beltl = /obj/item/rogueweapon/whip // You know why.
	backr = /obj/item/rogueweapon/shovel
	head = /obj/item/clothing/head/roguetown/helmet/leather/inquisitor
	neck = /obj/item/storage/belt/rogue/pouch
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 5, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("perception", 2)
		H.change_stat("intelligence", 1)
		H.change_stat("endurance", 2)
		H.change_stat("speed", 1)
		H.change_stat("fortune", -1) // Tradeoff for never being cursed when graverobbing.
		ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_GRAVEROBBER, TRAIT_GENERIC)
