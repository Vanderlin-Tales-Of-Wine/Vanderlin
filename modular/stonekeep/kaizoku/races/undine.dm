	/*==============*
	*				*
	*	  Undine  	*
	*				*
	*===============*/

//	( Not done yet. But hopefully breathing underwater. )
//	( Not sure what to give them as debuff tbh. )

/mob/living/carbon/human/species/elf/undine
	race = /datum/species/elf/undine

/datum/species/elf/undine
	name = "Undine"
	id = "elf"
	desc = "<b>Undine</b><br>\
	An amalgamation between Goblins and Elves that arrived at the Fog islands centuries \
	ago, long corrupted by demonic essence and alchemical misconducts over generations, \
	they now possess features that blends amphibious traits from Goblin's lineage, \
	including moist, permeable skin and a large shell on their back. They are a small, \
	water-dwelling creatures that inhabit rivers and ponds, often living tribalistic, \
	hedonistic lives, feared by those aware of their mischievous, people-drowning nature. \
	One may say these are misunderstood rituals of trust, others warns the others that it is \
	a sacrifice to the spirits they believe that exists. They have a natural, biological \
	antipathy and abhorrence to humens - and a mutual alliance with Abyssariads."
	default_color = "FFFFFF"
	species_traits = list(EYECOLOR,HAIR,FACEHAIR,LIPS,OLDGREY)
	inherent_traits = list(TRAIT_NOMOBSWAP)
	default_features = list("mcolor" = "FFF", "ears" = "Kappae", "tail_human" = "Kappav")
	use_skintones = 1
//	skinned_type = /obj/item/stack/sheet/animalhide/human
	disliked_food = NONE
	liked_food = NONE
	use_f = TRUE
	mutant_bodyparts = list("ears","tail_human")
	possible_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_OLD)
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | RACE_SWAP | SLIME_EXTRACT
	limbs_icon_m = 'modular/stonekeep/kaizoku/icons/abyssariad_bodies/male/ms_kappa.dmi'
	limbs_icon_f = 'modular/stonekeep/kaizoku/icons/abyssariad_bodies/female/fs_kappa.dmi'
	dam_icon = 'icons/roguetown/mob/bodies/dam/dam_male.dmi'
	dam_icon_f = 'icons/roguetown/mob/bodies/dam/dam_female.dmi'

	hairyness = ""
	use_f = FALSE
	soundpack_m = /datum/voicepack/male/elf
	soundpack_f = /datum/voicepack/female/elf
//	minrace_pq = 0

	offset_features = list(OFFSET_ID = list(0,-1), OFFSET_GLOVES = list(0,-1), OFFSET_WRISTS = list(0,-1),\
	OFFSET_CLOAK = list(0,-1), OFFSET_FACEMASK = list(0,-1), OFFSET_HEAD = list(0,-1), \
	OFFSET_FACE = list(0,-1), OFFSET_BELT = list(0,-1), OFFSET_BACK = list(0,-1), \
	OFFSET_NECK = list(0,-1), OFFSET_MOUTH = list(0,-1), OFFSET_PANTS = list(0,-1), \
	OFFSET_SHIRT = list(0,-1), OFFSET_ARMOR = list(0,-1), OFFSET_HANDS = list(0,-1), OFFSET_UNDIES = list(0,-1), \
	OFFSET_ID_F = list(0,-1), OFFSET_GLOVES_F = list(0,-1), OFFSET_WRISTS_F = list(0,-1), OFFSET_HANDS_F = list(0,-2), \
	OFFSET_CLOAK_F = list(0,-1), OFFSET_FACEMASK_F = list(0,-2), OFFSET_HEAD_F = list(0,-2), \
	OFFSET_FACE_F = list(0,-2), OFFSET_BELT_F = list(0,-1), OFFSET_BACK_F = list(0,-2), \
	OFFSET_NECK_F = list(0,-2), OFFSET_MOUTH_F = list(0,-2), OFFSET_PANTS_F = list(0,-1), \
	OFFSET_SHIRT_F = list(0,-1), OFFSET_ARMOR_F = list(0,-1), OFFSET_UNDIES_F = list(0,-1))
	specstats = list("strength" = 0, "perception" = 0, "intelligence" = 0, "constitution" = 2, "endurance" = 2, "speed" = 0, "fortune" = 0)
	specstats_f = list("strength" = -1, "perception" = 0, "intelligence" = 0, "constitution" = 2, "endurance" = 2, "speed" = 1, "fortune" = 0)
	enflamed_icon = "widefire"
	// Usual 0+0+0+1+1+0+0 = 2, switching only strength for speed, so they are balanced alike the abyssariads.

/datum/species/elf/undine/check_roundstart_eligible()
	return TRUE

/datum/species/elf/undine/get_span_language(datum/language/message_language)
	if(!message_language)
		return
//	if(message_language.type == /datum/language/elvish)
//		return list(SPAN_SELF)
//	if(message_language.type == /datum/language/common)
//		return list(SPAN_SELF)
	if(message_language.type == /datum/language/abyssal)
		return list(SPAN_ABYSSAL)
	return message_language.spans

/datum/species/elf/undine/get_skin_list()
	return sortList(list(
		"Swamp Bodysnatcher" = SKIN_COLOR_SWAMPCLAN,
		"Jungle Bodysnatcher" = SKIN_COLOR_JUNGLECLAN, //EDIT
		"Leaf Skypiercer" = SKIN_COLOR_LEAFCLAN,
		"Bog Skypiercer" = SKIN_COLOR_BOGCLAN, //EDIT
		"Forest Boneclad" = SKIN_COLOR_FORESTCLAN,
		"Shadow Boneclad" = SKIN_COLOR_SHADOWCLAN,
		"Abyssal Riverdweller" = SKIN_COLOR_ABYSSALCLAN,
	))

/datum/species/elf/undine/get_hairc_list()
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

	"green - grass" = "2a482c",
	"green - swamp" = "3b482a",
	"green - leaf" = "2f3c2e",
	"green - moss" = "3b3c2a",
	"white - silver" = "e8fdfd",
	"white - oceanid" = "afdddd"
	))

/datum/species/elf/undine/random_name(gender,unique,lastname)
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

/datum/species/elf/undine/random_surname()
	return " [pick(world.file2list("strings/rt/names/elf/elfwlast.txt"))]"

/datum/species/elf/undine/get_accent_list()
	return strings("abyssal_replacement.json", "abyssal")

/mob/proc/croak()
	set name = "Croak"
	set category = "Noises"
	emote("croak")

// Unique Undine Recipes. They are actually meant to be RACIAL. But I'm too bad at doing that.

/datum/crafting_recipe/reinforcedarmor //3-tier,  medium armor. Requires troll horns.
	name = "Reinforced Tribal Armor"
	time = 8 SECONDS
	reqs = list(/obj/item/alch/bone = 5, /obj/item/alch/sinew = 2, /obj/item/natural/hide = 3, /obj/item/alch/horn = 1)
	result = /obj/item/clothing/armor/ceramic/reinforced
	category = CAT_NONE

/datum/crafting_recipe/reinforcedhelmet //3-tier, medium armor. Requires troll horns.
	name = "Reinforced Tribal Helmet"
	time = 8 SECONDS
	reqs = list(/obj/item/alch/bone = 3, /obj/item/alch/sinew = 2, /obj/item/natural/hide = 2, /obj/item/alch/horn = 1) //Costs less since it is a helmet. Still requires troll horns.
	result = /obj/item/clothing/head/helmet/ceramic/reinforced
	category = CAT_NONE

/datum/crafting_recipe/mediumhelmet //2-tiers, medium armor. The materials can be adquired naturally by butchering.
	name = "Medium Tribal helmet"
	time = 4 SECONDS
	reqs = list(/obj/item/alch/bone = 2, /obj/item/alch/sinew = 1, /obj/item/natural/hide = 1, /obj/item/natural/cloth = 4)
	result = /obj/item/clothing/head/helmet/ceramic/medium
	category = CAT_NONE

/datum/crafting_recipe/mediumarmor //2-tiers, medium armor. The materials can be adquired naturally by butchering.
	name = "Medium Tribal Armor"
	time = 4 SECONDS
	reqs = list(/obj/item/alch/bone = 3, /obj/item/alch/sinew = 2, /obj/item/natural/hide = 2, /obj/item/natural/cloth = 4)
	result = /obj/item/clothing/armor/ceramic
	category = CAT_NONE

/datum/crafting_recipe/lighthelmet //1-tiers, light armor. The materials can be adquired naturally by butchering.
	name = "Light Tribal Helmet"
	time = 4 SECONDS
	reqs = list(/obj/item/alch/bone = 1, /obj/item/natural/cloth = 4)
	result = /obj/item/clothing/head/helmet/ceramic
	category = CAT_NONE

/datum/crafting_recipe/lightarmor //1-tier, light armor. The materials can be adquired naturally by butchering.
	name = "Light Tribal Armor"
	time = 4 SECONDS
	reqs = list(/obj/item/alch/bone = 2, /obj/item/natural/cloth = 4)
	result = /obj/item/clothing/armor/ceramic/light
	category = CAT_NONE

/datum/crafting_recipe/obsidian_club
	name = "Obsidian Club"
	time = 4 SECONDS
	reqs = list(/obj/item/grown/log/tree/small = 1, /obj/item/natural/stone =  4, /obj/item/ash = 1)
	result = /obj/item/weapon/mace/ararebo/obsidian
	category = CAT_NONE

/datum/crafting_recipe/obsidian_spear
	name = "Obsidian Spear"
	time = 4 SECONDS
	reqs = list(/obj/item/grown/log/tree/small = 1, /obj/item/natural/cloth = 1, /obj/item/natural/stone =  2, /obj/item/ash = 1)
	result = /obj/item/weapon/polearm/spear/stone/obsidian
	category = CAT_NONE
