/datum/advclass/mercenary/verderer
	name = "Hollow Verderer"
	tutorial = "A halberd expert that has for one reason or another, forsaken Amber Hollow in favor of pursuing coin and glory in wider parts of Psydonia."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Hollow-Kin",
		"Humen"
	)
	outfit = /datum/outfit/job/mercenary/verderer
	category_tags = list(CTAG_MERCENARY)
	maximum_possible_slots = 5


/datum/outfit/job/mercenary/verderer/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/boots/armor/light/rust
	cloak = /obj/item/clothing/cloak/raincloak/furcloak/brown
	head = /obj/item/clothing/head/helmet/leather/advanced
	gloves = /obj/item/clothing/gloves/plate/rust
	belt = /obj/item/storage/belt/leather/mercenary
	armor = /obj/item/clothing/armor/cuirass/iron/rust
	wrists = /obj/item/clothing/wrists/bracers/leather/advanced
	beltr = /obj/item/reagent_containers/glass/bottle/waterskin
	beltl = /obj/item/flashlight/flare/torch/lantern/copper
	backr = /obj/item/weapon/polearm/halberd/bardiche
	backl = /obj/item/storage/backpack/satchel
	shirt = /obj/item/clothing/shirt/tribalrag
	pants = /obj/item/clothing/pants/platelegs/rust
	neck = /obj/item/clothing/neck/chaincoif
	backpack_contents = list(/obj/item/storage/belt/pouch/coins/poor, /obj/item/weapon/knife/hunting, /obj/item/needle)

	if(H.mind)
		H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
		H.adjust_skillrank(/datum/skill/combat/shields, pick(0,0,1), TRUE)
		H.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.adjust_skillrank(/datum/skill/craft/tanning, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)

		H.merctype = 9

		H.change_stat(STATKEY_CON, 1)
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_STR, 2)

	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)

