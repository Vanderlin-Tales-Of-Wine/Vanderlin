/datum/job/stonekeep/inquisitor
	title = "Inquisitor"
	flag = SK_INQUISITOR
	department_flag = CHURCHMEN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_races = list(
		"Humen"
	)
	allowed_sexes = list(MALE)

	tutorial = "A recent arrival from Grenzelhoft, you are a member of the secretive lodges that have held to the service of Psydon since the Apotheosis War. You have been sent by your leader, the Holy Bishop, to assign the local Priest in combatting the increasing number of heretics and monsters infiltrating Vanderlin."
	whitelist_req = FALSE

	outfit = /datum/outfit/job/stonekeep/inquisitor
	display_order = INQUISITOR_ORDER
	min_pq = 0
	bypass_lastclass = TRUE
	is_foreigner = TRUE
	cmode_music = 'sound/music/cmode/church/CombatInquisitor.ogg'

/datum/job/stonekeep/inquisitor/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(!L.mind)
		return
	if(L.mind.has_antag_datum(/datum/antagonist))
		return
	var/datum/antagonist/new_antag = new /datum/antagonist/purishep()
	L.mind.add_antag_datum(new_antag)

/datum/outfit/job/stonekeep/inquisitor
	name = "Inquisitor"
	jobtype = /datum/job/stonekeep/inquisitor
	allowed_patrons = list(/datum/patron/psydon)

/datum/outfit/job/stonekeep/inquisitor/pre_equip(mob/living/carbon/human/H)
	..()
	shirt = /obj/item/clothing/armor/gambeson/heavy/dark
	belt = /obj/item/storage/belt/leather/black
	shoes = /obj/item/clothing/shoes/nobleboot
	pants = /obj/item/clothing/pants/trou/leather
	cloak = /obj/item/clothing/cloak/cape/puritan
	head = /obj/item/clothing/head/helmet/leather/inquisitor
	gloves = /obj/item/clothing/gloves/angle
	wrists = /obj/item/clothing/neck/psycross/silver
	backr = /obj/item/storage/backpack/satchel
	backl = /obj/item/weapon/sword/long/forgotten
	beltl = /obj/item/flashlight/flare/torch/lantern
	neck = /obj/item/clothing/neck/bevor
	armor = /obj/item/clothing/armor/leather/splint
	backpack_contents = list(/obj/item/storage/keyring/inquisitor = 1)
	var/prev_real_name = H.real_name
	var/prev_name = H.name
	var/honorary = "Ritter"
	if(H.gender == FEMALE)
		honorary = "Ritterin"
	H.real_name = "[honorary] [prev_real_name]"
	H.name = "[honorary] [prev_name]"
	H.confession_points = 10 // Starting with 10 points
	H.purchase_history = list() // Initialize as an empty list to track purchases
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/firearms, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.change_stat("intelligence", 2)
		H.change_stat("strength", 1)
		H.change_stat("perception", 2)
		H.change_stat("speed", 2)
		H.change_stat("endurance", 1)
		if(!H.has_language(/datum/language/oldpsydonic))
			H.grant_language(/datum/language/oldpsydonic)
		if(H.mind.has_antag_datum(/datum/antagonist))
			return
		var/datum/antagonist/new_antag = new /datum/antagonist/purishep()
		H.mind.add_antag_datum(new_antag)
		H.set_patron(/datum/patron/psydon)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)
	H.verbs |= /mob/living/carbon/human/proc/torture_victim
	H.verbs |= /mob/living/carbon/human/proc/faith_test
	to_chat(H,span_info("\
		-I can speak Old Psydonic with ,m before my speech.\n\
		-Your fraternal order and the blessed Imperiate have dispatched you to this island for grave import. Imperial spies have uncovered plots by cultists, sub-humens and monsters to overthrow the powers of Rockhill. Stop them at all costs.\n\
		-You've also been gaven 10 favors to use at the mail machines, you can get more favor by sending signed confessions to your brothers. Spend your favors wisely.")
		)
	H.mind?.teach_crafting_recipe(/datum/crafting_recipe/roguetown/confessional)
