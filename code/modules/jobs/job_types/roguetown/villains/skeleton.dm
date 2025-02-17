/* T: Skeletons should honestly just be a species.
 * In fact, they normally are on other codebases.
 * This will need refactoring for sure.
 */

/datum/job/roguetown/skeleton
	title = "Skeleton"
	tutorial = "Rattle rattle, click clack."
	flag = SKELETON
	department_flag = UNDEAD
	faction = FACTION_STATION //this seems wrong?
	job_flags = (JOB_EQUIP_RANK)
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

	cmode_music = 'sound/music/cmode/antag/combatskeleton.ogg'

	outfit = /datum/outfit/job/roguetown/skeleton
	show_in_credits = FALSE
	give_bank_account = FALSE

/datum/job/roguetown/skeleton/after_spawn(mob/living/spawned, client/player_client)
	..()

	var/mob/living/carbon/human/H = spawned
	if(spawned.mind)
		spawned.mind.special_role = "Skeleton"
		spawned.job = null //?
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
	H.base_intents = list(INTENT_HELP, INTENT_DISARM, INTENT_GRAB, /datum/intent/simple/claw)
	H.update_a_intents()

	var/obj/item/organ/eyes/eyes = H.getorganslot(ORGAN_SLOT_EYES)
	if(eyes)
		eyes.Remove(H, TRUE)
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
	ADD_TRAIT(H, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOSTAMINA, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOLIMBDISABLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOBREATH, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOPAIN, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_TOXIMMUNE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOSLEEP, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_SHOCKIMMUNE, TRAIT_GENERIC)

/datum/outfit/job/roguetown/skeleton/pre_equip(mob/living/carbon/human/H)
	..()

	H.TOTALSTR = rand(8,10)
	H.TOTALSPD = rand(7,10)
	H.TOTALINT = 1
	H.TOTALCON = 3

/* RAIDER SKELETONS */
/datum/job/roguetown/skeleton/raider
	title = "Skeleton Raider"
	outfit = /datum/outfit/job/roguetown/skeleton/raider

/datum/job/roguetown/skeleton/raider/after_spawn(mob/living/carbon/spawned, client/player_client)
	..()
	spawned.name = "skeleton"
	spawned.real_name = "skeleton"

	spawned.remove_all_languages()
	spawned.grant_language(/datum/language/hellspeak)
	spawned.silent = TRUE	// makes them unable to audible emote or speak, no more sexy moan zombies

	ADD_TRAIT(spawned, TRAIT_CRITICAL_WEAKNESS, TRAIT_GENERIC)
	ADD_TRAIT(spawned, TRAIT_EASYDISMEMBER, TRAIT_GENERIC)

	var/datum/antagonist/new_antag = new /datum/antagonist/skeleton()
	spawned.mind.add_antag_datum(new_antag)


/datum/outfit/job/roguetown/skeleton/raider/pre_equip(mob/living/carbon/human/H)
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
		if(1)
			head = /obj/item/clothing/head/roguetown/helmet/kettle
		if(2)
			head = /obj/item/clothing/head/roguetown/helmet/winged
		if(3)
			head = /obj/item/clothing/head/roguetown/helmet/leather/conical
		if(4)
			head = /obj/item/clothing/head/roguetown/helmet/coppercap
		if(5)
			neck = /obj/item/clothing/neck/roguetown/coif/cloth
		if(6)
			neck = /obj/item/clothing/neck/roguetown/coif
		if(7)
			head = /obj/item/clothing/head/roguetown/helmet/horned
		if(8)
			head = /obj/item/clothing/head/roguetown/helmet/skullcap
		if(9)
			head = /obj/item/clothing/head/roguetown/helmet

	if(prob(20))
		backr = /obj/item/rogueweapon/shield/wood

	switch(pick(1,6))
		if(1)
			var/obj/item/rogueweapon/sword/short/P = new()
			H.put_in_hands(P, forced = TRUE)
		if(2)
			var/obj/item/rogueweapon/axe/copper/P = new()
			H.put_in_hands(P, forced = TRUE)
		if(3)
			var/obj/item/rogueweapon/mace/P = new()
			H.put_in_hands(P, forced = TRUE)
		if(4)
			var/obj/item/rogueweapon/polearm/spear/P = new()
			H.put_in_hands(P, forced = TRUE)
		if(5)
			var/obj/item/rogueweapon/sword/long/rider/copper/P = new()
			H.put_in_hands(P, forced = TRUE)
		if(6)
			var/obj/item/rogueweapon/flail/militia/P = new()
			H.put_in_hands(P, forced = TRUE)


/* CULT SUMMONS */
/datum/job/roguetown/skeleton/zizoid
	title = "Cult Summon"
	outfit = /datum/outfit/job/roguetown/skeleton/zizoid
	cmode_music = 'sound/music/cmode/antag/combat_cult.ogg'

/datum/job/roguetown/skeleton/zizoid/after_spawn(mob/living/spawned, client/player_client)
	..()

	var/mob/living/carbon/human/H = spawned
	H.mind?.special_role = "Cult Summon"
	H.mind?.current.job = null
	H.set_patron(/datum/patron/inhumen/zizo)

/datum/outfit/job/roguetown/skeleton/zizoid/pre_equip(mob/living/carbon/human/H)
	..()
	H.TOTALSTR = rand(8,17)
	H.TOTALSPD = rand(7,10)
	H.TOTALINT = 1
	H.TOTALCON = 3

	H.verbs |= /mob/living/carbon/human/proc/praise
	H.verbs |= /mob/living/carbon/human/proc/communicate
