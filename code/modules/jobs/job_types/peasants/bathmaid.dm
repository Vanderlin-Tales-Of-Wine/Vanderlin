/**
 * This job used to do exactly what you think it does,
 * but now that we are PG-13, it only exists to be used
 * in adminbusses and smites.
 */
/datum/job/nitemaiden
	title = "Nitemaiden"
	tutorial = "Oh no."
	department_flag = PEASANTS
	job_flags = (JOB_EQUIP_RANK)
	faction = FACTION_STATION
	total_positions = 0
	spawn_positions = 0

	allowed_sexes = list(FEMALE)
	allowed_races =  ALL_PLAYER_RACES_BY_NAME
	allowed_ages = ALL_AGES_LIST

	outfit = /datum/outfit/job/nitemaiden
	min_pq = -20

/datum/outfit/job/nitemaiden/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/shortboots
	shirt = /obj/item/clothing/shirt/undershirt
	armor = /obj/item/clothing/shirt/dress/gen/sexy
	//neck = /obj/item/storage/belt/pouch/nitemaiden
	belt = /obj/item/storage/belt/leather/rope
	beltr = /obj/item/key/nitemaiden
	//ADD_TRAIT(H, TRAIT_GOODLOVER, TRAIT_GENERIC)

	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE) // To wrestle people out of the baths
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/stealing, pick(1,2,3,4), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking, pick(1,1,2), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/music, pick(1,2), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	if(H.gender == MALE)
		shoes = /obj/item/clothing/shoes/boots/leather
		shirt = /obj/item/clothing/shirt/undershirt/puritan
		armor = /obj/item/clothing/armor/leather/jacket/sea
