/datum/job/stonekeep/jaegward
	title = "Jaegward"
	f_title = "Jaegwardess"
	tutorial = "In the olden daes your profession guarded pilgrims and slew great beasts in the Murderwoods, \
				todae you plunder the forests for meat and decent wood in hopes of surviving another winter. \
				Your life is a testament to the fickleness of Dendor."
	faction = FACTION_STATION
	allowed_sexes = list(MALE,FEMALE)
	flag = HUNTER
	department_flag = PEASANTS
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Dark Elf",
		"Aasimar"
	)
	outfit = /datum/outfit/job/stonekeep/jaegward
	min_pq = -25
	give_bank_account = 15
	display_order = JDO_HUNTER
	total_positions = 0
	spawn_positions = 0
	apprentice_name = "Hunter"

/datum/outfit/job/stonekeep/jaegward/pre_equip(mob/living/carbon/human/H)
	..()
	pants = /obj/item/clothing/pants/tights/provisoner
	shirt = /obj/item/clothing/shirt/shortshirt/provisoner
	shoes = /obj/item/clothing/shoes/boots/leather
	neck = /obj/item/storage/belt/pouch/coins/poor
	head = /obj/item/clothing/head/brimmed
	cloak = /obj/item/clothing/cloak/raincloak/furcloak/brown
	armor = /obj/item/clothing/armor/leather/hide
	backr = /obj/item/ammo_holder/quiver/arrows
	backl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
	belt = /obj/item/storage/belt/leather
	beltr = /obj/item/weapon/axe/iron
	beltl = /obj/item/storage/meatbag
	backpack_contents = list(/obj/item/flint = 1, /obj/item/bait = 1, /obj/item/weapon/knife/hunting = 1, /obj/item/flashlight/flare/torch/lantern = 1)
	gloves = /obj/item/clothing/gloves/leather
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/tanning, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/butchering, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/taming, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/traps, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/lumberjacking, 3, TRUE)
		H.change_stat("endurance", 1)
		H.change_stat("perception", 3)
		if(H.age == AGE_OLD)
			H.mind?.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/traps, 1, TRUE)

