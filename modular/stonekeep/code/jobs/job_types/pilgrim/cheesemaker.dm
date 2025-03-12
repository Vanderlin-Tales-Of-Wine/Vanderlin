/datum/advclass/pilgrim/stonekeep/cheesemaker
	name = "Cheesemaker"
	tutorial = "Craftsmen who have mastered the art of curdling milks \
				into delicious and long lasting wheels of cheese."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Dark Elf",
		"Aasimar",
	)
	outfit = /datum/outfit/job/sk/pilgrim/cheesemaker

	category_tags = list(CTAG_PILGRIM)
	apprentice_name = "Cheesemaker Apprentice"

/datum/outfit/job/sk/pilgrim/cheesemaker/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/labor/taming, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/labor/farming, 2, TRUE)
	belt = /obj/item/storage/belt/leather
	pants = /obj/item/clothing/pants/tights/random
	shirt = /obj/item/clothing/shirt/shortshirt/random
	cloak = /obj/item/clothing/cloak/apron
	shoes = /obj/item/clothing/shoes/simpleshoes
	backl = /obj/item/storage/backpack/backpack
	r_hand = /obj/item/weapon/mace/copperbludgeon
	neck = /obj/item/storage/belt/pouch/coins/poor
	wrists = /obj/item/clothing/wrists/bracers/leather
	beltr = /obj/item/reagent_containers/glass/bottle/waterskin/milk
	beltl = /obj/item/weapon/knife/villager
	backpack_contents = list(/obj/item/reagent_containers/powder/salt = 3, /obj/item/reagent_containers/food/snacks/cheddar = 1, /obj/item/natural/cloth = 2, /obj/item/book/yeoldecookingmanual = 1)
	H.change_stat("intelligence", 1)
	H.change_stat("constitution", 2) // Cheese diet.
