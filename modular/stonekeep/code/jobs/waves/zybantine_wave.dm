/datum/migrant_role/sk/zybantine/emir
	name = "Zybantine Emir"
	greet_text = "An Emir hailing from the Zybantu Ziggurat, here on business for the Mercator's Guild to the Isle of the Enigma."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Elf",
		"Dwarf",
		"Tiefling",
		"Dark Elf",
		"Aasimar",
	)
	outfit = /datum/outfit/job/sk_migration/zyb_emir
	grant_lit_torch = TRUE
	show_wanderer_examine = FALSE

/datum/outfit/job/sk_migration/zyb_emir/pre_equip(mob/living/carbon/human/H)
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
	id = /obj/item/clothing/ring/gold/guild_mercator
	shirt = /obj/item/clothing/shirt/tunic/purple
	pants = /obj/item/clothing/pants/trou/leather
	neck = /obj/item/clothing/neck/shalal/emir
	backpack_contents = list(/obj/item/storage/belt/pouch/coins/veryrich = 1, /obj/item/reagent_containers/glass/bottle/wine = 1)
	if(H.gender == FEMALE)
		armor = /obj/item/clothing/armor/leather/jacket/silk_coat
		shirt = /obj/item/clothing/shirt/undershirt/lowcut
		head = /obj/item/clothing/head/crown/nyle
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
		H.change_stat(STATKEY_INT, 1)
		H.change_stat(STATKEY_END, 2)
		ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
		H.cmode_music = 'sound/music/cmode/adventurer/CombatOutlander.ogg'


/datum/migrant_role/sk/zybantine_guard
	name = "Zybantine Janissary"
	greet_text = "You are a slave soldier from the Ziggurat sent as an escort to the emirs on a foreign land, do not fail them."
	allowed_sexes = list(MALE,FEMALE)
	allowed_races = list("Humen",
		"Half-Elf",
		"Tiefling",
		"Dark Elf"
	)
	outfit = /datum/outfit/job/sk_migration/zyb_guard
	grant_lit_torch = TRUE
	show_wanderer_examine = FALSE

/datum/outfit/job/sk_migration/zyb_guard/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/shalal
	head = /obj/item/clothing/head/helmet/sallet/zybantine
	gloves = /obj/item/clothing/gloves/angle
	belt = /obj/item/storage/belt/leather/shalal
	armor = /obj/item/clothing/armor/brigandine/coatplates
	beltr = /obj/item/weapon/sword/long/rider
	beltl= /obj/item/flashlight/flare/torch/lantern
	shirt = /obj/item/clothing/shirt/undershirt/black
	pants = /obj/item/clothing/pants/tights/red
	neck = /obj/item/clothing/neck/keffiyeh/red
	backl = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/storage/belt/pouch/coins/poor)
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
		H.change_stat(STATKEY_STR, 1)
		H.change_stat(STATKEY_END, 2)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	H.cmode_music = 'sound/music/cmode/adventurer/CombatOutlander.ogg'

/datum/migrant_role/sk/zybantine_qatil
	name = "Qatil"
	greet_text = "You are the Emir's confident and most loyal protector, you shan't let them die in these wretched lands."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Tiefling",
		"Dark Elf",
		"Rakshari"
	)
	outfit = /datum/outfit/job/sk_migration/zyb_qatil
	show_wanderer_examine = FALSE

/datum/outfit/job/sk_migration/zyb_qatil/pre_equip(mob/living/carbon/human/H)
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
		H.change_stat(STATKEY_STR, 1)
		H.change_stat(STATKEY_SPD, 2)
		H.change_stat(STATKEY_END, 1)

	pants = /obj/item/clothing/pants/trou/leather
	beltr = /obj/item/weapon/knife/dagger/steel/special
	shoes = /obj/item/clothing/shoes/shalal
	gloves = /obj/item/clothing/gloves/angle
	belt = /obj/item/storage/belt/leather/shalal
	shirt = /obj/item/clothing/shirt/undershirt/red
	armor = /obj/item/clothing/armor/leather/splint
	backl = /obj/item/storage/backpack/satchel
	head = /obj/item/clothing/neck/keffiyeh/red
	backpack_contents = list(/obj/item/storage/belt/pouch/coins/poor, /obj/item/lockpick)
	if(!H.has_language(/datum/language/zybantine))
		H.grant_language(/datum/language/zybantine)
		to_chat(H, "<span class='info'>I can speak Zybean with ,z before my speech.</span>")

	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	H.cmode_music = 'sound/music/cmode/adventurer/CombatOutlander3.ogg'

/datum/migrant_wave/zybantine_wave
	name = "The Ziggurat expedition"
	max_spawns = 1
	shared_wave_type = list(/datum/migrant_wave/grenzelhoft_visit,/datum/migrant_wave/zybantine_wave,/datum/migrant_wave/heartfelt)
	weight = 25
	downgrade_wave = /datum/migrant_wave/zybantine_wave_down
	roles = list(
		/datum/migrant_role/sk/zybantine/emir = 1,
		/datum/migrant_role/sk/zybantine_qatil = 1,
		/datum/migrant_role/sk/zybantine_guard = 2
	)
	greet_text = "The Mercator Guild sent you, respected Zybantinian to seek favorable business proposals in these lands."

/datum/migrant_wave/zybantine_wave_down
	name = "The Ziggurat expedition"
	max_spawns = 1
	shared_wave_type = list(/datum/migrant_wave/grenzelhoft_visit,/datum/migrant_wave/zybantine_wave,/datum/migrant_wave/heartfelt)
	downgrade_wave = /datum/migrant_wave/zybantine_wave_down_last
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/sk/zybantine/emir = 1,
		/datum/migrant_role/sk/zybantine_qatil = 1,
		/datum/migrant_role/sk/zybantine_guard = 1
	)
	greet_text = "The Mercator Guild sent you, respected Zybantinian to seek favorable business proposals in these lands. Unfortunately most of your guards died on the way here."

/datum/migrant_wave/zybantine_wave_down_last
	name = "The Ziggurat expedition"
	max_spawns = 1
	shared_wave_type = list(/datum/migrant_wave/grenzelhoft_visit,/datum/migrant_wave/zybantine_wave,/datum/migrant_wave/heartfelt)
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/sk/zybantine/emir = 1,
		/datum/migrant_role/sk/zybantine_qatil = 1,
	)
	greet_text = "The Mercator Guild sent you, respected Zybantinian to seek favorable business proposals in these lands. Unfortunately your guards died on the way here."
