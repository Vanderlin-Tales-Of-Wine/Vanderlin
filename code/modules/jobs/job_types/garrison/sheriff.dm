/datum/job/sheriff
	title = "City Sheriff"
	tutorial = "You are the head of the City Watch. \
	Long ago you've proven yourself to the Monarch that you can keep the peace and manage your own men. \
	Now you have to keep the Watchmen in line or it will be on you."
	flag = SHERIFF
	department_flag = GARRISON
	display_order = JDO_SHERIFF
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	min_pq = 10
	bypass_lastclass = TRUE

	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD)
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Aasimar",
		"Dwarf"
	)
	
	outfit = /datum/outfit/job/sheriff
	spells = list(/obj/effect/proc_holder/spell/self/convertrole/guard/city_watch)
	give_bank_account = 85
	cmode_music = 'sound/music/cmode/garrison/CombatSheriff.ogg'

/datum/outfit/job/sheriff
	job_bitflag = BITFLAG_GARRISON

/datum/outfit/job/sheriff/pre_equip(mob/living/carbon/human/H)
	..()
	// His armor is in the office, he spawns wearing his court attire.
	head = /obj/item/clothing/head/chaperon/greyscale/chaperonsecondary
	shirt = /obj/item/clothing/armor/gambeson/heavy/guard
	pants = /obj/item/clothing/pants/trou/leather
	shoes = /obj/item/clothing/shoes/boots
	gloves = /obj/item/clothing/gloves/leather
	id = /obj/item/clothing/ring/silver // Wanna be noble
	belt = /obj/item/storage/belt/leather/black
	backr = /obj/item/storage/backpack/satchel
	beltl = /obj/item/weapon/sword/sabre
	backpack_contents = list(/obj/item/storage/keyring/sheriff = 1, /obj/item/signal_horn = 1)
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/firearms, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/mathematics, 1, TRUE)
		H.change_stat(STATKEY_STR, 2)
		H.change_stat(STATKEY_INT, 1)
		H.change_stat(STATKEY_CON, 1)
		H.change_stat(STATKEY_SPD, 1)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)
	H.verbs |= /mob/proc/haltyell
	to_chat(H, span_info("My armor resides within my office if I shall need it this week.")) // His armor is in the office, he spawns wearing his court attire.

/datum/job/sheriff/after_spawn(mob/living/spawned, client/player_client)
	..()
	var/mob/living/carbon/human/H = spawned
	var/prev_real_name = H.real_name
	var/prev_name = H.name
	var/honorary = "Sheriff"
	H.real_name = "[honorary] [prev_real_name]"
	H.name = "[honorary] [prev_name]"

/obj/effect/proc_holder/spell/self/convertrole/guard/city_watch
	name = "Recruit City Watchmen"
	new_role = "City Watchmen Recruit"
	recruitment_faction = "City Watch"
	recruitment_message = "Do you SWEAR to protect the city from ne'er-do-wells, %RECRUIT!"
	accept_message = "I swear to protect the innocent and keep the peace!"
	refuse_message = "I refuse."

/obj/structure/mannequin/sheriff
	mapping_head = /obj/item/clothing/head/helmet/visored/sallet
	mapping_armor = /obj/item/clothing/armor/brigandine/coatplates
