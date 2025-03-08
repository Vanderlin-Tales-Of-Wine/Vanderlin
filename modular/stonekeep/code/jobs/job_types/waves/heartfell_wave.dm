/datum/migrant_role/heartfelt/lord
	name = "Lord of Heartfelt"
	greet_text = "You are the proud Lord of Heartfelt, from the Fog Isles. Here to ask for aid, to claim a new throne or some more nebulous purpose."
	outfit = /datum/outfit/job/heartfelt_lord
	allowed_sexes = list(MALE)
	allowed_races = list("Humen")
	grant_lit_torch = TRUE
	show_wanderer_examine = FALSE

/datum/outfit/job/heartfelt_lord/pre_equip(mob/living/carbon/human/H)
	..()
	shirt = /obj/item/clothing/shirt/looseshirt
	belt = /obj/item/clothing/gloves/leather/black
	neck = /obj/item/clothing/neck/gorget
	head = /obj/item/clothing/head/helmet/kaizoku/heartfelt
	shoes = /obj/item/clothing/shoes/ridingboots/gutal
	pants = /obj/item/clothing/pants/trou/tobi/dark
	cloak = /obj/item/clothing/cloak/newheartfelt
	armor = /obj/item/clothing/armor/medium/surcoat/heartfelt
	beltr = /obj/item/storage/belt/pouch/coins/rich
	beltl = /obj/item/scomstone
	gloves = /obj/item/clothing/gloves/leather/abyssal/black
	neck = /obj/item/clothing/neck/chaincoif/karuta_zukin
	beltl = /obj/item/weapon/sword/long/tachi
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.change_stat(STATKEY_STR, 1)
		H.change_stat(STATKEY_INT, 3)
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_PER, 2)
		H.change_stat(STATKEY_LCK, 2)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	if(!HAS_TRAIT(H, TRAIT_KAIZOKU))
		ADD_TRAIT(H, TRAIT_KAIZOKU, TRAIT_GENERIC)
		to_chat(H, "<span class='info'I am an Islander, and I respectively have the culture of one.</span>")
	H.cmode_music = 'modular/stonekeep/kaizoku/sound/combat/combat_emperor.ogg'
	if(H.dna.species.id == "human")	// safeguard if its unlocked for more abyssariads later
		H.skin_tone = SKIN_COLOR_TROPICALDRY
		H.grant_language(/datum/language/abyssal)

	if(H.patron != /datum/patron/divine/abyssor)
		H.patron = GLOB.patronlist[/datum/patron/divine/abyssor]
		to_chat(H, "<span class='warning'>I am a Abyssanctum, loyal to The World Whale. May the tides of fate guide me to honor.")


/datum/migrant_role/heartfelt/shrinemaiden
	name = "Heartfelt Shrine Maiden"
	greet_text = "You are a Shrine Maiden in the entourage of the Lord."
	outfit = /datum/outfit/job/roguetown/heartfelt/shrinemaiden
	allowed_sexes = list(FEMALE)
	allowed_races = list(
		"Humen",
		"Changeling",
		"Skylancer",
		"Ogrun",
		"Undine")
	grant_lit_torch = TRUE
	show_wanderer_examine = FALSE

/datum/outfit/job/roguetown/heartfelt/shrinemaiden/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 5, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, pick(1,1,2), TRUE) // Wood staff
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, pick(2,2,3), TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)

		H.change_stat(STATKEY_STR, 1)
		H.change_stat(STATKEY_PER, -1)
		H.change_stat(STATKEY_CON, 1)
		H.change_stat(STATKEY_END, 1)
		H.change_stat(STATKEY_SPD, 1)

		ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)

	if(H.patron != /datum/patron/divine/abyssor)
		H.patron = GLOB.patronlist[/datum/patron/divine/abyssor]
		to_chat(H, "<span class='warning'>I am a Abyssanctum, loyal to The World Whale. May the tides of fate guide me to honor.")

	if(!HAS_TRAIT(H, TRAIT_KAIZOKU))
		ADD_TRAIT(H, TRAIT_KAIZOKU, TRAIT_GENERIC)
		to_chat(H, "<span class='info'I am an Islander, and I respectively have the culture of one.</span>")
	H.cmode_music = 'modular/stonekeep/kaizoku/sound/combat/combat_emperor.ogg'
	if(H.dna.species.id == "human")	// safeguard if its unlocked for more abyssariads later
		H.skin_tone = SKIN_COLOR_TROPICALDRY
		H.grant_language(/datum/language/abyssal)


/datum/migrant_role/heartfelt/bodyguard
	name = "Heartfelt Bodyguard"
	greet_text = "Loyal retainer of the Lord, your life is nothing compared to his!"
	outfit = /datum/outfit/job/roguetown/heartfelt/bodyguard
	allowed_races = list("Humen")
	grant_lit_torch = TRUE
	show_wanderer_examine = FALSE
/datum/outfit/job/roguetown/heartfelt/bodyguard/pre_equip(mob/living/carbon/human/H)
	..()

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

	H.dna.species.soundpack_m = new /datum/voicepack/male/knight()
	H.cure_blind("TRAIT_GENERIC")
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_SEEPRICES, TRAIT_GENERIC)
	if(!HAS_TRAIT(H, TRAIT_KAIZOKU))
		ADD_TRAIT(H, TRAIT_KAIZOKU, TRAIT_GENERIC)
		to_chat(H, "<span class='info'I am an Islander, and I respectively have the culture of one.</span>")
	H.cmode_music = 'modular/stonekeep/kaizoku/sound/combat/combat_emperor.ogg'
	if(H.dna.species.id == "human")	// safeguard if its unlocked for more abyssariads later
		H.skin_tone = SKIN_COLOR_TROPICALDRY
	H.hairstyle = /datum/sprite_accessory/hair/kaizoku




/datum/migrant_wave/heartfelt
	name = "The Heartfelt Lord"
	max_spawns = 1
	shared_wave_type = list(/datum/migrant_wave/grenzelhoft_visit,/datum/migrant_wave/zybantine_wave,/datum/migrant_wave/rockhill_wave,/datum/migrant_wave/heartfelt)
	weight = 25
	downgrade_wave = /datum/migrant_wave/heartfelt_down
	roles = list(
		/datum/migrant_role/heartfelt/lord = 1,
		/datum/migrant_role/heartfelt/shrinemaiden = 1,
		/datum/migrant_role/heartfelt/bodyguard = 2,
	)
	greet_text = "A foreignen Lord, here with his vassals; to escape disaster or to usurp the locals?"
/datum/migrant_wave/heartfelt_down
	name = "The Heartfelt Lord"
	shared_wave_type = list(/datum/migrant_wave/grenzelhoft_visit,/datum/migrant_wave/zybantine_wave,/datum/migrant_wave/rockhill_wave,/datum/migrant_wave/heartfelt)
	can_roll = FALSE
	downgrade_wave = /datum/migrant_wave/heartfelt_smallest
	roles = list(
		/datum/migrant_role/heartfelt/lord = 1,
		/datum/migrant_role/heartfelt/shrinemaiden = 1,
		/datum/migrant_role/heartfelt/bodyguard = 1,
	)
	greet_text = "A foreignen Lord, here with his vassals; to escape disaster or to usurp the locals?"
/datum/migrant_wave/heartfelt_smallest
	name = "The Heartfelt Lord"
	shared_wave_type = list(/datum/migrant_wave/grenzelhoft_visit,/datum/migrant_wave/zybantine_wave,/datum/migrant_wave/rockhill_wave,/datum/migrant_wave/heartfelt)
	can_roll = FALSE
	downgrade_wave = /datum/migrant_wave/heartfelt_smallest
	roles = list(
		/datum/migrant_role/heartfelt/lord = 1,
		/datum/migrant_role/heartfelt/bodyguard = 1,
	)
	greet_text = "A foreignen Lord, here with his bodyguard; to escape disaster or to usurp the locals?"
