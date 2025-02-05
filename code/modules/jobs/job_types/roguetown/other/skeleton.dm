/datum/job/roguetown/skeleton
	title = "Skeleton"
	flag = SKELETON
	department_flag = UNDEAD
	faction = "Station"
	total_positions = -1
	spawn_positions = 0

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Rakshari",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Dark Elf",
		"Aasimar",
		"Half-Orc"
	)
	tutorial = ""

	outfit = /datum/outfit/job/roguetown/skeleton
	show_in_credits = FALSE
	give_bank_account = FALSE

/datum/job/roguetown/skeleton/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		if(M.mind)
			M.mind.special_role = "skeleton"
			M.mind.assigned_role = "skeleton"
			M.mind.current.job = null
		if(H.dna && H.dna.species)
			H.dna.species.species_traits |= NOBLOOD
			H.dna.species.soundpack_m = new /datum/voicepack/skeleton()
			H.dna.species.soundpack_f = new /datum/voicepack/skeleton()
		var/obj/item/bodypart/O = H.get_bodypart(BODY_ZONE_R_ARM)
		if(O)
			O.drop_limb()
			qdel(O)
		O = H.get_bodypart(BODY_ZONE_L_ARM)
		if(O)
			O.drop_limb()
			qdel(O)
		H.regenerate_limb(BODY_ZONE_R_ARM)
		H.regenerate_limb(BODY_ZONE_L_ARM)
		for(var/obj/item/bodypart/B in H.bodyparts)
			B.skeletonize()
		H.remove_all_languages()
		H.base_intents = list(INTENT_HELP, INTENT_DISARM, INTENT_GRAB, /datum/intent/simple/claw)
		H.update_a_intents()
		H.cmode_music = 'sound/music/cmode/antag/combatskeleton.ogg'

		var/obj/item/organ/eyes/eyes = H.getorganslot(ORGAN_SLOT_EYES)
		if(eyes)
			eyes.Remove(H,1)
			QDEL_NULL(eyes)
		eyes = new /obj/item/organ/eyes/night_vision/zombie
		eyes.Insert(H)
		H.ambushable = FALSE
		H.underwear = "Nude"
		if(H.charflaw)
			QDEL_NULL(H.charflaw)
		H.update_body()
		H.mob_biotypes = MOB_UNDEAD
		H.faction = list("undead")
		H.name = "skeleton"
		H.real_name = "skeleton"
		ADD_TRAIT(H, TRAIT_NOMOOD, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOSTAMINA, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOLIMBDISABLE, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOHUNGER, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOBREATH, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOPAIN, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_TOXIMMUNE, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOSLEEP, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_SHOCKIMMUNE, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_CRITICAL_WEAKNESS, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_EASYDISMEMBER, TRAIT_GENERIC)
		H.silent = TRUE		// makes them unable to audible emote or speak, no more sexy moan zombies
		H.grant_language(/datum/language/hellspeak)

/datum/outfit/job/roguetown/skeleton/pre_equip(mob/living/carbon/human/H)
	..()
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	if(prob(50))
		wrists = /obj/item/clothing/wrists/roguetown/bracers
	belt = /obj/item/storage/belt/rogue/leather
	if(prob(10))
		armor = /obj/item/clothing/suit/roguetown/armor/gambeson/light
	if(prob(10))
		armor = /obj/item/clothing/suit/roguetown/armor/leather/vest
	if(prob(10))
		armor = /obj/item/clothing/suit/roguetown/armor/chainmail/iron
	if(prob(10))
		armor = /obj/item/clothing/suit/roguetown/armor/cuirass/copperchest
	if(prob(10))
		armor = /obj/item/clothing/suit/roguetown/armor/leather/hide
	if(prob(10))
		armor = /obj/item/clothing/suit/roguetown/armor/cuirass/iron/rust

	switch(pick(1,9))
		if (1)
			head = /obj/item/clothing/head/roguetown/helmet/kettle
		if (2)
			head = /obj/item/clothing/head/roguetown/helmet/winged
		if (3)
			head = /obj/item/clothing/head/roguetown/helmet/leather/conical
		if (4)
			head = /obj/item/clothing/head/roguetown/helmet/coppercap
		if (5)
			neck = /obj/item/clothing/neck/roguetown/coif/cloth
		if (6)
			neck = /obj/item/clothing/neck/roguetown/coif
		if (7)
			head = /obj/item/clothing/head/roguetown/helmet/horned
		if (8)
			head = /obj/item/clothing/head/roguetown/helmet/skullcap
		if (9)
			head = /obj/item/clothing/head/roguetown/helmet

	if(prob(20))
		backr = /obj/item/rogueweapon/shield/wood

	switch(pick(1,6))
		if (1)
			var/obj/item/rogueweapon/sword/short/P = new()
			H.put_in_hands(P, forced = TRUE)
		if (2)
			var/obj/item/rogueweapon/axe/copper/P = new()
			H.put_in_hands(P, forced = TRUE)
		if (3)
			var/obj/item/rogueweapon/mace/P = new()
			H.put_in_hands(P, forced = TRUE)
		if (4)
			var/obj/item/rogueweapon/polearm/spear/P = new()
			H.put_in_hands(P, forced = TRUE)
		if (5)
			var/obj/item/rogueweapon/sword/long/rider/copper/P = new()
			H.put_in_hands(P, forced = TRUE)
		if (6)
			var/obj/item/rogueweapon/flail/militia/P = new()
			H.put_in_hands(P, forced = TRUE)

	H.TOTALSTR = rand(8,10)
	H.TOTALSPD = rand(7,10)
	H.TOTALINT = 1
	H.TOTALCON = 3
	var/datum/antagonist/new_antag = new /datum/antagonist/skeleton()
	H.mind.add_antag_datum(new_antag)

