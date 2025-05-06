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

	outfit = /datum/outfit/job/royalguard
	give_bank_account = 30
	cmode_music = 'sound/music/cmode/nobility/CombatKnight.ogg'

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
	var/static/list/selectable = list("Flail" = /obj/item/weapon/flail/sflail, "Halberd" = /obj/item/weapon/polearm/halberd)
	spawned.select_equippable(player_client, selectable, message = "Take up arms!", title = "KNIGHT")

/datum/outfit/job/royalguard
	job_bitflag = BITFLAG_GARRISON

/datum/outfit/job/royalguard/pre_equip(mob/living/carbon/human/H)
	..()
	pants = /obj/item/clothing/pants/chainlegs
	cloak = /obj/item/clothing/cloak/tabard/knight/guard
	neck = /obj/item/clothing/neck/gorget
	shirt = /obj/item/clothing/armor/gambeson/arming
	armor = /obj/item/clothing/armor/brigandine // Wear the King's colors.
	shoes = /obj/item/clothing/shoes/boots/armor/light
	beltl = /obj/item/storage/keyring/manorguard
	belt = /obj/item/storage/belt/leather
	beltr = /obj/item/weapon/sword/arming
	backr = /obj/item/storage/backpack/satchel
	backl = /obj/item/weapon/shield/tower/metal
	gloves = /obj/item/clothing/gloves/chain
	head = /obj/item/clothing/head/helmet/visored/knight

	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/shields, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/whipsflails, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
		H.change_stat(STATKEY_STR, 2)
		H.change_stat(STATKEY_PER, 2)
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_CON, 1)
	H.verbs |= /mob/proc/haltyell
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	if(H.dna?.species)
		if(H.dna.species.id == "human")
			H.dna.species.soundpack_m = new /datum/voicepack/male/knight()
