/datum/job/roguetown/cheesemaker
	title =  "Cheesemaker"
	tutorial = "Craftsmen who have mastered the art of curdling milks \
				into delicious and long lasting wheels of cheese."
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
		"Half-Orc"
	)
	faction = "Station"
	outfit = /datum/outfit/job/roguetown/cheesemaker
	department_flag = PEASANTS
	flag = CHEESEMAKER
	display_order = JDO_CHEESEMAKER
	total_positions = 2
	spawn_positions = 2

/datum/outfit/job/roguetown/cheesemaker/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/labor/taming, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 4, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/labor/farming, 2, TRUE)
	belt = /obj/item/storage/belt/rogue/leather
	pants = /obj/item/clothing/under/roguetown/tights/random
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
	cloak = /obj/item/clothing/cloak/apron
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	backl = /obj/item/storage/backpack/rogue/backpack
	neck = /obj/item/storage/belt/rogue/pouch/coins/poor
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	beltr = /obj/item/reagent_containers/glass/bottle/waterskin/milk
	beltl = /obj/item/rogueweapon/knife/villager
	backpack_contents = list(/obj/item/reagent_containers/powder/salt = 3, /obj/item/reagent_containers/food/snacks/rogue/cheddar = 1, /obj/item/natural/cloth = 2, /obj/item/book/rogue/yeoldecookingmanual = 1)
	H.change_stat("intelligence", 1)
	H.change_stat("constitution", 2)
