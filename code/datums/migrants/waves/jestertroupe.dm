/datum/migrant_role/jestertroupe
	name = "Buffoon"
	greet_text = "You were once part of a glorious circus from Heartfelt. Long gone are the days of mirth. The tent having been set ablaze so many years ago, you and your lot have been wandering. Here is the perfect town to start the next act. The circus is in town!"
	outfit = /datum/outfit/job/roguetown/jestertroupe

	allowed_races = list(
		"Humen",
		"Elf",
		"Half-Elf",
		"Dwarf",
		"Tiefling",
		"Dark Elf",
		"Aasimar",
		"Half-Orc")
	grant_lit_torch = TRUE

/datum/outfit/job/roguetown/jestertroupe/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/jester
	pants = /obj/item/clothing/under/roguetown/tights
	armor = /obj/item/clothing/suit/roguetown/shirt/jester
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
	beltr = /obj/item/rogueweapon/knife/villager
	head = /obj/item/clothing/head/roguetown/jester
	neck = /obj/item/clothing/neck/roguetown/coif
	mask = /obj/item/clothing/mask/rogue/lordmask

	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, pick(2,3), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, pick(1,2), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/music, pick(4,5,5,6), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, pick(1,2,2,2,3), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, pick(1,2,2,2,3), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, pick(2,3,4,5), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/stealing, pick(3,4), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking, pick(2,2,3,3,4,), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, pick(4,4,4,4,5), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/mockery)
		H.change_stat("strength", -1)
		H.change_stat("constitution", -1)
		H.change_stat("speed", 1)
	H.verbs |= /mob/living/carbon/human/proc/ventriloquate
	ADD_TRAIT(H, TRAIT_EMPATH, TRAIT_GENERIC)
	H.cmode_music = 'sound/music/cmode/nobility/CombatJester2.ogg'

	var/instruments = list(
		"Harp" = /obj/item/rogue/instrument/harp,
		"Lute" = /obj/item/rogue/instrument/lute,
		"Accordion" = /obj/item/rogue/instrument/accord,
		"Guitar" = /obj/item/rogue/instrument/guitar,
		"Flute" = /obj/item/rogue/instrument/flute,
		"Drum" = /obj/item/rogue/instrument/drum,
		"Hurdy-Gurdy" = /obj/item/rogue/instrument/hurdygurdy,
		"Viola" = /obj/item/rogue/instrument/viola)
	var/instrument_choice = input("Choose your instrument.", "XYLIX") as anything in instruments
	H.set_blindness(0)
	if(instrument_choice && instruments[instrument_choice])
		backr = instruments[instrument_choice]
	else
		backr = /obj/item/rogue/instrument/lute

/datum/migrant_wave/jestertroupe
	name = "The Circus"
	max_spawns = 1
	shared_wave_type = /datum/migrant_wave/jestertroupe
	downgrade_wave = /datum/migrant_wave/jestertroupe_down
	weight = 10
	roles = list(
		/datum/migrant_role/jestertroupe = 3
	)
	greet_text = "Bread and Circuses. That's how little it takes to entertain the peasantry. You aren't funny for money, you're funny by nature."

/datum/migrant_wave/jestertroupe_down
	name = "The Comedian"
	shared_wave_type = /datum/migrant_wave/jestertroupe
	can_roll = FALSE
	weight = 35
	roles = list(
		/datum/migrant_role/jestertroupe = 1,
	)
	greet_text = "Bread and Circuses. That's how little it takes to entertain the peasantry. You aren't funny for money, you're funny by nature."
