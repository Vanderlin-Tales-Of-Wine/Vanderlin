//swordmaster with spear

/datum/advclass/combat/lancer
	name = "Lancer"
	tutorial = "Working for many years as a famous mercenary in the southern Humen kingdoms, you've started heading north to avoid the skeletons of your past. With your polearm by your side, you can face down any foe."
	allowed_sexes = list(MALE)
	allowed_races = list("Humen")
	outfit = /datum/outfit/job/roguetown/adventurer/lancer
	maximum_possible_slots = 1
	pickprob = 15
	min_pq = 2
	category_tags = list(CTAG_ADVENTURER)
	cmode_music = 'sound/music/cmode/adventurer/CombatOutlander3.ogg'

/datum/outfit/job/roguetown/adventurer/lancer/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("endurance", 2)
		H.change_stat("constitution", 2)
		H.change_stat("speed", -1)

	var/randy = rand(1,5)
	switch(randy)
		if(1 to 2)
			backr = /obj/item/rogueweapon/polearm/halberd/bardiche
		if(3 to 4)
			backr = /obj/item/rogueweapon/polearm/eaglebeak
		if(5)
			backr = /obj/item/rogueweapon/polearm/spear/billhook


	pants = /obj/item/clothing/under/roguetown/tights/black
	beltl = /obj/item/storage/belt/rogue/pouch/coins/mid
	shoes = /obj/item/clothing/shoes/roguetown/boots/rare/zybanplate
	gloves = /obj/item/clothing/gloves/roguetown/rare/zybanplate
	belt = /obj/item/storage/belt/rogue/leather
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
	armor = /obj/item/clothing/suit/roguetown/armor/rare/zybanplate
	backl = /obj/item/storage/backpack/rogue/satchel
	head = /obj/item/clothing/head/roguetown/rare/zybanplate
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	neck = /obj/item/clothing/neck/roguetown/chaincoif
	if(!H.has_language(/datum/language/zybantine))
		H.grant_language(/datum/language/zybantine)
		to_chat(H, "<span class='info'>I can speak Zybean with ,z before my speech.</span>")

	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
