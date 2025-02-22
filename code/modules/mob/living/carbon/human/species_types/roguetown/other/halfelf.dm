	/*==============*
	*				*
	*	Half-Elf	*
	*				*
	*===============*/

/mob/living/carbon/human/species/human/halfelf
	race = /datum/species/human/halfelf

/datum/species/human/halfelf
	name = "Half-Elf"
	id = "human"
	desc = "The child of Elf and Humen. \
	\n\n\
	Half-Elves are generally frowned upon by more conservative peoples, \
	although as species tensions lower, more and more half-elves are being born. \
	To the point that some scholars worry that someday, \
	it may be impossible to distinguish the two species. \
	\n\n\
	Half-Elves are extraordinarily diverse, as they combine both Humen and Elvish culture. \
	It is widely considered that Half-Elf culture is simply a melting pot of \
	various others condensing into one vibrant entity. \
	\n\n\
	Their longevity spanning too long for a human and short for an elf lead them to congregate together. \
	Due to their heritage, Half-Elves tend to gain species traits \
	depending on how strong their fathers, or mothers, genes were. \
	Half-Elves also typically try to find identity."

	skin_tone_wording = "Half-Elven Identity"

	default_color = "FFFFFF"
	species_traits = list(EYECOLOR,HAIR,FACEHAIR,LIPS,STUBBLE,OLDGREY)
	inherent_traits = list(TRAIT_NOMOBSWAP)
	default_features = list("mcolor" = "FFF", "ears" = "ElfH", "wings" = "None")
	mutant_bodyparts = list("ears")
	mutanteyes = /obj/item/organ/eyes/elf/less
	use_skintones = 1
	possible_ages = list(AGE_CHILD, AGE_ADULT, AGE_MIDDLEAGED, AGE_OLD)
	disliked_food = NONE
	liked_food = NONE
	max_age = 500
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | RACE_SWAP | SLIME_EXTRACT
	limbs_icon_m = 'icons/roguetown/mob/bodies/m/mm.dmi'
	limbs_icon_f = 'icons/roguetown/mob/bodies/f/fm.dmi'
	dam_icon = 'icons/roguetown/mob/bodies/dam/dam_male.dmi'
	dam_icon_f = 'icons/roguetown/mob/bodies/dam/dam_female.dmi'
	hairyness = "t2"
	soundpack_m = /datum/voicepack/male
	soundpack_f = /datum/voicepack/female
	offset_features = list(OFFSET_ID = list(0,0), OFFSET_GLOVES = list(0,0), OFFSET_WRISTS = list(0,0),\
	OFFSET_CLOAK = list(0,0), OFFSET_FACEMASK = list(0,0), OFFSET_HEAD = list(0,0), \
	OFFSET_FACE = list(0,0), OFFSET_BELT = list(0,0), OFFSET_BACK = list(0,0), \
	OFFSET_NECK = list(0,0), OFFSET_MOUTH = list(0,0), OFFSET_PANTS = list(0,0), \
	OFFSET_SHIRT = list(0,0), OFFSET_ARMOR = list(0,0), OFFSET_HANDS = list(0,0), OFFSET_UNDIES = list(0,0), \
	OFFSET_ID_F = list(0,-1), OFFSET_GLOVES_F = list(0,0), OFFSET_WRISTS_F = list(0,0), OFFSET_HANDS_F = list(0,0), \
	OFFSET_CLOAK_F = list(0,0), OFFSET_FACEMASK_F = list(0,-1), OFFSET_HEAD_F = list(0,-1), \
	OFFSET_FACE_F = list(0,-1), OFFSET_BELT_F = list(0,-1), OFFSET_BACK_F = list(0,-1), \
	OFFSET_NECK_F = list(0,-1), OFFSET_MOUTH_F = list(0,-1), OFFSET_PANTS_F = list(0,0), \
	OFFSET_SHIRT_F = list(0,0), OFFSET_ARMOR_F = list(0,0), OFFSET_UNDIES_F = list(0,0))
	specstats = list("strength" = 0, "perception" = 1, "intelligence" = 1, "constitution" = 0, "endurance" = 0, "speed" = 1, "fortune" = 0)
	specstats_f = list("strength" = 0, "perception" = 1, "intelligence" = 1, "constitution" = 0, "endurance" = 0, "speed" = 1, "fortune" = 0)
	enflamed_icon = "widefire"

	customizers = list(
		/datum/customizer/organ/eyes/humanoid,
		/datum/customizer/bodypart_feature/hair/head/humanoid,
		/datum/customizer/bodypart_feature/hair/facial/humanoid,
		/datum/customizer/bodypart_feature/accessory,
	)
	body_markings = list(
		/datum/body_marking/tonage,
	)

/datum/species/human/halfelf/check_roundstart_eligible()
	return TRUE

/datum/species/human/halfelf/get_skin_list()
	return sortList(list(
		"Zizo-Cursed" = SKIN_COLOR_ZIZO_CURSED, // - (Pale)
		"Timber-Gronn" = SKIN_COLOR_TIMBER_GRONN, // - (White 1)
		"Solar-Hue" = SKIN_COLOR_SOLAR_HUE, // - (White 2)
		"Walnut-Stine" = SKIN_COLOR_WALNUT_STINE, // - (White 3)
		"Amber-Stained" = SKIN_COLOR_AMBER_STAINED, // - (White 4)
		"Joshua-Aligned" = SKIN_COLOR_JOSHUA_ALIGNED, // - (Middle-Eastern)
		"Arid-Birthed" = SKIN_COLOR_ARID_BIRTHED, // - (Black)
		"Parasite-Taineted" = SKIN_COLOUR_PARASITE_TAINTED, // - (Light purple)
		"Mushroom-Minded" = SKIN_COLOR_MUSHROOM_MINDED, // - (Mid purple)
		"Cave-Attuned" = SKIN_COLOR_CAVE_ATTUNED, // - (Deep purple)
	))

/datum/species/human/halfelf/get_hairc_list()
	return sortList(list(
	"black - oil" = "181a1d",
	"black - cave" = "201616",
	"black - rogue" = "2b201b",
	"black - midnight" = "1d1b2b",

	"brown - mud" = "362e25",
	"brown - oats" = "584a3b",
	"brown - grain" = "58433b",
	"brown - soil" = "48322a",

	"red - berry" = "b23434",
	"red - wine" = "82534c",
	"red - sunset" = "82462b",
	"red - blood" = "822b2b",
	"red - maroon" = "612929",

	"blond - pale" = "9d8d6e",
	"blond - dirty" = "88754f",
	"blond - drywheat" = "8f8766",
	"blond - strawberry" = "977033",

	"green - leaf" = "2f3c2e",
	"green - moss" = "3b3c2a",

	"white - ice" = "f4f4f4",
	"white - cavedew" = "dee9ed",
	"white - spiderweb" = "f4f4f4"

	))

/datum/species/human/halfelf/get_possible_names(gender = MALE)
	var/static/list/male_names = world.file2list('strings/rt/names/elf/elfwm.txt')
	var/static/list/female_names = world.file2list('strings/rt/names/elf/elfwf.txt')
	return (gender == FEMALE) ? female_names : male_names

/datum/species/human/halfelf/get_possible_surnames(gender = MALE)
	return null

/datum/species/human/halfelf/after_creation(mob/living/carbon/C)
	..()
	C.grant_language(/datum/language/elvish)
	to_chat(C, "<span class='info'>I can speak Elfish with ,e before my speech.</span>")
