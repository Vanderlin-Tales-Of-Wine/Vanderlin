/datum/job/servant
	title = "Servant"
	tutorial = "You work your fingers to the bone nearly every dae, \
	and have naught to show for it but boney fingers. \
	Perhaps this week you will finally be recognized, or allowed some respite?"
	flag = SERVANT
	department_flag = APPRENTICES
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_SERVANT
	faction = FACTION_STATION
	total_positions = 9
	spawn_positions = 9
	min_pq = -20
	bypass_lastclass = TRUE

	allowed_ages = list(AGE_CHILD, AGE_ADULT, AGE_IMMORTAL)
	allowed_races = RACES_PLAYER_ALL

	give_bank_account = TRUE

	can_have_apprentices = FALSE

	advclass_cat_rolls = list(CTAG_SERVANT = 20)

/datum/outfit/job/servant/pre_equip(mob/living/carbon/human/H)
	..()
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
		shoes = /obj/item/clothing/shoes/simpleshoes
		pants = /obj/item/clothing/pants/tights/uncolored
		shirt = /obj/item/clothing/shirt/undershirt/uncolored
		belt = /obj/item/storage/belt/leather/rope
		beltl = /obj/item/storage/belt/pouch/coins/poor
		if(H.gender == MALE)
			armor = /obj/item/clothing/armor/leather/vest/black
		else
			cloak = /obj/item/clothing/cloak/apron

/datum/advclass/servant/keep
	name = "Keep's Servant"
	tutorial = "You are the faceless, nameless labor that keeps the royal court fed, washed, and attended to."
	outfit = /datum/outfit/job/servant/keep
	maximum_possible_slots = 5

	category_tags = list(CTAG_SERVANT)

/datum/outfit/job/servant/keep/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		neck = /obj/item/key/manor

/datum/advclass/servant/inn
	name = "Innkeeper's Servant"
	tutorial = "The Innkeeper needed waiters and here am I, serving the food, drinks and ensuring the rooms are clean."
	outfit = /datum/outfit/job/servant/inn
	maximum_possible_slots = 2

	category_tags = list(CTAG_SERVANT)

/datum/outfit/job/servant/inn/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		neck = /obj/item/key/tavern

/datum/advclass/servant/matron_assistant
	name = "Matron's Servant"
	tutorial = "I once was an orphan, the matron took me in and now I am forever in her debt. \
	That orphanage, those who were like me need guidance, I shall assist the matron in her tasks."
	outfit = /datum/outfit/job/servant/matron_assistant
	maximum_possible_slots = 2

	category_tags = list(CTAG_SERVANT)

/datum/outfit/job/servant/matron_assistant/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		neck = /obj/item/key/matron

/datum/advclass/servant/gaffer_assistant
	name = "Ring's Servant"
	tutorial = "I never had what it took to be a mercenary, but I offered my service to the guild regardless. \
	my vow is to serve whomever has the ring of burden, but I know to avoid its curse my self"
	outfit = /datum/outfit/job/servant/gaffer_assistant
	maximum_possible_slots = 1

	category_tags = list(CTAG_SERVANT)

/datum/outfit/job/servant/gaffer_assistant/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		neck = /obj/item/key/gaffer
