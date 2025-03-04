/////////////////////////////////////////////////////Abyssariad Pattern for Combat Skills/////////////////////////////////////////////////////////
//'Civilian/Low Abyssanctum' Combat Roles - 3 LEVELS MAX in Combat Skill (Normal) - Many reasons. Mostly religious and Finantial.				//
//'Zamurai/High Abyssanctum' Combat Roles - 4 lEVELS MAX in Combat Skill (Rare) - Plenty of Reasons. Leading religious and Demon-slaying.		//
//'Champion' Combat Roles - 5 LEVELS MAX in Combat SKill (Unique) - Little Reason to go to Rockhill besides Royal Expedition/Rockhill's Captain.//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


/datum/advclass/combat/abyssariad/champion //Champion role.
	name = "Abyssal Champion"
	tutorial = "The phantoms of the divine winds, the abyssal champions are the Heavenly Emperor's divine enforcers whom still lingers in large numbers. \
	They are directly funded by the imperial court, surpassing zamurais in power and renown, and even keeping them in check in case of audacious rebellions. \
	Their presence overseas is bound to their demon-slaying duties and current day warring intervetions against the influence from major powers, and alliance to Heartfelt."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
	"Changeling", // Myrmidon
	"Skylancer", // Eidolon
	"Ogrun",
	"Undine") // Dragonslayer
	outfit = /datum/outfit/job/roguetown/adventurer/abyssariad/champion
	category_tags = list(CTAG_ADVENTURER)
	maximum_possible_slots = 1
	pickprob = 100

/datum/outfit/job/roguetown/adventurer/abyssariad/champion/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.dna.species.name == "Changeling")
		if(H.mind)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 5, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.change_stat(STATKEY_END, 3)
			H.change_stat(STATKEY_SPD, -2)
			H.change_stat(STATKEY_STR, 2)
			H.change_stat(STATKEY_INT, 1)

		r_hand = /obj/item/weapon/polearm/halberd/bisento //Bisento cannot be stored in the back. Sometimes not even spawning. So I gave them an Wakizashi too in case the worst happens.
		pants = /obj/item/clothing/pants/trou/leather/fur
		beltl = /obj/item/storage/belt/pouch/coins/mid
		shoes = /obj/item/clothing/shoes/ridingboots/gutal
		gloves = /obj/item/clothing/gloves/angle/falcon
		belt = /obj/item/storage/belt/kaizoku/leather/daisho
		shirt = /obj/item/clothing/shirt/looseshirt
		armor = /obj/item/clothing/armor/rare/myrmidon
		head = /obj/item/clothing/head/rare/myrmidon
		neck = /obj/item/clothing/neck/gorget
		mask = /obj/item/clothing/face/kaizoku/menpo/facemask/colourable/kitsune
		beltr = /obj/item/weapon/sword/short/wakizashi
		ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
		to_chat(H, "<span class='warning'>You are a member of the Abyssal stormlancers, machine-slayers in service of the emperor, bulwark against demons and rogue automata of ancient eras, ready to change the tide of battles during sieges.")
		if(findtext(H.real_name, " Clanless")) //You can't be a clanless champion. This one literally does not exist because, at least, they would've settled a bloodline.
			to_chat(H, "<span class='userdanger'>I am member of the Royal court, of course I have a bloodline.</span>")
			clanfication(H)

		if(H.wear_mask)
			if(istype(H.wear_mask, /obj/item/clothing/face/eyepatch || /obj/item/clothing/face/eyepatch/left ))
				qdel(H.wear_mask)
				mask = /obj/item/clothing/face/kaizoku/menpo/facemask/colourable/kitsune
	else if(H.dna.species.name == "Ogrun")
		if(H.mind)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 5, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 5, TRUE)

			H.change_stat("strength", 2)
			H.change_stat("endurance", 2)
			H.change_stat("constitution", 2)
			H.change_stat("speed", -1)

		backr = /obj/item/storage/backpack/satchel
		backl = /obj/item/weapon/sword/dragonslayer
		pants = /obj/item/clothing/pants/trou/leather/fur/dragonslayer
		beltl = /obj/item/storage/belt/pouch/coins/mid
		shoes = /obj/item/clothing/shoes/boots/jikatabi/dragontabi
		gloves = /obj/item/clothing/gloves/chain/kikko
		belt = /obj/item/storage/belt/kaizoku/leather/daisho
		shirt = /obj/item/clothing/shirt/looseshirt/dragonslayer
		armor = /obj/item/clothing/armor/cuirass/nanbando
		head = /obj/item/clothing/head/rare/dragonslayer
		wrists = /obj/item/clothing/wrists/roguetown/kaizoku/dragonwrap
		neck = /obj/item/clothing/neck/gorget
		mask = /obj/item/clothing/face/kaizoku/menpo/facemask/colourable/oni
		cloak = /obj/item/clothing/cloak/raincloak/guardiancloak/dragonslayer
		ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
		to_chat(H, "<span class='warning'>You are the hunter, bane of progeny of magma, slaughter of malum's creatures. Armed with swords that dwarves any man and armored in tough fiber that laughs in the face of flames, your duty is to kill all dragons, no matter the cost.")
		if(findtext(H.real_name, " Clanless")) //You can't be a clanless champion. This one literally does not exist because, at least, they would've settled a bloodline.
			to_chat(H, "<span class='userdanger'>I am member of the Royal court, of course I have a bloodline.</span>")
			clanfication(H)

		if(H.wear_mask)
			if(istype(H.wear_mask, /obj/item/clothing/face/eyepatch || /obj/item/clothing/face/eyepatch/left ))
				qdel(H.wear_mask)
				mask = /obj/item/clothing/face/kaizoku/menpo/facemask/colourable/oni
	else
		if(H.mind)
			H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 5, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)

			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			H.change_stat("strength", 2)
			H.change_stat("speed", 2)
			H.change_stat("endurance", 1)
			H.change_stat("perception", -2) //Using a urn on the head, struggling for years to understand how the magic reflected light functions surely can't lead to a good sight.
			H.change_stat("intelligence", -1)
			to_chat(H, "<span class='warning'>You are a member of the abyssal windrunners, scarred by hellfire and face-forged in abyssal urn. You defy the limits of flesh, faith and speed shields your flesh when armor will not.")
		backl = /obj/item/storage/backpack/satchel
		head = /obj/item/clothing/head/helmet/heavy/bronzepot // cursed item.
		belt = /obj/item/storage/belt/kaizoku/leather/daisho/random
		backr = /obj/item/storage/backpack/backpack
		beltr = /obj/item/weapon/sword/uchigatana
		beltl = /obj/item/weapon/sword/uchigatana
		neck = /obj/item/clothing/neck/gorget
		cloak = /obj/item/clothing/shirt/tunic/kamishimo/eidolon
		armor = /obj/item/clothing/armor/leather/splint/kikko/eidolon
		shirt = /obj/item/clothing/armor/gambeson/light/hitatare/eidolon
		wrists = /obj/item/clothing/neck/psycross/silver/abyssanctum
		shoes = /obj/item/clothing/shoes/sandals/geta
		pants = /obj/item/clothing/pants/tights/hakama/eidolon
		mask = /obj/item/clothing/face/kaizoku/menpo/facemask/colourable/tengu
		if(H.wear_mask)
			if(istype(H.wear_mask, /obj/item/clothing/face/eyepatch || /obj/item/clothing/face/eyepatch/left ))
				qdel(H.wear_mask)
				mask = /obj/item/clothing/face/kaizoku/menpo/facemask/colourable/tengu
		if(findtext(H.real_name, " Clanless")) //You can't be a clanless champion. This one literally does not exist because, at least, they would've settled a bloodline.
			to_chat(H, "<span class='userdanger'>I am member of the Royal court, of course I have a bloodline.</span>")
			clanfication(H)


	H.champion = TRUE
	var/prev_real_name = H.real_name
	var/prev_name = H.name
	var/spec1 = "Myrmidon"
	var/spec2 = "Eidolon"
	var/spec3 = "Dragonslayer"
	if(H.dna.species.name == "Changeling")
		H.real_name = "[spec1] [prev_real_name]"
		H.name = "[spec1] [prev_name]"
	else if(H.dna.species.name == "Skylancer")
		H.real_name = "[spec2] [prev_real_name]"
		H.name = "[spec2] [prev_name]"
	else
		H.real_name = "[spec3] [prev_real_name]"
		H.name = "[spec3] [prev_name]"
