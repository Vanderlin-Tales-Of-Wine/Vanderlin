/datum/advclass/pilgrim/rare/merchant
	name = "Travelling Merchant"
	tutorial = "You are a travelling merchant, possibly either of local origin or from far away lands. \
	You've picked up many wears on your various adventures, now it's time to peddle them back to these locals."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Aasimar"
	)
	outfit = /datum/outfit/job/roguetown/adventurer/merchant
	category_tags = list(CTAG_PILGRIM)
	maximum_possible_slots = 2
	pickprob = 30
	min_pq = 0


/datum/outfit/job/roguetown/adventurer/merchant/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind?.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/alchemy, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/tailor, 1, TRUE)
	H.change_stat("intelligence", 2)
	H.change_stat("speed", 1)
	shoes = /obj/item/clothing/shoes/roguetown/boots
	belt = /obj/item/storage/belt/rogue/leather/black
	beltr = /obj/item/flashlight/flare/torch/lantern
	backl = /obj/item/storage/backpack/rogue/backpack
	backpack_contents = list(/obj/item/rogueweapon/knife/dagger/steel)
	neck = /obj/item/storage/belt/rogue/pouch/coins/rich
	id = /obj/item/clothing/ring/silver
	if(H.gender == FEMALE)
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/green
		head = /obj/item/clothing/head/roguetown/hatblu
		cloak = /obj/item/clothing/cloak/raincloak/purple
	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/tights/green
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/green
		cloak = /obj/item/clothing/cloak/half
		head = /obj/item/clothing/head/roguetown/fancyhat

	//For how we decide what kind of merchant they are.
	var/merchtype = pickweight(list("FOOD" = 4, "HEAL" = 2, "SILK" = 1, "GEMS" = 1))
	switch(merchtype)
		if("FOOD")		// Travelling food peddler
			backpack_contents = list(/obj/item/reagent_containers/food/snacks/rogue/meat/salami = 1, /obj/item/reagent_containers/food/snacks/cooked/coppiette = 1, /obj/item/reagent_containers/food/snacks/rogue/cheddar = 1, /obj/item/reagent_containers/food/snacks/saltfish = 1, /obj/item/reagent_containers/food/snacks/hardtack = 1)
			H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		if("HEAL")		// Travelling potion seller (If only we had snake oil..)
			backpack_contents = list(/obj/item/reagent_containers/glass/bottle/rogue/healthpot, /obj/item/reagent_containers/glass/bottle/rogue/healthpot, /obj/item/reagent_containers/glass/bottle/rogue/healthpot, /obj/item/reagent_containers/glass/bottle/rogue/manapot)
			H.mind?.adjust_skillrank(/datum/skill/craft/alchemy, 2, TRUE)
		if("SILK")		// Travelling silk trader
			backpack_contents = list(/obj/item/natural/bundle/silk = 2, /obj/item/natural/fur = 1, /obj/item/natural/bundle/fibers = 2, /obj/item/clothing/suit/roguetown/shirt/dress/silkdress, /obj/item/clothing/suit/roguetown/shirt/undershirt/puritan)
			H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		if("GEMS")		// Travelling high-end merchant
			backpack_contents = list(/obj/item/roguegem/yellow, /obj/item/roguegem/yellow, /obj/item/roguegem/green, /obj/item/roguegem/green, /obj/item/roguegem/violet)
			H.mind?.adjust_skillrank(/datum/skill/craft/blacksmithing, 1, TRUE)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_SEEPRICES, TRAIT_GENERIC)
