/datum/advclass/pilgrim/stonekeep/noble
	name = "Noble"
	tutorial = "The blood of a noble family runs through your veins. Perhaps you are visiting from some place far away, \
	looking to enjoy the hospitality of the ruler of Vanderlin. You have many mammons to your name, but with wealth comes \
	danger, so keep your wits and tread lightly..."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Dark Elf"
	)
	outfit = /datum/outfit/job/sk/pilgrim/noble
	category_tags = list(CTAG_PILGRIM)
	maximum_possible_slots = 2
	apprentice_name = "Servant"


/datum/outfit/job/sk/pilgrim/noble/pre_equip(mob/living/carbon/human/H)
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
	H.mind?.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
	H.change_stat("intelligence", 1)
	shirt = /obj/item/clothing/shirt/undershirt/random
	shoes = /obj/item/clothing/shoes/boots
	backl = /obj/item/storage/backpack/satchel
	neck = /obj/item/storage/belt/pouch/coins/veryrich
	belt = /obj/item/storage/belt/leather
	id = /obj/item/clothing/ring/silver
	cloak = /obj/item/clothing/cloak/cape/silk/random
	pants = /obj/item/clothing/pants/pantaloons/random
	backpack_contents = list(/obj/item/reagent_containers/glass/bottle/wine = 1, /obj/item/reagent_containers/glass/cup/silver = 1)
	if(H.gender == FEMALE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		armor = /obj/item/clothing/shirt/dress/silkydress
		head = /obj/item/clothing/head/hatfur
		backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
		beltr = /obj/item/weapon/knife/dagger/steel/special
		beltl = /obj/item/ammo_holder/quiver/arrows
	if(H.gender == MALE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		armor = /obj/item/clothing/shirt/tunic/noblecoat
		head = /obj/item/clothing/head/fancyhat
		beltr = /obj/item/weapon/sword/rapier
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
