/datum/advclass/sk_pilgrimminer
	name = "Miner"
	tutorial = "Hardy people who ceaselessly toil at the mines for ores and salt, \
				who will ever know what they'll find beneath?"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Rakshari",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Dark Elf",
		"Aasimar",
		"Ogrun"
	)
	outfit = /datum/outfit/job/stonekeep/adventurer/miner
	category_tags = list(CTAG_PILGRIM)
	apprentice_name = "Miner Apprentice"

/datum/outfit/job/stonekeep/adventurer/miner/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/armingcap
	pants = /obj/item/clothing/pants/trou
	armor = /obj/item/clothing/armor/gambeson/light/striped
	shirt = /obj/item/clothing/shirt/undershirt/random
	shoes = /obj/item/clothing/shoes/boots/leather
	belt = /obj/item/storage/belt/leather
	neck = /obj/item/storage/belt/pouch/coins/poor
	beltl = /obj/item/weapon/pick
	backr = /obj/item/weapon/shovel
	backl = /obj/item/storage/backpack/backpack
	backpack_contents = list(/obj/item/flint = 1, /obj/item/weapon/knife/villager = 1)
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/mining, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/traps, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/engineering, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/smelting, 4, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("intelligence", -2)
		H.change_stat("endurance", 1)
		H.change_stat("constitution", 1)

	if(H.dna.species.id == "dwarf")
		head = /obj/item/clothing/head/helmet/leather/minershelm
		id = /obj/item/key/guildring
		H.cmode_music = 'sound/music/cmode/combat_dwarf.ogg'
	else
		beltr = /obj/item/flashlight/flare/torch/lantern
