/mob/living/carbon/human/species/rakshari
	race = /datum/species/rakshari

/datum/species/rakshari
	name = "Rakshari"
	id = "rakshari"
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | RACE_SWAP | SLIME_EXTRACT

	desc = "<b>Rakshari</b><br>\
	Their origins trace back to nomadic desert tribes, whose survival in the harsh sands cultivated a culture steeped in resilience, cunning, and adaptability. \
	Over centuries, the Rakshari united under the banners of powerful Zybantine  merchant-kings and warlords, transforming their scattered clans into a dominant slaver force across the region., \
	For centuries, they raided weaker settlements and rival caravans, \
	capturing slaves to fuel their expanding cities and economies, \
	practice of this was justified through religious doctrines venerating strength and dominance as divine virtues \
	As they attached themselves to Zybantine Rakshari integrated more sophisticated forms of servitude, including indentured contracts and debt bondage. \
	\
	THIS IS A DISCRIMINATED SPECIES. EXPECT A MORE DIFFICULT EXPERIENCE. PLAY AT YOUR OWN RISK.\
	"

	skin_tone_wording = "Tribal Identity"
	use_skintones = 1
	default_color = "FFFFFF"
	default_features = list("mcolor" = "FFF",, "wings" = "None")
	specstats = list("strength" = -2, "perception" = 2, "intelligence" = 0, "constitution" = -2, "endurance" = 0, "speed" = 2, "fortune" = 0)
	specstats_f = list("strength" = -2, "perception" = 2, "intelligence" = 0, "constitution" = -2, "endurance" = 0, "speed" = 2, "fortune" = 0)

	limbs_icon_m = 'icons/roguetown/mob/bodies/m/rakshari.dmi'
	limbs_icon_f = 'icons/roguetown/mob/bodies/f/rakshari.dmi'
	child_icon = 'icons/roguetown/mob/bodies/c/child-rakshari.dmi'
	custom_clothes = FALSE
	custom_clothes = FALSE
	possible_ages = list(AGE_CHILD, AGE_ADULT, AGE_MIDDLEAGED, AGE_OLD)
	species_traits = list(EYECOLOR,OLDGREY)
	inherent_traits = list(TRAIT_NOMOBSWAP)

	offset_features = list(OFFSET_ID = list(0,0), OFFSET_GLOVES = list(0,0), OFFSET_WRISTS = list(0,0),\
	OFFSET_CLOAK = list(0,0), OFFSET_FACEMASK = list(0,0), OFFSET_HEAD = list(0,0), \
	OFFSET_FACE = list(0,0), OFFSET_BELT = list(0,0), OFFSET_BACK = list(0,0), \
	OFFSET_NECK = list(0,0), OFFSET_MOUTH = list(0,0), OFFSET_PANTS = list(0,0), \
	OFFSET_SHIRT = list(0,0), OFFSET_ARMOR = list(0,0), OFFSET_HANDS = list(0,0), OFFSET_UNDIES = list(0,0), \
	OFFSET_ID_F = list(0,-1), OFFSET_GLOVES_F = list(0,0), OFFSET_WRISTS_F = list(0,0), OFFSET_HANDS_F = list(0,0), \
	OFFSET_CLOAK_F = list(0,0), OFFSET_FACEMASK_F = list(0,-1), OFFSET_HEAD_F = list(0,-1), \
	OFFSET_FACE_F = list(0,-1), OFFSET_BELT_F = list(0,0), OFFSET_BACK_F = list(0,-1), \
	OFFSET_NECK_F = list(0,-1), OFFSET_MOUTH_F = list(0,-1), OFFSET_PANTS_F = list(0,0), \
	OFFSET_SHIRT_F = list(0,0), OFFSET_ARMOR_F = list(0,0), OFFSET_UNDIES_F = list(0,0))

/datum/species/rakshari/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	..()
	RegisterSignal(C, COMSIG_MOB_SAY, PROC_REF(handle_speech))
	C.grant_language(/datum/language/common)
	C.grant_language(/datum/language/thievescant)
	to_chat(C, "<span class='info'>I can gesture in thieves' cant with ,t before my speech.</span>")

/datum/species/rakshari/check_roundstart_eligible()
	return TRUE

/datum/species/rakshari/after_creation(mob/living/carbon/C)
	..()
	C.grant_language(/datum/language/common)
	C.grant_language(/datum/language/thievescant)

/datum/species/rakshari/on_species_loss(mob/living/carbon/C)
	. = ..()
	UnregisterSignal(C, COMSIG_MOB_SAY)

/datum/species/rakshari/qualifies_for_rank(rank, list/features)
	return TRUE

/datum/species/rakshari/get_skin_list()
	return sortList(list(
		"Oasis Rakshari" = SKIN_COLOR_PLAIN_ELF, // - (White 2)
		"Mountain Rakshari" = SKIN_COLOR_MOUNTAIN_ELF, // - (White 3)
		"City Rakshari" = SKIN_COLOR_COASTAL_ELF, // - (White 4)
		"Desert Rakshari" = SKIN_COLOR_WOOD_ELF, // - (Mediterranean 1)
	))
