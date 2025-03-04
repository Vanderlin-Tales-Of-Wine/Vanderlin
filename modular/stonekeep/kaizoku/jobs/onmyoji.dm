/////////////////////////////////////////////////////Abyssariad Pattern for Combat Skills/////////////////////////////////////////////////////////
//'Civilian/Low Abyssanctum' Combat Roles - 3 LEVELS MAX in Combat Skill (Normal) - Many reasons. Mostly religious and Finantial.				//
//'Zamurai/High Abyssanctum' Combat Roles - 4 lEVELS MAX in Combat Skill (Rare) - Plenty of Reasons. Leading religious and Demon-slaying.		//
//'Champion' Combat Roles - 5 LEVELS MAX in Combat SKill (Unique) - Little Reason to go to Rockhill besides Royal Expedition/Rockhill's Captain.//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/datum/advclass/combat/abyssariad/onmyoji //Considered 'high-abyssanctum', as Onmyojis actually makes part of their religion. (Also, their mana are sourced from Abyssor due to soul exchanging.)
	name = "Onmyoji"
	tutorial = "The Chosen of the Pressuring Depth, spiritcallers of Abyssor, sage of the oceans. The Onmyojis are celestial magicians skilled in divination \
	and manifesting the powers of the sea as intermediaries between the Abyssariads and the Abyssal realm. The Onmyojis are empowered in the same way Abyssor \
	was empowered, in the depths of the Weeping God's pressuring tears."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Changeling",
		"Skylancer",
		"Ogrun",
		"Undine"
	)
	outfit = /datum/outfit/job/roguetown/adventurer/abyssariad/onmyoji
	category_tags = list(CTAG_ADVENTURER)
	maximum_possible_slots = 2

/datum/outfit/job/roguetown/adventurer/abyssariad/onmyoji
	allowed_patrons = list(/datum/patron/divine/abyssor)

/datum/outfit/job/roguetown/adventurer/abyssariad/onmyoji/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/shortboots/cloudhead
	belt = /obj/item/storage/belt/leather/rope
	backr = /obj/item/storage/backpack/satchel
	beltl = /obj/item/reagent_containers/glass/bottle/manapot
	backl = /obj/item/weapon/polearm/woodstaff/quarterstaff/bostaff
	armor = /obj/item/clothing/shirt/kaizoku/robe
	head = /obj/item/clothing/head/wizhat/onmyoji/eboshi
	pants = /obj/item/clothing/pants/trou/tobi/dark

	var/yesno = list("Yes. I am Iron-hearted.","No. I am Civilian.")
	var/military = input("Sworn to the Fog Island ranks?", "Emperor's regiment?") as anything in yesno
	var/background = pickweight(list("thunder" = 1, "storm" = 1, "ocean" = 1, "island" = 1)) //This is just flavour in the same way Soheis are. Wait, are they related??? Leave it to the Players to explain.
	switch(military) //Just clothes.
		if("Yes. I am Iron-hearted.") //Cooler clothing. Roleplay-wise, an champion-type, theme unique solely to Kaizoku as far I'm aware.
			switch(background)
				if("thunder")
					armor = /obj/item/clothing/shirt/robe/wizard/guardian/thunder
					head = /obj/item/clothing/head/wizhat/onmyoji/thunder
					pants = /obj/item/clothing/pants/trou/tobi/thunder
				if("storm")
					armor = /obj/item/clothing/shirt/robe/wizard/guardian/storm
					head = /obj/item/clothing/head/wizhat/onmyoji/storm
					pants = /obj/item/clothing/pants/trou/tobi/storm
				if("ocean")
					armor = /obj/item/clothing/shirt/robe/wizard/guardian/ocean
					head = /obj/item/clothing/head/wizhat/onmyoji/ocean
					pants = /obj/item/clothing/pants/trou/tobi/ocean
				if("island")
					armor = /obj/item/clothing/shirt/robe/wizard/guardian/island
					head = /obj/item/clothing/head/wizhat/onmyoji/island
					pants = /obj/item/clothing/pants/trou/tobi/island
			H.set_blindness(0)
		if("No. I am a Civilian.)") //Just continue and replace.
			H.set_blindness(0)

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/arcane, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/alchemy, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.change_stat("strength", -1)
		H.change_stat("intelligence", 3)
		H.change_stat("constitution", -1)
		H.change_stat("endurance", -1)
		H.change_stat("speed", -2)
		//placeholder spells.
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/fireball) //They are intended to have their own powers. I will make that later in the future with the help of another coder.
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/lightningbolt)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/projectile/fetch)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/forcewall)
