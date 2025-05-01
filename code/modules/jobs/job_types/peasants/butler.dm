/datum/job/butler
	title = "Butler"
	f_title = "Head Housekeeper"
	tutorial = "You are elevated to near nobility, as you hold the distinguished position of master of the royal household staff. \
	Your blade is a charcuterie of artisanal cheeses and meat, your armor wit and classical training. \
	By your word the meals are served, the chambers kept, and the floors polished clean. \
	You wear the royal colors and hold their semblance of dignity, \
	for without you and the servants under your command, the court would have all starved to death."
	flag = BUTLER
	department_flag = SERFS
	display_order = JDO_BUTLER
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	min_pq = 2
	bypass_lastclass = TRUE

	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD, AGE_IMMORTAL)
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Dark Elf",
		"Tiefling",
		"Aasimar"
	)

	outfit = /datum/outfit/job/butler
	give_bank_account = 30 // Along with the pouch, enough to purchase some ingredients from the farm and give hard working servants a silver here and there. Still need the assistance of the crown's coffers to do anything significant
	cmode_music = 'sound/music/cmode/towner/CombatInn.ogg'

/datum/job/butler/after_spawn(mob/living/H, mob/M, latejoin)
	. = ..()
	if(ishuman(H) && GLOB.keep_doors.len > 0)
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(know_keep_door_password), H), 50)


/datum/outfit/job/butler/pre_equip(mob/living/carbon/human/H)
	..()
	backpack_contents = list(/obj/item/book/manners = 1)
	mask = /obj/item/clothing/face/spectacles
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE) // A well educated head of servants should at least have skilled literacy level
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/butchering, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/farming, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/music, pick(1,1,2,3), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE) // Privilege of living a life raising nobility. Knows the very basics about riding a mount
		H.change_stat(STATKEY_STR, -1)
		H.change_stat(STATKEY_INT, 2)
		H.change_stat(STATKEY_PER, 1)
		H.change_stat(STATKEY_END, 1)
		ADD_TRAIT(H, TRAIT_KNOWKEEPPLANS, TRAIT_GENERIC)


	if(H.gender == MALE)
		pants = /obj/item/clothing/pants/tights
		shirt = /obj/item/clothing/shirt/undershirt/guard
		shoes = /obj/item/clothing/shoes/nobleboot
		belt = /obj/item/storage/belt/leather/plaquesilver
		beltr = /obj/item/storage/keyring/butler
		beltl = /obj/item/storage/belt/pouch/coins/mid
		armor = /obj/item/clothing/armor/leather/vest/butler
		backr = /obj/item/storage/backpack/satchel

	else
		armor = /obj/item/clothing/shirt/dress/gen/maid
		shirt = /obj/item/clothing/shirt/undershirt
		shoes = /obj/item/clothing/shoes/ridingboots
		cloak = /obj/item/clothing/cloak/apron
		belt = /obj/item/storage/belt/leather/cloth/lady
		beltr = /obj/item/storage/keyring/butler
		beltl = /obj/item/storage/belt/pouch/coins/mid
		backr = /obj/item/storage/backpack/satchel
