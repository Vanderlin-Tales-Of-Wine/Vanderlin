/datum/job/stonekeep/nitemaster
	title = "Nitemaster"
	f_title = "Nitematron"
	flag = SK_NITEMAN
	department_flag = NOBLEMEN
	total_positions = 1
	spawn_positions = 1

	allowed_races = list(
		"Humen",
		"Dwarf",
		"Elf",
		"Half-Elf",
		"Dark Elf",
		"Tiefling"
	)

	tutorial = "Even nobles can be disgraced and fall on hard times, despite inheriting a fine bathhouse building. <br>\
	For whatever reason you have traded your reputation for a supply of drugs and nitemaidens to employ and profit from. The licenses can be bought from the Feldsher, or just make a forgery yourself to save money. <br>\
	Some accuse you of have connections with the Rogues and Bandits of the land but surely its just slander..."

	allowed_sexes = list(MALE, FEMALE)
	outfit = /datum/outfit/job/stonekeep/nitemaster
	display_order = NITEMAN_ORDER
	give_bank_account = 120
	cmode_music = 'sound/music/cmode/combat_hellish2.ogg'

/datum/outfit/job/stonekeep/nitemaster/pre_equip(mob/living/carbon/human/H)
	..()

	shirt = /obj/item/clothing/shirt/undershirt/webs
	belt = /obj/item/storage/belt/leather
	beltr = /obj/item/weapon/mace/cudgel
	beltl = /obj/item/storage/keyring/nitemaster
	if(H.gender == FEMALE)
		shoes = /obj/item/clothing/shoes/shortboots
		armor = /obj/item/clothing/shirt/dress/stewarddress
		cloak = /obj/item/clothing/cloak/cape/silk/dark
	if(isdarkelf(H))
		mask = /obj/item/clothing/face/spectacles/delf
	ADD_TRAIT(H, TRAIT_GOODLOVER, TRAIT_GENERIC)
	H.grant_language(/datum/language/thievescant)
	to_chat(H, "<span class='info'>I can gesture in thieves' cant with ,t before my speech.</span>")
	ADD_TRAIT(H, TRAIT_THIEVESGUILD, TRAIT_GENERIC)
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
		H.mind.teach_crafting_recipe(/datum/crafting_recipe/forgery_nitemaiden)
		H.mind.teach_crafting_recipe(/datum/crafting_recipe/forgery_adventurer)
	if(H.gender == MALE)
		head = /obj/item/clothing/head/roguehood/brown
		armor = /obj/item/clothing/armor/leather/jacket/niteman
		pants = /obj/item/clothing/pants/trou/leather
		shoes = /obj/item/clothing/shoes/nobleboot
		if(H.dna?.species)
			if(H.dna.species.id == "human")
				H.dna.species.soundpack_m = new /datum/voicepack/male/zeth()

/*	.................   Unique Nitemaster recipes   ................... */
/datum/crafting_recipe/forgery_nitemaiden
	name = "Forge nitemaiden license"
	time = 4 SECONDS
	req_table = TRUE
	tools = /obj/item/natural/feather
	reqs = list(/obj/item/paper = 1)
	result = /obj/item/paper/certificate/fake_health
	category = CAT_NONE

/datum/crafting_recipe/forgery_adventurer
	name = "Forge adventurer license"
	time = 4 SECONDS
	req_table = TRUE
	tools = /obj/item/natural/feather
	reqs = list(/obj/item/paper = 1)
	result = /obj/item/paper/certificate/adventurer_fake
	category = CAT_NONE
