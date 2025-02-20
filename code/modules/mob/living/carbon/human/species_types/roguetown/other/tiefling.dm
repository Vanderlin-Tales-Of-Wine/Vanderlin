	/*==============*
	*				*
	*	Tiefling	*
	*				*
	*===============*/

/mob/living/carbon/human/species/tieberian
	race = /datum/species/tieberian

/datum/species/tieberian
	name = "Tiefling"
	id = "tiefling"
	desc = "<b>Tiefling</b><br> \
	Tieflings; also known as Infernal-Spawn, Hell-Bloods, Surface-Devils, and perhaps most humourously, thief-lings.\
	Tieflings cannot reproduce with mortals, and thus are spawn of either devils, demons, or other tieflings. \
	Their treatment ranges from shunning to distrust, depending on the region. Shopkeeps and merchants always keep a wary eye out when \
	a tiefling passes by. The resentment feed into itself, leading to higher rates of tiefling ire and thievery against other species. \
	Many tieflings resign to seeking a solitary and nomadic life, huddled in groups outside the watchful eyes of others. \
	They also tend to be extremely perceptive and paranoid, as luck is rarely on their side. \
	Oddly positioned scales, hollow bones, and other varying oddities that may appear in a tiefling's biology \
	make them considerably fragile. If to make matters worse, their hellish progenitors have left them a destiny of misfortune, \
	though perhaps their immunity to fire opens new opportunities... \
	A tiefling may develop any number of hellish features, a wide range of horns, potential hooves, odd spines and spikes, or scales. \
	It is not uncommon for a tiefling to be generally unpleasant to look at in the eye of the commonfolk. \
	\
	THIS IS A DISCRIMINATED SPECIES. EXPECT A MORE DIFFICULT EXPERIENCE. PLAY AT YOUR OWN RISK."

	skin_tone_wording = "Progenitor"

	species_traits = list(EYECOLOR,HAIR,FACEHAIR,LIPS,STUBBLE,OLDGREY)
	inherent_traits = list(TRAIT_NOMOBSWAP,TRAIT_NOFIRE)
	default_features = list("mcolor" = "FFF", "ears" = "ElfW", "tail_human" = "TiebTail", "horns" = "TiebHorns")
	use_skintones = 1
	disliked_food = NONE
	liked_food = NONE
	possible_ages = list(AGE_CHILD, AGE_ADULT, AGE_MIDDLEAGED, AGE_OLD)
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | RACE_SWAP | SLIME_EXTRACT
	limbs_icon_m = 'icons/roguetown/mob/bodies/m/mm.dmi'
	limbs_icon_f = 'icons/roguetown/mob/bodies/f/fm.dmi'
	dam_icon = 'icons/roguetown/mob/bodies/dam/dam_male.dmi'
	dam_icon_f = 'icons/roguetown/mob/bodies/dam/dam_female.dmi'
	hairyness = "t3"
	mutant_bodyparts = list("ears","tail_human","horns")
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
	specstats = list("strength" = 0, "perception" = 2, "intelligence" = 1, "constitution" = -1, "endurance" = 0, "speed" = 1, "fortune" = -1)
	specstats_f = list("strength" = 0, "perception" = 2, "intelligence" = 1, "constitution" = -1, "endurance" = 0, "speed" = 1, "fortune" = -1)
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

/datum/species/tieberian/check_roundstart_eligible()
	return TRUE

/datum/species/tieberian/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	..()
	RegisterSignal(C, COMSIG_MOB_SAY, PROC_REF(handle_speech))
	C.grant_language(/datum/language/common)
	C.grant_language(/datum/language/hellspeak)

/datum/species/tieberian/after_creation(mob/living/carbon/C)
	..()
//	if(!C.has_language(/datum/language/sandspeak))
	C.grant_language(/datum/language/hellspeak)
	to_chat(C, "<span class='info'>I can speak Infernal with ,h before my speech.</span>")

/datum/species/tieberian/on_species_loss(mob/living/carbon/C)
	. = ..()
	UnregisterSignal(C, COMSIG_MOB_SAY)
	C.remove_language(/datum/language/hellspeak)

/datum/species/tieberian/handle_speech(datum/source, list/speech_args)
	. = ..()
	var/message = speech_args[SPEECH_MESSAGE]
	if(message)
		if(message[1])
			if(message[1] != "*")
				message = " [message]"
				var/list/accent_words = strings("accent_universal.json", "universal")

				for(var/key in accent_words)
					var/value = accent_words[key]
					if(islist(value))
						value = pick(value)

					message = replacetextEx(message, " [uppertext(key)]", " [uppertext(value)]")
					message = replacetextEx(message, " [capitalize(key)]", " [capitalize(value)]")
					message = replacetextEx(message, " [key]", " [value]")

	speech_args[SPEECH_MESSAGE] = trim(message)

/datum/species/tieberian/qualifies_for_rank(rank, list/features)
	return TRUE

/datum/species/tieberian/get_skin_list()
	return sortList(list(
		"Crimson Land" = SKIN_COLOR_CRIMSON_LAND, // - (Bright red)
		"Sun Stained" = SKIN_COLOR_SUNSTAINED, // - (Dark orange)
		"Sundered" = SKIN_COLOR_SUNDERED, //  - (Orange)
		"Zarkana" = SKIN_COLOR_ARCANA, // - (Dark violet)
		"Zarconum" = SKIN_COLOR_ZARCONUM, // - (Pink)
		"Flayer" = SKIN_COLOR_FLAYER, // - (Purple)
		"Abyssium" = SKIN_COLOR_ABYSS, // - (Navy blue)
		"Castillian" = SKIN_COLOR_CASTILLIAN, // - (Pale red)
		"Asturias" = SKIN_COLOR_ASTURIAS, // - (Clay red)
		"Vaquero" = SKIN_COLOR_VAQUERO, // - (Earthly red)
		"Zanguine" = SKIN_COLOR_ZANGUINE, // - (Dark violet)
		"Ash" = SKIN_COLOR_ASH, // - (Pale blue)
		"Arlenneth" = SKIN_COLOR_ARLENNETH, // - (Lavender blue)
	))

/datum/species/tieberian/get_hairc_list()
	return sortList(list(
	"black - oil" = "181a1d",
	"black - cave" = "201616",
	"black - rogue" = "2b201b",
	"black - midnight" = "1d1b2b",

	"blond - pale" = "9d8d6e",
	"blond - dirty" = "88754f",
	"blond - drywheat" = "d5ba7b",
	"blond - strawberry" = "c69b71",

	"purple - arcane" = "3f2f42",

	"blue - abyss" = "09282d",

	"red - demonic" = "480808",
	"red - impish" = "641010",
	"red - rubescent" = "8d5858"

	))

/datum/species/tieberian/random_name(gender,unique,lastname)

	var/randname
	if(unique)
		if(gender == MALE)
			for(var/i in 1 to 10)
				randname = pick( world.file2list("strings/rt/names/other/tiefm.txt") )
				if(!findname(randname))
					break
		if(gender == FEMALE)
			for(var/i in 1 to 10)
				randname = pick( world.file2list("strings/rt/names/other/tieff.txt") )
				if(!findname(randname))
					break
	else
		if(gender == MALE)
			randname = pick( world.file2list("strings/rt/names/other/tiefm.txt") )
		if(gender == FEMALE)
			randname = pick( world.file2list("strings/rt/names/other/tieff.txt") )
	return randname

/datum/species/tieberian/random_surname()
	return " [pick(world.file2list("strings/rt/names/other/tieflast.txt"))]"

/datum/species/tieberian/get_accent_list()
	return strings("spanish_replacement.json", "spanish")
