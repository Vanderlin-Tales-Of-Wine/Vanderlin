/datum/job/mayor
	title = "Town Elder"
	tutorial = "You were once a wanderer, an unremarkable soul who, alongside your old adventuring party, carved your name into history.\
	Now, the days of adventure are long past. You sit as the town's beloved elder; while the crown may rule from afar, the people\
	look to you to settle disputes, mend rifts, and keep the true peace in town. Not every conflict must end in bloodshed,\
	but when it must, you will do what is necessary, as you always have."
	flag = MAYOR
	department_flag = GARRISON
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_CHIEF
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	min_pq = 2
	bypass_lastclass = TRUE

	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD, AGE_IMMORTAL)
	allowed_races = RACES_PLAYER_NONDISCRIMINATED

	outfit = /datum/outfit/job/mayor
	spells = list(/obj/effect/proc_holder/spell/self/convertrole/town_militia)
	give_bank_account = 80
	cmode_music = 'sound/music/cmode/towner/CombatMayor.ogg'
	can_have_apprentices = FALSE

/datum/outfit/job/mayor
	name = "Town Elder"
	jobtype = /datum/job/mayor

/datum/outfit/job/mayor/pre_equip(mob/living/carbon/human/H)
	..()
	pants = /obj/item/clothing/pants/trou/leather
	head = /obj/item/clothing/head/brimmed
	armor = /obj/item/clothing/armor/leather/jacket
	shirt = /obj/item/clothing/shirt/tunic
	shoes = /obj/item/clothing/shoes/boots
	cloak = /obj/item/clothing/cloak/half
	neck = /obj/item/storage/belt/pouch/coins/rich
	belt = /obj/item/storage/belt/leather/black
	beltr = /obj/item/storage/keyring/mayor
	beltl = /obj/item/flashlight/flare/torch/lantern
	r_hand = /obj/item/weapon/polearm/woodstaff/quarterstaff
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
		if(H.age == AGE_OLD)
			H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
			H.change_stat(STATKEY_STR, 1)
			H.change_stat(STATKEY_PER, 1)
			H.change_stat(STATKEY_INT, 2)
		else
			H.change_stat(STATKEY_STR, 2)
			H.change_stat(STATKEY_END, 1)
			H.change_stat(STATKEY_INT, 2)
	H.verbs |= /mob/proc/haltyell

/obj/effect/proc_holder/spell/self/convertrole/town_militia
	name = "Recruit Militia"
	new_role = "Town Militiaman"
	overlay_state = "recruit_guard"
	recruitment_faction = "Garrison"
	recruitment_message = "Join the Town Militia, %RECRUIT!"
	accept_message = "I swear fealty to protect the town!"
	refuse_message = "I refuse."

/datum/job/militia //just used to change the title
	title = "Town Militiaman"
	f_title = "Town Militiawoman"
	flag = GUARDSMAN
	department_flag = GARRISON
	faction = FACTION_STATION
	total_positions = 0
	spawn_positions = 0
	display_order = JDO_CITYWATCHMEN
