	/*==============*
	*				*
	*	Wood Elf	*		Event only race, not meant to be balanced for players. Also has inhumen camp trait
	*				*
	*===============*/

//	( + Night Vision )

/mob/living/carbon/human/species/elf/snow/wood
	race = /datum/species/elf/snow/wood

/datum/species/elf/snow/wood //only for events and other rare stuff, so to not waste code time its just a subtype of snow elves since they are very similar
	name = "Wood Elf"

	//More physically capable elves that are less intelligent. Better night vision.
	mutanteyes = /obj/item/organ/eyes/elf
	specstats = list("strength" = 0, "perception" = 2, "intelligence" = -1, "constitution" = 0, "endurance" = 1, "speed" = 1, "fortune" = 0)
	specstats_f = list("strength" = 0, "perception" = 2, "intelligence" = 0, "constitution" = -1, "endurance" = 0, "speed" = 2, "fortune" = 0)
	inherent_traits = list(TRAIT_NOMOBSWAP,TRAIT_INHUMENCAMP)

/datum/species/elf/snow/wood/check_roundstart_eligible()
	return FALSE

/datum/species/elf/snow/wood/get_skin_list()
	return sortList(list(
		"Wood Elf" = SKIN_COLOR_WOOD_ELF,
	))

/mob/living/carbon/human/species/elf/snow/wood/Initialize()
	. = ..()
	spawn(10)
		after_creation() //so their stats are rolled

/mob/living/carbon/human/species/elf/snow/wood/proc/configure_mind()
	if(!mind)
		mind = new /datum/mind(src)

	mind.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
	mind.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)

/mob/living/carbon/human/species/elf/snow/wood/skilled/Initialize()
	. = ..()
	spawn(10)
		after_creation() //so their stats are rolled
		configure_mind()
