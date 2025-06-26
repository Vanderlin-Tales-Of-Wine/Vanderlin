/mob/living/carbon/human/species/triton/no_equipment
	ai_controller = /datum/ai_controller/human_bum
	faction = list("deepone")
	ambushable = FALSE
	dodgetime = 15
	canparry = TRUE

	flee_in_pain = TRUE
	possible_rmb_intents = list()

	wander = FALSE

/mob/living/carbon/human/species/triton/no_equipment/Initialize()
	. = ..()
	AddComponent(/datum/component/ai_aggro_system)
	AddComponent(/datum/component/combat_noise, list("rage" = 1, "scream" = 1))

/mob/living/carbon/human/species/triton/no_equipment
	ai_controller = /datum/ai_controller/human_npc

/mob/living/carbon/human/species/triton/no_equipment/Initialize()
	. = ..()
	set_species(/datum/species/triton)
	AddComponent(/datum/component/ai_aggro_system)
	addtimer(CALLBACK(src, PROC_REF(after_creation)), 1 SECONDS)

	adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
	adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
	adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)

/mob/living/carbon/human/species/triton/no_equipment/after_creation()
	..()
	job = "Beggar"
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
