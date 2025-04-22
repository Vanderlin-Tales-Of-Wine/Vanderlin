/datum/job/veteran
	title = "Veteran"
	tutorial = "There isn't a way to kill a man you havent practiced in the tapestries of war itself. \
	You wouldn't call yourself a hero-- \
	those belong to the men left rotting in the fields where you honed your ancient trade. \
	Tired of senseless killing for men with crowns, you traded stability for a life of adventure. You returned a hero and savior of the lands, but those glory days with your old adventurer party are long gone. \
	The honor has faded, your weary body aches, and your weapons gather dust. Sometimes you wonder how your old friends are doing."
	flag = GUARDSMAN
	department_flag = GARRISON
	display_order = JDO_VET
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	//Should...probably actually be a veteran of at least a few weeks before trying to teach others
	min_pq = 10

	spells = list(/obj/effect/proc_holder/spell/self/convertrole/town_militia)
	allowed_sexes = list(MALE, FEMALE) //same as town guard
	allowed_ages = list(AGE_OLD, AGE_IMMORTAL)
	allowed_races = RACES_PLAYER_NONDISCRIMINATED

	advclass_cat_rolls = list(CTAG_VETERAN = 20)
	give_bank_account = 35
	can_have_apprentices = FALSE

/datum/job/veteran/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	var/mob/living/carbon/human/H = spawned
	if(istype(H.cloak, /obj/item/clothing/cloak/half/vet))
		var/obj/item/clothing/S = H.cloak
		var/index = findtext(H.real_name, " ")
		if(index)
			index = copytext(H.real_name, 1,index)
		if(!index)
			index = H.real_name
		S.name = "veteran cloak ([index])"
	ADD_TRAIT(spawned, TRAIT_OLDPARTY, TRAIT_GENERIC)

/datum/advclass/veteran/battlemaster
	name = "Veteran Battlemaster"
	tutorial = "You have served under a hundred masters, some good, some bad. You were a general once. A marshal, a captain. To some a hero, others a monster. Something of the sorts. You made strategies, tactics, new innovations of war. A thousand new ways for one man to kill another. It still keeps you up at night."
	outfit = /datum/outfit/job/vet/battlemaster

	category_tags = list(CTAG_VETERAN)

// Normal veteran start, from the olden days.

/datum/outfit/job/vet
	job_bitflag = BITFLAG_GARRISON

/datum/outfit/job/vet/battlemaster/pre_equip(mob/living/carbon/human/H)
	neck = /obj/item/clothing/neck/bevor
	armor = /obj/item/clothing/armor/plate
	shirt = /obj/item/clothing/armor/chainmail
	pants = /obj/item/clothing/pants/chainlegs
	shoes = /obj/item/clothing/shoes/boots/armor
	beltl = /obj/item/weapon/sword/sabre
	beltr = /obj/item/storage/keyring/veteran
	backr = /obj/item/storage/backpack/satchel/black
	cloak = /obj/item/clothing/cloak/half/vet
	belt = /obj/item/storage/belt/leather/black
	H.cmode_music = 'sound/music/cmode/adventurer/CombatWarrior.ogg'
	backpack_contents = list(/obj/item/weapon/knife/dagger/steel/special = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/shields, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
		H.change_stat(STATKEY_PER, 1)
		H.change_stat(STATKEY_INT, 2)
		H.change_stat(STATKEY_END, 1)
		H.change_stat(STATKEY_CON, 1)
		H.change_stat(STATKEY_SPD, 1)
		H.change_stat(STATKEY_STR, 1)
		if(H.age == AGE_OLD)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
			H.change_stat(STATKEY_END, 1)

	H.verbs |= /mob/proc/haltyell
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)

/datum/advclass/veteran/footman
	name = "Retired Footman"
	tutorial = "You served on the fields of battle as no heroic knight steadfast in shining armor, but a mere mortal clad in whatever cheap armor coin could buy. You fought in formation as a member of a unit, and through discipline, have won numerous battles. Maybe one day you even served as the captain of your unit. You specialize in polearms and bows."
	outfit = /datum/outfit/job/vet/footman

	category_tags = list(CTAG_VETERAN)

// No hero, just a normal guy who happened to survive war.

/datum/outfit/job/vet/footman/pre_equip(mob/living/carbon/human/H)
	neck = /obj/item/clothing/neck/gorget
	armor = /obj/item/clothing/armor/plate // Meant to be better than man-at-arms, but worse than knight. No heavy armor!! This is a cuirass, not half-plate.
	shirt = /obj/item/clothing/armor/gambeson/heavy
	head = /obj/item/clothing/head/helmet/sallet
	pants = /obj/item/clothing/pants/chainlegs
	gloves = /obj/item/clothing/gloves/plate
	wrists = /obj/item/clothing/wrists/bracers
	shoes = /obj/item/clothing/shoes/boots/armor
	beltl = /obj/item/weapon/sword
	beltr = /obj/item/storage/keyring/veteran
	backr = /obj/item/storage/backpack/satchel/black
	backl = /obj/item/weapon/shield/tower/metal
	r_hand = /obj/item/weapon/polearm/spear/billhook
	belt = /obj/item/storage/belt/leather/black
	cloak = /obj/item/clothing/cloak/half/vet
	H.cmode_music = 'sound/music/cmode/garrison/CombatGarrison.ogg'
	backpack_contents = list(/obj/item/weapon/knife/dagger/steel/special = 1, /obj/item/rope/chain = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/shields, 4, TRUE) // this is a kinda scary skill to give them, surely it won't go wrong though.
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE) // two handed weapons require a LOT of stamina.
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.change_stat(STATKEY_PER, 1)
		H.change_stat(STATKEY_INT, 2)
		H.change_stat(STATKEY_END, 1)
		H.change_stat(STATKEY_CON, 2)
		H.change_stat(STATKEY_STR, 1)
		if(H.age == AGE_OLD)
			H.mind.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
	H.verbs |= /mob/proc/haltyell
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)

/datum/advclass/veteran/calvaryman
	name = "Tarnished Knight"
	tutorial = "You were once a member of a knightly calvary regiment, a prestigious title. You were ontop of the world, the townspeople rejoiced when you rode through their streets. Now, all you can hear is the screams of your brothers-in-arms as they fell. You specialize in mounted warfare."
	outfit = /datum/outfit/job/vet/calvaryman

	category_tags = list(CTAG_VETERAN)

// You get a SAIGA. Saigas are pretty good, you lose out on your legendary weapon skills and you suck more on foot though.

/datum/outfit/job/vet/calvaryman/pre_equip(mob/living/carbon/human/H)
	neck = /obj/item/clothing/neck/chaincoif
	armor = /obj/item/clothing/armor/plate/	////Former knights should have knightly armour.
	shirt = /obj/item/clothing/armor/chainmail
	head = /obj/item/clothing/head/helmet/heavy/decorated/knight
	pants = /obj/item/clothing/pants/chainlegs
	gloves = /obj/item/clothing/gloves/plate
	wrists = /obj/item/clothing/wrists/bracers
	shoes = /obj/item/clothing/shoes/boots/armor
	beltr = /obj/item/storage/keyring/veteran
	backr = /obj/item/storage/backpack/satchel/black
	belt = /obj/item/storage/belt/leather/black
	cloak = /obj/item/clothing/cloak/half/vet
	H.cmode_music = 'sound/music/cmode/nobility/CombatDungeoneer.ogg'
	backpack_contents = list(/obj/item/weapon/knife/dagger/steel/special = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/shields, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)
		H.change_stat(STATKEY_PER, 1)
		H.change_stat(STATKEY_INT, 1)
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_CON, 2)
		H.change_stat(STATKEY_SPD, -1)
		H.change_stat(STATKEY_STR, 1)
		if(H.age == AGE_OLD)
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE) // You get a lot of weapon skills, but none are legendary. Jack of all trades, master of none. This is probably worse than just having legendary in one, as people rarely swap weapons mid-combat.
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
	H.verbs |= /mob/proc/haltyell
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC) // retired knight!
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)

	H.adjust_blindness(-3)
	var/weapons = list("Sword + Recurve Bow","Axe + Crossbow","Spear + Shield")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Sword + Recurve Bow")
			r_hand = /obj/item/weapon/sword/long
			beltl = /obj/item/ammo_holder/quiver/arrows
			backl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve

		if("Axe + Crossbow")
			r_hand = /obj/item/weapon/axe/steel
			backl = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
			beltl = /obj/item/ammo_holder/quiver/bolts

		if ("Spear + Shield")
			r_hand = /obj/item/weapon/polearm/spear
			backl = /obj/item/weapon/shield/tower/metal

/datum/advclass/veteran/merc
	name = "Retired Mercenary"
	tutorial = "You were a sell-sword, a warrior of coin. Your pockets were never light, you always had a warm place to stay and food in your belly, but you knew that every battle could be your last. You're the last of your unit, and you can't help but regret it. You specialize in swords and polearms, or axes and polearms."
	outfit = /datum/outfit/job/vet/merc

	category_tags = list(CTAG_VETERAN)

// Normal veteran start, from the olden days

/datum/outfit/job/vet/merc/pre_equip(mob/living/carbon/human/H)
	neck = /obj/item/clothing/neck/gorget
	wrists = /obj/item/clothing/wrists/bracers
	shirt = /obj/item/clothing/shirt/grenzelhoft // You do NOT get the BLACKSTEEL CUIRASS because yours BROKE & I hate you. Go on a personal quest to replace it or something.
	head = /obj/item/clothing/head/helmet/skullcap/grenzelhoft
	armor = /obj/item/clothing/armor/cuirass/iron
	pants = /obj/item/clothing/pants/grenzelpants
	shoes = /obj/item/clothing/shoes/grenzelhoft
	gloves = /obj/item/clothing/gloves/angle/grenzel
	beltl = /obj/item/weapon/sword/short
	beltr = /obj/item/storage/keyring/veteran
	backr = /obj/item/storage/backpack/satchel/black
	belt = /obj/item/storage/belt/leather/black
	cloak = /obj/item/clothing/cloak/half/vet
	H.cmode_music = 'sound/music/cmode/adventurer/CombatOutlander.ogg'
	backpack_contents = list(/obj/item/weapon/knife/dagger/steel/special = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/shields, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
		H.change_stat(STATKEY_INT, 1)
		H.change_stat(STATKEY_END, 3) // two handed weapons require a LOT of stamina.
		H.change_stat(STATKEY_CON, 1)
		H.change_stat(STATKEY_SPD, -1)
		H.change_stat(STATKEY_STR, 2)
		if(H.age == AGE_OLD)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE) // two handed weapons require a LOT of stamina.
	H.verbs |= /mob/proc/haltyell
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)

	H.adjust_blindness(-3)
	var/weapons = list("Zweihander","Halberd")
	var/weapon_choice = input("Choose your weapon.", "TAKE UP ARMS") as anything in weapons
	H.set_blindness(0)
	switch(weapon_choice)
		if("Zweihander")
			r_hand = /obj/item/weapon/sword/long/greatsword/zwei
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			H.change_stat(STATKEY_STR, 1) // needs minimum strength to actually use the fucking sword
		if("Halberd")
			r_hand = /obj/item/weapon/polearm/halberd
			H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE) // SO, fun fact. The description of the grenzel halbardier says they specialize in axes, but they get no axe skill. Maybe this guy is where that rumor came from.
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
