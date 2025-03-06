/datum/job/roguetown/niteman
	title = "Niteman"
	flag = SK_NITEMAN
	department_flag = NOBLEMEN
	faction = "Station"
	total_positions = 1
	spawn_positions = 1

	allowed_races = list(
		"Humen",
		"Dwarf",
		"Elf",
		"Half-Elf"
	)

	tutorial = "Even nobles can be disgraced and fall on hard times, despite inheriting a fine bathhouse building. <br>\
	For whatever reason you have traded your reputation for a supply of drugs and nitemaidens to employ and profit from. The licenses can be bought from the Feldsher, or just make a forgery yourself to save money. <br>\
	Some accuse you of have connections with the Rogues and Bandits of the land but surely its just slander..."

	allowed_sexes = list(MALE)
	outfit = /datum/outfit/job/roguetown/niteman
	display_order = NITEMAN_ORDER
	give_bank_account = 120
	min_pq = 0
	bypass_lastclass = TRUE

/datum/outfit/job/roguetown/niteman/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguehood/brown
	armor = /obj/item/clothing/armor/leather/jacket/niteman
	shirt = /obj/item/clothing/shirt/undershirt/webs
	pants = /obj/item/clothing/pants/trou/leather
	shoes = /obj/item/clothing/shoes/nobleboot
// 	belt = /obj/item/storage/belt/leather/nitemaster ROGTODO
	beltr = /obj/item/weapon/knife/dagger/steel/special
//	beltl = /obj/item/keyring/niteman	ROGTODO
	ADD_TRAIT(H, TRAIT_GOODLOVER, TRAIT_GENERIC)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.change_stat("speed", 1)
		H.change_stat("intelligence", 1)
		H.change_stat("perception", 2)
	H.mind.teach_crafting_recipe(/datum/crafting_recipe/forgery_bathmaiden)
	if(H.dna?.species)
		if(H.dna.species.id == "human")
			H.dna.species.soundpack_m = new /datum/voicepack/male/zeth()

/*	.................   Unique Nitemaster recipes   ................... */
/datum/crafting_recipe/forgery_bathmaiden
	name = "Forge nitemaiden license"
	time = 4 SECONDS
	reqs = list(/obj/item/paper = 1,
		/obj/item/natural/feather = 1)
	result = /obj/item/paper/feldsher_certificate/fake
	category = CAT_NONE

