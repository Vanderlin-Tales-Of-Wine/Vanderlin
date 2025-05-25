/datum/job/royalknight
	title = "Royal Knight"
	tutorial = "You are a knight of the royal garrison, elevated by your skill and steadfast devotion. \
	Sworn to protect the royal family, you stand as their shield, upholding their rule with steel and sacrifice. \
	Yet service is not without its trials, and your loyalty will be tested in ways both seen and unseen. \
	In the end, duty is a path you must walk carefully."
	flag = GUARDSMAN
	department_flag = GARRISON
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_ROYALKNIGHT
	faction = FACTION_STATION
	total_positions = 2
	spawn_positions = 2
	min_pq = 8
	bypass_lastclass = TRUE
	selection_color = "#920909"

	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_IMMORTAL)
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_PLAYER_NONDISCRIMINATED

	advclass_cat_rolls = list(CTAG_ROYALKNIGHT = 20)
	give_bank_account = 60
	cmode_music = 'sound/music/cmode/nobility/CombatKnight.ogg'

/datum/advclass/royalknight/knight
	name = "Royal Knight"
	tutorial = "The classic Knight in shining armor. Slightly more skilled then their Steam counterpart but has worse armor."

	outfit = /datum/outfit/job/royalknight/knight

	category_tags = list(CTAG_ROYALKNIGHT)

/datum/outfit/job/royalknight
	job_bitflag = BITFLAG_GARRISON
	var/reduced_skill = FALSE

/datum/outfit/job/royalknight/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/clothing/neck/chaincoif
	pants = /obj/item/clothing/pants/platelegs
	cloak = /obj/item/clothing/cloak/tabard/knight/guard  // Wear the King's colors
	shirt = /obj/item/clothing/armor/gambeson/arming
	belt = /obj/item/storage/belt/leather
	beltr = /obj/item/weapon/sword/arming
	backl = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/storage/keyring/manorguard = 1)

	H.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)

	H.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/crossbows, 4, TRUE)

	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)

	H.change_stat(STATKEY_STR, 3)
	H.change_stat(STATKEY_PER, 2)
	H.change_stat(STATKEY_END, 2)
	H.change_stat(STATKEY_CON, 2)
	H.change_stat(STATKEY_INT, 1)

	H.verbs |= /mob/proc/haltyell
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	if(H.dna?.species?.id == "human")
		H.dna.species.soundpack_m = new /datum/voicepack/male/knight()

/datum/outfit/job/royalknight/post_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	if(H.cloak)
		if(!findtext(H.cloak.name,"([H.real_name])"))
			H.cloak.name = "[H.cloak.name]"+" "+"([H.real_name])"

	var/prev_real_name = H.real_name
	var/prev_name = H.name
	var/honorary = "Sir"
	if(H.gender == FEMALE)
		honorary = "Dame"
	H.real_name = "[honorary] [prev_real_name]"
	H.name = "[honorary] [prev_name]"

	var/static/list/selectable = list( \
		"Flail" = /obj/item/weapon/flail/sflail, \
		"Halberd" = /obj/item/weapon/polearm/halberd, \
		"Longsword" = /obj/item/weapon/sword/long, \
		"Sabre" = /obj/item/weapon/sword/sabre/dec, \
		"Unarmed" = /obj/item/weapon/knife/dagger/steel \
		)
	var/choice = H.select_equippable(H, selectable, message = "Choose Your Specialisation", title = "KNIGHT")
	if(!choice)
		return
	var/grant_shield = TRUE
	var/modifier = reduced_skill
	switch(choice)
		if("Flail")
			H.adjust_skillrank(/datum/skill/combat/whipsflails, 2 - modifier, TRUE)
		if("Halberd")
			H.adjust_skillrank(/datum/skill/combat/polearms, 2 - modifier, TRUE)
			grant_shield = FALSE
		if("Longsword")
			if(!reduced_skill)
				H.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			grant_shield = FALSE
		if("Sabre")
			if(!reduced_skill)
				H.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		if("Unarmed")
			if(!reduced_skill)
				H.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
			H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			grant_shield = FALSE
	if(grant_shield)
		H.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)
		var/shield = new /obj/item/weapon/shield/tower/metal()
		if(!H.equip_to_appropriate_slot(shield))
			qdel(shield)

/datum/outfit/job/royalknight/knight/pre_equip(mob/living/carbon/human/H)
	. = ..()
	armor = /obj/item/clothing/armor/plate/full
	head = /obj/item/clothing/head/helmet/visored/knight
	gloves = /obj/item/clothing/gloves/plate
	shoes = /obj/item/clothing/shoes/boots/armor

/datum/advclass/royalknight/steam
	name = "Steam Knight"
	tutorial = "The pinnacle of Vanderlin's steam technology. \
	Start with a set of Steam Armor that requires steam to function. \
	The suit is powerful when powered but will slow you down when not \
	and has the cost of reducing your space for arms."

	outfit = /datum/outfit/job/royalknight/steam

	category_tags = list(CTAG_ROYALKNIGHT)

/datum/outfit/job/royalknight/steam
	reduced_skill = TRUE

/datum/outfit/job/royalknight/steam/pre_equip(mob/living/carbon/human/H)
	. = ..()
	backr = /obj/item/clothing/cloak/boiler
	armor = /obj/item/clothing/armor/steam
	shoes = /obj/item/clothing/shoes/boots/armor/steam
	gloves = /obj/item/clothing/gloves/plate/steam
	head = /obj/item/clothing/head/helmet/heavy/steam

	// Steam armour is complex
	H.change_stat(STATKEY_INT, 2)
	// Stronger armour than base RK
	// Stat punishment for not having the armour active
	H.change_stat(STATKEY_STR, -1)
	H.change_stat(STATKEY_CON, -1)
	H.change_stat(STATKEY_END, -1)
	// Way heavier
	H.change_stat(STATKEY_SPD, -1)

/datum/outfit/job/royalknight/steam/post_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	if(H.backr && istype(H.backr, /obj/item/clothing/cloak/boiler))
		var/obj/item/clothing/cloak/boiler/B = H.backr
		SEND_SIGNAL(B, COMSIG_ATOM_STEAM_INCREASE, 1000)
		B.update_armor()
