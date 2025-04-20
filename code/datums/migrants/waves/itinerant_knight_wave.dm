/datum/migrant_role/itinerant_knight
	name = "Itinerant Knight"
	greet_text = "You are an itinerant Knight, you have embarked alongside your squire on a voyage to fullfil your knightly vows."
	outfit = /datum/outfit/job/itinerant_knight
	allowed_races = RACES_PLAYER_NONDISCRIMINATED
	grant_lit_torch = TRUE
	advjob_examine = FALSE
/datum/outfit/job/itinerant_knight/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/helmet/visored/sallet
	wrists = /obj/item/clothing/wrists/bracers
	gloves = /obj/item/clothing/gloves/plate
	pants = /obj/item/clothing/pants/platelegs
	neck = /obj/item/clothing/neck/chaincoif
	shirt = /obj/item/clothing/armor/chainmail
	armor = /obj/item/clothing/armor/plate/full
	shoes = /obj/item/clothing/shoes/boots/armor
	beltl = /obj/item/flashlight/flare/torch/lantern
	belt = /obj/item/storage/belt/leather/steel
	backr = /obj/item/storage/backpack/satchel
	backl = /obj/item/weapon/sword/long/greatsword
	backpack_contents = list(/obj/item/clothing/neck/psycross/silver = 1, /obj/item/weapon/knife/dagger/steel = 1, /obj/item/storage/belt/pouch/coins/mid = 1)

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
		H.mind?.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)
		H.change_stat(STATKEY_STR, 3)
		H.change_stat(STATKEY_PER, 2)
		H.change_stat(STATKEY_INT, 3)
		H.change_stat(STATKEY_CON, 4)
		H.change_stat(STATKEY_END, 3)
		H.change_stat(STATKEY_SPD, -2)
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
	outfit = /datum/outfit/job/itinerant_squire
	allowed_races = list("Humen", "Dwarf","Elf", "Half-Elf", "Aasimar")
	allowed_ages = list(AGE_CHILD, AGE_ADULT)
	grant_lit_torch = TRUE
	advjob_examine = FALSE

/datum/outfit/job/itinerant_squire/pre_equip(mob/living/carbon/human/H)
	..()
	shirt = /obj/item/clothing/shirt/dress/gen/black
	pants = /obj/item/clothing/pants/chainlegs/iron
	shoes = /obj/item/clothing/shoes/boots
	belt = /obj/item/storage/belt/leather
	beltr = /obj/item/ammo_holder/quiver/arrows
	armor = /obj/item/clothing/armor/plate/full
	backl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
	gloves = /obj/item/clothing/gloves/leather
	wrists = /obj/item/clothing/wrists/bracers/leather
	backr = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/weapon/knife/dagger/steel = 1, /obj/item/storage/belt/pouch/coins/poor = 1, /obj/item/clothing/neck/chaincoif = 1, /obj/item/weapon/hammer/iron = 1,)
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
		H.change_stat(STATKEY_PER, 1)
		H.change_stat(STATKEY_CON, 1)
		H.change_stat(STATKEY_INT, 1)
		H.change_stat(STATKEY_SPD, 2)
	if(H.gender == MALE && H.dna?.species)
		H.dna.species.soundpack_m = new /datum/voicepack/male/squire()
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	H.cmode_music = 'sound/music/cmode/garrison/CombatGarrison.ogg'

/datum/migrant_wave/knight
	name = "The Knightly Journey"
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
	name = "The Knightly Journey"
	max_spawns = 1
	shared_wave_type = /datum/migrant_wave/knight
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/itinerant_knight = 1,
	)
	greet_text = "The weight of Psydon's cross is heavy, the vows you have undertaken heavier, a Knight has took to the road to fullfill them."
