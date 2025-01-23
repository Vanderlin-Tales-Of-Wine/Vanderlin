/datum/job/roguetown/minor_noble
	title = "Noble"
	tutorial = "The blood of a noble family runs through your veins. You are the living proof that the minor houses \
	of Vanderlin still exist in spite of the Monarch. You have many mammons to your name, but with wealth comes \
	danger, so keep your wits and tread lightly..."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Dark Elf",
		"Half-Orc",
		"Aasimar",
		"Rakshari"
	)
	outfit = /datum/outfit/job/roguetown/noble
	faction = "Station"
	display_order = JDO_MINOR_NOBLE
	flag = MINOR_NOBLE
	department_flag = NOBLEMEN
	apprentice_name = "Servant"
	total_positions = 2
	spawn_positions = 2
	min_pq = 1
	give_bank_account = 60

/datum/outfit/job/roguetown/noble/pre_equip(mob/living/carbon/human/H)
	..()
	var/prev_real_name = H.real_name
	var/prev_name = H.name
	var/honorary = "Lord"
	if(H.gender == FEMALE)
		honorary = "Lady"
	H.real_name = "[honorary] [prev_real_name]"
	H.name = "[honorary] [prev_name]"

	H.mind?.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/music, rand(1,2), TRUE)
	H.change_stat("intelligence", 1)
	shoes = /obj/item/clothing/shoes/roguetown/boots
	backl = /obj/item/storage/backpack/rogue/satchel
	neck = /obj/item/storage/belt/rogue/pouch/coins/veryrich
	belt = /obj/item/storage/belt/rogue/leather
	id = /obj/item/clothing/ring/silver
	if(H.gender == FEMALE)
		H.change_stat("speed", 1)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		shirt = /obj/item/clothing/suit/roguetown/shirt/dress/silkdress/random
		head = /obj/item/clothing/head/roguetown/hatfur
		cloak = /obj/item/clothing/cloak/raincloak/furcloak
		backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
		beltr = /obj/item/rogueweapon/knife/dagger/steel/special
		beltl = /obj/item/ammo_holder/quiver/arrows
		backpack_contents = list(/obj/item/reagent_containers/glass/bottle/rogue/wine = 1, /obj/item/reagent_containers/glass/cup/silver = 1)
	if(H.gender == MALE)
		H.change_stat("constitution", 1)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		pants = /obj/item/clothing/under/roguetown/tights/black
		shirt = /obj/item/clothing/suit/roguetown/shirt/tunic/random
		cloak = /obj/item/clothing/cloak/raincloak/furcloak
		head = /obj/item/clothing/head/roguetown/fancyhat
		backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
		beltr = /obj/item/rogueweapon/sword/rapier/dec
		beltl = /obj/item/ammo_holder/quiver/arrows
		backpack_contents = list(/obj/item/reagent_containers/glass/bottle/rogue/wine = 1, /obj/item/reagent_containers/glass/cup/silver = 1)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
