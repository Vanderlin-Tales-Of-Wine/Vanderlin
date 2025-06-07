/datum/advclass/mercenary/kern
	name = "Kern"
	tutorial = "A mercanary hailing from Kaledon, you fight under your Gallowglass or for your own coin, you fled with your fellow countrymen to escape the Grenzelhoftian Occupation of your homeland."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Half-Elf",
		"Dwarf"
	)
	outfit = /datum/outfit/job/mercenary/kern
	category_tags = list(CTAG_MERCENARY)
	maximum_possible_slots = 4

	cmode_music = 'sound/music/cmode/Combat_Dwarf.ogg'

/datum/outfit/job/mercenary/kern/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/boots/leather
	head = /obj/item/clothing/head/roguehood/black
	belt = /obj/item/storage/belt/leather/mercenary/black
	armor = /obj/item/clothing/armor/chainmail/iron
	cloak = /obj/item/clothing/cloak/stabard/kaledon
	wrists = /obj/item/clothing/wrists/bracers/leather
	gloves = /obj/item/clothing/gloves/leather
	neck = /obj/item/clothing/neck/gorget
	beltr = /obj/item/storage/belt/pouch/coins/poor
	beltl = /obj/item/ammo_holder/quiver/arrows
	shirt = /obj/item/clothing/armor/gambeson/light/striped
	pants = /obj/item/clothing/pants/chainlegs/kilt/iron
	backl = /obj/item/weapon/polearm/spear
	backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
	backpack_contents = list(/obj/item/weapon/knife/villager = 1)
	if(H.mind)
		H.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE) // Main weapon skill
		H.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)// Secondary Weapon Skill
		H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE) // Better at climbing than the Gallowglass
		H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.change_stat(STATKEY_SPD, 2) // fast, not strong
	H.change_stat(STATKEY_END, 1)
	H.change_stat(STATKEY_STR, -1)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
