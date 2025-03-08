/datum/advclass/pilgrim/sk_tailor
	name = "Tailor"
	allowed_sexes = list(MALE)
	allowed_races = list("Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Aasimar",
		"Changeling",
		"Skylancer",
		"Ogrun",
		"Undine"
	)
	outfit = /datum/outfit/job/stonekeep/adventurer/tailor
	category_tags = list(CTAG_PILGRIM)
	apprentice_name = "Tailor Apprentice"

/datum/outfit/job/stonekeep/adventurer/tailor/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/nobleboot
	head = /obj/item/clothing/head/courtierhat
	belt = /obj/item/storage/belt/leather
	beltr = /obj/item/weapon/knife/scissors
	backr = /obj/item/storage/backpack/satchel
	neck = /obj/item/storage/belt/pouch/coins/mid
	cloak = /obj/item/clothing/cloak/raincloak/furcloak
	backpack_contents = list(/obj/item/needle = 1, /obj/item/natural/bundle/cloth = 2, /obj/item/natural/bundle/fibers = 1, /obj/item/dye_pack/luxury = 1, /obj/item/book/advice_weaving = 1, /obj/item/weapon/knife/villager = 1)

	H.mind?.adjust_skillrank(/datum/skill/misc/sewing, pick(4,5), TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/tanning, pick(3,4), TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/stealing, 1, TRUE)
	ADD_TRAIT(H, TRAIT_SEEPRICES, TRAIT_GENERIC)

	pants = /obj/item/clothing/pants/tights/red
	shirt = /obj/item/clothing/shirt/undershirt/webs
	armor = /obj/item/clothing/shirt/tunic/random

	H.change_stat(STATKEY_INT, 2)
	H.change_stat(STATKEY_SPD, 1)
	H.change_stat(STATKEY_PER, 1)
	H.change_stat(STATKEY_STR, -1)

/datum/advclass/pilgrim/sk_seamstress
	name = "Seamstress"
	allowed_sexes = list(FEMALE)
	allowed_races = list("Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Aasimar",
		"Changeling",
		"Skylancer",
		"Ogrun",
		"Undine"
	)
	outfit = /datum/outfit/job/stonekeep/adventurer/seamstress
	category_tags = list(CTAG_PILGRIM)
	apprentice_name = "Tailor Apprentice"

/datum/outfit/job/stonekeep/adventurer/seamstress/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/nobleboot
	head = /obj/item/clothing/head/courtierhat
	belt = /obj/item/storage/belt/leather
	beltr = /obj/item/weapon/knife/scissors
	beltl = /obj/item/storage/keyring/tailor
	backr = /obj/item/storage/backpack/satchel
	neck = /obj/item/storage/belt/pouch/coins/mid
	cloak = /obj/item/clothing/cloak/raincloak/furcloak
	backpack_contents = list(/obj/item/needle = 1, /obj/item/natural/bundle/cloth = 2, /obj/item/natural/bundle/fibers = 1, /obj/item/dye_pack/luxury = 1, /obj/item/book/advice_weaving = 1, /obj/item/weapon/knife/villager = 1)

	H.mind?.adjust_skillrank(/datum/skill/misc/sewing, pick(4,5), TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/tanning, pick(3,4), TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/stealing, 1, TRUE)
	ADD_TRAIT(H, TRAIT_SEEPRICES, TRAIT_GENERIC)

	shirt = /obj/item/clothing/shirt/dress/gen/random
	pants = /obj/item/clothing/pants/tights/purple
	H.change_stat(STATKEY_INT, 2)
	H.change_stat(STATKEY_SPD, 1)
	H.change_stat(STATKEY_PER, 1)
	H.change_stat(STATKEY_STR, -1)
