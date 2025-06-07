/datum/migrant_role/bodyguard
	name = "Bodyguard"
	greet_text = "Many adventurers decide to strike it rich by raiding tombs, others band together to form mercenary companies. \
	You, however, have had the misfortune of slipping through many cracks. Instead of tainting your eternal soul by means of \
	murder, you've elected to taint it in self-defense. Find an employer, and make a use for yourself. Cut the middleman, \
	avoid working with any guilds."
	outfit = /datum/outfit/job/bodyguard
	grant_lit_torch = TRUE

/datum/outfit/job/bodyguard/pre_equip(mob/living/carbon/human/H)
	..()
	wrists = /obj/item/clothing/wrists/bracers/leather
	neck = /obj/item/clothing/neck/coif
	gloves = /obj/item/clothing/gloves/angle
	pants = /obj/item/clothing/pants/trou/leathertights
	shirt = /obj/item/clothing/shirt/tunic/black
	armor = /obj/item/clothing/armor/leather/jacket/leathercoat/black
	shoes = /obj/item/clothing/shoes/nobleboot
	beltl = /obj/item/flashlight/flare/torch/lantern
	mask = /obj/item/clothing/face/spectacles/inqglasses
	beltr = /obj/item/weapon/knife/cleaver/combat
	belt = /obj/item/storage/belt/leather/steel
	backr = /obj/item/storage/backpack/satchel
	ring = /obj/item/clothing/ring/silver
	head = /obj/item/clothing/neck/keffiyeh/black

	if(H.mind)
		H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
		H.change_stat(STATKEY_STR, 1)
		H.change_stat(STATKEY_SPD, -1)
		H.change_stat(STATKEY_CON, 3) // Minimal armor, they kind of need it. Very much a bruiser.
	ADD_TRAIT(H, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOPAINSTUN, TRAIT_GENERIC)
	H.cmode_music = 'sound/music/cmode/adventurer/CombatOutlander.ogg'

/datum/migrant_wave/bodyguard
	name = "Bodyguard"
	max_spawns = 2
	shared_wave_type = /datum/migrant_wave/bodyguard
	weight = 10
	roles = list(
		/datum/migrant_role/bodyguard = 1,
	)
	greet_text = "A hired hand takes an empty seat, sliding an invoice across the table - a heavy knife embeds it into the wood."
