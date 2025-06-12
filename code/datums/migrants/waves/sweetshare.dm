/datum/migrant_role/sweetshare
	name = "Candyman"
	greet_text = "Who can take a rainbow, wrap it in a sigh. Soak it in the sun, and make a groovy pie? The Candy Man can. \
	Sell your product to those who should imbibe - the poor, the downtrodden, the youth. Get them hooked; stay off of your \
	own supply. You are Baotha's strongest spice-addict."
	outfit = /datum/outfit/job/sweetshare
	grant_lit_torch = TRUE

/datum/outfit/job/sweetshare/pre_equip(mob/living/carbon/human/H)
	..()
	shirt = /obj/item/clothing/shirt/undershirt/black
	mask = /obj/item/clothing/face/spectacles/sglasses
	gloves = /obj/item/clothing/gloves/fingerless
	pants = /obj/item/clothing/pants/trou/leather
	cloak = /obj/item/clothing/cloak/raincloak/mortus
	shoes = /obj/item/clothing/shoes/boots
	backl = /obj/item/storage/backpack/backpack
	belt = /obj/item/storage/belt/leather
	beltr = /obj/item/weapon/knife/cleaver
	beltl = /obj/item/storage/belt/pouch/coins/poor
	backpack_contents = list(/obj/item/reagent_containers/powder/spice = 8, /obj/item/reagent_containers/powder/ozium = 8, /obj/item/reagent_containers/powder/moondust = 8)

	var/prev_real_name = H.real_name
	var/prev_name = H.name
	var/honorary = "Candyman"
	if(H.gender == FEMALE)
		honorary = "Candywoman"
	H.real_name = "[honorary] [prev_real_name]"
	H.name = "[honorary] [prev_name]"

	if(H.mind)
		if(H.patron != /datum/patron/inhumen/baotha)
			H.set_patron(/datum/patron/inhumen/baotha)

		H.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE) // Not a fighter, enough for self-defense
		H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/climbing, 4)
		H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE) // For fleeing
		H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.adjust_skillrank(/datum/skill/craft/alchemy, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.change_stat(STATKEY_SPD, 2)
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_STR, -2)
		H.change_stat(STATKEY_CON, -1)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	H.cmode_music = 'sound/music/cmode/antag/CombatBandit1.ogg'// Temp, song in the works

/datum/migrant_wave/sweetshare
	name = "The Candy Man"
	max_spawns = 1
	shared_wave_type = /datum/migrant_wave/sweetshare
	weight = 7
	roles = list(
		/datum/migrant_role/sweetshare = 1,
	)
	greet_text = "A hooded man comes in, the only thing you can see is the stained teeth he flashes in his smile. He smells of unknown reagents."
