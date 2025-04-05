/datum/job/town_elder
	title = "Town Elder"

	tutorial = "You were once a wanderer, an unremarkable soul who, alongside your old adventuring party, carved your name into history.\
	Now, the days of adventure are long past. You sit as the town's beloved elder; while the crown may rule from afar, the people\
	look to you to settle disputes, mend rifts, and keep the true peace in town. Not every conflict must end in bloodshed,\
	but when it must, you will do what is necessary, as you always have."
	flag = TOWN_ELDER
	department_flag = GARRISON
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_CHIEF
	faction = FACTION_STATION
	total_positions = 1
	spawn_positions = 1
	min_pq = 10 // Requires knowledge and good rp for the classes.
	bypass_lastclass = TRUE
	spells = list(/obj/effect/proc_holder/spell/self/convertrole/town_militia)
	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD, AGE_IMMORTAL)
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Aasimar"
	)


	advclass_cat_rolls = list(CTAG_TOWN_ELDER = 20)
	give_bank_account = 50
	can_have_apprentices = FALSE



/datum/job/town_elder/after_spawn(mob/living/spawned, client/player_client)
	. = ..()
	var/mob/living/carbon/human/H = spawned
	H.advsetup = 1
	H.invisibility = INVISIBILITY_MAXIMUM
	H.become_blind("advsetup")
	if(istype(H.cloak, /obj/item/clothing/cloak/half/guard))
		var/obj/item/clothing/S = H.cloak
		var/index = findtext(H.real_name, " ")
		if(index)
			index = copytext(H.real_name, 1,index)
		if(!index)
			index = H.real_name
		S.name = "Retired guard's half cloak ([index])"



/mob/living/carbon/human/proc/townannouncement()
	set name = "Announcement"
	set category = "Town Elder"
	if(stat)
		return
	var/inputty = input("Make an announcement", "VANDERLIN") as text|null
	if(inputty)
		if(!istype(get_area(src), /area/rogue/indoors/town/tavern))
			to_chat(src, "<span class='warning'>I need to do this from the drunken saiga tavern.</span>")
			return FALSE
		priority_announce("[inputty]", title = "[src.real_name], The Town Elder Speaks", sound = 'sound/misc/bell.ogg')
		src.log_talk("[TIMETOTEXT4LOGS] [inputty]", LOG_SAY, tag="Town Elder announcement")
		



/obj/effect/proc_holder/spell/self/convertrole/town_militia
	name = "Recruit Militia"
	new_role = "Town Militiaman"
	overlay_state = "recruit_guard"
	recruitment_faction = "Garrison"
	recruitment_message = "Join the Town Militia, %RECRUIT!"
	accept_message = "I swear fealty to protect the town!"
	refuse_message = "I refuse."

/datum/job/militia //just used to change the title
	title = "Town Militiaman"
	f_title = "Town Militiawoman"
	flag = GUARDSMAN
	department_flag = GARRISON
	faction = FACTION_STATION
	total_positions = 0
	spawn_positions = 0
	display_order = JDO_CITYWATCHMEN

/datum/advclass/town_elder/mayor
	name = "Mayor"

	tutorial = "You have spent decades immersed in politics, mediating between the people and the crown. Your skills range from high-level diplomacy to extensive knowledge of trade and commerce. In recognition of your expertise, the crown has granted you nobility and the esteemed title of Mayor. Use it wisely, after all, aren’t you serving the people?"
	outfit = /datum/outfit/job/town_elder/mayor

	category_tags = list(CTAG_TOWN_ELDER)

// Mayor start with slightly changes, they were turned noble and got more money, also highly skilled in merchant skills.



/datum/outfit/job/town_elder/mayor/pre_equip(mob/living/carbon/human/H)
	
	
	H.verbs |= /mob/living/carbon/human/proc/townannouncement
	pants = /obj/item/clothing/pants/trou/leather
	head = /obj/item/clothing/head/tophat
	armor = /obj/item/clothing/armor/leather/vest/winterjacket
	shirt = /obj/item/clothing/shirt/undershirt/fancy
	shoes = /obj/item/clothing/shoes/boots
	gloves = /obj/item/clothing/gloves/leather/black
	id = /obj/item/clothing/ring/gold/toper
	backl = /obj/item/storage/backpack/satchel
	cloak = /obj/item/clothing/cloak/raincloak/furcloak/black
	neck = /obj/item/storage/belt/pouch/coins/veryrich
	belt = /obj/item/storage/belt/leather/plaquesilver
	beltr = /obj/item/storage/keyring/elder
	beltl = /obj/item/flashlight/flare/torch/lantern
	r_hand = /obj/item/weapon/polearm/woodstaff/quarterstaff
	if(H.mind)

		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/mathematics, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)

		H.change_stat(STATKEY_STR, -1)
		H.change_stat(STATKEY_PER, 2)
		H.change_stat(STATKEY_END, 1)
		H.change_stat(STATKEY_INT, 2)

		if(H.age == AGE_OLD)
			H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/labor/mathematics, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
			H.change_stat(STATKEY_STR, -1)
			H.change_stat(STATKEY_PER, 1)
			H.change_stat(STATKEY_INT, 1)

	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_SEEPRICES, type)






/datum/advclass/town_elder/retired_city_watchmen
	name = "Retired City Watchmen"

	tutorial = "You were once a Watchman who endured the Goblin War and countless bandit attacks, shedding blood and tears to defend the town. But after taking an arrow to the knee, the crown granted you the right to retire. Now, you spend your days training new watchmen and lending a hand to the guard in times of need."
	outfit = /datum/outfit/job/town_elder/retired_city_watchmen

	// Retired City watchmen, better in terms of skills but retired due to an arrow to their knee, heavy speed debuff.

	category_tags = list(CTAG_TOWN_ELDER)


/datum/outfit/job/town_elder/retired_city_watchmen/pre_equip(mob/living/carbon/human/H)

	H.verbs |= /mob/living/carbon/human/proc/townannouncement
	pants = /obj/item/clothing/pants/trou/leather/guard
	head = /obj/item/clothing/head/helmet/townwatch/alt
	armor = /obj/item/clothing/armor/chainmail/hauberk
	shirt = /obj/item/clothing/armor/gambeson
	shoes = /obj/item/clothing/shoes/boots
	cloak = /obj/item/clothing/cloak/half/guard
	gloves = /obj/item/clothing/gloves/leather
	neck = /obj/item/clothing/neck/gorget
	backr = /obj/item/weapon/shield/heater
	backl = /obj/item/storage/backpack/satchel
	belt = /obj/item/storage/belt/leather
	beltr = /obj/item/storage/keyring/former_city_watchmen
	beltl = /obj/item/flashlight/flare/torch/lantern
	r_hand = /obj/item/weapon/mace/warhammer/steel
	backpack_contents = list(/obj/item/storage/belt/pouch/coins/mid = 1)
	if(H.mind)

		H.cmode_music = 'sound/music/cmode/garrison/CombatGarrison.ogg'
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/mathematics, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/shields, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)

		H.change_stat(STATKEY_STR, 3)
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_CON, 2)
		H.change_stat(STATKEY_SPD, -2) // Arrow to the knee, low mobility

		if(H.age == AGE_OLD)
			H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)
			H.mind.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
			H.change_stat(STATKEY_SPD, -1) // They got older and it is even worse now.
			H.change_stat(STATKEY_STR, 1)
			H.change_stat(STATKEY_INT, 2)

		H.verbs |= /mob/proc/haltyell

	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC) // Went through alot in the Goblin War and Bandit Attacks



/datum/advclass/town_elder/master_of_crafts_and_labor
	name = "Master of Crafts and Labor"

	tutorial = "You were one of the hardest-working individuals in the city, there isn’t a single job you haven’t done. From farming and butchery to alchemy, blacksmithing, cooking, and even medicine, your vast knowledge has made you a guiding light for the people. Recognizing your wisdom and experience, the townsfolk turned to you for guidance. Now, as the Master of Crafts and Labor, you oversee and aid all who contribute to the city's survival. Lead them well."
	outfit = /datum/outfit/job/town_elder/master_of_crafts_and_labor

	//A Job meant to guide and help new players in multiple areas heavy RNG so it can range from Average to Master.

	category_tags = list(CTAG_TOWN_ELDER)


/datum/outfit/job/town_elder/master_of_crafts_and_labor/pre_equip(mob/living/carbon/human/H)

	H.verbs |= /mob/living/carbon/human/proc/townannouncement
	head = /obj/item/clothing/head/hatblu
	armor = /obj/item/clothing/armor/leather/vest/random
	pants = /obj/item/clothing/pants/trou
	shirt = /obj/item/clothing/shirt/undershirt/random
	shoes = /obj/item/clothing/shoes/boots/leather
	belt = /obj/item/storage/belt/leather
	beltr = /obj/item/weapon/hammer/steel
	beltl = /obj/item/flashlight/flare/torch/lantern
	backr = /obj/item/weapon/pick/paxe
	backl = /obj/item/storage/backpack/backpack
	backpack_contents = list(/obj/item/storage/belt/pouch/coins/mid = 1, /obj/item/weapon/knife/hunting = 1, /obj/item/storage/keyring/master_of_crafts_and_labor = 1)

	if(H.mind)

		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/mathematics, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE) // Heavy worker
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)

		H.mind?.adjust_skillrank(/datum/skill/labor/mining, pick(2,3,4), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/lumberjacking,pick(2,3,4),TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/masonry, pick(2,3,4), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, pick(2,3,4), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/carpentry, pick(2,3,4), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/engineering, pick(2,3,4), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/smelting, pick(2,3,4), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, pick(2,3,4), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/farming, pick(2,3,4), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, pick(2,3,4), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/tanning, pick(2,3,4), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/butchering, pick(2,3,4), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/labor/taming, pick(2,3,4), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/alchemy, pick(2,3,4), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/blacksmithing, pick(2,3,4), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/armorsmithing, pick(2,3,4) ,TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/weaponsmithing, pick(2,3,4) ,TRUE)

		H.change_stat(STATKEY_STR, 1)
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_INT, 2)


		if(H.age == AGE_OLD)
			H.mind?.adjust_skillrank(/datum/skill/labor/mining, pick(0,0,1), TRUE)
			H.mind?.adjust_skillrank(/datum/skill/labor/lumberjacking,pick(0,0,1), TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/masonry, pick(0,0,1), TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/crafting, pick(0,0,1), TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/carpentry, pick(0,0,1), TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/engineering, pick(0,0,1), TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/smelting, pick(0,0,1), TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/sewing, pick(0,0,1), TRUE)
			H.mind?.adjust_skillrank(/datum/skill/labor/farming, pick(0,0,1), TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/medicine, pick(0,0,1), TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/tanning, pick(0,0,1), TRUE)
			H.mind?.adjust_skillrank(/datum/skill/labor/butchering, pick(0,0,1), TRUE)
			H.mind?.adjust_skillrank(/datum/skill/labor/taming, pick(0,0,1),TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/alchemy, pick(0,0,1), TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/blacksmithing, pick(0,0,1), TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/armorsmithing, pick(0,0,1), TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/weaponsmithing, pick(0,0,1), TRUE)

			H.change_stat(STATKEY_END, 1)
			H.change_stat(STATKEY_INT, 1)


		ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_SEEDKNOW, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_MALUMFIRE, TRAIT_GENERIC)


/datum/advclass/town_elder/twilight_veil
	name = "Twilight Veil"

	tutorial = "You were once a master thief, one of the finest in the Thieves' Guild. Vaults, merchants, nobles, none were beyond your reach, and for years, none could catch you. But times have changed. The city struggles, corruption festers, and people suffer under those who hoard wealth and power. You still walk in the shadows, but now your targets are chosen carefully, not for personal gain, but to keep the balance. Some call you a criminal, others a hero. Either way, your hands are never idle. Can a thief who steals for others ever truly be free?"
	outfit = /datum/outfit/job/town_elder/twilight_veil

	//Master Thief that left the thieves guild and uses their power to help and guide the town.

	category_tags = list(CTAG_TOWN_ELDER)


/datum/outfit/job/town_elder/twilight_veil/pre_equip(mob/living/carbon/human/H)

	H.verbs |= /mob/living/carbon/human/proc/townannouncement
	pants = /obj/item/clothing/pants/trou/leather
	armor = /obj/item/clothing/armor/leather/splint
	shirt = /obj/item/clothing/shirt/undershirt/black
	shoes = /obj/item/clothing/shoes/boots
	gloves = /obj/item/clothing/gloves/leather
	neck = /obj/item/clothing/neck/gorget
	backl = /obj/item/storage/backpack/satchel
	belt = /obj/item/storage/belt/leather
	beltr = /obj/item/storage/keyring/elder
	beltl = /obj/item/flashlight/flare/torch/lantern
	backpack_contents = list(/obj/item/storage/belt/pouch/coins/mid = 1, /obj/item/weapon/knife/dagger/steel = 2, /obj/item/lockpickring/mundane = 1)

	if(H.mind)
		H.cmode_music = 'sound/music/cmode/adventurer/CombatRogue.ogg'
		H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 4, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 5, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/stealing, 5, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking,4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/traps, 3, TRUE)

		H.change_stat(STATKEY_STR, -1)
		H.change_stat(STATKEY_PER, 1)
		H.change_stat(STATKEY_END, 1)
		H.change_stat(STATKEY_SPD, 3)
		H.grant_language(/datum/language/thievescant)

		if(H.age == AGE_OLD)

			H.mind.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/craft/traps, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/stealing, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking,1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)

			H.change_stat(STATKEY_PER, 1)
			H.change_stat(STATKEY_END, 1)

		ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_LIGHT_STEP, TRAIT_GENERIC)


/datum/outfit/job/town_elder/twilight_veil/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	..()
	// Give them their cloak- as well as the ability to choose what color they want.
	var/list/thiefcloak_colors = list(\
		// Red Colors
		"Fyritius Dye"	="#b47011",\
		"Winestain Red"	="#6b3737",\
		"Maroon"		="#672c0d",\
		"Blood Red"		="#770d0d",\
		// Green Colors
		"Forest Green"	="#3f8b24",\
		"Bog Green"		="#58793f",\
		"Spring Green"	="#435436",\
		// Blue Colors
		"Royal Teal"	="#249589",\
		"Mana Blue"		="#1b3c7a",\
		"Berry"			="#38455b",\
		"Lavender"		="#865c9c",\
		"Majenta"		="#822b52",\
		// Brown Colors
		"Bark Brown"	="#685542",\
		"Russet"		="#685542",\
		"Chestnut"		="#5f3d21",\
		"Old Leather"	="#473a30",\
		"Ashen Black"	="#2f352f",\
		)
	var/thiefcloak_color_selection = input(usr,"What color was I again?","The Cloak","Ashen Black") in thiefcloak_colors
	var/obj/item/clothing/cloak/raincloak/thiefcloak = new()
	thiefcloak.color = thiefcloak_colors[thiefcloak_color_selection]
	H.equip_to_slot(thiefcloak, SLOT_CLOAK, TRUE)


/datum/advclass/town_elder/spellblade
	name = "Spellblade"

	tutorial = "Steel paid your way, but steel alone was never enough. You spent years as a mercenary, selling your sword to survive, yet always yearning for something more, the power of the arcane. Now, with enough coin and hard-earned wisdom, you've finally begun your studies in magic. But old habits die hard, and the town has no shortage of trouble. Whether solving disputes, defending the streets, or uncovering hidden dangers, you put your newfound magic to use where it's needed most."
	outfit = /datum/outfit/job/town_elder/spellblade

	//Mercenary turned into a mage, works for the people using magick and sword.

	category_tags = list(CTAG_TOWN_ELDER)


/datum/outfit/job/town_elder/spellblade/pre_equip(mob/living/carbon/human/H)
	H.verbs |= /mob/living/carbon/human/proc/townannouncement
	pants = /obj/item/clothing/pants/trou/leather
	armor = /obj/item/clothing/shirt/robe/newmage/sorcerer
	shirt = /obj/item/clothing/armor/chainmail/hauberk
	shoes = /obj/item/clothing/shoes/boots
	gloves = /obj/item/clothing/gloves/leather
	neck = /obj/item/clothing/neck/gorget
	backl = /obj/item/storage/backpack/satchel
	backr = /obj/item/weapon/sword/long
	belt = /obj/item/storage/belt/leather
	beltr = /obj/item/storage/magebag/apprentice
	beltl = /obj/item/flashlight/flare/torch/lantern
	backpack_contents = list(/obj/item/storage/belt/pouch/coins/mid = 1, /obj/item/storage/keyring/elder = 1, /obj/item/book/granter/spellbook/apprentice = 1)


	if(H.mind)
		H.mana_pool.set_intrinsic_recharge(MANA_ALL_LEYLINES)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/magic/arcane, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)

		H.change_stat(STATKEY_STR, 1)
		H.change_stat(STATKEY_INT, 2)
		H.change_stat(STATKEY_END, 1)
		H.change_stat(STATKEY_SPD, 1)

		if(H.age == AGE_OLD)
			H.mind?.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)
			H.mind?.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
			H.change_stat(STATKEY_INT, 1)

		H.mind.adjust_spellpoints(5)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)



	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)



/datum/advclass/town_elder/hearth_acolyte
	name = "Hearth Acolyte"

	tutorial = "As an Acolyte, you dedicated your life to faith and service, expecting nothing in return. When you saved a noble, they repaid you with a home and gold, but you saw it as the will of the Ten. Stepping away from the Church, you found a new purpose, not in a grand temple, but among the people. Whether offering healing, wisdom, or guidance, your faith remains strong. Only now, your congregation is the town itself."
	outfit = /datum/outfit/job/town_elder/hearth_acolyte

	//An acolyte that left the church and now serve and help the town people.

	category_tags = list(CTAG_TOWN_ELDER)

/datum/outfit/job/town_elder/hearth_acolyte
	allowed_patrons = ALL_TEMPLE_PATRONS

/datum/outfit/job/town_elder/hearth_acolyte/pre_equip(mob/living/carbon/human/H)
	H.verbs |= /mob/living/carbon/human/proc/townannouncement
	head = /obj/item/clothing/head/roguehood/random
	armor = /obj/item/clothing/shirt/robe
	shoes = /obj/item/clothing/shoes/sandals
	belt = /obj/item/storage/belt/leather/rope
	beltr = /obj/item/storage/keyring/elder
	beltl = /obj/item/flashlight/flare/torch/lantern
	backl = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/storage/belt/pouch/coins/mid = 1, /obj/item/needle = 1 )



	switch(H.patron?.type)
		if(/datum/patron/divine/astrata)
			neck = /obj/item/clothing/neck/psycross/silver/astrata
			H.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'
		if(/datum/patron/divine/necra)
			neck = /obj/item/clothing/neck/psycross/silver/necra
			H.cmode_music = 'sound/music/cmode/church/CombatGravekeeper.ogg'
		if(/datum/patron/divine/eora)
			neck = /obj/item/clothing/neck/psycross/silver/eora
			H.cmode_music = 'sound/music/cmode/church/CombatEora.ogg'
			ADD_TRAIT(H, TRAIT_BEAUTIFUL, TRAIT_GENERIC)
		if(/datum/patron/divine/noc)
			neck = /obj/item/clothing/neck/psycross/noc
			H.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'
		if(/datum/patron/divine/pestra)
			neck = /obj/item/clothing/neck/psycross/silver/pestra
			H.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'
		if(/datum/patron/divine/dendor)
			neck = /obj/item/clothing/neck/psycross/silver/dendor
			H.cmode_music = 'sound/music/cmode/garrison/CombatForestGarrison.ogg'
		if(/datum/patron/divine/abyssor)
			neck = /obj/item/clothing/neck/psycross/silver/abyssor
			H.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'
			H.mind?.adjust_skillrank(/datum/skill/labor/fishing, 1, TRUE)
		if(/datum/patron/divine/ravox)
			neck = /obj/item/clothing/neck/psycross/silver/ravox
			H.cmode_music = 'sound/music/cmode/adventurer/CombatOutlander2.ogg'
			H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		if(/datum/patron/divine/xylix)
			neck = /obj/item/clothing/neck/psycross/silver/xylix
			H.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'
			H.mind?.adjust_skillrank(/datum/skill/misc/stealing, 1, TRUE)
		if(/datum/patron/divine/malum)
			neck = /obj/item/clothing/neck/psycross/silver/malum
			H.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'
		else // Failsafe
			neck = /obj/item/clothing/neck/psycross/silver
			H.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/magic/holy, 3, TRUE)

		// More hand to hand focused
		H.change_stat(STATKEY_STR, 2)
		H.change_stat(STATKEY_INT, 1)
		H.change_stat(STATKEY_END, 2)

		if(H.age == AGE_OLD)
			H.mind?.adjust_skillrank(/datum/skill/magic/holy, 2, TRUE)
			H.change_stat(STATKEY_END, 1)

		if(!H.has_language(/datum/language/celestial))
			H.grant_language(/datum/language/celestial)
			to_chat(H, "<span class='info'>I can speak Celestial with ,c before my speech.</span>")

	var/datum/devotion/cleric_holder/C = new /datum/devotion/cleric_holder(H, H.patron)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)
	C.grant_spells(H)
