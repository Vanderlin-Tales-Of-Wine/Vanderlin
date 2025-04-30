/datum/advclass/mercenary/desert_pirate
	name = "Desert Rider"
	tutorial = "A pirate of rakshari origin, hailing from the wast dune-sea of Zybantu. Well trained riders and expirienced archers, these nomads live the life of marauders and raiders, taking what belongs to other settlements and caravans."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Rakshari"
	)
	outfit = /datum/outfit/job/mercenary/desert_pirate
	maximum_possible_slots = 3
	min_pq = 0
	category_tags = list(CTAG_MERCENARY)

	cmode_music = 'sound/music/cmode/unused/combat_desertrider.ogg'

/datum/outfit/job/mercenary/desert_pirate/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		if(H.patron != /datum/patron/misc/penice)
			H.set_patron(/datum/patron/misc/penice)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE) // Little use for climbing, main targets were other caravans and shitty settlements.
		//H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE) Where do you swim in the dunes?
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/traps, 1, TRUE)
		H.change_stat(STATKEY_STR, 1)
		H.change_stat(STATKEY_SPD, 2)
		H.change_stat(STATKEY_END, 1)


	pants = /obj/item/clothing/pants/trou/leather
	beltr = /obj/item/weapon/sword/long/rider //or better /sword/saber(/shalal?) /sword/scimitar?
	if(prob(10))
		backl= /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
		beltl= /obj/item/ammo_holder/quiver/bolts
		H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 1, TRUE)
	else
		if(prob(25))
			backl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve //Maybe longbow, maybe only normal bow?
		else
			backl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
		beltl= /obj/item/ammo_holder/quiver/arrows
		H.mind?.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
	shoes = /obj/item/clothing/shoes/shalal
	gloves = /obj/item/clothing/gloves/angle
	belt = /obj/item/storage/belt/leather/mercenary/shalal
	shirt = /obj/item/clothing/shirt/undershirt/uncolored
	armor = /obj/item/clothing/armor/leather/splint
	backr = /obj/item/storage/backpack/satchel
	head = /obj/item/clothing/neck/keffiyeh/uncolored //For blending in with the sand?
	backpack_contents = list(/obj/item/storage/belt/pouch/coins/poor, /obj/item/weapon/knife/dagger)
	if(!H.has_language(/datum/language/zybantine))
		H.grant_language(/datum/language/zybantine)
		to_chat(H, "<span class='info'>I can speak Zybean with ,z before my speech.</span>")

	H.merctype = 1 //Desert Rider chain, 0 for Desert Rider Medal

	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	// See value trait? As they are (former) pirates
