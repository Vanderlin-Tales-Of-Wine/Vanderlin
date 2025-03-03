	/*==============*
	*				*
	*  	Skylancer  	*
	*				*
	*===============*/

//	( Not done yet. But hopefully temporary flying. )
//	( Not done yet, but hopefully easily breakable bones. )

/mob/living/carbon/human/species/abyssariad/skylancer
	race = /datum/species/abyssariad/skylancer

/datum/species/abyssariad/skylancer
	name = "Skylancer"
	id = "abyssariad"
	desc = "<b>Sky branched Champions</b><br>\
	Molded from Abyssor's relentless skies, the avian denmorians are a inquisitive race with lithe bodies \
	glaceful as the flows of the tides to navigate and glide across the rocky shores and crashing \
	waves of their currently destroyed domain to provide information, supplies and messages in any \
	battlefield. Just like the skies they branched from, they are vast and enduring - if not \
	mysterious and deep, often appearing aloof and solitary to outsiders. Their society almost crumbled \
	during The Bloody Apotheosis, but their bronze-age traditions lives on together with a deep \
	hatred for all things Graggar. They are refined souls that, when not belonging to military or clerical jobs, \
	usually partakes in the society's mercantile division, usually as merchants, bankers and gem lapidary. \
	Their specialized syrinxs makes them complex vocalizators for spionage and disguise."

	skin_tone_wording = "Championage Branch"

	default_color = "FFFFFF"
	species_traits = list(EYECOLOR,HAIR,FACEHAIR,LIPS)
	inherent_traits = list(TRAIT_NOMOBSWAP)
	default_features = list("mcolor" = "FFF", "ears" = "TenguS", "tail_human" = "TenguV")
	use_skintones = 1
	possible_ages = list(AGE_IMMORTAL) //Abyssariads are Immortal. However, if they become stray from Abyssor's will - they suffer severe dementia after some decades.
//	skinned_type = /obj/item/stack/sheet/animalhide/human
	disliked_food = NONE
	liked_food = NONE
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | RACE_SWAP | SLIME_EXTRACT
	limbs_icon_m = 'modular/stonekeep/kaizoku/icons/abyssariad_bodies/male/mtan.dmi'
	limbs_icon_f = 'modular/stonekeep/kaizoku/icons/abyssariad_bodies/female/ftan.dmi'
	dam_icon = 'icons/roguetown/mob/bodies/dam/dam_male.dmi'
	dam_icon_f = 'icons/roguetown/mob/bodies/dam/dam_female.dmi'
	hairyness = ""
	mutant_bodyparts = list("ears","tail_human")
	use_f = TRUE
	soundpack_m = /datum/voicepack/male/abyssariad
	soundpack_f = /datum/voicepack/female/abyssariad
	offset_features = list(OFFSET_ID = list(0,2), OFFSET_GLOVES = list(0,0), OFFSET_WRISTS = list(0,1),\
	OFFSET_CLOAK = list(0,2), OFFSET_FACEMASK = list(0,1), OFFSET_HEAD = list(0,1), \
	OFFSET_FACE = list(0,1), OFFSET_BELT = list(0,1), OFFSET_BACK = list(0,2), \
	OFFSET_NECK = list(0,1), OFFSET_MOUTH = list(0,2), OFFSET_PANTS = list(0,2), \
	OFFSET_SHIRT = list(0,2), OFFSET_ARMOR = list(0,2), OFFSET_HANDS = list(0,2), OFFSET_UNDIES = list(0,0), \
	OFFSET_ID_F = list(0,-1), OFFSET_GLOVES_F = list(0,0), OFFSET_WRISTS_F = list(0,0), OFFSET_HANDS_F = list(0,0), \
	OFFSET_CLOAK_F = list(0,0), OFFSET_FACEMASK_F = list(0,-1), OFFSET_HEAD_F = list(0,-1), \
	OFFSET_FACE_F = list(0,-1), OFFSET_BELT_F = list(0,0), OFFSET_BACK_F = list(0,-1), \
	OFFSET_NECK_F = list(0,-1), OFFSET_MOUTH_F = list(0,-1), OFFSET_PANTS_F = list(0,0), \
	OFFSET_SHIRT_F = list(0,0), OFFSET_ARMOR_F = list(0,0), OFFSET_UNDIES_F = list(0,0))
	specstats = list("strength" = -1, "perception" = 2, "intelligence" = 0, "constitution" = -2, "endurance" = 2, "speed" = 2, "fortune" = 0)
	specstats_f = list("strength" = -1, "perception" = 2, "intelligence" = 0, "constitution" = -2, "endurance" = 2, "speed" = 2, "fortune" = 0) // Don't even bother making each gender different. Abyssariads are equals in championage.
	enflamed_icon = "widefire"
	mutanteyes = /obj/item/organ/eyes/rogue/tengu
//	minrace_pq = 0

	customizers = list(
		/datum/customizer/organ/eyes/humanoid,
		/datum/customizer/bodypart_feature/hair/head/humanoid,
		/datum/customizer/bodypart_feature/hair/facial/humanoid,
		/datum/customizer/bodypart_feature/accessory,
	)
	body_markings = list(
		/datum/body_marking/tonage,
	)

/datum/species/abyssariad/skylancer/get_span_language(datum/language/message_language)
	if(!message_language)
		return
//	if(message_language.type == /datum/language/abyssal)
//		return list(SPAN_ABYSSAL)
	return message_language.spans

/datum/species/abyssariad/skylancer/check_roundstart_eligible()
	return TRUE

/datum/species/abyssariad/skylancer/get_skin_list()
	return sortList(list(
		"Oathbound Muqian" = SKIN_COLOR_OATHBOUND_MUQIAN,
		"Oathbound Kaizoku" = SKIN_COLOR_OATHBOUND_KAIZOKU,
		"Oathbound Shuhen" = SKIN_COLOR_OATHBOUND_SHUHEN,
		"Oathbound Linyou" = SKIN_COLOR_OATHBOUND_LINYOU,
		"Oathbound Dustwalker" = SKIN_COLOR_OATHBOUND_DUSTWALKER,
		"Warpcaster Muqian" = SKIN_COLOR_WARPCASTER_MUQIAN,
		"Warpcaster Kaizoku" = SKIN_COLOR_WARPCASTER_KAIZOKU,
		"Warpcaster Shuhen" = SKIN_COLOR_WARPCASTER_SHUHEN,
		"Warpcaster Linyou" = SKIN_COLOR_WARPCASTER_LINYOU,
		"Peppersblow Warpcaster" = SKIN_COLOR_PEPPERSBLOW,
	))


/datum/species/abyssariad/skylancer/get_hairc_list()
	return sortList(list(
	"blond - pale" = "9d8d6e",
	"blond - dirty" = "88754f",
	"blond - drywheat" = "d5ba7b",
	"blond - strawberry" = "c69b71",

	"brown - mud" = "362e25",
	"brown - oats" = "584a3b",
	"brown - grain" = "58433b",
	"brown - soil" = "48322a",

	"black - oil" = "181a1d",
	"black - cave" = "201616",
	"black - rogue" = "2b201b",
	"black - midnight" = "1d1b2b",

	"red - berry" = "48322a",
	"red - wine" = "82534c",
	"red - sunset" = "82462b",
	"red - blood" = "822b2b",

	"white - platinum" = "f8f3f3",
	"white - silver" = "ddddc8",
	"white - oceanid" = "141f1f"

	))

/datum/species/abyssariad/skylancer/random_name(gender,unique,lastname)
	var/randname
	if(unique)
		if(gender == MALE)
			for(var/i in 1 to 10)
				randname = pick( world.file2list("strings/rt/names/abyssariad/abyssnorm.txt") )
				if(!findname(randname))
					break
		if(gender == FEMALE)
			for(var/i in 1 to 10)
				randname = pick( world.file2list("strings/rt/names/abyssariad/abyssnorf.txt") )
				if(!findname(randname))
					break
	else
		if(gender == MALE)
			randname = pick( world.file2list("strings/rt/names/abyssariad/abyssnorm.txt") )
		if(gender == FEMALE)
			randname = pick( world.file2list("strings/rt/names/abyssariad/abyssnorf.txt") )
	randname += " Clanless"
	return randname

/datum/species/abyssariad/skylancer/random_surname()
	return " [pick(world.file2list("strings/rt/names/abyssariad/abyssnorm.txt"))]"
