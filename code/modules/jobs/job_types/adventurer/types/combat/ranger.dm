/datum/advclass/combat/ranger
	name = "Ranger"
	tutorial = "Humen and elf rangers often live among each other, as these bow-wielding \
	adventurers are often scouting the lands for the same purpose."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Tiefling",
		"Dark Elf",
		"Aasimar",
		"Half-Orc",
		"Rakshari"
	)
	outfit = /datum/outfit/job/adventurer/ranger
	min_pq = 0
	category_tags = list(CTAG_ADVENTURER)
	cmode_music = 'sound/music/cmode/adventurer/CombatWarrior.ogg'

/datum/outfit/job/adventurer/ranger/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/boots/leather
	H.mind?.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/tanning, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/labor/taming, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/traps, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	if(H.gender == MALE)
		pants = /obj/item/clothing/pants/trou/leather
		shirt = /obj/item/clothing/shirt/undershirt
	else
		pants = /obj/item/clothing/pants/tights
		if(prob(50))
			pants = /obj/item/clothing/pants/tights/black
		shirt = /obj/item/clothing/shirt/undershirt
	if(prob(23))
		gloves = /obj/item/clothing/gloves/leather
	else
		gloves = /obj/item/clothing/gloves/fingerless
	wrists = /obj/item/clothing/wrists/bracers/leather
	belt = /obj/item/storage/belt/leather
	armor = /obj/item/clothing/armor/leather/hide
	cloak = /obj/item/clothing/cloak/raincloak/brown
	if(prob(33))
		cloak = /obj/item/clothing/cloak/raincloak/green
	backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
	backl = /obj/item/storage/backpack/satchel
	beltr = /obj/item/flashlight/flare/torch/lantern
	backpack_contents = list(/obj/item/bait = 1, /obj/item/weapon/knife/hunting = 1)
	beltl = /obj/item/ammo_holder/quiver/arrows
	H.change_stat(STATKEY_PER, 2)
	H.change_stat(STATKEY_END, 1)
	H.change_stat(STATKEY_SPD, 1)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	if(prob(25))
		if(!H.has_language(/datum/language/elvish))
			H.grant_language(/datum/language/elvish)
			to_chat(H, "<span class='info'>I can speak Elfish with ,e before my speech.</span>")
