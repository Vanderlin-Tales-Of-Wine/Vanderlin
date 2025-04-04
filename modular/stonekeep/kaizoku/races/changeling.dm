	/*==============*
	*				*
	*   Changeling 	*
	*				*
	*===============*/

//	( + Hard Bite perk )
//	( - 'Bite' intention always set a warning state. )
/*
>>>MAJOR NEED! Please, someone code in a "Felinid"-like system for the changeling, but instead of CRINGE 'CUTESY' BS, I want
help to portray Changeling's bloodthirsty nature. The 'Eldritch Jaw', which is essentially, "wagging_tail" system
for the mouth THAT opens with a automatic emote (bite intention).<<<
Future plan:
-Physical Extension, Kitsune-bi; Immune to fire, put fires on others by touch and need no water, but takes damage from water sources, including water splash from buckets.
-Can only eat meat from all sources. Uncooked or cooked meat, fat, tallows, bones, corpses, gibs. Cannot eat vegetables, cereals, fruits. Exceptions only comes to Sake and Rice.
*/

/mob/living/carbon/human/species/abyssariad/changeling
	race = /datum/species/abyssariad/changeling

/datum/species/abyssariad/changeling
	name = "Changeling"
	id = "abyssariad"
	desc = "<b>Storm branched Champions</b><br>\
	Molded from Abyssor's tumultuous embrace of storm and will, the Changelings are a warrior, demiurgic race \
	deeply bonded with honor and ethos that intertwines with the tempestuous forces of Abyssor, \
	never set on a balance, all Changelings are extreme as the storms, with the tendency to be both \
	hermeticly humble and quick tempered, and know for either loving duel for honor's sake \
	- or being the most radical martial pacifists on Grimoria. Their society almost crumbled \
	during The Bloody Apotheosis, but their bronze-age traditions lives on together with a deep \
	hatred for all things Graggar. Their biology allows high degree of fleshbending, their faces exactly alike masks. \
	They are noble souls that, when not belonging to military or clerical jobs, usually partakes \
	in the society's intelligentsia division, usually as astronomers, alchemists and surgeons."

	skin_tone_wording = "Championage Branch"

	default_color = "FFFFFF"
	species_traits = list(EYECOLOR,HAIR,FACEHAIR,LIPS)
	inherent_traits = list(TRAIT_NOMOBSWAP)
	default_features = list("mcolor" = "FFF", "ears" = "Upright", "tail" = "Onetail" )
	use_skintones = 1
	possible_ages = list(AGE_IMMORTAL) //Abyssariads are Immortal. However, if they become stray from Abyssor - they suffer severe dementia, and after some decades, become Dais.
//	skinned_type = /obj/item/stack/sheet/animalhide/human
	disliked_food = NONE
	liked_food = MEAT
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | RACE_SWAP | SLIME_EXTRACT
	limbs_icon_m = 'modular/stonekeep/kaizoku/icons/abyssariad_bodies/male/mt_kit.dmi'
	limbs_icon_f = 'modular/stonekeep/kaizoku/icons/abyssariad_bodies/female/ft_kit.dmi'
	dam_icon = 'icons/roguetown/mob/bodies/dam/dam_male.dmi'
	dam_icon_f = 'icons/roguetown/mob/bodies/dam/dam_female.dmi'
	hairyness = ""
	mutant_bodyparts = list("ears","tail_human")
	use_f = FALSE
	soundpack_m = /datum/voicepack/male/abyssariad
	soundpack_f = /datum/voicepack/female/abyssariad
	offset_features = list(OFFSET_ID = list(0,1), OFFSET_GLOVES = list(0,1), OFFSET_WRISTS = list(0,1),\
	OFFSET_CLOAK = list(0,1), OFFSET_FACEMASK = list(0,1), OFFSET_HEAD = list(0,1), \
	OFFSET_FACE = list(0,1), OFFSET_BELT = list(0,1), OFFSET_BACK = list(0,1), \
	OFFSET_NECK = list(0,1), OFFSET_MOUTH = list(0,1), OFFSET_PANTS = list(0,1), \
	OFFSET_SHIRT = list(0,1), OFFSET_ARMOR = list(0,1), OFFSET_HANDS = list(0,1), OFFSET_UNDIES = list(0,1), \
	OFFSET_ID_F = list(0,-1), OFFSET_GLOVES_F = list(0,1), OFFSET_WRISTS_F = list(0,1), OFFSET_HANDS_F = list(0,1), \
	OFFSET_CLOAK_F = list(0,1), OFFSET_FACEMASK_F = list(0,0), OFFSET_HEAD_F = list(0,0), \
	OFFSET_FACE_F = list(0,0), OFFSET_BELT_F = list(0,1), OFFSET_BACK_F = list(0,0), \
	OFFSET_NECK_F = list(0,0), OFFSET_MOUTH_F = list(0,0), OFFSET_PANTS_F = list(0,1), \
	OFFSET_SHIRT_F = list(0,1), OFFSET_ARMOR_F = list(0,1), OFFSET_UNDIES_F = list(0,1))
	// Lore explanation for stats:
	// Qualities: +Dense muscles ; higher fast-twitch fiber
	// =>Disadvantage: -Lower Stationary Acuity; They are better at noticing movements, bad at noticing stationary objects. Bad with bows by nature. Foxes have that IRL because of nightvision. At least they have more reason to have it than Dark Elves.
	// -Low fat mass, high muscle mass. Streamlined body structure that minimizes resistance and maximizes intense muscular movements.
	specstats = list("strength" = 0, "perception" = -2, "intelligence" = 2, "constitution" = -1, "endurance" = 1, "speed" = 1, "fortune" = 0) // Don't even bother making each gender different. Abyssariads are equals in championage.
	specstats_f = list("strength" = 0, "perception" = -2, "intelligence" = 2, "constitution" = -1, "endurance" = 1, "speed" = 1, "fortune" = 0)
	enflamed_icon = "widefire"
	mutanttongue = /obj/item/organ/tongue/kitsune
//	minrace_pq = 0
	// 1(str)-1+1-0.5+0.5+1(spd)+0 = 2 specstats. Balance adjusted.
	//statsvalue reference by Dova
	//Strength and Speed are 1, everything else is .5, all races are +2 or +3 except Humen
	customizers = list(
		/datum/customizer/organ/eyes/humanoid,
		/datum/customizer/bodypart_feature/hair/head/humanoid,
		/datum/customizer/bodypart_feature/hair/facial/humanoid,
		/datum/customizer/bodypart_feature/accessory
	)
	body_markings = list(
		/datum/body_marking/tonage,
	)

/datum/species/abyssariad/changeling/get_span_language(datum/language/message_language)
	if(!message_language)
		return
//	if(message_language.type == /datum/language/abyssal)
//		return list(SPAN_ABYSSAL)
//	if(message_language.type == /datum/language/common)
//		return list(SPAN_SELF)
	return message_language.spans

/datum/species/abyssariad/changeling/check_roundstart_eligible()
	return TRUE

/datum/species/abyssariad/changeling/get_skin_list()
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
	))


/datum/species/abyssariad/changeling/get_hairc_list()
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

/datum/species/abyssariad/changeling/random_name(gender,unique,lastname)
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

/datum/species/abyssariad/changeling/random_surname()
	return " [pick(world.file2list("strings/rt/names/abyssariad/abyssnorlast.txt"))]"

// Commented out. All this was a code FAILURE by my part, and I require help.
/*
/datum/species/abyssariad/changeling/can_wag_tongue(mob/living/carbon/human/H)
	return ("kitsune_tongue" in mutant_bodyparts) || ("waggingkitsune_tongue" in mutant_bodyparts)
/datum/species/abyssariad/changeling/is_wagging_tongue(mob/living/carbon/human/H)
	return ("waggingkitsune_tongue" in mutant_bodyparts)
/datum/species/abyssariad/changeling/start_wagging_tongue(mob/living/carbon/human/H)
	if("changeling" in mutant_bodyparts)
		mutant_bodyparts -= "kitsune_tongue"
		mutant_bodyparts |= "waggingkitsune_tongue"
	H.update_body()
/datum/species/abyssariad/changeling/stop_wagging_tongue(mob/living/carbon/human/H)
	if("waggingkitsune_tongue" in mutant_bodyparts)
		mutant_bodyparts -= "waggingkitsune_tongue"
		mutant_bodyparts |= "kitsune_tongue"
	H.update_body()
*/
