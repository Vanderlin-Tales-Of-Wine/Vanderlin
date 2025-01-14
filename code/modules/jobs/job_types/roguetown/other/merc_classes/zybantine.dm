/datum/advclass/mercenary/zybantine
	name = "Zybantine"
	tutorial = "A cutthroat from the western countries, you've headed into foreign lands to make even greater coin than you had prior."
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
	outfit = /datum/outfit/job/roguetown/mercenary/zybantine
	category_tags = list(CTAG_MERCENARY)
	maximum_possible_slots = 5

	cmode_music = 'sound/music/cmode/adventurer/CombatOutlander.ogg' //Forgive me, Combat_DesertRider, I'm sorry, I'll miss you.

/datum/outfit/job/roguetown/mercenary/zybantine/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/roguetown/shalal
	head = /obj/item/clothing/head/roguetown/helmet/sallet/zybantine
	gloves = /obj/item/clothing/gloves/roguetown/angle
	belt = /obj/item/storage/belt/rogue/leather/mercenary/shalal
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

		H.merctype = 1

		H.change_stat("strength", 1)
		H.change_stat("endurance", 2)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
