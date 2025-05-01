/datum/job/artificer
	title = "Artificer"
	tutorial = "You are one of the greatest minds of Heartfelt- an artificer, an engineer. \
	You will build the future, regardless of what superstition the more mystical minded may spout. \
	You know your machines' inner workings as well as you do stone, down to the last cog."
	flag = ARTIFICER
	department_flag = SERFS
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_ARTIFICER
	faction = FACTION_STATION
	total_positions = 2
	spawn_positions = 2
	min_pq = -50
	bypass_lastclass = TRUE

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_PLAYER_ALL

	outfit = /datum/outfit/job/artificer
	give_bank_account = 8

/datum/outfit/job/artificer
	job_bitflag = BITFLAG_CONSTRUCTOR

/datum/outfit/job/artificer/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, rand(1,3), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, rand(1,3), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/lumberjacking, pick(1,1,2), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/masonry, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/engineering, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/mining, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/smelting, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)

	head = /obj/item/clothing/head/articap
	armor = /obj/item/clothing/armor/leather/jacket/artijacket
	pants = /obj/item/clothing/pants/trou/artipants
	shirt = /obj/item/clothing/shirt/undershirt/artificer
	shoes = /obj/item/clothing/shoes/simpleshoes/buckle
	belt = /obj/item/storage/belt/leather
	beltr = /obj/item/storage/belt/pouch/coins/mid
	beltl = /obj/item/storage/keyring/artificer
	mask = /obj/item/clothing/face/goggles
	backl = /obj/item/storage/backpack/backpack
	ring = /obj/item/clothing/ring/silver/makers_guild
	backpack_contents = list(/obj/item/weapon/hammer/steel = 1, /obj/item/flashlight/flare/torch/lantern = 1, /obj/item/weapon/knife/villager = 1, /obj/item/weapon/chisel = 1)

	H.change_stat(STATKEY_STR, 1)
	H.change_stat(STATKEY_INT, 2)
	H.change_stat(STATKEY_END, 1)
	H.change_stat(STATKEY_CON, 1)
	H.change_stat(STATKEY_SPD, -1)

	if(H.dna.species.id == "dwarf")
		head = /obj/item/clothing/head/helmet/leather/minershelm
		H.cmode_music = 'sound/music/cmode/combat_dwarf.ogg'
