/datum/migrant_role/zybantine/emir
	name = "Zybantine Emir"
	greet_text = "An Emir hailing from the Zybantu Ziggurat, here on business for the Mercator's Guild to the Isle of the Enigma."
	allowed_sexes = list(MALE)
	allowed_races = list(
		"Humen",
		"Rakshari",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Dark Elf",
		"Aasimar",
		"Half-Orc"
	)
	outfit = /datum/outfit/job/roguetown/zybantine_migration/emir
	grant_lit_torch = TRUE
	show_wanderer_examine = FALSE

/datum/outfit/job/roguetown/zybantine_migration/emir/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/shalal
	gloves = /obj/item/clothing/gloves/roguetown/leather
	head = /obj/item/clothing/head/roguetown/crown/circlet
	cloak = /obj/item/clothing/cloak/raincloak/purple
	armor = /obj/item/clothing/suit/roguetown/armor/gambeson/arming
	belt = /obj/item/storage/belt/rogue/leather/shalal
	beltl = /obj/item/rogueweapon/sword/sabre/shalal
	beltr = /obj/item/flashlight/flare/torch/lantern
	backr = /obj/item/storage/backpack/rogue/satchel
	id = /obj/item/clothing/ring/gold/guild_mercator
	shirt = /obj/item/clothing/suit/roguetown/shirt/tunic/purple
	pants = /obj/item/clothing/under/roguetown/trou/leather
	neck = /obj/item/clothing/neck/roguetown/shalal/emir
	backpack_contents = list(/obj/item/storage/belt/rogue/pouch/coins/veryrich)
	if(H.gender == FEMALE)
		armor = /obj/item/clothing/suit/roguetown/armor/leather/jacket/silk_coat
		shirt = /obj/item/clothing/suit/roguetown/shirt/dress/silkdress/black
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
		H.change_stat("intelligence", 1)
		H.change_stat("endurance", 2)
		ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
		H.cmode_music = 'sound/music/cmode/adventurer/CombatOutlander.ogg'


/datum/migrant_role/zybantine/amirah
	name = "Zybantine Amirah"
	greet_text = "An Amirah hailing from the Zybantu Ziggurat, here on business for the Mercator's Guild to the Isle of the Enigma."
	allowed_sexes = list(FEMALE)
	allowed_races = list(
		"Humen",
		"Rakshari",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Dark Elf",
		"Aasimar",
		"Half-Orc"
	)
	outfit = /datum/outfit/job/roguetown/zybantine_migration/amirah
	grant_lit_torch = TRUE
	show_wanderer_examine = FALSE

/datum/outfit/job/roguetown/zybantine_migration/amirah/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/shalal
	gloves = /obj/item/clothing/gloves/roguetown/leather
	head = /obj/item/clothing/head/roguetown/crown/nyle
	cloak = /obj/item/clothing/cloak/raincloak/purple
	armor = /obj/item/clothing/suit/roguetown/armor/leather/jacket/silk_coat
	belt = /obj/item/storage/belt/rogue/leather/shalal
	beltl = /obj/item/rogueweapon/sword/sabre/shalal
	beltr = /obj/item/flashlight/flare/torch/lantern
	backr = /obj/item/storage/backpack/rogue/satchel
	id = /obj/item/clothing/ring/gold/guild_mercator
	shirt = /obj/item/clothing/suit/roguetown/shirt/dress/silkdress/black
	pants = /obj/item/clothing/under/roguetown/trou/leather
	neck = /obj/item/clothing/neck/roguetown/shalal/emir
	backpack_contents = list(/obj/item/storage/belt/rogue/pouch/coins/veryrich = 1, /obj/item/reagent_containers/glass/bottle/rogue/wine = 1)

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
		var/prev_real_name = H.real_name
		var/prev_name = H.name
		var/honorary = "Amirah"
		H.real_name = "[honorary] [prev_real_name]"
		H.name = "[honorary] [prev_name]"
		if(!H.has_language(/datum/language/zybantine))
			H.grant_language(/datum/language/zybantine)
			to_chat(H, "<span class='info'>I can speak Zybean with ,z before my speech.</span>")
		H.change_stat("intelligence", 1)
		H.change_stat("endurance", 2)
		ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
		H.cmode_music = 'sound/music/cmode/adventurer/CombatOutlander.ogg'

/datum/migrant_role/zybantine/furusiyya
	name = "Furusiyya"
	greet_text = "You are a furusiyya, pledged to the Emir and the Amirah. Make sure they come out alive of that place."
	allowed_sexes = list(MALE)
	allowed_races = list("Humen")
	outfit = /datum/outfit/job/roguetown/zybantine_migration/furusiyya
	grant_lit_torch = TRUE
	show_wanderer_examine = FALSE

/datum/outfit/job/roguetown/zybantine_migration/furusiyya/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/whipsflails, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 4, TRUE)
		H.change_stat(STATKEY_STR, 3)
		H.change_stat(STATKEY_PER, 1)
		H.change_stat(STATKEY_INT, 2)
		H.change_stat(STATKEY_CON, 2)
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_SPD, -1)

	var/randy = rand(1,5)
	switch(randy)
		if(1 to 2)
			backr = /obj/item/rogueweapon/polearm/halberd/bardiche
		if(3 to 4)
			backr = /obj/item/rogueweapon/polearm/eaglebeak
		if(5)
			backr = /obj/item/rogueweapon/polearm/spear/billhook


	pants = /obj/item/clothing/under/roguetown/tights/black
	beltl = /obj/item/storage/belt/rogue/pouch/coins/mid
	shoes = /obj/item/clothing/shoes/roguetown/boots/rare/zybanplate
	gloves = /obj/item/clothing/gloves/roguetown/rare/zybanplate
	belt = /obj/item/storage/belt/rogue/leather/shalal
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/random
	armor = /obj/item/clothing/suit/roguetown/armor/rare/zybanplate
	backl = /obj/item/storage/backpack/rogue/satchel
	head = /obj/item/clothing/head/roguetown/rare/zybanplate
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	neck = /obj/item/clothing/neck/roguetown/chaincoif
	if(!H.has_language(/datum/language/zybantine))
		H.grant_language(/datum/language/zybantine)
		to_chat(H, "<span class='info'>I can speak Zybean with ,z before my speech.</span>")

	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOSEGRAB, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	H.cmode_music = 'sound/music/cmode/adventurer/CombatOutlander.ogg'

/datum/migrant_role/zybantine_guard
	name = "Zybantine soldier"
	greet_text = "You are a slave soldier from the Ziggurat sent as an escort to the emirs on a foreign land, do not fail them."
	allowed_sexes = list(MALE,FEMALE)
	allowed_races = list("Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Dark Elf",
		"Aasimar",
		"Half-Orc"
	)
	outfit = /datum/outfit/job/roguetown/zybantine_migration/zybantine_guard
	grant_lit_torch = TRUE
	show_wanderer_examine = FALSE

/datum/outfit/job/roguetown/zybantine_migration/zybantine_guard/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/shalal
	head = /obj/item/clothing/head/roguetown/helmet/sallet/zybantine
	gloves = /obj/item/clothing/gloves/roguetown/angle
	belt = /obj/item/storage/belt/rogue/leather/shalal
	armor = /obj/item/clothing/suit/roguetown/armor/brigandine/coatplates
	beltr = /obj/item/rogueweapon/sword/long/rider
	beltl= /obj/item/flashlight/flare/torch/lantern
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/black
	pants = /obj/item/clothing/under/roguetown/tights/red
	neck = /obj/item/clothing/neck/roguetown/keffiyeh/red
	backl = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/storage/belt/rogue/pouch/coins/poor)
	if(!H.has_language(/datum/language/zybantine))
		H.grant_language(/datum/language/zybantine)
		to_chat(H, "<span class='info'>I can speak Zybean with ,z before my speech.</span>")
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/shields, pick(0,1,1), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("endurance", 2)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	H.cmode_music = 'sound/music/cmode/adventurer/CombatOutlander.ogg'

/datum/migrant_role/qatil
	name = "Qatil"
	greet_text = "You are the Amirah's confident and most loyal protector, you shan't let them die in these wretched lands."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Tiefling",
		"Dark Elf",
		"Half-Orc"
	)
	outfit = /datum/outfit/job/roguetown/zybantine_migration/qatil
	show_wanderer_examine = FALSE

/datum/outfit/job/roguetown/zybantine_migration/qatil/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/traps, 1, TRUE)
		H.change_stat("strength", 1)
		H.change_stat("speed", 2)
		H.change_stat("endurance", 1)

	pants = /obj/item/clothing/under/roguetown/trou/leather
	beltr = /obj/item/rogueweapon/knife/dagger/steel/special
	shoes = /obj/item/clothing/shoes/roguetown/shalal
	gloves = /obj/item/clothing/gloves/roguetown/angle
	belt = /obj/item/storage/belt/rogue/leather/shalal
	shirt = /obj/item/clothing/suit/roguetown/shirt/undershirt/red
	armor = /obj/item/clothing/suit/roguetown/armor/leather/splint
	backl = /obj/item/storage/backpack/rogue/satchel
	head = /obj/item/clothing/neck/roguetown/keffiyeh/red
	backpack_contents = list(/obj/item/storage/belt/rogue/pouch/coins/poor, /obj/item/lockpick)
	if(!H.has_language(/datum/language/zybantine))
		H.grant_language(/datum/language/zybantine)
		to_chat(H, "<span class='info'>I can speak Zybean with ,z before my speech.</span>")

	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	H.cmode_music = 'sound/music/cmode/adventurer/CombatOutlander3.ogg'

/datum/migrant_wave/zybantine_wave
	name = "The Ziggurat expedition"
	max_spawns = 1
	shared_wave_type = list(/datum/migrant_wave/grenzelhoft_visit,/datum/migrant_wave/zybantine_wave,/datum/migrant_wave/rockhill_wave,/datum/migrant_wave/heartfelt)
	weight = 25
	downgrade_wave = /datum/migrant_wave/zybantine_wave_down
	roles = list(
		/datum/migrant_role/zybantine/emir = 1,
		/datum/migrant_role/zybantine/amirah = 1,
		/datum/migrant_role/zybantine/furusiyya = 1,
		/datum/migrant_role/qatil = 1,
		/datum/migrant_role/zybantine_guard = 2
	)
	greet_text = "The Mercator Guild sent you, respected Zybantinian to seek favorable business proposal within the Kingdom of Vanderlin."

/datum/migrant_wave/zybantine_wave_down
	name = "The Ziggurat expedition"
	max_spawns = 1
	shared_wave_type = list(/datum/migrant_wave/grenzelhoft_visit,/datum/migrant_wave/zybantine_wave,/datum/migrant_wave/rockhill_wave,/datum/migrant_wave/heartfelt)
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/zybantine/emir = 1,
		/datum/migrant_role/zybantine/amirah = 1,
		/datum/migrant_role/zybantine/furusiyya = 1,
		/datum/migrant_role/qatil = 1
	)
	greet_text = "The Mercator Guild sent you, respected Zybantinian to seek favorable business proposal within the Kingdom of Vanderlin. Unfortunately most of your guards died on the way here."
