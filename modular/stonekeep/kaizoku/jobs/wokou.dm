/////////////////////////////////////////////////////Abyssariad Pattern for Combat Skills/////////////////////////////////////////////////////////
//'Civilian/Low Abyssanctum' Combat Roles - 3 LEVELS MAX in Combat Skill (Normal) - Many reasons. Mostly religious and Finantial.				//
//'Zamurai/High Abyssanctum' Combat Roles - 4 lEVELS MAX in Combat Skill (Rare) - Plenty of Reasons. Leading religious and Demon-slaying.		//
//'Champion' Combat Roles - 5 LEVELS MAX in Combat SKill (Unique) - Little Reason to go to Rockhill besides Royal Expedition/Rockhill's Captain.//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/datum/advclass/combat/abyssariad/wokou //Civilian role. They are not even Ashigarus, so no retainer/military position whasoever.
	name = "Wokou Warrior"
	tutorial = "The Wokou is a general term for abyssariad fighter and/or pirates, those who constantly causes annual invasions on coastline provinces worldwide. They have many specializations and many \
	receives government subsidy. However, their presence on Enigma has less boundaries to raiding the place, but more about taking the 'lawful' privateer role."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
	"Changeling",
	"Skylancer",
	"Ogrun",
	"Undine")
	outfit = /datum/outfit/job/stonekeep/adventurer/abyssariad/wokou
	category_tags = list(CTAG_ADVENTURER)
	pickprob = 100

/datum/outfit/job/stonekeep/adventurer/abyssariad/wokou/pre_equip(mob/living/carbon/human/H) // Same as Warrior.
	..()
	H.mind.adjust_skillrank(/datum/skill/combat/crossbows, pick(1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/bows, pick(1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, pick(1,1,2), TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/shields, pick(2,3), TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/riding, pick(1,1,2), TRUE)

	shoes = /obj/item/clothing/shoes/boots/jikatabi
	gloves = /obj/item/clothing/gloves/leather
	belt = /obj/item/storage/belt/kaizoku/leather/daisho
	shirt = /obj/item/clothing/shirt/looseshirt
	pants = /obj/item/clothing/pants/trou/tobi/random

	H.become_blind("TRAIT_GENERIC")
	var/wokoutype = list("LinYou (Ambusher)","Dustrider (Scout)","Muqian (Towerdweller)","Shuhen (Militia)","Kaizoku (Navy)", "Jizamurai (Enforcer)")
	var/specialization = input("Choose your culture", "Available culture") as anything in wokoutype
	switch(specialization) //as far I know, all roles here are meant to be balanced.
		if("LinYou (Ambusher)") //Weaker iron armor, specialized exactly in being able to repair their own weaker armor.
			var/roll = rand(1, 100)
			H.set_blindness(0)
			armor = /obj/item/clothing/armor/chainmail/rattan
			head = /obj/item/clothing/head/helmet/kaizoku/rattan
			backl = /obj/item/storage/backpack/satchel
			backr = /obj/item/weapon/shield/wood/rattan
			beltr = /obj/item/storage/belt/pouch/coins/poor
			if(roll <= 33)
				beltl = /obj/item/weapon/sword/short/jian
			else if(roll <= 66)
				beltl = /obj/item/weapon/sword/scimitar/messer/dao
			else
				beltl = /obj/item/weapon/sword/iron/jian
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			to_chat(H, span_warning( "<span class='info'>Hailing from the tropical edges, I am a 'LinYou', armored in humble, oil-boiled wickerwork and iron, I am trained to perform long-term expeditions and guerrila tactics on any soil.</span>"))

			//same as normal warriors.
			H.change_stat(STATKEY_STR, 2)
			H.change_stat(STATKEY_CON, 1)
			H.change_stat(STATKEY_END, 1)
			H.change_stat(STATKEY_INT, -1)
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)

		if("Dustrider (Scout)") // Full light armor, highest quality of light armor. Loses shield and money for bow. Literally mongolian, but lacking a horse. Only Dodge expert.
			H.set_blindness(0)
			armor = /obj/item/clothing/armor/leather/hide/dustwalker
			shirt = /obj/item/clothing/armor/gambeson/heavy/deelcoat
			head = /obj/item/clothing/head/helmet/leather/malgai/duulga
			backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/hankyu
			backl = /obj/item/storage/backpack/satchel
			beltr = /obj/item/ammo_holder/quiver/arrows
			if(prob(60))
				beltl = /obj/item/weapon/huntingknife/kunai //so they HAVE something to use in melee combat.
			else
				beltl = /obj/item/weapon/knife/steel/tanto // luckyroll. Now you have a short-short sword.
			H.mind.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)

			//please tell me if this is balanced or not.
			H.change_stat(STATKEY_STR, 1)
			H.change_stat(STATKEY_SPD, 1)
			H.change_stat(STATKEY_END, 1)
			H.change_stat(STATKEY_INT, -1)
			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			to_chat(H, span_warning( "<span class='info'>Hailing from the arid heart of the island, I am a 'Dustwalker'. I left my horse behind to try my luck among the sailing allies, but my trusted bow remains with me.</span>"))





		if("Shuhen (Militia)")  //No protective helmet, full face protection + neck from a full menpo - still does not protect the head. Their weapon also functions to work the field, but since that can be done by hand nowadays, is no balance issue now.
			H.set_blindness(0)
			armor = /obj/item/clothing/armor/plate/mirror/iron
			head = /obj/item/clothing/head/tengai/gasa
			if(prob(33))
				head = /obj/item/clothing/head/tengai/torioigasa
			if(prob(33))
				head = /obj/item/clothing/head/tengai/sandogasa
			mask = /obj/item/clothing/face/kaizoku/menpo
			backr = /obj/item/weapon/shield/wood/rattan
			beltr = /obj/item/storage/belt/pouch/coins/poor
			if(prob(60))
				beltl = /obj/item/weapon/sickle/kama
			else
				beltl = /obj/item/weapon/axe/iron/changfu // luckyroll. Now you have an axe.
			H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
			to_chat(H, span_warning("<span class='info'>Farmlands shall never struggle under my might, as I came from the Outskirts where the demons once brew, I slaughtered the Grezenholft like pigs - and I can do it again. May the waters fortalify the soil I step on.</span>"))

			//same as normal warriors.
			H.change_stat(STATKEY_STR, 2)
			H.change_stat(STATKEY_CON, 1)
			H.change_stat(STATKEY_END, 1)
			H.change_stat(STATKEY_INT, -1)
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)

		if("Muqian (Towerdweller)") //The 20% of Wokou Population. Practically the best armored - but has no shield and no money, and have to rely on flails for combat. 'Kusari/Chain-People'
			H.set_blindness(0)
			shirt = /obj/item/clothing/armor/chainmail/hauberk/kusari
			neck = /obj/item/clothing/neck/chaincoif/iron/kusari_zukin
			shoes = /obj/item/clothing/shoes/boots/armor/light/kusaritabi
			beltl = /obj/item/weapon/flail/kusarigama/peasant
			H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
			to_chat(H, span_warning("<span class='info'>I am a Muqian, I hail from the towers of civilization, those upheld in sturdy chains alike my body. May the dices of destiny enlight my ways.</span>"))

			//same as normal warriors.
			H.change_stat(STATKEY_STR, 2)
			H.change_stat(STATKEY_CON, 1)
			H.change_stat(STATKEY_END, 1)
			H.change_stat(STATKEY_INT, -1)
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)

		if("Kaizoku (Navy)") // Special one. "AYO THIS IS THE PROJECT NAME!!!" Start with Steel Weapon - but uses weak light armor, but they have DRIP, and non-rattan shield, because from where they come from, has no Rattan.
			H.set_blindness(0)
			armor = /obj/item/clothing/armor/leather/vest/kaizoku
			head = /obj/item/clothing/head/helmet/leather/malgai/kaizoku
			beltl = /obj/item/weapon/sword/scimitar/falchion/yuntoudao
			backr = /obj/item/weapon/shield/wood
			beltr = /obj/item/storage/belt/pouch/coins/poor
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			to_chat(H, span_warning("<span class='info'>I am a son of Kaizoku and I am one with the destroyed Atoll, my life is on the seas. The major empire's supply lines shall crumble against my ways of warfare. May the Abyssal Emperor live FOREVER. </span>"))

			//focused on having more stamina.
			H.change_stat(STATKEY_STR, 1)
			H.change_stat(STATKEY_END, 3)
			H.change_stat(STATKEY_INT, -1)
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
		if("Jizamurai (Enforcer)")
			H.set_blindness(0)
			armor = /obj/item/clothing/armor/leather/splint/kikko/rich
			head = /obj/item/clothing/head/tengai/gasa
			cloak = /obj/item/clothing/cloak/stabard/haramaki/jinbaori/jizamurai
			mask = /obj/item/clothing/face/kaizoku/menpo/steel/half
			mouth = /obj/item/clothing/face/cigarette/pipe/westman
			neck = /obj/item/clothing/neck/chaincoif/karuta_zukin
			shirt = /obj/item/clothing/armor/gambeson/light/hitatare/rich
			pants = /obj/item/clothing/pants/trou/tobi/random
			beltr = /obj/item/weapon/sword/short/wakizashi
			beltl = /obj/item/weapon/sword/uchigatana
			H.mind.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			to_chat(H, span_warning("<span class='info'>As a minor Zamurai lord, my roots are bound to the sword. I shall protect the weak and the innocent from corruption, as its reach ends where my blade begins. </span>"))

			//Strength and Endurance.
			H.change_stat(STATKEY_STR, 2)
			H.change_stat(STATKEY_END, 2)
			H.change_stat(STATKEY_PER, -1)
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
			ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)

	H.cure_blind("TRAIT_GENERIC")
