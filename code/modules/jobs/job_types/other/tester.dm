/datum/job/tester
	title = "Tester"
	tutorial = "Try not to get obliterated by the Gods while they toy with you."
	flag = GRAVETENDER
	department_flag = PEASANTS
	job_flags = (JOB_EQUIP_RANK)
	faction = FACTION_STATION
	display_order = JDO_MERCENARY
	#ifdef TESTSERVER
	total_positions = 99
	spawn_positions = 99
	#endif

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_PLAYER_ALL

	outfit = /datum/outfit/job/tester

/datum/outfit/job/tester/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/boots/leather
	wrists = /obj/item/clothing/wrists/bracers
	belt = /obj/item/storage/belt/leather
	armor = /obj/item/clothing/armor/gambeson/arming
	if(prob(50))
		armor = /obj/item/clothing/armor/gambeson
	neck = /obj/item/key/mercenary
	beltl = /obj/item/storage/belt/pouch/coins/poor
	beltr = /obj/item/weapon/sword/sabre
	if(prob(50))
		beltr = /obj/item/weapon/sword/arming
	shirt = /obj/item/clothing/shirt/shortshirt/merc
	pants = /obj/item/clothing/pants/trou/leather
	neck = /obj/item/clothing/neck/gorget
	if(H.gender == FEMALE)
		pants = /obj/item/clothing/pants/tights/black
		beltr = /obj/item/weapon/sword/sabre
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, rand(1,5), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, rand(1,5), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, rand(1,5), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, rand(1,5), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/bows, rand(1,5), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, rand(1,5), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, rand(1,5), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, rand(1,5), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, rand(1,5), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/polearms, rand(1,5), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/whipsflails, rand(1,5), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, rand(1,5), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, rand(1,5), TRUE)
		H.change_stat(STATKEY_STR, 1)
