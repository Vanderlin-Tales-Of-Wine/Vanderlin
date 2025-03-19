/datum/advclass/combat/assassin
	name = "Assassin"
	tutorial = "From a young age you have been drawn to blood, to hurting others. Eventually you found others like you, and a god who would bless your actions. Your cursed dagger has never led you astray, and with every stab you feel a little less empty."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Dark Elf"
	)
	outfit = /datum/outfit/job/adventurer/assassin
	category_tags = list(CTAG_PILGRIM)
	maximum_possible_slots = 2
	min_pq = 0
	pickprob = 100
	displays_adv_job = FALSE //this prevents advjob from being set back to "Assassin" in equipme

/datum/outfit/job/adventurer/assassin/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 5)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 5, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/traps, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE) // Used for leaving notes after your evil work.
		var/datum/antagonist/new_antag = new /datum/antagonist/assassin() // Adds the assassin antag label.
		H.ambushable = FALSE
		H.mind.add_antag_datum(new_antag)

	H.become_blind("TRAIT_GENERIC")
	H.advjob = "Assassin"
	// Assassin now spawns disguised as one of the non-combat drifters. You never know who will stab you in the back.
	var/disguises = list("Bard", "Beggar", "Fisher", "Hunter", "Miner", "Noble", "Peasant", "Carpenter")
	var/disguisechoice = input("Choose your cover", "Available disguises") as anything in disguises

	if(disguisechoice)
		H.advjob = disguisechoice

	switch(disguisechoice)
		if("Bard")
			H.mind?.adjust_skillrank(/datum/skill/misc/music, 1, TRUE) //Have to know to "PLAY" the part... Eh? Eh?
			head = /obj/item/clothing/head/bardhat
			shoes = /obj/item/clothing/shoes/boots
			pants = /obj/item/clothing/pants/tights/random
			shirt = /obj/item/clothing/shirt/shortshirt
			belt = /obj/item/storage/belt/leather/assassin
			armor = /obj/item/clothing/armor/leather/vest
			cloak = /obj/item/clothing/cloak/raincloak/red
			backl = /obj/item/storage/backpack/satchel
			beltr = /obj/item/weapon/knife/dagger/steel/special
			beltl = /obj/item/storage/belt/pouch/coins/poor
			backpack_contents = list(/obj/item/flint)
			if(H.dna?.species)
				if(H.dna.species.id == "human")
					backr = /obj/item/instrument/lute
				if(H.dna.species.id == "dwarf")
					backr = /obj/item/instrument/accord
				if(H.dna.species.id == "elf")
					backr = /obj/item/instrument/harp
				if(H.dna.species.id == "tiefling")
					backr = /obj/item/instrument/guitar
		if("Beggar") //The sole "town" disguise available.
			H.job = "Beggar"
			belt = /obj/item/storage/belt/leather/assassin
			if(H.gender == FEMALE)
				armor = /obj/item/clothing/shirt/rags
			else
				pants = /obj/item/clothing/pants/tights/vagrant
				shirt = /obj/item/clothing/shirt/undershirt/vagrant
		if("Fisher")
			H.mind?.adjust_skillrank(/datum/skill/labor/fishing, 1, TRUE) //Have to know to play the part.
			if(H.gender == MALE)
				pants = /obj/item/clothing/pants/tights/random
				shirt = /obj/item/clothing/shirt/shortshirt/random
				shoes = /obj/item/clothing/shoes/boots/leather
				neck = /obj/item/storage/belt/pouch/coins/poor
				head = /obj/item/clothing/head/fisherhat
				mouth = /obj/item/weapon/knife/hunting
				armor = /obj/item/clothing/armor/gambeson/light/striped
				backl = /obj/item/storage/backpack/satchel
				belt = /obj/item/storage/belt/leather/assassin
				backr = /obj/item/fishingrod
				beltr = /obj/item/cooking/pan
				beltl = /obj/item/flint
				backpack_contents = list(/obj/item/weapon/knife/hunting = 1, /obj/item/natural/worms = 1, /obj/item/weapon/shovel/small = 1)
			else
				shirt = /obj/item/clothing/shirt/dress/gen/random
				armor = /obj/item/clothing/armor/gambeson/light/striped
				shoes = /obj/item/clothing/shoes/boots/leather
				neck = /obj/item/storage/belt/pouch/coins/poor
				head = /obj/item/clothing/head/fisherhat
				backl = /obj/item/storage/backpack/satchel
				backr = /obj/item/fishingrod
				belt = /obj/item/storage/belt/leather/assassin
				beltr = /obj/item/cooking/pan
				beltl = /obj/item/flint
				backpack_contents = list(/obj/item/weapon/knife/hunting = 1, /obj/item/natural/worms = 1, /obj/item/weapon/shovel/small = 1)
		if("Hunter")
			H.mind?.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE) //The assassin trades their crossbow abilities to match their disguise.
			H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, -2, TRUE)
			pants = /obj/item/clothing/pants/tights/random
			shirt = /obj/item/clothing/shirt/shortshirt/random
			shoes = /obj/item/clothing/shoes/boots/leather
			neck = /obj/item/storage/belt/pouch/coins/poor
			cloak = /obj/item/clothing/cloak/raincloak/furcloak/brown
			backr = /obj/item/storage/backpack/satchel
			backl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
			belt = /obj/item/storage/belt/leather/assassin
			beltr = /obj/item/ammo_holder/quiver/arrows
			beltl = /obj/item/flashlight/flare/torch/lantern
			backpack_contents = list(/obj/item/flint = 1, /obj/item/bait = 1, /obj/item/weapon/knife/hunting = 1)
			gloves = /obj/item/clothing/gloves/leather
		if("Miner")
			H.mind?.adjust_skillrank(/datum/skill/labor/mining, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE) //Use the pickaxe...
			H.mind?.adjust_skillrank(/datum/skill/combat/swords, -2, TRUE)
			head = /obj/item/clothing/head/armingcap
			pants = /obj/item/clothing/pants/trou
			armor = /obj/item/clothing/armor/gambeson/light/striped
			shirt = /obj/item/clothing/shirt/undershirt/random
			shoes = /obj/item/clothing/shoes/boots/leather
			belt = /obj/item/storage/belt/leather/assassin
			neck = /obj/item/storage/belt/pouch/coins/poor
			beltl = /obj/item/weapon/pick
			backr = /obj/item/weapon/shovel
			backl = /obj/item/storage/backpack/backpack
			backpack_contents = list(/obj/item/flint = 1, /obj/item/weapon/knife/hunting = 1)
		if("Noble")
			var/prev_real_name = H.real_name
			var/prev_name = H.name
			var/honorary = "Lord"
			if(H.gender == FEMALE)
				honorary = "Lady"
			H.real_name = "[honorary] [prev_real_name]"
			H.name = "[honorary] [prev_name]"

			shoes = /obj/item/clothing/shoes/boots
			backl = /obj/item/storage/backpack/satchel
			neck = /obj/item/storage/belt/pouch/coins/poor //Spent all their money on expensive clothing.
			belt = /obj/item/storage/belt/leather/assassin
			id = /obj/item/clothing/ring/silver
			if(H.gender == MALE)
				H.mind?.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE) //The male noble's sword is less useful than the female noble's bow, so no downside.
				pants = /obj/item/clothing/pants/tights/black
				shirt = /obj/item/clothing/shirt/tunic/random
				cloak = /obj/item/clothing/cloak/raincloak/furcloak
				head = /obj/item/clothing/head/fancyhat
				backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
				beltr = /obj/item/weapon/sword/rapier/dec
				beltl = /obj/item/ammo_holder/quiver/arrows
				backpack_contents = list(/obj/item/reagent_containers/glass/bottle/wine = 1, /obj/item/reagent_containers/glass/cup/silver = 1)
			else
				H.mind?.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE) //Female nobles get the male noble's bow, but are less trained than an Assassin disguising as a Hunter. Balance.
				H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, -1, TRUE)
				shirt = /obj/item/clothing/shirt/dress/silkdress/random
				head = /obj/item/clothing/head/hatfur
				cloak = /obj/item/clothing/cloak/raincloak/furcloak
				backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
				beltr = /obj/item/weapon/knife/dagger/steel/special
				beltl = /obj/item/ammo_holder/quiver/arrows
				backpack_contents = list(/obj/item/reagent_containers/glass/bottle/wine = 1, /obj/item/reagent_containers/glass/cup/silver = 1)
		if("Peasant")
			H.mind?.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
			belt = /obj/item/storage/belt/leather/assassin
			shirt = /obj/item/clothing/shirt/undershirt/random
			pants = /obj/item/clothing/pants/trou
			head = /obj/item/clothing/head/strawhat
			shoes = /obj/item/clothing/shoes/simpleshoes
			wrists = /obj/item/clothing/wrists/bracers/leather
			backr = /obj/item/weapon/hoe
			backl = /obj/item/storage/backpack/satchel
			neck = /obj/item/storage/belt/pouch/coins/poor
			armor = /obj/item/clothing/armor/gambeson/light/striped
			beltl = /obj/item/weapon/sickle
			beltr = /obj/item/flint
			var/obj/item/weapon/pitchfork/P = new()
			H.put_in_hands(P, forced = TRUE)
			if(H.gender == FEMALE)
				head = /obj/item/clothing/head/armingcap
				armor = /obj/item/clothing/shirt/dress/gen/random
				shirt = /obj/item/clothing/shirt/undershirt
				pants = null
			backpack_contents = list(/obj/item/neuFarm/seed/wheat=1,/obj/item/neuFarm/seed/apple=1,/obj/item/ash=1,/obj/item/weapon/knife/villager=1)
		if("Carpenter")
			H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE) //Use the axe...
			H.mind?.adjust_skillrank(/datum/skill/combat/swords, -2, TRUE)
			belt = /obj/item/storage/belt/leather/assassin
			shirt = /obj/item/clothing/shirt/undershirt/random
			pants = /obj/item/clothing/pants/trou
			head = pick(/obj/item/clothing/head/hatfur, /obj/item/clothing/head/hatblu, /obj/item/clothing/head/brimmed)
			shoes = /obj/item/clothing/shoes/boots/leather
			backr = /obj/item/storage/backpack/satchel
			neck = /obj/item/clothing/neck/coif
			wrists = /obj/item/clothing/wrists/bracers/leather
			armor = /obj/item/clothing/armor/gambeson/light/striped
			beltr = /obj/item/storage/belt/pouch/coins/poor
			beltl = /obj/item/weapon/hammer/steel
			backr = /obj/item/weapon/axe/iron
			backl = /obj/item/storage/backpack/backpack
			backpack_contents = list(/obj/item/flint = 1, /obj/item/weapon/knife/villager = 1)

	H.cure_blind("TRAIT_GENERIC")

	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_ASSASSIN, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_VILLAIN, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STRONG_GRABBER, TRAIT_GENERIC)

	H.change_stat(STATKEY_PER, 2)
	H.change_stat(STATKEY_SPD, 2)
	if(H.dna.species.id == "human")
		if(H.gender == "male")
			H.dna.species.soundpack_m = new /datum/voicepack/male/assassin()
		else
			H.dna.species.soundpack_f = new /datum/voicepack/female/assassin()
