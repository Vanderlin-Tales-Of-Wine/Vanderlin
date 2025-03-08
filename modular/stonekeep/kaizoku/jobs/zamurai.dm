/////////////////////////////////////////////////////Abyssariad Pattern for Combat Skills/////////////////////////////////////////////////////////
//'Civilian/Low Abyssanctum' Combat Roles - 3 LEVELS MAX in Combat Skill (Normal) - Many reasons. Mostly religious and Finantial.				//
//'Zamurai/High Abyssanctum' Combat Roles - 4 lEVELS MAX in Combat Skill (Rare) - Plenty of Reasons. Leading religious and Demon-slaying.		//
//'Champion' Combat Roles - 5 LEVELS MAX in Combat SKill (Unique) - Little Reason to go to Rockhill besides Royal Expedition/Rockhill's Captain.//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/datum/advclass/combat/abyssariad/zamurai // Zamurai-tier role. Still not leading people since they own no retainer on Rockhill.
	name = "Zamurai"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
	//humen - need to settle Heartfeltean culture on this one.
	"Changeling",
	"Skylancer",
	"Ogrun")
	outfit = /datum/outfit/job/stonekeep/adventurer/abyssariad/zamurai
	maximum_possible_slots = 0
	pickprob = 0
	tutorial = "A lower-ranking zamurai serving the warrior caste that became adrift during a expedition, \
	keeping their trusty steed. They are expected to uphold their oficial duties and following the strict \
	martial code of the Abyssal Tide, at least on paper."
	category_tags = list(CTAG_ADVENTURER)
	horse = /mob/living/simple_animal/hostile/retaliate/saiga/horse/tame/saddled

/datum/advclass/combat/abyssariad/zamurai/equipme(mob/living/carbon/human/H)
	if(H.gender == FEMALE)
		horse = /mob/living/simple_animal/hostile/retaliate/saiga/horse/tame/saddled
	return ..()

/datum/outfit/job/stonekeep/adventurer/abyssariad/zamurai/pre_equip(mob/living/carbon/human/H)
	pants = /obj/item/clothing/pants/trou/tobi/random //Fully intended to give them Haidate Tatami, but the armor is strong enough already.
	shoes = /obj/item/clothing/shoes/boots/armor/suneate
	gloves = /obj/item/clothing/gloves/leather/abyssal //kote already protects the hands.
	belt = /obj/item/storage/belt/kaizoku/leather/daisho/random
	shirt = /obj/item/clothing/armor/gambeson/light/hitatare/zamurai //weaker gambeson. Has way more DRIP. (Doesn't matter for balance, shutup)
	armor = /obj/item/clothing/armor/medium/surcoat/heartfelt/abyssariad //Paying off for 4 swordskill instead of 5.
	head = /obj/item/clothing/head/helmet/visored/zunari //fucking-shit-up knight helmet tier. Sacrificed some to keep that one.
	wrists = /obj/item/clothing/wrists/bracers/kote //Cooler Bracer that protects the hands.
	neck = /obj/item/clothing/neck/chaincoif/karuta_zukin/military

	to_chat(H, span_warning( "<span class='userdanger'>I am a noble storm-hardened warrior in lacquered armor whom lands I own and control. Yet, here I stand in unfamiliar lands no different of my own.</span>"))

	H.mind.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/labor/taming, 1, TRUE) //Zamurais does not tame their steed. Their retainer do that.
	H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	if(findtext(H.real_name, " Clanless")) //You can't be a clanless zamurai.
		to_chat(H, "<span class='info'>As a important member of Fog Islands, of course I have a clan. What the hell you've been thinking?</span>")
		clanfication(H)

	var/prev_real_name = H.real_name // Initialize the previous real name
	var/original_first_name
	var/original_clan
	var/honorary = "-dono" //The organization for that one is different from the Rockhillian counterpart.
	var/index = findtext(prev_real_name, " of ") // If "of" is found, split the name
	if(index)
		original_first_name = copytext(prev_real_name, 1, index)
		original_clan = copytext(prev_real_name, index)
		H.real_name = "[original_first_name][honorary][original_clan]"
	else // If no "of" is found, apply honorific to the full name instead.
		H.real_name = "[prev_real_name][honorary]"

	H.become_blind("TRAIT_GENERIC")
	var/zamuraitype = list("Odashibushi(Melee)","Yumibushi(Ranged)")
	var/specialization = input("Choose your Specialization", "Available Specialization") as anything in zamuraitype
	switch(specialization)
		if("Odashibushi(Melee)") //Not as sword-specialized as Swordmaster, but have better armor.
			H.set_blindness(0)
			backr = /obj/item/weapon/sword/long/greatsword/odachi
			ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
			if(H.mind)
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE) //4 instead of 5. Abyssariads with 5 are champions only.
				H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
				H.change_stat(STATKEY_CON, 1)
				H.change_stat(STATKEY_END, 1)
				H.change_stat(STATKEY_SPD, 1)
				H.change_stat(STATKEY_STR, 1)

		if("Yumibushi(Ranged)") // Ranged Focus.
			H.set_blindness(0)
			backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/long/yumi
			beltl = /obj/item/ammo_holder/quiver/arrows
			beltr = /obj/item/weapon/sword/uchigatana
			if(H.mind)
				H.mind.adjust_skillrank(/datum/skill/combat/bows, 4, TRUE)
				H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
				H.change_stat(STATKEY_PER, 2)
				H.change_stat(STATKEY_SPD, 1)
				H.change_stat(STATKEY_STR, 1)
	H.cure_blind("TRAIT_GENERIC")
