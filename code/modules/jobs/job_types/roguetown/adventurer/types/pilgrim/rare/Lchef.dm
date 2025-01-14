//master chef

/datum/advclass/pilgrim/rare/masterchef
	name = "Master Chef"
	tutorial = "A master chef is one of the best cooks to ever live. \
	You received an early education from the guild of culinary arts and have traveled across Psydonia, cooking exotic masterpieces for wealthy merchants and nobility alike. \
	Now you find yourself approaching Vanderlin... perhaps this will be a perfect location to prepare your next great feast?"
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
	outfit = /datum/outfit/job/roguetown/adventurer/masterchef

	maximum_possible_slots = 1
	pickprob = 15
	category_tags = list(CTAG_PILGRIM, CTAG_TOWNER)
	apprentice_name = "Chef Apprentice"

/datum/outfit/job/roguetown/adventurer/masterchef/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/labor/farming, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 4, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/labor/butchering, 4, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/labor/taming, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 6, TRUE)
	belt = /obj/item/storage/belt/rogue/leather
	pants = /obj/item/clothing/under/roguetown/tights/random
	shirt = /obj/item/clothing/suit/roguetown/shirt/shortshirt/random
	cloak = /obj/item/clothing/cloak/apron
	head = /obj/item/clothing/head/roguetown/cookhat/chef
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	backl = /obj/item/storage/backpack/rogue/backpack
	neck = /obj/item/storage/belt/rogue/pouch/coins/mid
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	beltr = /obj/item/cooking/pan
	beltl = /obj/item/rogueweapon/knife/cleaver
	H.change_stat("intelligence", 3)
	H.change_stat("constitution", 2)
	if(H.age == AGE_OLD)
		H.mind?.adjust_skillrank(/datum/skill/labor/butchering, 1, TRUE)
	var/packcontents = pickweight(list("Honey" = 1, "Truffles" = 1, "Bacon" = 1)) // What is our special ingredient? Honey, truffles, or BACON?
	switch(packcontents)
		if("Honey")
			backpack_contents = list(/obj/item/kitchen/rollingpin = 1, /obj/item/flint = 1, /obj/item/kitchen/spoon = 1, /obj/item/natural/cloth = 1, /obj/item/reagent_containers/peppermill = 1, /obj/item/reagent_containers/powder/flour = 2, /obj/item/reagent_containers/food/snacks/rogue/honey = 2, /obj/item/reagent_containers/powder/salt = 1, /obj/item/reagent_containers/food/snacks/butter = 1, /obj/item/reagent_containers/food/snacks/rogue/meat/salami = 1, /obj/item/reagent_containers/food/snacks/rogue/handpie = 1, /obj/item/book/rogue/yeoldecookingmanual = 1)
		if("Truffles")
			backpack_contents = list(/obj/item/kitchen/rollingpin = 1, /obj/item/flint = 1, /obj/item/kitchen/spoon = 1, /obj/item/natural/cloth = 1, /obj/item/reagent_containers/peppermill = 1, /obj/item/reagent_containers/powder/flour = 2, /obj/item/reagent_containers/food/snacks/rogue/truffles = 2, /obj/item/reagent_containers/powder/salt = 1, /obj/item/reagent_containers/food/snacks/butter = 1, /obj/item/reagent_containers/food/snacks/rogue/meat/salami = 1, /obj/item/reagent_containers/food/snacks/rogue/handpie = 1, /obj/item/book/rogue/yeoldecookingmanual = 1)
		if("Bacon")
			backpack_contents = list(/obj/item/kitchen/rollingpin = 1, /obj/item/flint = 1, /obj/item/kitchen/spoon = 1, /obj/item/natural/cloth = 1, /obj/item/reagent_containers/peppermill = 1, /obj/item/reagent_containers/powder/flour = 2, /obj/item/reagent_containers/food/snacks/rogue/meat/bacon = 2, /obj/item/reagent_containers/powder/salt = 1, /obj/item/reagent_containers/food/snacks/butter = 1, /obj/item/reagent_containers/food/snacks/rogue/meat/salami = 1, /obj/item/reagent_containers/food/snacks/rogue/handpie = 1, /obj/item/book/rogue/yeoldecookingmanual = 1)
