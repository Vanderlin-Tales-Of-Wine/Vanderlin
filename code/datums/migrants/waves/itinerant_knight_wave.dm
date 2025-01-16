/datum/migrant_role/itinerant_knight
	name = "Itinerant Knight"
	greet_text = "You are an itinerant Knight, you have embarked alongside your squire on a voyage to fullfil your knightly vows."
	outfit = /datum/outfit/job/roguetown/itinerant_knight
	allowed_races = list("Humen", "Dwarf", "Elf", "Aasimar")
	grant_lit_torch = TRUE
	advjob_examine = FALSE
/datum/outfit/job/roguetown/itinerant_knight/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguetown/helmet/visored/sallet
	wrists = /obj/item/clothing/wrists/roguetown/bracers
	gloves = /obj/item/clothing/gloves/roguetown/plate
	pants = /obj/item/clothing/under/roguetown/platelegs
	neck = /obj/item/clothing/neck/roguetown/chaincoif
	shirt = /obj/item/clothing/suit/roguetown/armor/chainmail
	armor = /obj/item/clothing/suit/roguetown/armor/plate/full
	shoes = /obj/item/clothing/shoes/roguetown/boots/armor
	beltl = /obj/item/flashlight/flare/torch/lantern
	belt = /obj/item/storage/belt/rogue/leather/steel
	backr = /obj/item/storage/backpack/rogue/satchel
	backl = /obj/item/rogueweapon/sword/long/greatsword
	backpack_contents = list(/obj/item/clothing/neck/roguetown/psycross/silver = 1, /obj/item/rogueweapon/knife/dagger/steel = 1, /obj/item/storage/belt/rogue/pouch/coins/mid = 1)

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
		H.change_stat("strength", 3)
		H.change_stat("perception", 2)
		H.change_stat("intelligence", 3)
		H.change_stat("constitution", 4)
		H.change_stat("endurance", 3)
		H.change_stat("speed", -2)
	H.dna.species.soundpack_m = new /datum/voicepack/male/knight()
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOSEGRAB, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	H.cmode_music = 'sound/music/cmode/nobility/CombatKnight.ogg'

/datum/migrant_role/itinerant_squire
	name = "Itinerant Squire"
	greet_text = "You are the squire of an itinerant knight, they have taken you under their custody as you have shown great talents, if you keep it on, you might become a knight yourself."
	outfit = /datum/outfit/job/roguetown/itinerant_squire
	allowed_races = list("Humen", "Dwarf","Elf", "Half-Elf", "Aasimar")
	grant_lit_torch = TRUE
	advjob_examine = FALSE
/datum/outfit/job/roguetown/itinerant_squire/pre_equip(mob/living/carbon/human/H)
	..()
	shirt = /obj/item/clothing/suit/roguetown/shirt/dress/gen/black
	pants = /obj/item/clothing/under/roguetown/chainlegs/iron
	shoes = /obj/item/clothing/shoes/roguetown/boots
	belt = /obj/item/storage/belt/rogue/leather
	beltr = /obj/item/ammo_holder/quiver/arrows
	armor = /obj/item/clothing/suit/roguetown/armor/plate/full
	backl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
	gloves = /obj/item/clothing/gloves/roguetown/leather
	wrists = /obj/item/clothing/wrists/roguetown/bracers/leather
	backr = /obj/item/storage/backpack/rogue/satchel
	backpack_contents = list(/obj/item/rogueweapon/knife/dagger/steel = 1, /obj/item/storage/belt/rogue/pouch/coins/poor = 1, /obj/item/clothing/neck/roguetown/chaincoif = 1, /obj/item/rogueweapon/hammer/iron = 1,)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/weaponsmithing, 2, TRUE)
		H.mind.adjust_skillrank(/datum/skill/craft/armorsmithing, 2, TRUE)
		H.change_stat("perception", 1)
		H.change_stat("constitution", 1)
		H.change_stat("intelligence", 1)
		H.change_stat("speed", 2)
	if(H.gender == MALE && H.dna?.species)
		H.dna.species.soundpack_m = new /datum/voicepack/male/squire()
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	H.cmode_music = 'sound/music/cmode/garrison/CombatGarrison.ogg'

/datum/migrant_wave/knight
	name = "The Knightly journey"
	max_spawns = 1
	shared_wave_type = /datum/migrant_wave/knight
	downgrade_wave = /datum/migrant_wave/knight_down
	weight = 10
	roles = list(
		/datum/migrant_role/itinerant_knight = 1,
		/datum/migrant_role/itinerant_squire = 1,
	)
	greet_text = "The weight of Psydon's cross is heavy, the vows you have undertaken heavier, a Knight and their squire has took to the road to fullfill them."

/datum/migrant_wave/knight_down
	name = "The Knightly journey"
	max_spawns = 1
	shared_wave_type = /datum/migrant_wave/knight
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/itinerant_knight = 1,
	)
	greet_text = "The weight of Psydon's cross is heavy, the vows you have undertaken heavier, a Knight has took to the road to fullfill them."
