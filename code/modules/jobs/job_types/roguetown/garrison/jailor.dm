/datum/job/roguetown/jailor
	title = "Jailor"
	flag = JAILOR
	department_flag = GARRISON
	display_order = JDO_JAILOR
	faction = "Station"
	total_positions = 1
	spawn_positions = 1
	tutorial = "Your eyes have seen true terror in The Crimson Valley Asylum- men ripping one another apart for\
	their own entertainment. You now live in this town- a quiet peaceful place compared Asylum you used to guard."
	allowed_races = list( // They're from Crimson Valley Asylum- only a select of houses are in position of guard there.
		"Humen",
		"Dwarf",
		"Elf",
		"Half-Elf"
	)
	allowed_ages = list(AGE_OLD, AGE_IMMORTAL) // He's a wierd elderly man that is fucking jacked- this will make for a memorable character I think.
	allowed_sexes = list(MALE, FEMALE)
	outfit = /datum/outfit/job/roguetown/jailor
	cmode_music = 'sound/music/cmode/garrison/CombatJailor.ogg'
	give_bank_account = 25
	min_pq = 4

/datum/outfit/job/roguetown/jailor/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/roguehood/black
	neck = /obj/item/clothing/neck/roguetown/coif
	armor = /obj/item/clothing/suit/roguetown/armor/leather/splint
	shirt = /obj/item/clothing/suit/roguetown/shirt/tunic/black
	pants = /obj/item/clothing/under/roguetown/loincloth/black
	shoes = /obj/item/clothing/shoes/roguetown/shortboots
	wrists = /obj/item/rope/chain
	belt = /obj/item/storage/belt/rogue/leather
	beltl = /obj/item/rogueweapon/mace/spiked // He gets a random mace.
	beltr = /obj/item/storage/keyring/guard
	backpack_contents = list(/obj/item/rogueweapon/knife/dagger)
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE) // Main weapon
		H.mind?.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE) // He has lost his trusty whip a long time ago
		H.mind?.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE) // He uses this quite often to get the truth out of liars
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, pick(3,4,4,4,5), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, pick(3,4,4,4,5), TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/traps, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE) // He needs to sew his prisoners back up
		//H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	// He's really strong- but anyone is faster than him, the question is can they run for long enough? (Also remember they are an elderly man)
	H.change_stat("strength", pick(4,4,5))
	H.change_stat("endurance", pick(4,5,6))
	H.change_stat("constitution", -2)
	H.change_stat("speed", -4) // To balance out how strong he is
	H.change_stat("intelligence", pick(-4,-5,-6)) // He's stupid
	H.change_stat("perception", pick(-3,-3,-4)) // Yeah he's stupid- he's not going to notice small things
	H.verbs |= /mob/living/carbon/human/proc/torture_victim // I don't think they need it, but here we go anyways.
