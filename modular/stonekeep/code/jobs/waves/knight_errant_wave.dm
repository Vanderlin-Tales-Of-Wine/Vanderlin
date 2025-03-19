/* Notes-
Strong knight and weak squire with some crafting/bow skills
Bit overpowered, but comparable to rare adventurers.
Spawns in forest area.
*/

/datum/migrant_role/sk/errant/knight
	name = "Knight Errant"
	greet_text = "You are an Knight Errant, you have embarked alongside your squire on a voyage to fullfil your knightly vows."
	outfit = /datum/outfit/job/sk_migration/knight_errant
	allowed_races = list("Humen", "Dwarf", "Elf", "Aasimar")
	allowed_sexes = list(MALE)
	grant_lit_torch = TRUE
	advjob_examine = FALSE

/datum/migrant_role/sk/errant/after_spawn(mob/living/carbon/human/character)
	. = ..()
	character.forceMove(pick(GLOB.forestroad_starts))

/datum/outfit/job/sk_migration/knight_errant/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/helmet/heavy/chevalier
	wrists = /obj/item/clothing/wrists/bracers
	gloves = /obj/item/clothing/gloves/plate
	pants = /obj/item/clothing/pants/platelegs
	cloak = /obj/item/clothing/cloak/cape/yellow
	neck = /obj/item/clothing/neck/chaincoif
	shirt = /obj/item/clothing/armor/gambeson
	armor = /obj/item/clothing/armor/plate/full
	shoes = /obj/item/clothing/shoes/boots/armor
	beltl = /obj/item/flashlight/flare/torch/lantern
	belt = /obj/item/storage/belt/leather
	backr = /obj/item/storage/backpack/satchel
	backl = /obj/item/weapon/sword/long/greatsword
	backpack_contents = list(/obj/item/clothing/neck/psycross/silver = 1, /obj/item/weapon/knife/dagger/steel = 1)

	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/riding, 4, TRUE)
		H.change_stat(STATKEY_STR, 3)
		H.change_stat(STATKEY_PER, -1)
		H.change_stat(STATKEY_INT, -1)
		H.change_stat(STATKEY_CON, 3)
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_SPD, -2)
	H.dna.species.soundpack_m = new /datum/voicepack/male/knight()
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	H.cmode_music = 'sound/music/cmode/nobility/CombatKnight.ogg'

/datum/migrant_role/sk/errant/squire
	name = "Errant Squire"
	greet_text = "You are the squire of an knight errant, they have taken you under their custody as you have shown great talents, if you keep it on, you might become a knight yourself."
	outfit = /datum/outfit/job/sk_migration/errant_squire
	allowed_races = list("Humen", "Dwarf","Half-Elf", "Aasimar")
	grant_lit_torch = TRUE
	advjob_examine = FALSE
/datum/outfit/job/sk_migration/errant_squire/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/clothing/neck/chaincoif/iron
	shirt = /obj/item/clothing/shirt/tunic/yellow
	pants = /obj/item/clothing/pants/trou/leather
	shoes = /obj/item/clothing/shoes/boots
	belt = /obj/item/storage/belt/leather
	beltl = /obj/item/weapon/sword/short
	beltr = /obj/item/ammo_holder/quiver/arrows
	armor = /obj/item/clothing/armor/chainmail/iron
	backl = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
	gloves = /obj/item/clothing/gloves/leather
	wrists = /obj/item/clothing/wrists/bracers/leather
	backr = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/weapon/knife/dagger = 1, /obj/item/weapon/hammer/iron = 1,/obj/item/storage/belt/pouch/coins/mid = 1)
	if(H.mind)
		H.mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
		H.mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
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

/datum/migrant_wave/knight_errant
	name = "The Knightly journey"
	max_spawns = 1
	shared_wave_type = /datum/migrant_wave/knight_errant
	downgrade_wave = /datum/migrant_wave/knight_errant_down
	weight = 10
	roles = list(
		/datum/migrant_role/sk/errant/knight = 1,
		/datum/migrant_role/sk/errant/squire = 1,
	)
	greet_text = "The weight of your chosen Quest grows heavier as time passes, but at least a friend makes the road less gloomy."

/datum/migrant_wave/knight_errant_down
	name = "The Knightly journey"
	max_spawns = 1
	shared_wave_type = /datum/migrant_wave/knight_errant
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/sk/errant/knight = 1,
	)
	greet_text = "The weight of your chosen Quest grows heavier as time passes. Yours is a lonely road."
