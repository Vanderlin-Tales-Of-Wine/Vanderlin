/////////////////////////////////////////////////////Abyssariad Pattern for Combat Skills/////////////////////////////////////////////////////////
//'Civilian/Low Abyssanctum' Combat Roles - 3 LEVELS MAX in Combat Skill (Normal) - Many reasons. Mostly religious and Finantial.				//
//'Zamurai/High Abyssanctum' Combat Roles - 4 lEVELS MAX in Combat Skill (Rare) - Plenty of Reasons. Leading religious and Demon-slaying.		//
//'Champion' Combat Roles - 5 LEVELS MAX in Combat SKill (Unique) - Little Reason to go to Rockhill besides Royal Expedition/Rockhill's Captain.//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/datum/advclass/combat/marauder //None. This is a tribal.
	name = "Marauder Tribal"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
	"Undine")
	outfit = /datum/outfit/job/sk/adventurer/marauder
	category_tags = list(CTAG_ADVENTURER)
	tutorial = "Ever since Grenzelhoft invasions on Fog Islands, the Undine Tribes became allies of many Abyssariad clans and guardians. Even if untrue for the entire government itself, Undine Marauders take part of Abyssariad expeditions as ''allies'' and formidable annihilators of Humens and Goblins alike."

/datum/outfit/job/sk/adventurer/marauder/pre_equip(mob/living/carbon/human/H)
	..()
	//average normal skill for all. They are not civilized Undine, so they have skills for survival.
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 4, TRUE) //Tribal Undine lives on the river.
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/labor/fishing, 2, TRUE) //fish is their main course.
	H.mind.adjust_skillrank(/datum/skill/craft/crafting, 4, TRUE) //crafting is their deal.
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/labor/butchering, 3, TRUE) //butchering is also their deal.
	H.mind.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE) //Elf-Goblin nature.

	H.become_blind("TRAIT_GENERIC")
	var/tribaltype = list("boneclad","bodysnatcher", "skypiercer")
	var/specialization = input("Choose your equipments", "Available equipments") as anything in tribaltype
	switch(specialization)
		if("boneclad") //Starts with no survival tool. Full melee, tier 3 makeshift armor roundstart. Mace/axe focus.
			H.set_blindness(0)
			armor = /obj/item/clothing/armor/ceramic/reinforced
			head = /obj/item/clothing/head/helmet/ceramic/reinforced
			pants = /obj/item/clothing/pants/kaizoku/ceramic
			beltl = /obj/item/weapon/mace/cudgel/rungu
			backl = /obj/item/weapon/mace/ararebo/obsidian
			shoes = /obj/item/clothing/shoes/sandals/geta
			wrists = /obj/item/clothing/wrists/bracers/bonebracer
			shirt = /obj/item/clothing/shirt/rags/tribal
			belt = /obj/item/storage/belt/leather/rope

			H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)

			to_chat(H, span_warning( "<span class='info'>I am a warrior from Boneclad Clan! Revenge against paupers-folk! No more shall we pity the fool! To be forced to work is only for weaklings and the disgraced!</span>"))

			//same as normal warriors.
			H.change_stat("strength", 2)
			H.change_stat("endurance", 1)
			H.change_stat("constitution", 1)
			H.change_stat("intelligence", -1)
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)

		if("bodysnatcher") //Starts with blade as survival tool. Has Tier 2 makeshift armor, spear and throwable ranged weapon. Spear focus.
			H.set_blindness(0)
			armor = /obj/item/clothing/armor/ceramic
			head = /obj/item/clothing/head/helmet/ceramic/medium
			pants = /obj/item/clothing/pants/kaizoku/ceramic/light
			backr = /obj/item/weapon/polearm/spear/stone/obsidian
			backl = /obj/item/weapon/shield/wood/rattan
			beltr = /obj/item/weapon/mace/cudgel/rungu
			beltl = /obj/item/weapon/huntingknife/kunai
			shoes = /obj/item/clothing/shoes/sandals/geta
			wrists = /obj/item/clothing/wrists/bracers/bonebracer
			shirt = /obj/item/clothing/shirt/rags/tribal
			belt = /obj/item/storage/belt/leather/rope

			H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)

			to_chat(H, span_warning( "<span class='info'>We've suffered under the yoke of humens for ages, and so I hold the banner of my ancestors with all my strength. How long must we suffer war?</span>"))

			//same as normal warriors.
			H.change_stat("strength", 2)
			H.change_stat("endurance", 1)
			H.change_stat("constitution", 1)
			H.change_stat("intelligence", -1)
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)

		if("skypiercer") //Start with survival tool. Ranged weapon focus.
			H.set_blindness(0)
			cloak = /obj/item/clothing/cloak/raincloak/mino
			armor = /obj/item/clothing/armor/leather/vest/muneate/kappa
			shirt = /obj/item/clothing/armor/ceramic/light
			head = /obj/item/clothing/head/helmet/ceramic
			pants = /obj/item/clothing/pants/kaizoku/tribal
			shoes = /obj/item/clothing/shoes/sandals/geta
			wrists = /obj/item/clothing/wrists/bracers/bonebracer
			backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
			beltl = /obj/item/flashlight/flare/torch/lantern
			backl = /obj/item/ammo_holder/quiver/arrows
			belt = /obj/item/storage/belt/leather

			H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
			H.mind.adjust_skillrank(/datum/skill/craft/tanning, 2, TRUE)
			backpack_contents = list(/obj/item/bait = 1, /obj/item/weapon/huntingknife/kunai = 1)

			ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
			H.change_stat("strength", -1)
			H.change_stat("perception", 2)
			H.change_stat("speed", 2)

			to_chat(H, span_warning( "<span class='info'>We suffered under the veil of night, but no longer shall we suffer, as my clan will rain death on the whalers - and I shall take part in this.</span>"))

	H.cure_blind("TRAIT_GENERIC")
