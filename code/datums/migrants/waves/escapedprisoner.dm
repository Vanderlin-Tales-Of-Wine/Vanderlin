/datum/migrant_role/escprisoner
	name = "Escaped Prisoner"
	greet_text = "You've been rotting for years in your rotted garbs, your atrophied body wasted on the cold, moist floors of \
	an oubliette. The years of abuse made you forget who you were, or what you did to deserve this punishment - but you were of \
	blue-blood, this is for certain. When your use faded, and when they brought you to the hangman to usher you to your final \
	destination, your last bit of strengh surged, and the man met his end with a cracked skull on your mask. The restraints, \
	too rusted to stay together, broke as you jumped into the river. The tiny voice you forgot you had echoed in the back of \
	your mind. 'I'm not going back.'"
	outfit = /datum/outfit/job/escprisoner
	grant_lit_torch = TRUE

/datum/outfit/job/escprisoner/pre_equip(mob/living/carbon/human/H)
	..()
	pants = /obj/item/clothing/pants/loincloth/brown
	mask = /obj/item/clothing/face/facemask/prisoner
	cloak = /obj/item/clothing/cloak/raincloak/furcloak/brown
	belt = /obj/item/storage/belt/leather/rope
	beltl = /obj/item/weapon/knife/villager
	if(H.mind)
		H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.adjust_skillrank(/datum/skill/labor/butchering, 2, TRUE)
		H.adjust_skillrank(/datum/skill/labor/taming, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.adjust_skillrank(/datum/skill/craft/tanning, 3, TRUE)
		H.change_stat(STATKEY_CON, -2)
		H.change_stat(STATKEY_END, -1)
		H.change_stat(STATKEY_PER, 2)
		H.change_stat(STATKEY_STR, 2)
		ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC) // Years of mistreatment has culminated in this.
	H.cmode_music = 'sound/music/cmode/towner/CombatPrisoner.ogg'
	GLOB.outlawed_players += H.real_name // Don't get caught!

/datum/migrant_wave/escprisoner
	name = "Escaped Prisoner"
	max_spawns = 1
	shared_wave_type = /datum/migrant_wave/escprisoner
	weight = 8
	roles = list(
		/datum/migrant_role/escprisoner = 1,
	)
	greet_text = "A cloaked man sits in the farthest seat, smelling of blood. He looks terrified, he looks tired."
