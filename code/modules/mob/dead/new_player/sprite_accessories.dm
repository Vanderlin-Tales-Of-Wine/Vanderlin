/*

	Hello and welcome to sprite_accessories: For sprite accessories, such as hair,
	facial hair, and possibly tattoos and stuff somewhere along the line. This file is
	intended to be friendly for people with little to no actual coding experience.
	The process of adding in new hairstyles has been made pain-free and easy to do.
	Enjoy! - Doohl


	Notice: This all gets automatically compiled in a list in dna.dm, so you do not
	have to define any UI values for sprite accessories manually for hair and facial
	hair. Just add in new hair types and the game will naturally adapt.

	!!WARNING!!: changing existing hair information can be VERY hazardous to savefiles,
	to the point where you may completely corrupt a server's savefiles. Please refrain
	from doing this unless you absolutely know what you are doing, and have defined a
	conversion in savefile.dm
*/
/proc/init_sprite_accessory_subtypes(prototype, list/L, list/male, list/female,roundstart = FALSE, female_same = FALSE)//Roundstart argument builds a specific list for roundstart parts where some parts may be locked
	if(!istype(L))
		L = list()
	if(!istype(male))
		male = list()
	if(!istype(female))
		female = list()

	for(var/path in subtypesof(prototype))
		if(roundstart)
			var/datum/sprite_accessory/P = path
			if(initial(P.locked))
				continue
		var/datum/sprite_accessory/D = new path()

		if(D.icon_state)
			L[D.name] = D
		else
			L += D.name

		switch(D.gender)
			if(MALE)
				male += D.name
				if(female_same)
					female += D.name
			if(FEMALE)
				female += D.name
			else
				male += D.name
				female += D.name
	return L

/datum/sprite_accessory
	var/icon			//the icon file the accessory is located in
	var/icon_state		//the icon_state of the accessory
	var/name			//the preview name of the accessory. Even if they have different paths and say gender requirements the MUST BE UNIQUE or they wont show
	var/gender = NEUTER	//Determines if the accessory will be skipped or included in random hair generations
	var/gender_specific //Something that can be worn by either gender, but looks different on each
	var/use_static		//determines if the accessory will be skipped by color preferences
	var/color_src = MUTCOLORS	//Currently only used by mutantparts so don't worry about hair and stuff. This is the source that this accessory will get its color from. Default is MUTCOLOR, but can also be HAIR, FACEHAIR, EYECOLOR and 0 if none.
	var/hasinner		//Decides if this sprite has an "inner" part, such as the fleshy parts on ears.
	var/locked = FALSE		//Is this part locked from roundstart selection? Used for parts that apply effects
	var/dimension_x = 32
	var/dimension_y = 32
	var/center = FALSE	//Should we center the sprite?
	var/list/specuse = list("human") //what species can use dis
	var/additional = FALSE //added hairbands/metal in hair/beards
	var/offsetti = FALSE
	var/roundstart = TRUE
	var/under_layer = FALSE

//////////////////////
// Hair Definitions //
//////////////////////
/datum/sprite_accessory/hair
	icon = 'icons/roguetown/mob/hair.dmi'	  // default icon for all hairs

	// please make sure they're sorted alphabetically and, where needed, categorized
	// try to capitalize the names please~
	// try to spell
	// you do not need to define _s or _l sub-states, game automatically does this for you

	// each race gets four unique haircuts
	// dwarf - miner, gnomish, boss, hearth
	// elf - son, fancy, mysterious, long
	// human - adventurer, dark knight, graceful, squire, pigtails, noblesse
	// dual - nomadic, shrine
	// aasimar - amazon, topknot, martial, forsaken
	// tiefling - junia, performer, tribal, lover

/datum/sprite_accessory/hair/bald
	name = "Bald"
	icon_state = ""
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")
	gender = MALE

/datum/sprite_accessory/hair/adventurer_human
	name = "Adventurer"
	icon_state = "adventurer"
	gender = MALE
	specuse = list("human")

/datum/sprite_accessory/hair/berserker
	name = "Berserker"
	icon_state = "berserker"
	gender = MALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")
	under_layer = TRUE

/datum/sprite_accessory/hair/bog
	name = "Bog"
	icon_state = "bog"
	gender = MALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/boss_dwarf
	name = "Boss"
	icon_state = "boss" // original name bodicker
	gender = MALE
	specuse = list("dwarf")
	under_layer = TRUE

/datum/sprite_accessory/hair/bowlcut
	name = "Bowlcut"
	icon_state = "bowlcut"
	gender = MALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/brother
	name = "Brother"
	icon_state = "brother"
	gender = MALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/cavehead
	name = "Cavehead"
	icon_state = "cavehead" // original name thinning?
	gender = MALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")
	under_layer = TRUE

/datum/sprite_accessory/hair/conscript
	name = "Conscript"
	icon_state = "conscript"
	gender = MALE
	under_layer = TRUE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/courtier
	name = "Courtier"
	icon_state = "courtier"
	gender = MALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/dark_knight
	name = "Dark Knight"
	icon_state = "darkknight"
	gender = MALE
	specuse = list("human")

/datum/sprite_accessory/hair/dome
	name = "Dome"
	icon_state = "dome"
	gender = MALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")
	under_layer = TRUE

/datum/sprite_accessory/hair/druid
	name = "Druid"
	icon_state = "druid"  // original name elf_scout?
	gender = MALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/fancy_elf
	name = "Fancy"
	icon_state = "fancy_elf"
	gender = MALE
	specuse = list("elf")

/datum/sprite_accessory/hair/forester
	name = "Forester"
	icon_state = "forester"
	gender = MALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/foreigner_tief
	name = "Foreigner"
	icon_state = "foreigner"
	gender = MALE
	specuse = list("tiefling")

/datum/sprite_accessory/hair/forsaken_aas
	name = "Forsaken"
	icon_state = "forsaken"
	gender = MALE
	specuse = list("aasimar")
	under_layer = TRUE

/datum/sprite_accessory/hair/forged
	name = "Forged"
	icon_state = "forged"
	gender = MALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")
	under_layer = TRUE

/datum/sprite_accessory/hair/graceful
	name = "Graceful"
	icon_state = "graceful"
	gender = MALE
	specuse = list("human")

/datum/sprite_accessory/hair/helmet
	name = "Helmet hair"
	icon_state = "helmet"
	gender = MALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/heroic
	name = "Heroic"
	icon_state = "heroic"
	gender = MALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/hunter
	name = "Hunter"
	icon_state = "hunter"
	gender = MALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/landlord
	name = "Landlord"
	icon_state = "landlord"
	gender = MALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/lover_tief
	name = "Lover"
	icon_state = "lover_tief_m"
	gender = MALE
	specuse = list("tiefling")

/datum/sprite_accessory/hair/lion
	name = "Lions mane"
	icon_state = "lion"
	gender = MALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/monk
	name = "Monk"
	icon_state = "monk"
	gender = MALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/majestic_human
	name = "Majesty"
	icon_state = "majestic"
	gender = MALE
	specuse = list("human")

/datum/sprite_accessory/hair/merc
	name = "Mercenary"
	icon_state = "mercenary"
	gender = MALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/miner_dwarf
	name = "Miner"
	icon_state = "miner"
	gender = MALE
	specuse = list("dwarf")

/datum/sprite_accessory/hair/nobility_human
	name = "Nobility"
	icon_state = "nobility"
	gender = MALE
	specuse = list("human")

/datum/sprite_accessory/hair/nomadic_humtief
	name = "Nomadic"
	icon_state = "nomadic"
	gender = MALE
	specuse = list("human", "tiefling")

/datum/sprite_accessory/hair/pirate
	name = "Pirate"
	icon_state = "pirate"
	gender = MALE
	under_layer = TRUE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/princely
	name = "Princely"
	icon_state = "princely"
	gender = MALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/rogue
	name = "Rogue"
	icon_state = "rogue"
	gender = MALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/romantic
	name = "Romantic"
	icon_state = "romantic"
	gender = MALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/scribe
	name = "Scribe"
	icon_state = "scribe"
	gender = MALE
	specuse = list("human", "dwarf", "aasimar", "tiefling", "halforc")
	under_layer = TRUE

/datum/sprite_accessory/hair/southern_human
	name = "Southern"
	icon_state = "southern"
	gender = MALE
	specuse = list("human")

/datum/sprite_accessory/hair/son
	name = "Son"
	icon_state = "sun"
	gender = MALE
	specuse = list("human", "dwarf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/son_elf
	name = "Sonne"
	icon_state = "son_elf"
	gender = MALE
	specuse = list("elf")

/datum/sprite_accessory/hair/squire_human
	name = "Squired"
	icon_state = "squire" // original name shaved_european
	gender = MALE
	specuse = list("human")

/datum/sprite_accessory/hair/swain
	name = "Swain"
	icon_state = "swain"
	gender = MALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/top_aas
	name = "Topknot"
	icon_state = "topknot"
	gender = MALE
	specuse = list("aasimar")

/datum/sprite_accessory/hair/troubadour
	name = "Troubadour"
	icon_state = "troubadour"
	gender = MALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/tied
	name = "Tied"
	icon_state = "tied"
	gender = MALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/tied_long
	name = "Tied long"
	icon_state = "tiedlong"
	gender = MALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/tied_sidecut
	name = "Tied sidecut"
	icon_state = "tsidecut"
	gender = MALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/trimmed
	name = "Trimmed"
	icon_state = "trimmed"
	gender = MALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/warrior
	name = "Warrior"
	icon_state = "warrior"
	gender = MALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/wildside
	name = "Wild sidecut"
	icon_state = "wildside"
	gender = MALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/woodsman_elf
	name = "Woodsman"
	icon_state = "woodsman_elf"
	gender = MALE
	specuse = list("elf")

/datum/sprite_accessory/hair/zybantu
	name = "Zybantu"
	icon_state = "zybantu" // orginal name gelled
	gender = MALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")



/////////////////////////////
// GIRLY Hair Definitions  //
/////////////////////////////

/datum/sprite_accessory/hair/amazon
	name = "Amazon"
	icon_state = "amazon_f"
	gender = FEMALE
	specuse = list("aasimar")

/datum/sprite_accessory/hair/archivist
	name = "Archivist"
	icon_state = "archivist_f" // original name bob_scully
	gender = FEMALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/barbarian
	name = "Barbarian"
	icon_state = "barbarian_f"
	gender = FEMALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/beartails
	name = "Beartails"
	icon_state = "beartails_f" // modified cotton
	gender = FEMALE
	under_layer = TRUE
	specuse = list("human")

/datum/sprite_accessory/hair/buns
	name = "Buns"
	icon_state = "buns_f" // original name twinbuns
	gender = FEMALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/bob
	name = "Bob"
	icon_state = "bob_f"
	gender = FEMALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/curlyshort
	name = "Curly Short"
	icon_state = "curly_f"
	gender = FEMALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/empress
	name = "Empress"
	icon_state = "empress_f"
	gender = FEMALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/fancy_femelf
	name = "Fancy"
	icon_state = "fancy_elf_f"
	gender = FEMALE
	specuse = list("elf")

/datum/sprite_accessory/hair/grumpy_f
	name = "Grumpy"
	icon_state = "grumpy_f"
	gender = FEMALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/gnomish_f
	name = "Gnomish"
	icon_state = "gnomish_f" // original name bun_grandma
	gender = FEMALE
	specuse = list("dwarf")

/datum/sprite_accessory/hair/hearth_f
	name = "Hearth"
	icon_state = "hearth_f" // original name ponytail_fox
	gender = FEMALE
	specuse = list("dwarf")

/datum/sprite_accessory/hair/homely
	name = "Homely"
	icon_state = "homely_f"
	gender = FEMALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/junia
	name = "Junia"
	icon_state = "junia_tief_f" // modified hime_updo
	gender = FEMALE
	specuse = list("tiefling")

/datum/sprite_accessory/hair/lady
	name = "Lady"
	icon_state = "lady_f" // original name newyou
	gender = FEMALE
	specuse = list("human", "elf", "tiefling")

/datum/sprite_accessory/hair/loosebraid
	name = "Loose Braid"
	icon_state = "loosebraid_f"
	gender = FEMALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/maiden
	name = "Maiden"
	icon_state = "maiden_f"
	gender = FEMALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/majestic_dwarf_F
	name = "Majestiq"
	icon_state = "majestic_dwarf"
	gender = FEMALE
	specuse = list("dwarf")

/datum/sprite_accessory/hair/majestic_f
	name = "Majestic"
	icon_state = "majestic_f"
	gender = FEMALE
	specuse = list("human")

/datum/sprite_accessory/hair/messy
	name = "Messy"
	icon_state = "messy_f"
	gender = FEMALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/mysterious_elf
	name = "Mysterious"
	icon_state = "mysterious_elf" // modified hime_long
	gender = FEMALE
	specuse = list("elf")

/datum/sprite_accessory/hair/mystery
	name = "Mystery"
	icon_state = "mystery_f" // modified hime_long
	gender = FEMALE
	specuse = list("human", "dwarf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/noblesse
	name = "Noblesse"
	icon_state = "noblesse_f" // modified sidetail
	gender = FEMALE
	specuse = list("human")

/datum/sprite_accessory/hair/orc
	name = "Orc"
	icon_state = "orc_f" // modified african_pigtails
	gender = FEMALE
	specuse = list("orc")

/datum/sprite_accessory/hair/performer
	name = "Performer"
	icon_state = "performer_tief_f" // modified drillruru_long
	gender = FEMALE
	specuse = list("tiefling")

/datum/sprite_accessory/hair/pix
	name = "Pixie"
	icon_state = "pixie_f"
	gender = FEMALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/plain
	name = "Plain"
	icon_state = "plain_f"
	gender = FEMALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/queen
	name = "Queenly"
	icon_state = "queenly_f"
	gender = FEMALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/shrine
	name = "Shrinekeeper"
	icon_state = "shrine_f"
	gender = FEMALE
	specuse = list("elf", "tiefling", "human")

/datum/sprite_accessory/hair/soilbride
	name = "Soilbride"
	icon_state = "soilbride_f"
	gender = FEMALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/squire_f
	name = "Squire"
	icon_state = "squire_f" // original name ponytail_rynn
	gender = FEMALE
	specuse = list("human")

/datum/sprite_accessory/hair/tails
	name = "Tails"
	icon_state = "tails_f"
	gender = FEMALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/tied_pony
	name = "Tied ponytail"
	icon_state = "tied_f"
	gender = FEMALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/tiedup
	name = "Tied up"
	icon_state = "tiedup_f"
	gender = FEMALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/updo
	name = "Updo"
	icon_state = "updo_f"
	gender = FEMALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/wisp
	name = "Wisp"
	icon_state = "wisp_f"
	gender = FEMALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/singlebraid
	name = "Single braid"
	icon_state = "singlebraid"
	gender = FEMALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/shorthime
	name = "Hime Cut (Short)"
	icon_state = "shorthime"
	gender = FEMALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

//////////////////////////////
// UNISEX Hair Definitions  //
//////////////////////////////

/datum/sprite_accessory/hair/martial
	name = "Martial"
	icon_state = "martial"
	gender = NEUTER
	specuse = list("aasimar")

/datum/sprite_accessory/hair/shaved
	name = "Shaved"
	icon_state = "shaved"
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")
	gender = NEUTER
	under_layer = TRUE

/datum/sprite_accessory/hair/runt
	name = "Runt"
	icon_state = "runt"
	gender = NEUTER
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/hair/majestic_elf
	name = "Majestie"
	icon_state = "majestic_elf"
	gender = NEUTER
	specuse = list("elf")


/*
/datum/sprite_accessory/hair/felfhair_fatherless
	name = "Fatherless"
	icon_state = "fatherless_elf_f"
	gender = FEMALE
	specuse = list("elf")*/

/////////////////////////////
// Facial Hair Definitions //
/////////////////////////////

/datum/sprite_accessory/facial_hair
	icon = 'icons/roguetown/mob/facial.dmi'
	gender = MALE

/datum/sprite_accessory/facial_hair/none
	name = "None"
	icon_state = ""
	gender = FEMALE
	specuse = ALL_RACES_LIST

/datum/sprite_accessory/facial_hair/shaved
	name = "None"
	icon_state = "facial_shaven"
	gender = MALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/facial_hair/brew
	name = "Brew"
	icon_state = "facial_moonshiner"
	gender = MALE
	specuse = list("human", "dwarf", "elf", "tiefling", "halforc")

/datum/sprite_accessory/facial_hair/chops
	name = "Choppe"
	icon_state = "facial_muttonmus"
	gender = MALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/facial_hair/chin
	name = "Clean Chin"
	icon_state = "facial_chin"
	gender = MALE
	specuse = list("human", "dwarf", "elf", "tiefling", "halforc")

/datum/sprite_accessory/facial_hair/braided
	name = "Dignitary"
	icon_state = "braided"
	gender = MALE
	specuse = list("dwarf")

/datum/sprite_accessory/facial_hair/manly
	name = "Drinker"
	icon_state = "facial_manly"
	gender = MALE
	specuse = list("human", "dwarf", "elf", "tiefling", "halforc")

/datum/sprite_accessory/facial_hair/fullbeard
	name = "Full Beard"
	icon_state = "facial_fullbeard"
	gender = MALE
	specuse = list("human", "dwarf", "elf", "tiefling", "halforc")

/datum/sprite_accessory/facial_hair/cousin
	name = "Fullest Beard"
	icon_state = "facial_brokenman"
	gender = MALE
	specuse = list("human", "dwarf", "elf", "tiefling", "halforc")

/datum/sprite_accessory/facial_hair/knightly
	name = "Knightly"
	icon_state = "facial_knightly"
	gender = MALE
	specuse = list("human", "dwarf", "elf", "tiefling", "halforc")

/datum/sprite_accessory/facial_hair/know
	name = "Knowledge"
	icon_state = "facial_wise"
	gender = MALE
	specuse = list("human", "dwarf", "elf", "tiefling", "halforc")

/datum/sprite_accessory/facial_hair/fiveoclockm
	name = "Mustache"
	icon_state = "facial_5oclockmoustache"
	gender = MALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/facial_hair/pick
	name = "Pick"
	icon_state = "facial_longbeard"
	gender = MALE
	specuse = list("human", "dwarf", "elf", "tiefling", "halforc")

/datum/sprite_accessory/facial_hair/pipe
	name = "Pipesmoker"
	icon_state = "facial_pipe"
	gender = MALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/facial_hair/viking
	name = "Raider"
	icon_state = "facial_viking"
	gender = MALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/facial_hair/ranger
	name = "Ranger"
	icon_state = "facial_dwarf"
	gender = MALE
	specuse = list("human", "dwarf", "elf", "tiefling", "halforc")

/datum/sprite_accessory/facial_hair/vandyke
	name = "Rumata"
	icon_state = "facial_vandyke"
	gender = MALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/facial_hair/burns
	name = "Sideburns"
	icon_state = "facial_burns"
	gender = MALE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/facial_hair/hermit
	name = "Wise Hermit"
	icon_state = "facial_moonshiner"
	gender = MALE
	specuse = list("human", "dwarf", "elf", "tiefling", "halforc")

///////////////////////////
// Accessory Definitions //
///////////////////////////


/datum/sprite_accessory/accessories
	name = ""
	icon_state = null
	gender = NEUTER
	icon = 'icons/roguetown/mob/accessories.dmi'
	use_static = TRUE
	specuse = list("human", "dwarf", "elf")

/datum/sprite_accessory/accessories/nothing
	name = "Nothing"
	icon_state = "nothing"
	specuse = list("human", "dwarf", "elf")

/datum/sprite_accessory/accessories/earrings/sil
	name = "Earrings"
	icon_state = "earrings_sil"
	gender = FEMALE
	specuse = list("human", "dwarf", "elf")

/datum/sprite_accessory/accessories/earrings
	name = "Earrings (G)"
	icon_state = "earrings"
	gender = FEMALE
	specuse = list("human", "dwarf", "elf")

/datum/sprite_accessory/accessories/earrings/em
	name = "Earrings (E)"
	icon_state = "earrings_em"
	gender = FEMALE
	specuse = list("human", "dwarf", "elf")

/datum/sprite_accessory/accessories/choker
	name = "Neckband"
	icon_state = "choker"
	gender = FEMALE
	specuse = list("elf")

/datum/sprite_accessory/accessories/chokere
	name = "Neckband (E)"
	icon_state = "chokere"
	gender = FEMALE
	specuse = list("elf")

/datum/sprite_accessory/accessories/eyepierce
	name = "Pierced Brow (L)"
	icon_state = "eyepierce"
	gender = FEMALE
	specuse = list("human", "dwarf", "elf")

/datum/sprite_accessory/accessories/eyepierce/alt
	name = "Pierced Brow (R)"
	icon_state = "eyepiercealt"
	gender = FEMALE
	specuse = list("human", "dwarf", "elf")

///////////////////////////
// Detail Definitions //
///////////////////////////


/datum/sprite_accessory/detail
	name = ""
	icon_state = null
	gender = NEUTER
	icon = 'icons/roguetown/mob/detail.dmi'
	use_static = TRUE
	specuse = list("human", "dwarf", "elf", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/detail/nothing
	name = "Nothing"
	icon_state = "no tings"

/datum/sprite_accessory/detail/burnface_r
	name = "Burns (r)"
	icon_state = "burnface_r"

/datum/sprite_accessory/detail/burnface_l
	name = "Burns (l)"
	icon_state = "burnface_l"

/datum/sprite_accessory/detail/burneye_r
	name = "Burned Eye (r)"
	icon_state = "burneye_r"

/datum/sprite_accessory/detail/burneye_l
	name = "Burned Eye (l)"
	icon_state = "burneye_l"

/datum/sprite_accessory/detail/brows/dark
	name = "Dark Eyebrows"
	icon_state = "darkbrows"

/datum/sprite_accessory/detail/unibrow/dark
	name = "Dark Unibrow"
	icon_state = "darkunibrow"

/datum/sprite_accessory/detail/deadeye_r
	name = "Dead Eye (r)"
	icon_state = "deadeye_r"

/datum/sprite_accessory/detail/deadeye_l
	name = "Dead Eye (l)"
	icon_state = "deadeye_l"

/datum/sprite_accessory/detail/scarhead
	name = "Scarred Head"
	icon_state = "scarhead"

/datum/sprite_accessory/detail/scar
	name = "Scar"
	icon_state = "scar"

/datum/sprite_accessory/detail/scart
	name = "Scar2"
	icon_state = "scar2"

/datum/sprite_accessory/detail/slashedeye_r
	name = "Slashed Eye (r)"
	icon_state = "slashedeye_r"

/datum/sprite_accessory/detail/slashedeye_r
	name = "Slashed Eye (r)"
	icon_state = "slashedeye_r"

/datum/sprite_accessory/detail/slashedeye_l
	name = "Slashed Eye (l)"
	icon_state = "slashedeye_l"

/datum/sprite_accessory/detail/mangled
	name = "Mangled Jaw"
	icon_state = "mangled"

/datum/sprite_accessory/detail/warpaint_blue
	name = "Warpaint (Blue)"
	icon_state = "warpaint_blue"

/datum/sprite_accessory/detail/warpaint_red
	name = "Warpaint (Red)"
	icon_state = "warpaint_red"

/datum/sprite_accessory/detail/warpaint_green
	name = "Warpaint (Green)"
	icon_state = "warpaint_green"

/datum/sprite_accessory/detail/warpaint_purple
	name = "Warpaint (Purple)"
	icon_state = "warpaint_purple"

/datum/sprite_accessory/detail/warpaint_black
	name = "Warpaint (Black)"
	icon_state = "warpaint_black"

/datum/sprite_accessory/detail/harlequin
	name = "Harlequin"
	icon_state = "harlequin"

/datum/sprite_accessory/detail/tattoo_lips
	name = "Tattoo (Lips)"
	icon_state = "tattoo_lips"

/datum/sprite_accessory/detail/tattoo_eye_r
	name = "Tattoo (r Eye)"
	icon_state = "tattoo_eye_r"

/datum/sprite_accessory/detail/tattoo_eye_l
	name = "Tattoo (l Eye)"
	icon_state = "tattoo_eye_l"

/datum/sprite_accessory/detail/brows
	name = "Thick Eyebrows"
	icon_state = "brows"
	color_src = HAIR
	use_static = FALSE

/datum/sprite_accessory/detail/unibrow
	name = "Unibrow"
	icon_state = "unibrow"
	color_src = HAIR
	use_static = FALSE

///////////////////////////
// Underwear Definitions //
///////////////////////////

/datum/sprite_accessory/underwear
	icon = 'icons/mob/clothing/underwear.dmi'
	use_static = FALSE
/*#ifdef MATURESERVER
/datum/sprite_accessory/underwear/nude
	name = "None"
	icon_state = null
	gender = NEUTER
	use_static = TRUE
	specuse = ALL_RACES_LIST
#else*/
/datum/sprite_accessory/underwear/regm
	name = "Undies"
	icon_state = "male_reg"
	gender = MALE
	specuse = list("human", "aasimar", "tiefling", "halforc")

/datum/sprite_accessory/underwear/regme
	name = "Undiese"
	icon_state = "maleelf_reg"
	gender = MALE
	specuse = list("elf")

/datum/sprite_accessory/underwear/regmd
	name = "Undiesd"
	icon_state = "maledwarf_reg"
	gender = MALE
	specuse = list("dwarf")

/datum/sprite_accessory/underwear/female_bikini
	name = "Femundies"
	icon_state = "female_bikini"
	gender = FEMALE
	specuse = ALL_RACES_LIST

/datum/sprite_accessory/underwear/female_leotard
	name = "Femleotard"
	icon_state = "female_leotard"
	gender = FEMALE
	specuse = ALL_RACES_LIST
	roundstart = FALSE

//#endif
////////////////////////////
// Undershirt Definitions //
////////////////////////////

/datum/sprite_accessory/undershirt
	icon = 'icons/mob/clothing/underwear.dmi'

/datum/sprite_accessory/undershirt/nude
	name = "Nude"
	icon_state = null
	gender = NEUTER

// please make sure they're sorted alphabetically and categorized
///////////////////////
// Socks Definitions //
///////////////////////

/datum/sprite_accessory/socks
	icon = 'icons/mob/clothing/underwear.dmi'

/datum/sprite_accessory/socks/nude
	name = "Nude"
	icon_state = null


//////////.//////////////////
// MutantParts Definitions //
/////////////////////////////

/datum/sprite_accessory/body_markings
	icon = 'icons/mob/mutant_bodyparts.dmi'

/datum/sprite_accessory/body_markings/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/body_markings/dtiger
	name = "Dark Tiger Body"
	icon_state = "dtiger"
	gender_specific = 1

/datum/sprite_accessory/body_markings/ltiger
	name = "Light Tiger Body"
	icon_state = "ltiger"
	gender_specific = 1

/datum/sprite_accessory/body_markings/lbelly
	name = "Light Belly"
	icon_state = "lbelly"
	gender_specific = 1

/datum/sprite_accessory/tails
	icon = 'icons/mob/mutant_bodyparts.dmi'
	gender = MALE
	specuse = list()

/datum/sprite_accessory/tails_animated
	icon = 'icons/mob/mutant_bodyparts.dmi'

/datum/sprite_accessory/tails/lizard/smooth
	name = "Smooth"
	icon_state = "smooth"

/datum/sprite_accessory/tails_animated/lizard/smooth
	name = "Smooth"
	icon_state = "smooth"

/datum/sprite_accessory/tails/lizard/dtiger
	name = "Dark Tiger"
	icon_state = "dtiger"

/datum/sprite_accessory/tails_animated/lizard/dtiger
	name = "Dark Tiger"
	icon_state = "dtiger"

/datum/sprite_accessory/tails/lizard/ltiger
	name = "Light Tiger"
	icon_state = "ltiger"

/datum/sprite_accessory/tails_animated/lizard/ltiger
	name = "Light Tiger"
	icon_state = "ltiger"

/datum/sprite_accessory/tails/lizard/spikes
	name = "Spikes"
	icon_state = "spikes"

/datum/sprite_accessory/tails_animated/lizard/spikes
	name = "Spikes"
	icon_state = "spikes"

/datum/sprite_accessory/tails/human/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/tails_animated/human/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/tails/human/cat
	name = "Cat"
	icon_state = "cat"
	color_src = HAIR

/datum/sprite_accessory/tails_animated/human/cat
	name = "Cat"
	icon_state = "cat"
	color_src = HAIR

/datum/sprite_accessory/snouts
	icon = 'icons/mob/mutant_bodyparts.dmi'

/datum/sprite_accessory/snouts/sharp
	name = "Sharp"
	icon_state = "sharp"

/datum/sprite_accessory/snouts/round
	name = "Round"
	icon_state = "round"

/datum/sprite_accessory/snouts/sharplight
	name = "Sharp + Light"
	icon_state = "sharplight"

/datum/sprite_accessory/snouts/roundlight
	name = "Round + Light"
	icon_state = "roundlight"

/datum/sprite_accessory/horns
	icon = 'icons/mob/mutant_bodyparts.dmi'
	gender = MALE
	specuse = list()

/datum/sprite_accessory/ears
	icon = 'icons/mob/mutant_bodyparts.dmi'

/datum/sprite_accessory/ears/none
	name = "None"
	icon_state = null

/datum/sprite_accessory/ears/elf
	icon = 'icons/roguetown/mob/bodies/attachments.dmi'
	name = "Elf"
	icon_state = "elf"
	specuse = list("elf")
	color_src = SKINCOLOR
	offsetti = TRUE

/datum/sprite_accessory/ears/elfw
	icon = 'icons/roguetown/mob/bodies/attachments.dmi'
	name = "ElfW"
	icon_state = "elfw"
	specuse = list("elf", "tiefling") //tiebs use these
	color_src = SKINCOLOR
	offsetti = TRUE

/datum/sprite_accessory/ears/elfh //halfelfs are humens techincally
	icon = 'icons/roguetown/mob/bodies/attachments.dmi'
	name = "ElfH"
	icon_state = "elf"
	specuse = list("human")
	color_src = SKINCOLOR
	offsetti = TRUE

/datum/sprite_accessory/tails/human/tieb
	icon = 'icons/roguetown/mob/bodies/attachments.dmi'
	name = "TiebTail"
	icon_state = "tiebtail"
	specuse = list("tiefling")
	gender = NEUTER
	color_src = SKINCOLOR
	offsetti = TRUE

/datum/sprite_accessory/horns/tieb
	icon = 'icons/roguetown/mob/bodies/attachments.dmi'
	name = "TiebHorns"
	icon_state = "tiebhorns"
	specuse = list("tiefling")
	color_src = SKINCOLOR
	offsetti = TRUE

/* Needs to be made selectable somehow. Tie to gender? Enable horn selection in char pref? I dunno. Sprites there anyways.
/datum/sprite_accessory/horns/tieb_alt
	icon = 'icons/roguetown/mob/bodies/attachments.dmi'
	name = "TiebHornies"
	icon_state = "tiebhornsalt"
	specuse = list("tiefling")
	color_src = SKINCOLOR
	offsetti = TRUE
*/

/datum/sprite_accessory/ears/cat
	name = "Cat"
	icon_state = "cat"
	hasinner = 1
	color_src = HAIR
	specuse = list("cattan")

/datum/sprite_accessory/wings/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/wings
	icon = 'icons/mob/clothing/wings.dmi'

/datum/sprite_accessory/wings_open
	icon = 'icons/mob/clothing/wings.dmi'

/datum/sprite_accessory/wings/angel
	name = "Angel"
	icon_state = "angel"
	color_src = 0
	dimension_x = 46
	center = TRUE
	dimension_y = 34
	locked = TRUE

/datum/sprite_accessory/wings_open/angel
	name = "Angel"
	icon_state = "angel"
	color_src = 0
	dimension_x = 46
	center = TRUE
	dimension_y = 34

/datum/sprite_accessory/wings/dragon
	name = "Dragon"
	icon_state = "dragon"
	dimension_x = 96
	center = TRUE
	dimension_y = 32
	locked = TRUE

/datum/sprite_accessory/wings_open/dragon
	name = "Dragon"
	icon_state = "dragon"
	dimension_x = 96
	center = TRUE
	dimension_y = 32

/datum/sprite_accessory/frills
	icon = 'icons/mob/mutant_bodyparts.dmi'

/datum/sprite_accessory/frills/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/frills/simple
	name = "Simple"
	icon_state = "simple"

/datum/sprite_accessory/frills/short
	name = "Short"
	icon_state = "short"

/datum/sprite_accessory/frills/aquatic
	name = "Aquatic"
	icon_state = "aqua"

/datum/sprite_accessory/spines
	icon = 'icons/mob/mutant_bodyparts.dmi'

/datum/sprite_accessory/spines_animated
	icon = 'icons/mob/mutant_bodyparts.dmi'

/datum/sprite_accessory/spines/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/spines_animated/none
	name = "None"
	icon_state = "none"

/datum/sprite_accessory/spines/short
	name = "Short"
	icon_state = "short"

/datum/sprite_accessory/spines_animated/short
	name = "Short"
	icon_state = "short"

/datum/sprite_accessory/spines/shortmeme
	name = "Short + Membrane"
	icon_state = "shortmeme"

/datum/sprite_accessory/spines_animated/shortmeme
	name = "Short + Membrane"
	icon_state = "shortmeme"

/datum/sprite_accessory/spines/long
	name = "Long"
	icon_state = "long"

/datum/sprite_accessory/spines_animated/long
	name = "Long"
	icon_state = "long"

/datum/sprite_accessory/spines/longmeme
	name = "Long + Membrane"
	icon_state = "longmeme"

/datum/sprite_accessory/spines_animated/longmeme
	name = "Long + Membrane"
	icon_state = "longmeme"

/datum/sprite_accessory/spines/aqautic
	name = "Aquatic"
	icon_state = "aqua"

/datum/sprite_accessory/spines_animated/aqautic
	name = "Aquatic"
	icon_state = "aqua"


/datum/sprite_accessory/legs 	//legs are a special case, they aren't actually sprite_accessories but are updated with them.
	icon = null					//These datums exist for selecting legs on preference, and little else

/datum/sprite_accessory/legs/none
	name = "Normal Legs"

/datum/sprite_accessory/legs/digitigrade_lizard
	name = "Digitigrade Legs"

/datum/sprite_accessory/caps
	icon = 'icons/mob/mutant_bodyparts.dmi'
	color_src = HAIR

/datum/sprite_accessory/caps/round
	name = "Round"
	icon_state = "round"
