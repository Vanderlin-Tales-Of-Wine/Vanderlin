/datum/advclass/combat/monk
	name = "Monk"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_PLAYER_NONHERETICAL
	tutorial = "A traveling monk of either Ravox or Psydon, unmatched in unarmed combat and with an unwavering devotion to Justice."

	outfit = /datum/outfit/job/adventurer/monk
	min_pq = 0
	category_tags = list(CTAG_ADVENTURER)
	vampcompat = FALSE
	allowed_patrons = list(/datum/patron/divine/ravox, /datum/patron/psydon)

/datum/outfit/job/adventurer/monk

/datum/outfit/job/adventurer/monk/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguehood/brown
	shoes = /obj/item/clothing/shoes/shortboots
	cloak = /obj/item/clothing/cloak/raincloak/furcloak/brown
	armor = /obj/item/clothing/shirt/robe/plain
	wrists = /obj/item/clothing/wrists/bracers/leather
	belt = /obj/item/storage/belt/leather/rope
	beltr = /obj/item/storage/belt/pouch/coins/poor
	backl = /obj/item/storage/backpack/backpack
	backr = /obj/item/weapon/polearm/woodstaff

	switch(H.patron?.type) // This probably isn't the cleanest way of doing this, but everything else didn't work music/godwise. Don't yell at me
		if(/datum/patron/divine/ravox)
			neck = /obj/item/clothing/neck/psycross/silver/ravox
			H.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'
		if(/datum/patron/psydon)
			neck = /obj/item/clothing/neck/psycross/silver
			H.cmode_music = 'sound/music/cmode/church/CombatInquisitor.ogg'
		if(/datum/patron/psydon/progressive)
			neck = /obj/item/clothing/neck/psycross/silver
			H.cmode_music = 'sound/music/cmode/church/CombatInquisitor.ogg'
		else // Failsafe. Psydon or Ravox. If for some reason allowed patron fucks up / triumph buy, they get set to Ravox.
			H.set_patron(/datum/patron/divine/ravox)
			neck = /obj/item/clothing/neck/psycross/silver/ravox
			H.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'

	H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 5, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, pick(1,1,2), TRUE) // Wood staff
	H.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, pick(2,2,3), TRUE)

	H.change_stat(STATKEY_STR, 3)
	H.change_stat(STATKEY_CON, 2)
	H.change_stat(STATKEY_END, 2)
	H.change_stat(STATKEY_PER, -1)
	H.change_stat(STATKEY_SPD, 1)

	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)


