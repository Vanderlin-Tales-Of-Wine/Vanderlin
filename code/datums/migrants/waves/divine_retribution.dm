/// This is a ERT-like wave, we only send it when we want direct intervention of the god to fullfil a task.

/datum/migrant_role/retribution/commander
	name = "Divine Commander"
	greet_text = "The Gods have awoken you to accomplish a specific task, wait until it is transmited to you and fullfil it."
	outfit = /datum/outfit/job/roguetown/invasion/retribution/commander
	show_wanderer_examine = FALSE
	allowed_races = list("Aasimar")

/datum/outfit/job/roguetown/invasion/retribution/commander/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 5, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/shields, 5, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 6, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 4, TRUE)
		H.change_stat("strength", 4)
		H.change_stat("endurance", 3)
		H.change_stat("constitution", 3)
		H.change_stat("speed", 2)
		H.change_stat("fortune", 5)

		pants = /obj/item/clothing/under/roguetown/loincloth/brown
		beltr = /obj/item/flashlight/flare/torch/lantern
		shoes = /obj/item/clothing/shoes/roguetown/hoplite
		cloak = /obj/item/clothing/cloak/half/red
		belt = /obj/item/storage/belt/rogue/leather/rope
		armor = /obj/item/clothing/suit/roguetown/armor/rare/hoplite
		head = /obj/item/clothing/head/roguetown/rare/hoplite
		wrists = /obj/item/clothing/wrists/roguetown/bracers/hoplite
		neck = /obj/item/clothing/neck/roguetown/gorget/hoplite
		backl = /obj/item/rogueweapon/shield/tower/hoplite
		backr = /obj/item/rogueweapon/polearm/spear/hoplite/winged

/datum/migrant_role/retribution/soldier
	name = "Divine Soldier"
	greet_text = "The Gods have awoken you to accomplish a specific task, wait until it is transmited to the commander and fullfil it."
	outfit = /datum/outfit/job/roguetown/invasion/retribution/soldier
	show_wanderer_examine = FALSE
	allowed_races = list("Aasimar")

/datum/outfit/job/roguetown/invasion/retribution/soldier/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/shields, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("endurance", 2)
		H.change_stat("constitution", 2)
		H.change_stat("speed", 1)
		H.change_stat("fortune", 3)

		pants = /obj/item/clothing/under/roguetown/loincloth/brown
		beltr = /obj/item/flashlight/flare/torch/lantern
		shoes = /obj/item/clothing/shoes/roguetown/hoplite
		belt = /obj/item/storage/belt/rogue/leather/rope
		armor = /obj/item/clothing/suit/roguetown/armor/rare/hoplite
		head = /obj/item/clothing/head/roguetown/rare/hoplite
		wrists = /obj/item/clothing/wrists/roguetown/bracers/hoplite
		neck = /obj/item/clothing/neck/roguetown/gorget/hoplite
		backl = /obj/item/rogueweapon/shield/tower/hoplite
	var/soldiertype = pickweight(list("Newlycreated" = 5, "Caretaker" = 3, "Veteran" = 2))
	switch(soldiertype)
		if("Newlycreated")
			if(prob(50))
				beltl = /obj/item/rogueweapon/sword/khopesh
				H.mind?.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
			else
				backr = /obj/item/rogueweapon/polearm/spear/hoplite/
				H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
		if("Caretaker")
			beltl = /obj/item/rogueweapon/sword/khopesh
			cloak = /obj/item/clothing/cloak/half/blue
			backr = /obj/item/storage/backpack/rogue/satchel
			r_hand = /obj/item/storage/backpack/rogue/satchel/surgbag
			H.mind?.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
		if("Veteran")
			backr = /obj/item/rogueweapon/polearm/spear/hoplite/winged
			H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 5, TRUE)
