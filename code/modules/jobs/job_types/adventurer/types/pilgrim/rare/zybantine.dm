/datum/advclass/pilgrim/rare/zybantine
	name = "Zybantine Emir"
	tutorial = "An Emir hailing from the Zybantu Ziggurat, here on business for the Mercator's Guild to Vanderlin."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Rakshari",
		"Elf",
		"Half-Elf",
		"Dwarf"
	)
	outfit = /datum/outfit/job/adventurer/zybantine
	category_tags = list(CTAG_PILGRIM)
	maximum_possible_slots = 1
	pickprob = 30
	min_pq = 0

	cmode_music = 'sound/music/cmode/adventurer/CombatOutlander.ogg'

/datum/outfit/job/adventurer/zybantine/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/shalal
	gloves = /obj/item/clothing/gloves/leather
	head = /obj/item/clothing/head/crown/circlet
	cloak = /obj/item/clothing/cloak/raincloak/purple
	armor = /obj/item/clothing/armor/gambeson/arming
	belt = /obj/item/storage/belt/leather/shalal
	beltl = /obj/item/weapon/sword/sabre/shalal
	beltr = /obj/item/flashlight/flare/torch/lantern
	backr = /obj/item/storage/backpack/satchel
	ring = /obj/item/clothing/ring/gold/guild_mercator
	shirt = /obj/item/clothing/shirt/tunic/purple
	pants = /obj/item/clothing/pants/trou/leather
	neck = /obj/item/clothing/neck/shalal/emir
	backpack_contents = list(/obj/item/storage/belt/pouch/coins/veryrich)
	if(H.gender == FEMALE)
//		armor = /obj/item/clothing/armor/leather/jacket/silk_coat
		shirt = /obj/item/clothing/shirt/dress/silkdress/black
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/music, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)
		var/prev_real_name = H.real_name
		var/prev_name = H.name
		var/honorary = "Emir"
		if(H.gender == FEMALE)
			honorary = "Amirah"
		H.real_name = "[honorary] [prev_real_name]"
		H.name = "[honorary] [prev_name]"
		if(!H.has_language(/datum/language/zybantine))
			H.grant_language(/datum/language/zybantine)
			to_chat(H, "<span class='info'>I can speak Zybean with ,z before my speech.</span>")
		H.change_stat(STATKEY_INT, 1)
		H.change_stat(STATKEY_END, 2)
		ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_FOREIGNER, TRAIT_GENERIC)
