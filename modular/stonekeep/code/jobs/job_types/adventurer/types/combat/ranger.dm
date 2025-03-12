/datum/advclass/combat/sk/ranger
	name = "Ranger"
	tutorial = "Rangers live outside of society and explore the far corners of the wilderness. \
	They protect remote settlements from wild beasts and sell their notes to the cartographers."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Dwarf",
		"Elf",
		"Half-Elf",
		"Tiefling",
		"Dark Elf",
		"Aasimar"
	)
	outfit = /datum/outfit/job/sk/adventurer/ranger
	min_pq = -10
	category_tags = list(CTAG_ADVENTURER)
	cmode_music = 'sound/music/cmode/adventurer/CombatWarrior.ogg'

/datum/outfit/job/sk/adventurer/ranger/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind?.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/tanning, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/labor/taming, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/traps, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)

	shirt = /obj/item/clothing/shirt/undershirt/random
	pants = pick(/obj/item/clothing/pants/tights/random, /obj/item/clothing/pants/trou/leather )
	gloves = pick(/obj/item/clothing/gloves/leather, /obj/item/clothing/gloves/fingerless)
	wrists = /obj/item/clothing/wrists/bracers/leather
	belt = /obj/item/storage/belt/leather
	armor = /obj/item/clothing/armor/leather/hide
	cloak = /obj/item/clothing/cloak/raincloak/woodsman
	backl = /obj/item/storage/backpack/satchel
	shoes = pick(/obj/item/clothing/shoes/boots, /obj/item/clothing/shoes/boots/leather)
	backpack_contents = list(/obj/item/bait = 1, /obj/item/flashlight/flare/torch/lantern = 1, /obj/item/weapon/knife/hunting = 1)

	H.change_stat("perception", 2)
	H.change_stat("endurance", 1)
	H.change_stat("speed", 1)
	if(prob(10))
		H.change_stat("perception", 1)

	if(H.dna.species.id == "dwarf")

		armor = /obj/item/clothing/armor/chainmail/iron // Starts with better armor than a typical ranger (iron chainmail) but has no dodge expert or sneaking skill
		backr = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
		beltr = /obj/item/weapon/sword/scimitar/falchion
		beltl = /obj/item/ammo_holder/quiver/bolts
		ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC) // Dwarf rangers are no good at dodging, but can wear heavier armor than typical rangers
		H.cmode_music = 'sound/music/cmode/combat_dwarf.ogg'
	else
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
		beltr = /obj/item/weapon/sword/iron
		beltl = /obj/item/ammo_holder/quiver/arrows
		ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
		if(!H.has_language(/datum/language/elvish))
			H.grant_language(/datum/language/elvish)
			to_chat(H, "<span class='info'>I can speak Elfish with ,e before my speech.</span>")
