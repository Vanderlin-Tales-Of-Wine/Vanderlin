/datum/job/men_at_arms
	title = "Men-at-arms"
	tutorial = "Like a hound on a leash, you stand vigilant for your masters. \
	You live better than the rest of the taffers in this kingdom-- \
	infact, you take shifts manning the gate with your brethren, \
	keeping the savages out, keeping the shit-covered knaves away from your foppish superiors. \
	It will be a cold day in hell when you and your compatriots are slain, and nobody in this town will care. \
	The nobility needs good men, and they only come in a pair of pairs."
	flag = WATCHMAN
	department_flag = GARRISON
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_MENATARMS
	faction = FACTION_STATION
	total_positions = 4
	spawn_positions = 4
	min_pq = 6
	bypass_lastclass = TRUE

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_PLAYER_NONDISCRIMINATED

	outfit = /datum/outfit/job/watchman
	advclass_cat_rolls = list(CTAG_MENATARMS = 20)
	cmode_music = 'sound/music/cmode/garrison/CombatManAtArms.ogg'
	give_bank_account = 15
	min_pq = 6

/datum/outfit/job/watchman
	job_bitflag = BITFLAG_GARRISON

/datum/outfit/job/watchman/pre_equip(mob/living/carbon/human/H)
	. = ..()
	wrists = /obj/item/clothing/wrists/bracers/leather
	pants = /obj/item/clothing/pants/trou/leather/guard
	shoes = /obj/item/clothing/shoes/boots
	belt = /obj/item/storage/belt/leather
	beltl = /obj/item/storage/keyring/manorguard

/datum/job/men_at_arms/after_spawn(mob/living/carbon/spawned, client/player_client)
	..()

/datum/advclass/menatarms/watchman_pikeman
	name = "Pikeman Men-At-Arms"
	tutorial = "You once warded the town, beating the poor and killing the senseless. \
	Now you get to stare at them in the eyes, watching as they bleed, \
	exanguinated personally by one of the Monarch's best. \
	You are poor, and your belly is yet full."
	outfit = /datum/outfit/job/watchman/pikeman

	category_tags = list(CTAG_MENATARMS)

/datum/outfit/job/watchman/pikeman/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/helmet/kettle
	cloak = /obj/item/clothing/cloak/stabard/guard
	armor = /obj/item/clothing/armor/cuirass
	shirt = /obj/item/clothing/armor/chainmail
	neck = /obj/item/clothing/neck/chaincoif/iron
	gloves = /obj/item/clothing/gloves/chain
	beltr = /obj/item/weapon/sword/arming
	backr = /obj/item/weapon/polearm/spear/billhook
	backl = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/weapon/knife/dagger/steel/special)
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.change_stat(STATKEY_STR, 2)
		H.change_stat(STATKEY_PER, -1)
		H.change_stat(STATKEY_END, -1)
		H.change_stat(STATKEY_CON, 1)
		H.change_stat(STATKEY_SPD, 1)
		H.verbs |= /mob/proc/haltyell
		ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)

/datum/advclass/menatarms/watchman_swordsmen
	name = "Fencer Men-At-Arms"
	tutorial = "You once warded the town, beating the poor and killing the senseless. \
	You were quite a good dancer, you've blended that skill with your blade- \
	exanguinated personally by one of the Monarch's best. \
	You are poor, and your belly is yet full."
	outfit = /datum/outfit/job/watchman/swordsmen
	category_tags = list(CTAG_MENATARMS)

/datum/outfit/job/watchman/swordsmen/pre_equip(mob/living/carbon/human/H)
	..()
	head = pick(/obj/item/clothing/head/roguehood/guard, /obj/item/clothing/head/roguehood/guardsecond)
	cloak = /obj/item/clothing/cloak/stabard/guard
	armor = /obj/item/clothing/armor/leather/advanced
	shirt = /obj/item/clothing/armor/gambeson
	neck = /obj/item/clothing/neck/gorget
	gloves = /obj/item/clothing/gloves/chain
	beltr = /obj/item/weapon/sword/rapier
	backl = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/weapon/knife/dagger/steel/special)
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_SPD, 2)
		ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)
		H.verbs |= /mob/proc/haltyell

/datum/advclass/menatarms/watchman_ranger
	name = "Archer Men-At-Arms"
	tutorial = "You once warded the town, beating the poor and killing the senseless. \
	Now you stare at them from above, raining hell down upon the knaves and the curs that see you a traitor. \
	You are poor, and your belly is yet full."
	outfit = /datum/outfit/job/watchman/ranger

	category_tags = list(CTAG_MENATARMS)

/datum/outfit/job/watchman/ranger/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/helmet/kettle
	cloak = /obj/item/clothing/cloak/stabard/guard
	armor = /obj/item/clothing/armor/leather/hide
	shirt = /obj/item/clothing/armor/gambeson/heavy
	beltr = /obj/item/weapon/mace/cudgel
	neck = /obj/item/clothing/neck/chaincoif/iron
	gloves = /obj/item/clothing/gloves/leather
	backpack_contents = list(/obj/item/weapon/knife/dagger/steel/special)
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/bows, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.change_stat(STATKEY_STR, 1)
		H.change_stat(STATKEY_PER, 2)
		H.change_stat(STATKEY_END, -2)
		H.change_stat(STATKEY_SPD, 1)
		H.verbs |= /mob/proc/haltyell
		ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
		var/weapontypec = pickweight(list("Bow" = 6, "Crossbow" = 4)) // Rolls for either a bow or a Crossbow
		switch(weapontypec)
			if("Bow")
				backl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/long
				backr = /obj/item/ammo_holder/quiver/arrows
			if("Crossbow")
				backl = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
				backr = /obj/item/ammo_holder/quiver/bolts
