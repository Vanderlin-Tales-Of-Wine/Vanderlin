/datum/job/apothecary
	title = "Apothecary"
	tutorial = "You know every plant growing on these grounds and in the woods like the back of your hand. \
	You are tasked with mixing tinctures and supplying the town and Feldsher with medicine for pain... or pleasure. \
	For a price, of course. \
	You have been known to kill men who cross you or your work-partner."
	flag = NIGHTMAN
	department_flag = NOBLEMEN
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_APOTHECARY
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	min_pq = 1
	bypass_lastclass = TRUE

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_PLAYER_NONEXOTIC
	outfit = /datum/outfit/job/apothecary
	give_bank_account = 100
	cmode_music = 'sound/music/cmode/towner/CombatBeggar.ogg'

/datum/outfit/job/apothecary
	job_bitflag = BITFLAG_ROYALTY | BITFLAG_CONSTRUCTOR

/datum/outfit/job/apothecary/pre_equip(mob/living/carbon/human/H)
	..()
	armor = /obj/item/clothing/armor/gambeson/apothecary
	shoes = /obj/item/clothing/shoes/apothboots
	shirt = /obj/item/clothing/shirt/apothshirt
	pants = /obj/item/clothing/pants/trou/apothecary
	gloves = /obj/item/clothing/gloves/leather/apothecary
	belt = /obj/item/storage/belt/leather
	beltr = /obj/item/storage/keyring/apothecary
	beltl = /obj/item/storage/belt/pouch/coins/mid
	ADD_TRAIT(H, TRAIT_LEGENDARY_ALCHEMIST, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_FORAGER, TRAIT_GENERIC)
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/alchemy, 5, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/farming, 3, TRUE)
		H.change_stat(STATKEY_STR, -1)
		H.change_stat(STATKEY_INT, 1)

	if(H.gender == MALE)
		if(H.dna?.species)
			if(H.dna.species.id == "human")
				H.dna.species.soundpack_m = new /datum/voicepack/male/zeth()
