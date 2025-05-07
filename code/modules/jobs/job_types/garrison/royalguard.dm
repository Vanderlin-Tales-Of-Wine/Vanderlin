/datum/job/royalguard
	title = "Royal Knight"
	tutorial = "You are a knight of the royal garrison, elevated by your skill and steadfast devotion. \
	Sworn to protect the royal family, you stand as their shield, upholding their rule with steel and sacrifice. \
	Yet service is not without its trials, and your loyalty will be tested in ways both seen and unseen. \
	In the end, duty is a path you must walk carefully."
	flag = GUARDSMAN
	department_flag = GARRISON
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_ROYALGUARD
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
	give_bank_account = 30
	cmode_music = 'sound/music/cmode/nobility/CombatKnight.ogg'

/datum/advclass/royalguard/knight
	name = "Steel Knight"
	tutorial = "The classic Knight in shining armor."

	outfit = /datum/outfit/job/royalguard/knight

	category_tags = list(CTAG_ROYALKNIGHT)

/datum/job/royalguard/after_spawn(mob/living/carbon/human/spawned, client/player_client)
	..()
	if(istype(spawned.cloak, /obj/item/clothing/cloak/tabard/knight/guard))
		var/obj/item/clothing/S = spawned.cloak
		var/index = findtext(spawned.real_name, " ")
		if(index)
			index = copytext(spawned.real_name, 1,index)
		if(!index)
			index = spawned.real_name
		S.name = "knight's tabard ([index])"
	var/prev_real_name = spawned.real_name
	var/prev_name = spawned.name
	var/honorary = "Sir"
	if(spawned.gender == FEMALE)
		honorary = "Dame"
	spawned.real_name = "[honorary] [prev_real_name]"
	spawned.name = "[honorary] [prev_name]"

/datum/outfit/job/royalguard
	job_bitflag = BITFLAG_GARRISON

/datum/outfit/job/royalguard/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/clothing/neck/chaincoif
	pants = /obj/item/clothing/pants/platelegs
	cloak = /obj/item/clothing/cloak/tabard/knight/guard  // Wear the King's colors
	shirt = /obj/item/clothing/armor/gambeson/arming
	belt = /obj/item/storage/belt/leather
	beltr = /obj/item/weapon/sword/arming
	backl = /obj/item/storage/backpack/satchel
	wrists = /obj/item/clothing/wrists/bracers
	backpack_contents = list(/obj/item/storage/keyring/manorguard = 1)

	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)

		H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 4, TRUE)

		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)

	H.change_stat(STATKEY_STR, 3)
	H.change_stat(STATKEY_PER, 2)
	H.change_stat(STATKEY_END, 3)
	H.change_stat(STATKEY_CON, 2)
	H.change_stat(STATKEY_INT, 1)

	H.verbs |= /mob/proc/haltyell
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	if(H.dna?.species?.id == "human")
		H.dna.species.soundpack_m = new /datum/voicepack/male/knight()

/datum/outfit/job/royalguard/post_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	var/static/list/selectable = list( \
		"Flail" = /obj/item/weapon/flail/sflail, \
		"Halberd" = /obj/item/weapon/polearm/halberd, \
		"Greatsword" = /obj/item/weapon/sword/long/greatsword, \
		"Sabre" = /obj/item/weapon/sword/sabre/dec, \
		"Unarmed" = /obj/item/weapon/knife/dagger/steel \
		)
	var/choice = H.select_equippable(selectable, message = "Take up arms!", title = "KNIGHT")
	if(!choice)
		return
	var/grant_shield = TRUE
	switch(choice)
		if("Flail")
			H.mind?.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
		if("Halberd")
			H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
			grant_shield = FALSE
		if("Greatsword")
			H.mind?.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			grant_shield = FALSE
		if("Sabre")
			H.mind?.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		if("Unarmed")
			H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
			grant_shield = FALSE
	if(grant_shield)
		H.mind?.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
		var/shield = new /obj/item/weapon/shield/tower/metal()
		if(!H.equip_to_appropriate_slot(shield))
			qdel(shield)

/datum/outfit/job/royalguard/knight/pre_equip(mob/living/carbon/human/H)
	. = ..()
	armor = /obj/item/clothing/armor/brigandine
	shoes = /obj/item/clothing/shoes/boots/armor/light
	gloves = /obj/item/clothing/gloves/chain
	head = /obj/item/clothing/head/helmet/visored/knight

/datum/advclass/royalguard/steam
	name = "Steam Knight"
	tutorial = "The pinnacle of Vanderlin's steam technology. \
	Start with a set of Steam Armor that requires steam to function. \
	The suit is powerful when powered but will slow you down when not \
	and has the cost of reducing your space for arms."

	outfit = /datum/outfit/job/royalguard/steam

	category_tags = list(CTAG_ROYALKNIGHT)

/datum/outfit/job/royalguard/steam/pre_equip(mob/living/carbon/human/H)
	. = ..()
	backr = /obj/item/clothing/cloak/boiler
	armor = /obj/item/clothing/armor/steam
	shoes = /obj/item/clothing/shoes/boots/armor/steam
	gloves = /obj/item/clothing/gloves/plate/steam
	head = /obj/item/clothing/head/helmet/heavy/steam

	H.change_stat(STATKEY_INT, 1)
	// Stronger armour than base RK
	// Stat punishment for not having the armour active
	H.change_stat(STATKEY_STR, -2)
	H.change_stat(STATKEY_END, -1)
	H.change_stat(STATKEY_CON, -1)
	H.change_stat(STATKEY_SPD, -2)

/datum/outfit/job/royalguard/steam/post_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	if(H.backr && istype(H.backr, /obj/item/clothing/cloak/boiler))
		SEND_SIGNAL(H.backr, COMSIG_ATOM_STEAM_INCREASE, 500)
