/////////////////////////////////////////////////////Abyssariad Pattern for Combat Skills/////////////////////////////////////////////////////////
//'Civilian/Low Abyssanctum' Combat Roles - 3 LEVELS MAX in Combat Skill (Normal) - Many reasons. Mostly religious and Finantial.				//
//'Zamurai/High Abyssanctum' Combat Roles - 4 lEVELS MAX in Combat Skill (Rare) - Plenty of Reasons. Leading religious and Demon-slaying.		//
//'Champion' Combat Roles - 5 LEVELS MAX in Combat SKill (Unique) - Little Reason to go to Rockhill besides Royal Expedition/Rockhill's Captain.//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//THIS ROLE IS FAR FROM FINISHED! The coder that voluntered in helping me on the Abyssanctum spells quitted. So someone willing and able is VERY necessary.
//Contact Monochrome9090 for further information.

/datum/advclass/combat/sk/abyss/sohei //Low-abyssanctum tier.
	name = "Underling Sohei"
	tutorial = "Senso Soheis are the Abyssanctum war disciples from the Tideweaver branch, the direct \
	continuation of the champions of old age. Their duty is to protect the shrines and spiritual entities \
	from demonic corruption."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		//humen - need to settle Heartfeltean culture on this one.
		"Changeling",
		"Skylancer",
		"Ogrun",
		"Undine"
	)
	outfit = /datum/outfit/job/sk/adventurer/abyss/sohei
	category_tags = list(CTAG_ADVENTURER)
	vampcompat = FALSE
	maximum_possible_slots = 2 //Only two, united with Yamabushi.
	pickprob = 100

/datum/outfit/job/sk/adventurer/abyss/sohei
	allowed_patrons = list(/datum/patron/divine/abyssor)

/datum/outfit/job/sk/adventurer/abyss/sohei/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/clothing/head/soheicloth
	armor = /obj/item/clothing/armor/cuirass/sanmaido
	wrists = /obj/item/clothing/neck/psycross/silver/abyssanctum
	shirt = /obj/item/clothing/armor/chainmail/iron/tatami
	shoes = /obj/item/clothing/shoes/boots/jikatabi
	head = /obj/item/clothing/head/helmet/kaizoku/hachigane
	beltr = /obj/item/weapon/knife/hunting/sai

	var/background = pickweight(list("thunder" = 1, "storm" = 1, "ocean" = 1, "island" = 1)) //This is just flavour. Mostly unwritten portrayal how different Soheis were of each other. Leave it up to the players to interact.
	var/weapontype = pickweight(list("yari" = 6, "tsukushi" = 5, "katakama" = 3)) // Rolls for various polearms.
	switch(background)
		if("thunder")
			neck = /obj/item/clothing/head/soheicloth/thunder
			pants = /obj/item/clothing/pants/trou/tobi/thunder
			belt = /obj/item/storage/belt/kaizoku/leather/daisho/thunder
			head = /obj/item/clothing/head/helmet/kaizoku/hachigane/thunder
		if("storm")
			neck = /obj/item/clothing/head/soheicloth/storm
			pants = /obj/item/clothing/pants/trou/tobi/storm
			belt = /obj/item/storage/belt/kaizoku/leather/daisho/storm
			head = /obj/item/clothing/head/helmet/kaizoku/hachigane/storm
		if("ocean")
			neck = /obj/item/clothing/head/soheicloth/ocean
			pants = /obj/item/clothing/pants/trou/tobi/ocean
			belt = /obj/item/storage/belt/kaizoku/leather/daisho/ocean
			head = /obj/item/clothing/head/helmet/kaizoku/hachigane/ocean
		if("island")
			neck = /obj/item/clothing/head/soheicloth/island
			pants = /obj/item/clothing/pants/trou/tobi/island
			belt = /obj/item/storage/belt/kaizoku/leather/daisho/island
			head = /obj/item/clothing/head/helmet/kaizoku/hachigane/island
	switch(weapontype)
		if("tsukushi")
			backr = /obj/item/weapon/polearm/halberd/bardiche/naginata/tsukushi  //weaker naginata, mass-produced iron tier. Slightly more rare than Yari.
		if("katakama")
			backr = /obj/item/weapon/polearm/spear/yari/katakama//Steel, more combat-effective and rarer than iron Yari.
		if("yari")
			backr = /obj/item/weapon/polearm/spear/yari //just a simple iron spear.

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE) //The true focus of this class.
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE) //I don't think they are deserving of bows, but Soheis irl also used them, soo...
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/holy, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, pick(0,1,1), TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, pick(0,1,1), TRUE)
		if(H.age == AGE_OLD)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/magic/holy, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)
		H.change_stat("strength", 2)
		H.change_stat("constitution", 1)
		H.change_stat("endurance", 2)
		H.change_stat("perception", -2) //imagine training meditation so hard you end up edging your own eyes, but start noticing spirits. (schizophrenia)
		H.change_stat("speed", -1)

	var/datum/devotion/cleric_holder/C = new /datum/devotion/cleric_holder(H, H.patron)
	//Max devotion limit - Sohei are strong for a common role, but cannot pray to gain more abilities beyond t1
	C.update_devotion(50, 50)
	C.holder_mob = H
	C.grant_spells_sohei(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)

	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	if(H.patron != /datum/patron/divine/abyssor)
		H.patron = GLOB.patronlist[/datum/patron/divine/abyssor]
		to_chat(H, "<span class='warning'>I am a Abyssanctum, loyal to The World Whale. May the tides of fate guide me to honor.")
