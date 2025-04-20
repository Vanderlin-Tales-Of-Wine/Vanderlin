/datum/job/jailor
	title = "Jailor"
	tutorial = "Your eyes have laid bare upon true terror in the Crimson Valley Asylum. \
	Men, ripping apart one another for their own entertainment-- \
	not for sport, not for sadism, for blood. \
	You now live in this kingdom - a quiet peaceful place \
	compared to the Asylum you once warded, \
	having once kept bloodthirsty churls locked in the dark."
	flag = JAILOR
	department_flag = GARRISON
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_JAILOR
	faction = FACTION_STATION
	total_positions = 0
	spawn_positions = 0
	min_pq = 4

	allowed_ages = list(AGE_OLD, AGE_IMMORTAL) // He's a wierd elderly man that is fucking jacked- this will make for a memorable character I think.
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_PLAYER_NONDISCRIMINATED

	outfit = /datum/outfit/job/jailor
	give_bank_account = 25
	cmode_music = 'sound/music/cmode/nobility/CombatDungeoneer.ogg'

/datum/outfit/job/jailor
	job_bitflag = BITFLAG_GARRISON

/datum/outfit/job/jailor/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguehood/black
	neck = /obj/item/clothing/neck/coif
	armor = /obj/item/clothing/armor/leather/splint
	shirt = /obj/item/clothing/shirt/tunic/black
	pants = /obj/item/clothing/pants/loincloth/black
	shoes = /obj/item/clothing/shoes/shortboots
	wrists = /obj/item/rope/chain
	belt = /obj/item/storage/belt/leather
	beltl = /obj/item/weapon/mace/spiked // He gets a random mace.
	beltr = /obj/item/storage/keyring/guard
	backpack_contents = list(/obj/item/weapon/knife/dagger)
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE) // Main weapon
		H.mind?.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE) // He has lost his trusty whip a long time ago
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE) // He uses this quite often to get the truth out of liars
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, pick(4,4,4,5), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, pick(4,4,4,5), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/traps, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE) // He needs to sew his prisoners back up
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE) // He needs to SUTURE his prisoners up too
		//H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	// He's really strong- but anyone is faster than him, the question is can they run for long enough? (Also remember they are an elderly man)
	H.change_stat(STATKEY_STR, 5)
	H.change_stat(STATKEY_END, pick(4,5,6))
	H.change_stat(STATKEY_CON, -2)
	H.change_stat(STATKEY_SPD, -4) // To balance out how strong he is
	H.change_stat(STATKEY_INT, pick(-4,-5,-6)) // He's stupid
	H.change_stat(STATKEY_PER, pick(-3,-3,-4)) // Yeah he's stupid- he's not going to notice small things
	H.verbs |= /mob/living/carbon/human/proc/torture_victim // I don't think they need it, but here we go anyways.
