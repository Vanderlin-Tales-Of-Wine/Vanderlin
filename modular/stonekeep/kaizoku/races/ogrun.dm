	/*==============*
	*				*
	*	  ogrun	  	*
	*				*
	*===============*/

//	( Not done yet. But hopefully something related to endurance. )
//	( Not done yet, but hopefully something quite goreful. )

/mob/living/carbon/human/species/abyssariad/ogrun //Remember to code in abyssal powers that forces Orcs to become Onis if it is used with specific purifying ways.
	race = /datum/species/abyssariad/ogrun

/datum/species/abyssariad/ogrun
	name = "Ogrun"
	id = "abyssariad"
	desc = "<b>Island Branched Champions</b><br>\
	Created from Abyssor's purifying artifacts under the guide of other Abyssariads, \
	the Ogrun are a stoic race, with stout and sturdy bodies equal to wide trunked trees. \
	Just like the islands that sprinkled the ocean's surface, the Onis are individuals \
	bearing the constant waves and storms of life. It is set in history that Onis were \
	recovered orcs from the Bloody Apotheosis under the effects of Abyssor's Grey Dreams, \
	and under mercy instead of carnage, were purified by Abyssal artifacts into the \
	complete removal of their graggarious demonic corruption, unrooting the evil for the \
	forevermore. They are rekindled souls that, when not belonging to military or clerical jobs, \
	usually partakes in the society's industrial division, usually as blacksmiths, artisans and architects."

	skin_tone_wording = "Championage Branch"

	default_color = "FFFFFF"
	species_traits = list(EYECOLOR,HAIR,FACEHAIR,LIPS,STUBBLE)
	inherent_traits = list(TRAIT_NOMOBSWAP)
	default_features = list("mcolor" = "FFF", "ears" = "Ogrun", "horns" = "Onihorn")
	mutant_bodyparts = list("ears","horns")
	use_skintones = 1
	possible_ages = list(AGE_IMMORTAL) //Abyssariads are Immortal. However, Onis are the newest ones on the fold, and they become Orcs mentally if they stray away from Abyssor.
	max_age = 430 //The year Onis became part of the Abyssariads. Roughly after the Blood Apotheosis
//	skinned_type = /obj/item/stack/sheet/animalhide/human
	disliked_food = NONE
	liked_food = MEAT
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | RACE_SWAP | SLIME_EXTRACT
	limbs_icon_m = 'icons/roguetown/mob/bodies/m/mt_muscular.dmi'
	limbs_icon_f = 'icons/roguetown/mob/bodies/f/ft_muscular.dmi'
	dam_icon = 'icons/roguetown/mob/bodies/dam/dam_male.dmi'
	dam_icon_f = 'icons/roguetown/mob/bodies/dam/dam_male.dmi'
	hairyness = "t2"
	use_m = TRUE
	soundpack_m = /datum/voicepack/male/abyssariad
	soundpack_f = /datum/voicepack/female/abyssariad
	offset_features = list(OFFSET_ID = list(0,1), OFFSET_GLOVES = list(0,1), OFFSET_WRISTS = list(0,1),\
	OFFSET_CLOAK = list(0,1), OFFSET_FACEMASK = list(0,1), OFFSET_HEAD = list(0,1), \
	OFFSET_FACE = list(0,1), OFFSET_BELT = list(0,1), OFFSET_BACK = list(0,1), \
	OFFSET_NECK = list(0,1), OFFSET_MOUTH = list(0,1), OFFSET_PANTS = list(0,1), \
	OFFSET_SHIRT = list(0,1), OFFSET_ARMOR = list(0,1), OFFSET_HANDS = list(0,1), OFFSET_UNDIES = list(0,1), \
	OFFSET_ID_F = list(0,1), OFFSET_GLOVES_F = list(0,1), OFFSET_WRISTS_F = list(0,1), OFFSET_HANDS_F = list(0,1), \
	OFFSET_CLOAK_F = list(0,1), OFFSET_FACEMASK_F = list(0,1), OFFSET_HEAD_F = list(0,1), \
	OFFSET_FACE_F = list(0,1), OFFSET_BELT_F = list(0,1), OFFSET_BACK_F = list(0,1), \
	OFFSET_NECK_F = list(0,1), OFFSET_MOUTH_F = list(0,1), OFFSET_PANTS_F = list(0,1), \
	OFFSET_SHIRT_F = list(0,1), OFFSET_ARMOR_F = list(0,1), OFFSET_UNDIES_F = list(0,1))
	specstats = list("strength" = 1, "perception" = -1, "intelligence" = -1, "constitution" = 2, "endurance" = 2, "speed" = 0, "fortune" = 0)
	specstats_f = list("strength" = 1, "perception" = -1, "intelligence" = -1, "constitution" = 2, "endurance" = 2, "speed" = 0, "fortune" = 0) // Don't even bother making each gender different. Abyssariads are equals in championage.
	enflamed_icon = "widefire"
//	minrace_pq = 0
// 1(str)-0.5-0.5+1+1+0(spd)+0 = 2 = 2.0 specstats. Balance adjusted.
//statsvalue reference by Dova
//Strength and Speed are 1, everything else is .5, all races are +2 or +3 except Humen. So we keeping it as +2 for balance reasons.


	customizers = list(
		/datum/customizer/organ/eyes/humanoid,
		/datum/customizer/bodypart_feature/hair/head/humanoid,
		/datum/customizer/bodypart_feature/hair/facial/humanoid,
		/datum/customizer/bodypart_feature/accessory,
	)
	body_markings = list(
		/datum/body_marking/tonage,
	)

/datum/species/abyssariad/ogrun/check_roundstart_eligible()
	return TRUE

/datum/species/abyssariad/ogrun/get_skin_list()
	return sortList(list(
		"Defiant Oni" = SKIN_COLOR_DEFIANCE,
		"Sanguine Oni" = SKIN_COLOR_DEFIANCE_SANGUINE,
		"Stable Oni" = SKIN_COLOR_STABILITY,
		"Intellectual Oni" = SKIN_COLOR_STABILITY_INTELLECT,
		"Audacious Oni" = SKIN_COLOR_AUDACY,
		"Mysterious Oni" = SKIN_COLOR_AUDACY_MYSTERY,
		"Recently Purified" = SKIN_COLOR_BLANK_PURIFICATED,
	))

/datum/species/abyssariad/ogrun/get_hairc_list()
	return sortList(list(
	"black - oil" = "181a1d",
	"black - cave" = "201616",
	"black - rogue" = "2b201b",
	"black - midnight" = "1d1b2b",

	"brown - mud" = "362e25",
	"brown - oats" = "584a3b",
	"brown - grain" = "58433b",
	"brown - soil" = "48322a",

	"red - berry" = "48322a",
	"red - wine" = "82534c",
	"red - sunset" = "82462b",
	"red - blood" = "822b2b",

	"white - snow" = "dee9ed",
	"white - ice" = "f4f4f4",

	"blond - pale" = "9d8d6e",
	"blond - dirty" = "88754f",
	"blond - drywheat" = "8f8766",
	"blond - strawberry" = "977033",

	"white - platinum" = "f8f3f3",
	"white - silver" = "ddddc8",
	"white - oceanid" = "141f1f"


	))

/datum/species/abyssariad/ogrun/get_span_language(datum/language/message_language)
	if(!message_language)
		return
//	if(message_language.type == /datum/language/abyssal)
//		return list(SPAN_ABYSSAL)
	return message_language.spans

/datum/species/abyssariad/ogrun/random_name(gender,unique,lastname)
	var/randname
	if(unique)
		if(gender == MALE)
			for(var/i in 1 to 10)
				randname = pick( world.file2list("strings/rt/names/abyssariad/onim.txt") )
				if(!findname(randname))
					break
		if(gender == FEMALE)
			for(var/i in 1 to 10)
				randname = pick( world.file2list("strings/rt/names/abyssariad/onif.txt") )
				if(!findname(randname))
					break
	else
		if(gender == MALE)
			randname = pick( world.file2list("strings/rt/names/abyssariad/onim.txt") )
		if(gender == FEMALE)
			randname = pick( world.file2list("strings/rt/names/abyssariad/onif.txt") )
	randname += " Clanless"
	return randname

/datum/species/abyssariad/ogrun/random_surname()
	return " [pick(world.file2list("strings/rt/names/abyssariad/abyssnorm.txt"))]"
