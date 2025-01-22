/datum/job/roguetown/churchling
	title = "Churchling"
	flag = CHURCHLING
	department_flag = YOUNGFOLK
	faction = "Station"
	total_positions = 2
	spawn_positions = 2

	allowed_races = ALL_PLAYER_RACES_BY_NAME
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_CHILD)

	tutorial = "Your family were zealots. They scolded you with a studded belt and prayed like sinners every waking hour of the day they weren’t toiling in the fields. You escaped them by becoming a churchling--and a guaranteed education isn't so bad."

	outfit = /datum/outfit/job/roguetown/churchling
	display_order = JDO_CHURCHLING
	give_bank_account = TRUE
	min_pq = -10
	can_have_apprentices = FALSE
	allowed_patrons = ALL_TEMPLE_PATRONS

/datum/outfit/job/roguetown/churchling
	name = "Churchling"
	jobtype = /datum/job/roguetown/churchling
	allowed_patrons = ALL_TEMPLE_PATRONS

/datum/outfit/job/roguetown/churchling/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/holy, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	if(H.gender == FEMALE)
		head = /obj/item/clothing/head/roguetown/armingcap
		armor = /obj/item/clothing/suit/roguetown/shirt/dress/gen/random
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	else
		armor = /obj/item/clothing/suit/roguetown/shirt/robe
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt
	pants = /obj/item/clothing/under/roguetown/tights
	belt = /obj/item/storage/belt/rogue/leather/rope
	shoes = /obj/item/clothing/shoes/roguetown/simpleshoes
	beltl = /obj/item/storage/keyring/priest
	neck = /obj/item/clothing/neck/roguetown/psycross/silver
	switch(H.patron?.type)
		if(/datum/patron/divine/astrata)
			neck = /obj/item/clothing/neck/roguetown/psycross/silver/astrata
		if(/datum/patron/divine/necra) //Necra acolytes are now gravetenders
			neck = /obj/item/clothing/neck/roguetown/psycross/silver/necra
		if(/datum/patron/divine/eora)
			neck = /obj/item/clothing/neck/roguetown/psycross/silver/eora
		if(/datum/patron/divine/noc)
			neck = /obj/item/clothing/neck/roguetown/psycross/noc
		if(/datum/patron/divine/pestra)
			neck = /obj/item/clothing/neck/roguetown/psycross/silver/pestra
		if(/datum/patron/divine/dendor)
			neck = /obj/item/clothing/neck/roguetown/psycross/silver/dendor
		if(/datum/patron/divine/abyssor)
			neck = /obj/item/clothing/neck/roguetown/psycross/silver/abyssor
		if(/datum/patron/divine/ravox)
			neck = /obj/item/clothing/neck/roguetown/psycross/silver/ravox
		if(/datum/patron/divine/xylix)
			neck = /obj/item/clothing/neck/roguetown/psycross/silver/xylix
		if(/datum/patron/divine/malum)
			neck = /obj/item/clothing/neck/roguetown/psycross/silver/malum

	H.change_stat("perception", 1)
	H.change_stat("speed", 2)

	var/datum/devotion/cleric_holder/C = new /datum/devotion/cleric_holder(H, H.patron)
	C.grant_spells_churchling(H)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)
