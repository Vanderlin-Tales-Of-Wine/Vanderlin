/datum/job/page
	title = "Page"
	tutorial = "You've shown promise, both physically and mentally, and now you've been taken in by the knights of the realm to both serve and learn.\
	Though you may be a knight one day, it's mostly doing what you're told so far..."
	flag = page
	department_flag = APPRENTICES
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	faction = FACTION_STATION
	total_positions = 2
	spawn_positions = 2

	allowed_races = RACES_PLAYER_NONDISCRIMINATED
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_CHILD)

	outfit = /datum/outfit/job/page
	display_order = JDO_page
	give_bank_account = TRUE
	min_pq = 0
	bypass_lastclass = TRUE
	selection_color = "#304529"
	advclass_cat_rolls = list(CTAG_page = 20)
	can_have_apprentices = FALSE


/datum/outfit/job/page
	shirt = /obj/item/clothing/shirt/undershirt/guard
	pants = /obj/item/clothing/pants/trou/leather
	shoes = /obj/item/clothing/shoes/boots
	belt = /obj/item/storage/belt/leather
	beltl = /obj/item/storage/keyring/manorguard
	armor = /obj/item/clothing/armor/gambeson/light

/datum/job/page/after_spawn(mob/living/carbon/spawned, client/player_client)
	. = ..()

/datum/advclass/page/lancer
	name = "Pikeman Page"
	tutorial = "You were chosen as a page, a knight's servant, and chose the pike as your weapon of choice. Perhaps your future holds you as a man-at-arms, or a knight in shining armor, if you survive to adulthood, that is."
	outfit = /datum/outfit/job/page/lancer

	category_tags = list(CTAG_page)

/datum/outfit/job/page/lancer/pre_equip(mob/living/carbon/human/H)
	r_hand = /obj/item/weapon/polearm/spear
	gloves = /obj/item/clothing/gloves/leather
	wrists = /obj/item/clothing/wrists/bracers/leather
	backr = /obj/item/storage/backpack/satchel
	cloak = /obj/item/clothing/cloak/stabard/guard
	backpack_contents = list(/obj/item/storage/belt/pouch/coins/poor = 1, /obj/item/clothing/neck/chaincoif = 1, /obj/item/weapon/hammer/iron = 1,)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/weaponsmithing, 1, TRUE)  // For repairing your good Royal Guards equipment
		H.mind.adjust_skillrank(/datum/skill/craft/armorsmithing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
		H.change_stat(STATKEY_STR, 1)
		H.change_stat(STATKEY_PER, 1)
		H.change_stat(STATKEY_CON, 1)
		H.change_stat(STATKEY_INT, 1)
		H.change_stat(STATKEY_SPD, 1)
	if(H.gender == MALE && H.dna?.species)
		H.dna.species.soundpack_m = new /datum/voicepack/male/page()

/datum/advclass/page/footman
	name = "Footman Page"
	tutorial = "You were chosen as a page, a knight's servant, and chose the sword as your weapon of choice. Perhaps your future holds you as a man-at-arms, or a knight in shining armor, if you survive to adulthood, that is."
	outfit = /datum/outfit/job/page/footman

	category_tags = list(CTAG_page)

/datum/outfit/job/page/footman/pre_equip(mob/living/carbon/human/H)
	gloves = /obj/item/clothing/gloves/leather
	wrists = /obj/item/clothing/wrists/bracers/leather
	backr = /obj/item/storage/backpack/satchel
	beltr = /obj/item/weapon/sword
	cloak = /obj/item/clothing/cloak/tabard/knight/guard
	backpack_contents = list(/obj/item/storage/belt/pouch/coins/poor = 1, /obj/item/clothing/neck/chaincoif = 1, /obj/item/weapon/hammer/iron = 1,)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/weaponsmithing, 1, TRUE)  // For repairing your good Royal Guards equipment
		H.mind.adjust_skillrank(/datum/skill/craft/armorsmithing, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
		H.change_stat(STATKEY_STR, 1)
		H.change_stat(STATKEY_PER, 1)
		H.change_stat(STATKEY_CON, 1)
		H.change_stat(STATKEY_INT, 1)
		H.change_stat(STATKEY_SPD, 1)
	if(H.gender == MALE && H.dna?.species)
		H.dna.species.soundpack_m = new /datum/voicepack/male/page()

/datum/advclass/page/skirmisher
	name = "Bowman Page"
	tutorial = "You were chosen as a page, a knight's servant, and chose the bow as your weapon of choice. Perhaps your future holds you as a man-at-arms, or a knight in shining armor, if you survive to adulthood, that is."
	outfit = /datum/outfit/job/page/skirmisher

	category_tags = list(CTAG_page)

/datum/outfit/job/page/skirmisher/pre_equip(mob/living/carbon/human/H)
	beltr = /obj/item/ammo_holder/quiver/arrows
	backl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
	gloves = /obj/item/clothing/gloves/leather
	wrists = /obj/item/clothing/wrists/bracers/leather
	backr = /obj/item/storage/backpack/satchel
	cloak = /obj/item/clothing/cloak/stabard/surcoat/guard
	backpack_contents = list(/obj/item/weapon/knife/dagger/steel = 1, /obj/item/storage/belt/pouch/coins/poor = 1, /obj/item/clothing/neck/chaincoif = 1, /obj/item/weapon/hammer/iron = 1,)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/weaponsmithing, 1, TRUE)  // For repairing your good Royal Guards equipment
		H.mind.adjust_skillrank(/datum/skill/craft/armorsmithing, 1, TRUE)
		H.change_stat(STATKEY_STR, 1)
		H.change_stat(STATKEY_PER, 1)
		H.change_stat(STATKEY_CON, 1)
		H.change_stat(STATKEY_INT, 1)
		H.change_stat(STATKEY_SPD, 1)
	if(H.gender == MALE && H.dna?.species)
		H.dna.species.soundpack_m = new /datum/voicepack/male/page()
