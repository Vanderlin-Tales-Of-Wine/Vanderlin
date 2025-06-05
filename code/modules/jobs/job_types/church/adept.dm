/datum/job/adept
	title = "Adept"
	tutorial = "You were a convicted criminal, the lowest scum of Vanderlin. \
	Your master, the Inquisitor, saved you from the gallows \
	and has given you true purpose in service to Psydon. \
	You will not let him down."
	flag = MONK
	department_flag = CHURCHMEN
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_SHEPHERD
	faction = FACTION_STATION
	total_positions = 3
	spawn_positions = 2
	min_pq = 5
	bypass_lastclass = TRUE

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_PLAYER_ALL

	outfit = /datum/outfit/job/adept
	advclass_cat_rolls = list(CTAG_ADEPT = 20)
	can_have_apprentices = FALSE
	is_foreigner = TRUE

/datum/outfit/job/adept
	name = "Adept"
	jobtype = /datum/job/adept
	allowed_patrons = list(/datum/patron/psydon)
	job_bitflag = BITFLAG_CHURCH

/datum/outfit/job/adept // Base outfit for Adepts, before loadouts
	shoes = /obj/item/clothing/shoes/boots
	beltr = /obj/item/storage/belt/pouch/coins/poor
	mask = /obj/item/clothing/face/facemask
	pants = /obj/item/clothing/pants/trou/leather
	shirt = /obj/item/clothing/shirt/undershirt/black
	wrists = /obj/item/clothing/neck/psycross/silver

// Brutal Zealot, a class balanced to town guard, with 1 more strength but less intelligence and perception. Axe/Mace and shield focus.
/datum/advclass/adept/bzealot
	name = "Brutal Zealot"
	tutorial = "You are a former thug who has been given a chance to redeem yourself by the Inquisitor. You serve him and Psydon with your physical strength and zeal."
	outfit = /datum/outfit/job/adept/bzealot

	category_tags = list(CTAG_ADEPT)
	cmode_music = 'sound/music/cmode/church/CombatInquisitor.ogg'
	maximum_possible_slots = 1

/datum/outfit/job/adept/bzealot/pre_equip(mob/living/carbon/human/H)
	..()
	//Armor for class
	belt = /obj/item/storage/belt/leather
	armor = /obj/item/clothing/armor/chainmail
	cloak = /obj/item/clothing/cloak/tabard/adept
	neck = /obj/item/clothing/neck/chaincoif
	beltl = /obj/item/weapon/mace/spiked
	backr = /obj/item/weapon/shield/wood/adept
	gloves = /obj/item/clothing/gloves/leather
	backpack_contents = list(/obj/item/storage/keyring/inquisitor = 1, /obj/item/weapon/knife/dagger/psydon = 1)

	//Stats for class
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/firearms, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	H.change_stat(STATKEY_STR, 2)
	H.change_stat(STATKEY_INT, -2)
	H.change_stat(STATKEY_END, 1)
	H.change_stat(STATKEY_CON, 1)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)
	if(H.dna?.species)
		H.dna.species.soundpack_m = new /datum/voicepack/male/warrior() // Lunkhead.


// Reformed Thief, a class balanced to rogue. Axe and crossbow focus.
/datum/advclass/adept/rthief
	name = "Reformed Thief"
	tutorial = "You are a former thief who has been given a chance to redeem yourself by the Inquisitor. You serve him and Psydon with your stealth and cunning."
	outfit = /datum/outfit/job/adept/rthief

	category_tags = list(CTAG_ADEPT)
	cmode_music = 'sound/music/cmode/adventurer/CombatRogue.ogg'
	maximum_possible_slots = 1

/datum/outfit/job/adept/rthief/pre_equip(mob/living/carbon/human/H)
	..()
	//Armor for class
	belt = /obj/item/storage/belt/leather
	armor = /obj/item/clothing/armor/leather/splint
	neck = /obj/item/clothing/neck/gorget
	backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
	backl = /obj/item/ammo_holder/quiver/arrows
	beltl = /obj/item/weapon/mace/cudgel
	pants = /obj/item/clothing/pants/trou/leather
	cloak = /obj/item/clothing/cloak/raincloak/brown
	backpack_contents = list(/obj/item/storage/keyring/inquisitor = 1, /obj/item/weapon/knife/dagger/psydon = 1)

	//Stats for class
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/crossbows, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE) // Bows can be bullshit annoying so they aren't given one immediately. Inquisitor can get them one now!
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 5, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/stealing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/lockpicking, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/firearms, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/traps, 2, TRUE)
	H.change_stat(STATKEY_STR, -1)
	H.change_stat(STATKEY_END, 1)
	H.change_stat(STATKEY_PER, 1)
	H.change_stat(STATKEY_SPD, 2)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)


// Vile Highwayman, utility and ranged focus. Whip and Bow user with a heavy disincentive to get into a direct fight.
/datum/advclass/adept/highwayman
	name = "Vile Renegade"
	tutorial = "You were a former outlaw who has been given a chance to redeem yourself by the Inquisitor. You serve him and Psydon with your survival skills and deadly accuracy."
	outfit = /datum/outfit/job/adept/highwayman

	category_tags = list(CTAG_ADEPT)
	cmode_music = 'sound/music/cmode/towner/CombatGaffer.ogg'
	maximum_possible_slots = 1

/datum/outfit/job/adept/highwayman/pre_equip(mob/living/carbon/human/H)
	..()
	//Armor for class
	belt = /obj/item/storage/belt/leather
	cloak = /obj/item/clothing/cloak/half
	armor = /obj/item/clothing/armor/leather/jacket/leathercoat/black
	head = /obj/item/clothing/head/helmet/leather/inquisitor // A nice swashbuckler hat would go hard.
	neck = /obj/item/clothing/neck/gorget
	beltl = /obj/item/weapon/whip // Great length, they don't need to be next to a person to help in apprehending them.
	backr = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
	backl = /obj/item/ammo_holder/quiver/bolts
	pants = /obj/item/clothing/pants/trou/leather
	backpack_contents = list(/obj/item/lockpick = 1, /obj/item/storage/keyring/inquisitor = 1, /obj/item/weapon/knife/dagger/psydon = 1)

	//Stats for class
	H.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE) // No good armor, cannot dodge, cannot parry with whips/flails. We can keep it at 3.
	H.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
	H.adjust_skillrank(/datum/skill/labor/mathematics, 2, TRUE) // Smart... For a knave.
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/firearms, 1, TRUE)
	H.change_stat(STATKEY_PER, 2)
	H.change_stat(STATKEY_INT, 2)
	H.change_stat(STATKEY_CON, -2)
	H.change_stat(STATKEY_STR, -2) // Not great in a direct fight.
	ADD_TRAIT(H, TRAIT_FORAGER, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)
	if(H.dna?.species)
		H.dna.species.soundpack_m = new /datum/voicepack/male/knight() // We're going with gentleman-thief here.


/datum/outfit/job/adept/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		if(H.mind.has_antag_datum(/datum/antagonist))
			return
		var/datum/antagonist/new_antag = new /datum/antagonist/purishep()
		H.mind.add_antag_datum(new_antag)
		H.set_patron(/datum/patron/psydon)
		H.verbs |= /mob/living/carbon/human/proc/torture_victim
		H.verbs |= /mob/living/carbon/human/proc/faith_test
		if(!H.has_language(/datum/language/oldpsydonic))
			H.grant_language(/datum/language/oldpsydonic)
			to_chat(H, "<span class='info'>I can speak Old Psydonic with ,m before my speech.</span>")
		H.mind?.teach_crafting_recipe(/datum/repeatable_crafting_recipe/reading/confessional)
		GLOB.outlawed_players += H.real_name // Lore

/datum/job/adept/after_spawn(mob/living/carbon/spawned, client/player_client)
	..()
