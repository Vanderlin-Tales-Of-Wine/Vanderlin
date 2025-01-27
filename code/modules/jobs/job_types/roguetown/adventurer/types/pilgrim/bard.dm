
/datum/advclass/pilgrim/bard
	name = "Bard"
	tutorial = "Bards make up one of the largest populations of \
	registered adventurers in Enigma, mostly because they are \
	the last ones in a party to die. Their wish is to experience \
	the greatest adventures of the age and write amazing songs about them."
	allowed_sexes = list(MALE, FEMALE)
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
	outfit = /datum/outfit/job/roguetown/adventurer/bard
	category_tags = list(CTAG_PILGRIM)
	apprentice_name = "Aspiring Bard"

/datum/outfit/job/roguetown/adventurer/bard/pre_equip(mob/living/carbon/human/H)
	..()
	H.mind?.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/stealing, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/lockpicking, 1, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/music, 4, TRUE)
	H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.mind.AddSpell(new /obj/effect/proc_holder/spell/invoked/mockery)
	head = /obj/item/clothing/head/roguetown/bardhat
	shoes = /obj/item/clothing/shoes/roguetown/boots
	pants = /obj/item/clothing/under/roguetown/tights/random
	shirt = /obj/item/clothing/suit/roguetown/shirt/tunic/noblecoat
	if(prob(30))
		gloves = /obj/item/clothing/gloves/roguetown/fingerless
	belt = /obj/item/storage/belt/rogue/leather
	armor = /obj/item/clothing/suit/roguetown/armor/leather/vest
	cloak = /obj/item/clothing/cloak/raincloak/blue
	if(prob(50))
		cloak = /obj/item/clothing/cloak/raincloak/red
	backl = /obj/item/storage/backpack/rogue/satchel
	beltr = /obj/item/rogueweapon/knife/dagger/steel/special
	beltl = /obj/item/storage/belt/rogue/pouch/coins/poor
	backpack_contents = list(/obj/item/flint)

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
	if(H.dna?.species?.id == "dwarf")
		H.cmode_music = 'sound/music/cmode/combat_dwarf.ogg'
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_BARDIC_TRAINING, TRAIT_GENERIC)
	H.change_stat("perception", 1)
	H.change_stat("speed", 2)
	H.change_stat("strength", -1)
