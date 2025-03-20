/datum/job/roguetown/mapprentice
	title = "Maker's Apprentice"
	flag = APPRENTICE
	department_flag = APPRENTICES
	faction = FACTION_STATION
	total_positions = 0
	spawn_positions = 0

	allowed_races = ALL_PLAYER_RACES_BY_NAME
	allowed_ages = list(AGE_ADULT)

	tutorial = "You have entered into the debt of the Maker's Guild through a contract of apprenticeship, \
				processing ore, porting components and backbreaking labor has been your daily life. \
				One dae you will craft your own masterwork, pay your remaining dues and have your own apprentices to torment."

	outfit = /datum/outfit/job/roguetown/mapprentice
	display_order = JDO_BAPP
	give_bank_account = TRUE
	min_pq = -50
	bypass_lastclass = TRUE

	can_have_apprentices = FALSE

/datum/outfit/job/roguetown/mapprentice/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/blacksmithing, pick(1,2,3), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/armorsmithing, pick(1,2,3), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/weaponsmithing, pick(1,2,3), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/smelting, pick(1,2,3), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, pick(1,2,3), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, pick(1,2,3), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/tanning, pick(1,2,3), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/carpentry, pick(1,2,3), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/mining, pick(1,2,3), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/engineering, 1, TRUE)

		id = /obj/item/key/guildring
		shirt = /obj/item/clothing/shirt/shortshirt/makers
		pants = /obj/item/clothing/pants/tights/makers
		shoes = /obj/item/clothing/shoes/shortboots
		belt = /obj/item/storage/belt/leather/rope
		backr = /obj/item/storage/backpack/satchel
		gloves = /obj/item/clothing/gloves/leather
		beltr = /obj/item/storage/keyring/armorsmith
		beltl = /obj/item/weapon/hammer/iron

		switch(H.patron?.type)
			if(/datum/patron/divine/malum)
				neck = /obj/item/clothing/neck/psycross/silver/malum_steel
				backpack_contents = list(/obj/item/storage/belt/pouch/coins/poor)
			else
				neck = /obj/item/storage/belt/pouch/coins/poor


		H.change_stat("endurance", 1)
		H.change_stat("constitution", 1)
		H.change_stat("speed", 1)
		ADD_TRAIT(H, TRAIT_MALUMFIRE, TRAIT_GENERIC)
		if(!H.has_language(/datum/language/dwarvish))
			H.grant_language(/datum/language/dwarvish)
			to_chat(H, "<span class='info'>My life has been shaped by working for the Dwarf-dominated Maker's Guild. I can speak Dwarvish with ,d before my speech.</span>")

