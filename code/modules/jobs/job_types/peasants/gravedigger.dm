/datum/job/undertaker
	title = "Gravetender"
	tutorial = "As a servant of Necra, you embody the sanctity of her domain, \
	ensuring the dead rest peacefully within the earth. \
	You are the bane of grave robbers and necromancers, \
	and your holy magic brings undead back into Necra's embrace: \
	the only rightful place for lost souls."
	flag = GRAVETENDER
	department_flag = CHURCHMEN
	display_order = JDO_GRAVETENDER
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	faction = FACTION_STATION
	total_positions = 3
	spawn_positions = 3
	min_pq = -10
	bypass_lastclass = TRUE

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_PLAYER_NONHERETICAL
	allowed_patrons = list(/datum/patron/divine/necra)

	outfit = /datum/outfit/job/undertaker
	give_bank_account = TRUE
	cmode_music = 'sound/music/cmode/church/CombatGravekeeper.ogg'

/datum/outfit/job/undertaker
	allowed_patrons = list(/datum/patron/divine/necra)
	job_bitflag = BITFLAG_CHURCH

/datum/outfit/job/undertaker/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/padded/deathshroud
	neck = /obj/item/clothing/neck/psycross/silver/necra
	pants = /obj/item/clothing/pants/trou/leather/mourning
	armor = /obj/item/clothing/shirt/robe/necra
	shoes = /obj/item/clothing/shoes/boots
	belt = /obj/item/storage/belt/leather
	beltl = /obj/item/storage/keyring/gravetender
	beltr = /obj/item/storage/belt/pouch/coins/poor
	backr = /obj/item/weapon/shovel
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE) // these are basically the acolyte skills with a bit of other stuff
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/magic/holy, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/mathematics, 2, TRUE)
		H.change_stat(STATKEY_STR, 1)
		H.change_stat(STATKEY_INT, 2)
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_PER, -1) // similar to acolyte's stats
		H.change_stat(STATKEY_LCK, -1) // Tradeoff for never being cursed when unearthing graves.
	ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC) // Operating with corpses every day.
	ADD_TRAIT(H, TRAIT_GRAVEROBBER, TRAIT_GENERIC) // In case they need to move tombs or anything.

	var/datum/devotion/cleric_holder/C = new /datum/devotion/cleric_holder(H, H.patron)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)
	C.grant_spells(H)
