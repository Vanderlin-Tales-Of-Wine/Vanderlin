/datum/job/mason
	title = "Mason"
	flag = SK_MASON
	department_flag = SERFS
	faction = "Station"
	total_positions = 2
	spawn_positions = 2

	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Aasimar",
	)
	allowed_sexes = list(MALE, FEMALE)

	tutorial = "There are ancient secrets within stone, something your creed has known since man built upon dirt. Youve pride in your work, youre the only reason this place doesnt fall apart. The King could replace you in a heartbeat, prove to them why youre the Master Mason."

	outfit = /datum/outfit/job/sk_mason
	display_order = MASON_ORDER
	bypass_lastclass = TRUE
	give_bank_account = 8
	min_pq = -50

/datum/outfit/job/sk_mason/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, rand(1,3), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, rand(1,3), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/carpentry, pick(2,2,3), TRUE)
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

	head = /obj/item/clothing/head/brimmed
	armor = /obj/item/clothing/armor/leather/jacket/artijacket
	pants = /obj/item/clothing/pants/trou/artipants
	shirt = /obj/item/clothing/shirt/undershirt/artificer
	shoes = /obj/item/clothing/shoes/simpleshoes
	belt = /obj/item/storage/belt/leather
	beltr = /obj/item/storage/belt/pouch/coins/poor
	beltl = /obj/item/key/artificer
	backl = /obj/item/storage/backpack/backpack
	id = /obj/item/clothing/ring/silver/makers_guild
	backpack_contents = list(/obj/item/weapon/hammer/steel = 1, /obj/item/weapon/chisel = 1, /obj/item/flashlight/flare/torch/lantern, /obj/item/weapon/knife/villager)

	H.change_stat(STATKEY_STR, 1)
	H.change_stat(STATKEY_INT, 2)
	H.change_stat(STATKEY_END, 1)
	H.change_stat(STATKEY_CON, 1)
	H.change_stat(STATKEY_SPD, -1)

	if(H.dna.species.id == "dwarf")
		H.cmode_music = 'sound/music/cmode/combat_dwarf.ogg'
