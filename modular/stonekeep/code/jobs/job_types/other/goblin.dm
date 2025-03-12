/datum/job/goblin
	allowed_races = list(
		"Humen",
		"Rakshari",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Dark Elf",
		"Aasimar",
		"Changeling","Skylancer","Ogrun","Undine"
	)
	tutorial = ""

/datum/job/goblin/hell
	outfit = /datum/outfit/job/npc/hellgoblin

/datum/job/goblin/hell/equip(mob/living/carbon/human/H, visualsOnly, announce, latejoin, datum/outfit/outfit_override, client/preference_source)
	. = ..()
	return  H.change_mob_type(/mob/living/carbon/human/species/goblin/hell, delete_old_mob = TRUE)

/datum/job/goblin/hell/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		H.set_species(/datum/species/goblin/hell)

/datum/outfit/job/npc/hellgoblin/pre_equip(mob/living/carbon/human/H)
	..()
	H.TOTALSTR = rand(10, 12)
	H.TOTALPER = rand(5, 7)
	H.TOTALINT = rand(1, 4)
	H.TOTALCON = rand(10, 12)
	H.TOTALEND = rand(10, 12)
	H.TOTALSPD = rand(12, 15)
	var/loadout = rand(1,5)
	switch(loadout)
		if(1) //tribal spear
			r_hand = /obj/item/weapon/polearm/spear/stone
			armor = /obj/item/clothing/armor/leather/hide/goblin
		if(2) //tribal axe
			r_hand = /obj/item/weapon/axe/stone
			armor = /obj/item/clothing/armor/leather/hide/goblin
		if(3) //tribal club
			r_hand = /obj/item/weapon/mace/woodclub
			armor = /obj/item/clothing/armor/leather/hide/goblin
			if(prob(10))
				head = /obj/item/clothing/head/helmet/leather/goblin
		if(4) //lightly armored sword/flail/daggers
			H.simpmob_attack += 25
			H.simpmob_defend += 10
			if(prob(50))
				r_hand = /obj/item/weapon/sword/iron
			else
				r_hand = /obj/item/weapon/mace/spiked
			if(prob(30))
				l_hand = /obj/item/weapon/shield/wood
			if(prob(23))
				r_hand = /obj/item/weapon/knife/stone
				l_hand = /obj/item/weapon/knife/stone
			armor = /obj/item/clothing/armor/leather/goblin
			if(prob(80))
				head = /obj/item/clothing/head/helmet/leather/goblin
		if(5) //heavy armored sword/flail/shields
			H.simpmob_attack += 45
			H.simpmob_defend += 25
			ADD_TRAIT(src, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
			if(prob(30))
				armor = /obj/item/clothing/armor/cuirass/iron/goblin
			else
				armor = /obj/item/clothing/armor/leather/goblin
			if(prob(80))
				head = /obj/item/clothing/head/helmet/goblin
			else
				head = /obj/item/clothing/head/helmet/leather/goblin
			if(prob(50))
				r_hand = /obj/item/weapon/sword/iron
			else
				r_hand = /obj/item/weapon/mace/spiked
			if(prob(20))
				r_hand = /obj/item/weapon/flail
			l_hand = /obj/item/weapon/shield/wood
