/datum/job/stonekeep/hammerite
	title = "Hammerite"
	tutorial = "As a long-standing and dedicated member of the Maker's Guild, you have risen to the illustrious rank of Master Builder. \
				Your work is praise to Malum, either through excavation or construction, \
				if only you had the time to rebuild what has been lost to the ruin of time."
	faction = FACTION_STATION
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = ALL_PLAYER_RACES_BY_NAME
	outfit = /datum/outfit/job/stonekeep/hammerite
	flag = MINER
	department_flag = PEASANTS
	display_order = JDO_MINER
	give_bank_account = 30
	total_positions = 0
	spawn_positions = 0
	min_pq = -50
	allowed_patrons = list(/datum/patron/divine/malum)

/datum/outfit/job/stonekeep/hammerite/pre_equip(mob/living/carbon/human/H)
	..()
	id = /obj/item/key/guildring
	pants = /obj/item/clothing/pants/tights/makers
	armor = /obj/item/clothing/armor/leather/vest/black
	shirt = /obj/item/clothing/shirt/undershirt/red
	shoes = /obj/item/clothing/shoes/boots/leather
	belt = /obj/item/storage/belt/leather
	neck = /obj/item/clothing/neck/psycross/silver/malum_steel
	beltr = /obj/item/storage/belt/pouch/coins/poor
	beltl = /obj/item/weapon/pick
	backr = /obj/item/weapon/hammer/sledgehammer
	backl = /obj/item/storage/backpack/backpack
	head = /obj/item/clothing/head/helmet/leather/minershelm
	backpack_contents = list(/obj/item/flint = 1, /obj/item/weapon/knife/villager = 1)
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/mining, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/traps, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/engineering, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/smelting, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/lumberjacking, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/carpentry, 4, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("endurance", 1)
		H.change_stat("constitution", 1)
		if(!H.has_language(/datum/language/dwarvish))
			H.grant_language(/datum/language/dwarvish)
			to_chat(H, "<span class='info'>My life has been shaped by working for the Dwarf-dominated Maker's Guild. I can speak Dwarvish with ,d before my speech.</span>")

