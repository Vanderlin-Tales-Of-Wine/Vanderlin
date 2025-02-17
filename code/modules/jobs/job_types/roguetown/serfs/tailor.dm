/datum/job/roguetown/tailor
	title = "Tailor"
	f_title = "Seamstress"
	tutorial = "Cloth, linen, silk and leather. \
	You've tirelessly studied and poured your life into \
	sewing articles of protection, padding, and fashion for serf and noble alike."
	flag = TAILOR
	department_flag = SERFS
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_TAILOR
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	bypass_lastclass = TRUE

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = ALL_PLAYER_RACES_BY_NAME

	outfit = /datum/outfit/job/roguetown/tailor
	give_bank_account = TRUE

/datum/outfit/job/roguetown/tailor/pre_equip(mob/living/carbon/human/H)
	..()

	shoes = /obj/item/clothing/shoes/roguetown/nobleboot
	head = /obj/item/clothing/head/roguetown/courtierhat
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/rogueweapon/knife/scissors
	beltl = /obj/item/storage/keyring/tailor
	backr = /obj/item/storage/backpack/rogue/satchel
	neck = /obj/item/storage/belt/rogue/pouch/coins/mid
	backpack_contents = list(/obj/item/needle = 1, /obj/item/natural/bundle/cloth = 2, /obj/item/natural/bundle/fibers = 1, /obj/item/luxury_dyes = 1, /obj/item/book/rogue/advice_weaving = 1, /obj/item/rogueweapon/knife/villager = 1)

	H.mind?.adjust_skillrank(/datum/skill/misc/sewing, pick(4,5), TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/tanning, pick(3,4), TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/stealing, 1, TRUE)
	ADD_TRAIT(H, TRAIT_SEEPRICES, TRAIT_GENERIC)
	if(H.gender == MALE)
		pants = /obj/item/clothing/under/roguetown/tights/red
		shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/red
		armor = /obj/item/clothing/suit/roguetown/shirt/tunic/red
		cloak = /obj/item/clothing/cloak/raincloak/furcloak
	else
		cloak = /obj/item/clothing/cloak/raincloak/furcloak
		shirt = /obj/item/clothing/suit/roguetown/shirt/dress/gen/purple
		armor = /obj/item/clothing/suit/roguetown/shirt/tunic/purple
		pants = /obj/item/clothing/under/roguetown/tights/purple
	H.change_stat("intelligence", 2)
	H.change_stat("speed", 2)
	H.change_stat("perception", 1)
	H.change_stat("strength", -1)
