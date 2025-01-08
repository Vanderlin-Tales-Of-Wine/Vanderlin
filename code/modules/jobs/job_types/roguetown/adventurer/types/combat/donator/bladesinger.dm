/datum/advclass/combat/bladesinger
	name = "Bladesinger"
	tutorial = "Your vigil over the elven cities has long since ended. Though dutiful, the inevitable happened and now you hope these lands have use for your talents."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Elf",
		"Dark Elf"
	)
	maximum_possible_slots = 1
	pickprob = 15
	outfit = /datum/outfit/job/roguetown/adventurer/bladesinger
	category_tags = list(CTAG_ADVENTURER)
	min_pq = 2
	cmode_music = 'sound/music/cmode/adventurer/CombatWarrior.ogg'


/datum/outfit/job/roguetown/adventurer/bladesinger/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.change_stat("strength", 2) // Same stat spread as lancer/swordmaster, but gets a small bonus to speed instead of a malus, at the cost of getting no constitution bonus
		H.change_stat("endurance", 2)
		H.change_stat("speed", 1)
	if(H.gender == FEMALE)
		H.underwear = "Femleotard"
		H.underwear_color = CLOTHING_SOOT_BLACK
		H.update_body()
	if(H.dna.species.name == "Dark Elf")
		pants = /obj/item/clothing/under/roguetown/tights/black
		backr = /obj/item/rogueweapon/sword/long/greatsword/elfgsword
		beltl = /obj/item/storage/belt/rogue/pouch/coins/mid
		shoes = /obj/item/clothing/shoes/roguetown/boots/rare/elfplate
		gloves = /obj/item/clothing/gloves/roguetown/rare/elfplate
		belt = /obj/item/storage/belt/rogue/leather
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
		armor = /obj/item/clothing/suit/roguetown/armor/rare/elfplate
		backl = /obj/item/storage/backpack/rogue/satchel
		head = /obj/item/clothing/head/roguetown/rare/elfplate
		neck = /obj/item/clothing/neck/roguetown/chaincoif
	if(H.dna.species.name == "Elf")
		pants = /obj/item/clothing/under/roguetown/tights/black
		backr = /obj/item/rogueweapon/sword/long/greatsword/elfgsword
		beltl = /obj/item/storage/belt/rogue/pouch/coins/mid
		shoes = /obj/item/clothing/shoes/roguetown/boots/rare/elfplate/welfplate
		gloves = /obj/item/clothing/gloves/roguetown/rare/elfplate/welfplate
		belt = /obj/item/storage/belt/rogue/leather
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
		armor = /obj/item/clothing/suit/roguetown/armor/rare/elfplate/welfplate
		backl = /obj/item/storage/backpack/rogue/satchel
		head = /obj/item/clothing/head/roguetown/rare/elfplate/welfplate
		neck = /obj/item/clothing/neck/roguetown/chaincoif
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
