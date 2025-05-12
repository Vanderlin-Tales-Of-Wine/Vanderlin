/datum/advclass/mercenary/boltslinger
	name = "Boltslinger"
	tutorial = "A cutthroat and a soldier of fortune, your mastery of the crossbow has brought you to many battlefields, all in pursuit of mammon."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_PLAYER_NONEXOTIC
	outfit = /datum/outfit/job/mercenary/boltslinger
	category_tags = list(CTAG_MERCENARY)
	maximum_possible_slots = 5


/datum/outfit/job/mercenary/boltslinger/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/boots/leather
	cloak = /obj/item/clothing/cloak/half
	head = /obj/item/clothing/head/helmet/sallet
	gloves = /obj/item/clothing/gloves/angle
	belt = /obj/item/storage/belt/leather/mercenary
	armor = /obj/item/clothing/armor/cuirass
	beltr = /obj/item/weapon/sword/iron
	beltl = /obj/item/ammo_holder/quiver/bolts
	backr = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
	backl = /obj/item/storage/backpack/satchel
	shirt = /obj/item/clothing/shirt/undershirt/black
	pants = /obj/item/clothing/pants/tights/black
	neck = /obj/item/clothing/neck/chaincoif
	backpack_contents = list(/obj/item/storage/belt/pouch/coins/poor, /obj/item/weapon/knife/hunting)
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/shields, pick(0,0,1), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/tanning, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)

		H.merctype = 6

		H.change_stat(STATKEY_PER, 2)
		H.change_stat(STATKEY_END, 1)
		H.change_stat(STATKEY_STR, 1)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
