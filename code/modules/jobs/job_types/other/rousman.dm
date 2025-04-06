/datum/job/rousman
	title = "Rousman"
	tutorial = ""
	flag = GRAVETENDER
//	department_flag = PEASANTS
	faction = FACTION_STATION
	total_positions = 0
	spawn_positions = 0

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_PLAYER_ALL

	outfit = /datum/outfit/job/rousman
	give_bank_account = FALSE

/datum/outfit/job/rousman/equip(mob/living/carbon/human/H, visualsOnly, announce, latejoin, datum/outfit/outfit_override, client/preference_source)
	. = ..()
	return  H.change_mob_type(/mob/living/carbon/human/species/rousman, delete_old_mob = TRUE)

/datum/outfit/job/rousman/pre_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	H.set_species(/datum/species/rousman)
	var/loadout = rand(1,4)
	switch(loadout)
		if(1) //Grats, you got all the good armor
			armor = /obj/item/clothing/armor/cuirass/iron/rousman
			head = /obj/item/clothing/head/helmet/rousman
			ADD_TRAIT(src, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
		if(2) //Plate armor with chance of getting a helm
			armor = /obj/item/clothing/armor/cuirass/iron/rousman
			ADD_TRAIT(src, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
			if(prob(50))
				head = /obj/item/clothing/head/helmet/rousman
		if(3) //Helm with chance of getting plate armor
			if(prob(50))
				armor = /obj/item/clothing/armor/cuirass/iron/rousman
				ADD_TRAIT(src, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
			else
				armor = /obj/item/clothing/armor/leather/hide/rousman
			head = /obj/item/clothing/head/helmet/rousman
		if(4) //Just a loincloth for you
			armor = /obj/item/clothing/armor/leather/hide/rousman

	var/weapons = rand(1,5)
	switch(weapons)
		if(1) //Sword and Shield
			r_hand = /obj/item/weapon/sword/iron
			l_hand = /obj/item/weapon/shield/wood
		if(2) //Daggers
			r_hand = /obj/item/weapon/knife/copper
			l_hand = /obj/item/weapon/knife/copper
		if(3) //Spear
			r_hand = /obj/item/weapon/polearm/spear
		if(4) //Flail
			r_hand = /obj/item/weapon/flail
		if(5) //Mace
			r_hand = /obj/item/weapon/mace/spiked

	weapons = 4
