/datum/job/servant
	title = "Servant"
	tutorial = "You are the faceless, nameless labor that keeps the royal court fed, washed, and attended to. \
	You work your fingers to the bone nearly every dae, \
	and have naught to show for it but boney fingers. \
	Perhaps this week you will finally be recognized, or allowed some respite?"
	flag = SERVANT
	department_flag = APPRENTICES
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_SERVANT
	faction = FACTION_STATION
	total_positions = 5
	spawn_positions = 5
	min_pq = -20
	bypass_lastclass = TRUE

	allowed_ages = list(AGE_CHILD, AGE_ADULT, AGE_IMMORTAL)
	allowed_races = RACES_PLAYER_ALL

	outfit = /datum/outfit/job/servant
	give_bank_account = TRUE

	can_have_apprentices = FALSE

/datum/outfit/job/servant/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/simpleshoes
	pants = /obj/item/clothing/pants/tights/uncolored
	shirt = /obj/item/clothing/shirt/undershirt/uncolored
	belt = /obj/item/storage/belt/leather/rope
	beltl = /obj/item/storage/belt/pouch/coins/poor
	neck = /obj/item/key/manor
	if(H.gender == MALE)
		armor = /obj/item/clothing/armor/leather/vest/black
	else
		cloak = /obj/item/clothing/cloak/apron
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/butchering, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/music, pick(0,1,1), TRUE)
		H.change_stat(STATKEY_SPD, 1)
		H.change_stat(STATKEY_END, 1)

/datum/job/tapster
	title = "Tapster"
	f_title = "Alemaid"
	tutorial = "The Innkeeper needed waiters and extra hands. So here am I, serving the food and drinks while ensuring the tavern rooms are kept clean."
	flag = SERVANT
	department_flag = APPRENTICES
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_SERVANT
	faction = FACTION_STATION
	total_positions = 2
	spawn_positions = 2
	min_pq = -20
	bypass_lastclass = TRUE

	allowed_races = RACES_PLAYER_ALL

	outfit = /datum/outfit/job/tapster
	give_bank_account = TRUE

	can_have_apprentices = FALSE

/datum/outfit/job/tapster/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/simpleshoes
	pants = /obj/item/clothing/pants/tights/uncolored
	shirt = /obj/item/clothing/shirt/undershirt/uncolored
	belt = /obj/item/storage/belt/leather/rope
	beltl = /obj/item/storage/belt/pouch/coins/poor
	neck = /obj/item/key/tavern
	if(H.gender == MALE)
		armor = /obj/item/clothing/armor/leather/vest/black
	else
		cloak = /obj/item/clothing/cloak/apron
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/butchering, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/music, pick(0,1,1), TRUE)
		H.change_stat(STATKEY_SPD, 1)
		H.change_stat(STATKEY_END, 1)

/datum/job/matron_assistant
	title = "Orphanage Assistant"
	tutorial = "I once was an orphan, the matron took me in and now I am forever in her debt. \
	That orphanage, those who were like me need guidance, I shall assist the matron in her tasks."
	flag = SERVANT
	department_flag = APPRENTICES
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_SERVANT
	faction = FACTION_STATION
	total_positions = 0
	spawn_positions = 0
	min_pq = -20
	bypass_lastclass = TRUE

	allowed_races = RACES_PLAYER_ALL

	outfit = /datum/outfit/job/matron_assistant
	give_bank_account = TRUE

	can_have_apprentices = FALSE

/datum/outfit/job/matron_assistant/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/simpleshoes
	pants = /obj/item/clothing/pants/tights/uncolored
	shirt = /obj/item/clothing/shirt/undershirt/uncolored
	belt = /obj/item/storage/belt/leather/rope
	beltl = /obj/item/storage/belt/pouch/coins/poor
	neck = /obj/item/key/matron
	if(H.gender == MALE)
		armor = /obj/item/clothing/armor/leather/vest/black
	else
		cloak = /obj/item/clothing/cloak/apron
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/butchering, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/music, pick(0,1,1), TRUE)
		H.change_stat(STATKEY_SPD, 1)
		H.change_stat(STATKEY_END, 1)

/datum/job/gaffer_assistant
	title = "Ring Servant"
	tutorial = "I never had what it took to be a mercenary, but I offered my service to the Guild regardless. \
	My vow is to serve whomever holds the ring of Burden while avoiding its curse from befalling me."
	flag = SERVANT
	department_flag = APPRENTICES
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_SERVANT
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	min_pq = 8
	bypass_lastclass = TRUE

	allowed_races = RACES_PLAYER_ALL

	outfit = /datum/outfit/job/gaffer_assistant
	give_bank_account = TRUE

/datum/outfit/job/gaffer_assistant/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/simpleshoes
	pants = /obj/item/clothing/pants/tights/uncolored
	shirt = /obj/item/clothing/shirt/undershirt/uncolored
	belt = /obj/item/storage/belt/leather/rope
	beltl = /obj/item/storage/belt/pouch/coins/poor
	beltr = /obj/item/storage/keyring/gaffer_assistant
	if(H.gender == MALE)
		armor = /obj/item/clothing/armor/leather/vest/black
	else
		cloak = /obj/item/clothing/cloak/apron
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/butchering, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/farming, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/mathematics, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/music, pick(0,1,1), TRUE)
		H.change_stat(STATKEY_SPD, 1)
		H.change_stat(STATKEY_END, 1)
