/datum/advclass/mercenary/exiled
	name = "Exiled Warrior"
	tutorial = "A barbarian - you're a brute, and you're a long way from home. You took more of a liking to the blade than your elders wanted - in truth, they did not have to even deliberate to banish you. You will drown in ale, and your enemies in blood."
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Half-Orc"
	)
	outfit = /datum/outfit/job/mercenary/exiled
	category_tags = list(CTAG_MERCENARY)
	maximum_possible_slots = 5

	cmode_music = 'sound/music/cmode/adventurer/CombatOutlander2.ogg'

/datum/outfit/job/mercenary/exiled/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.mind?.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)	// Minimal armor, expected to have big sword.
		H.mind?.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/tanning, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE) // Cut those trees #Morbiussweep
		H.mind?.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.mind?.adjust_skillrank(/datum/skill/craft/traps, 3, TRUE) // Valor pleases you, Crom.

	beltr = /obj/item/weapon/sword/arming
	neck = /obj/item/clothing/neck/coif
	pants = /obj/item/clothing/pants/loincloth
	gloves = /obj/item/clothing/gloves/leather
	belt = /obj/item/storage/belt/leather/mercenary
	beltl = /obj/item/weapon/axe/iron
	head = /obj/item/clothing/head/helmet/leather
	armor = /obj/item/clothing/armor/leather/hide
	shirt = /obj/item/clothing/armor/gambeson
	shoes = /obj/item/clothing/shoes/boots/leather
	wrists = /obj/item/clothing/wrists/bracers/leather
	cloak = /obj/item/clothing/cloak/raincloak/furcloak/brown
	backl = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/storage/belt/pouch/coins/poor)

	H.change_stat(STATKEY_STR, 1)
	H.change_stat(STATKEY_END, 2)
	H.change_stat(STATKEY_CON, 2)
	H.change_stat(STATKEY_SPD, -1) // fat fuck
	H.change_stat(STATKEY_INT, 3) // Conan! What is best in life?
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOPAINSTUN, TRAIT_GENERIC)
	if(H.dna?.species)
		H.dna.species.soundpack_m = new /datum/voicepack/male/warrior()
