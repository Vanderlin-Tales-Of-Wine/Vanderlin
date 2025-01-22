	/*==============*
	*				*
	*		Elf		*
	*				*
	*===============*/

//	( + Night Vision )


/mob/living/carbon/human/species/elf/snow
	race = /datum/species/elf/snow

/datum/species/elf/snow
	name = "Elf"
	id = "elf"
	desc = "<b>Elf</b><br>\
	Elves, the first species of Psydonia, are characterized by lengthened age, \
	low fertility, and magical aptitude originating from a vast array of tribal cultures and sub-races. \
	With the ascension of Zizo, the entire culture of snow-elves was all but destroyed, \
	leading the remaining tribes to live in fear and paranoia of suffering the same fate. \
	Many elves sought safety through mixing culture, positioning themselves under the watchful guard of their stronger humen counterparts. \
	A longstanding fued remains between elves and dwarves. Elven kind has never forgiven the dwarves for their destruction of homeland and \
	pillaging of natural resources within the former snow-elf territory. To elves, it was the greatest signifier of disrespect for those lost. "

	skin_tone_wording = "Tribal Identity"

	default_color = "FFFFFF"
	species_traits = list(EYECOLOR,HAIR,FACEHAIR,LIPS,OLDGREY)
	inherent_traits = list(TRAIT_NOMOBSWAP)
	default_features = list("mcolor" = "FFF", "ears" = "ElfW", "wings" = "None")
	use_skintones = 1
	disliked_food = NONE
	liked_food = NONE
	possible_ages = list(AGE_CHILD, AGE_ADULT, AGE_MIDDLEAGED, AGE_OLD)
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | RACE_SWAP | SLIME_EXTRACT
	limbs_icon_m = 'icons/roguetown/mob/bodies/m/met.dmi'
	limbs_icon_f = 'icons/roguetown/mob/bodies/f/ft.dmi'
	dam_icon = 'icons/roguetown/mob/bodies/dam/dam_male.dmi'
	dam_icon_f = 'icons/roguetown/mob/bodies/dam/dam_female.dmi'
	hairyness = "t1"
	mutant_bodyparts = list("ears")
	mutanteyes = /obj/item/organ/eyes/elf/less
	use_f = TRUE
	soundpack_m = /datum/voicepack/male/elf
	soundpack_f = /datum/voicepack/female/elf
	offset_features = list(OFFSET_ID = list(0,2), OFFSET_GLOVES = list(0,0), OFFSET_WRISTS = list(0,1),\
	OFFSET_CLOAK = list(0,2), OFFSET_FACEMASK = list(0,1), OFFSET_HEAD = list(0,1), \
	OFFSET_FACE = list(0,1), OFFSET_BELT = list(0,1), OFFSET_BACK = list(0,2), \
	OFFSET_NECK = list(0,1), OFFSET_MOUTH = list(0,2), OFFSET_PANTS = list(0,2), \
	OFFSET_SHIRT = list(0,2), OFFSET_ARMOR = list(0,2), OFFSET_HANDS = list(0,2), OFFSET_UNDIES = list(0,0), \
	OFFSET_ID_F = list(0,0), OFFSET_GLOVES_F = list(0,1), OFFSET_WRISTS_F = list(0,1), OFFSET_HANDS_F = list(0,1), \
	OFFSET_CLOAK_F = list(0,1), OFFSET_FACEMASK_F = list(0,0), OFFSET_HEAD_F = list(0,0), \
	OFFSET_FACE_F = list(0,0), OFFSET_BELT_F = list(0,1), OFFSET_BACK_F = list(0,0), \
	OFFSET_NECK_F = list(0,0), OFFSET_MOUTH_F = list(0,0), OFFSET_PANTS_F = list(0,1), \
	OFFSET_SHIRT_F = list(0,1), OFFSET_ARMOR_F = list(0,1), OFFSET_UNDIES_F = list(0,1))
	specstats = list("strength" = -1, "perception" = 1, "intelligence" = 1, "constitution" = -1, "endurance" = 0, "speed" = 2, "fortune" = 0)
	specstats_f = list("strength" = -1, "perception" = 1, "intelligence" = 1, "constitution" = -1, "endurance" = 0, "speed" = 2, "fortune" = 0)
	enflamed_icon = "widefire"
	patreon_req = 0

	customizers = list(
		/datum/customizer/organ/eyes/humanoid,
		/datum/customizer/bodypart_feature/hair/head/humanoid,
		/datum/customizer/bodypart_feature/hair/facial/humanoid,
		/datum/customizer/bodypart_feature/accessory,
	)
	body_markings = list(
		/datum/body_marking/tonage,
	)

/datum/species/elf/snow/check_roundstart_eligible()
	return TRUE

/datum/species/elf/snow/get_span_language(datum/language/message_language)
	if(!message_language)
		return
//	if(message_language.type == /datum/language/elvish)
//		return list(SPAN_SELF)
//	if(message_language.type == /datum/language/common)
//		return list(SPAN_SELF)
	return message_language.spans

/datum/species/elf/snow/get_skin_list()
	return sortList(list(
		"Plain Elf" = SKIN_COLOR_PLAIN_ELF, // - (White 2)
		"Mountain Elf" = SKIN_COLOR_MOUNTAIN_ELF, // - (White 3)
		"Coastal Elf" = SKIN_COLOR_COASTAL_ELF, // - (White 4)
		"Wood Elf" = SKIN_COLOR_WOOD_ELF, // - (Mediterranean 1)
		"Sea Elf" = SKIN_COLOR_SEA_ELF, // - (Mediterranean 2)
		"Jungle Elf" = SKIN_COLOR_JUNGLE_ELF, // - (Latin)
		"Savannah Elf" = SKIN_COLOR_SAVANNAH_ELF, // - (Middle-Eastern)
		"Sand Elf" = SKIN_COLOR_SAND_ELF, // - (Black 1)
		"Crimson Elf" = SKIN_COLOR_CRIMSON_ELF, // - (Black2)
	))

/datum/species/elf/snow/get_hairc_list()
	return sortList(list(
	"black - oil" = "181a1d",
	"black - cave" = "201616",
	"black - rogue" = "2b201b",
	"black - midnight" = "1d1b2b",

	"blond - pale" = "9d8d6e",
	"blond - dirty" = "88754f",
	"blond - drywheat" = "d5ba7b",
	"blond - strawberry" = "c69b71",

	"white - snow" = "dee9ed",
	"white - ice" = "f4f4f4",

	"brown - mud" = "362e25",
	"brown - oats" = "584a3b",
	"brown - grain" = "58433b",
	"brown - soil" = "48322a",
	"brown - bark" = "2d1300",

	"red - berry" = "b23434",
	"red - wine" = "82534c",
	"red - sunset" = "82462b",
	"red - blood" = "822b2b",
	"red - maroon" = "612929",

	"green - grass" = "2a482c",
	"green - swamp" = "3b482a",
	"green - leaf" = "2f3c2e",
	"green - moss" = "3b3c2a"

	))

/datum/species/elf/snow/random_name(gender,unique,lastname)

	var/randname
	if(unique)
		if(gender == MALE)
			for(var/i in 1 to 10)
				randname = pick( world.file2list("strings/rt/names/elf/elfwm.txt") )
				if(!findname(randname))
					break
		if(gender == FEMALE)
			for(var/i in 1 to 10)
				randname = pick( world.file2list("strings/rt/names/elf/elfwf.txt") )
				if(!findname(randname))
					break
	else
		if(gender == MALE)
			randname = pick( world.file2list("strings/rt/names/elf/elfwm.txt") )
		if(gender == FEMALE)
			randname = pick( world.file2list("strings/rt/names/elf/elfwf.txt") )
	return randname

/datum/species/elf/snow/random_surname()
	return " [pick(world.file2list("strings/rt/names/elf/elfwlast.txt"))]"

/datum/species/elf/snow/get_accent_list()
	return strings("russian_replacement.json", "russian")
