//ROGUETRAITS (description when rmb skills button)
#define TRAIT_WEBWALK 					"Webwalker"
#define TRAIT_NOSTINK 					"Dead Nose"
#define TRAIT_ZJUMP 					"High Jumping"
#define TRAIT_NOSEGRAB 				"Intimidating"
#define TRAIT_NUTCRACKER 				"Nutcracker"
#define TRAIT_STRONGBITE				"Strong Bite"
#define TRAIT_HATEWOMEN				"Ladykiller"
#define TRAIT_SEEDKNOW 				"Seed Knower"
#define TRAIT_NOBLE					"Noble Blooded"
#define TRAIT_EMPATH					"Empath"
#define TRAIT_BREADY					"Battleready"
#define TRAIT_MEDIUMARMOR				"Mail Training"
#define TRAIT_HEAVYARMOR				"Plate Training"
#define TRAIT_DODGEEXPERT              "Fast Reflexes"
#define TRAIT_DECEIVING_MEEKNESS 		"Deceiving Meekness"
#define TRAIT_VILLAIN					"Villain"
#define TRAIT_CRITICAL_RESISTANCE		"Critical Resistance"
#define TRAIT_CRITICAL_WEAKNESS		"Critical Weakness"
#define TRAIT_MANIAC_AWOKEN			"Awoken"
#define TRAIT_NOSTAMINA				"Indefatigable" //for ai
#define TRAIT_NOSLEEP				"Fatal Insomnia" //for thralls
#define TRAIT_FASTSLEEP 			"Fast Sleeper"
#define TRAIT_NUDIST					"Nudist" //you can't wear most clothes
#define TRAIT_INHUMANE_ANATOMY			"Inhumen Anatomy" //can't wear hats and shoes
#define TRAIT_NASTY_EATER 				"Inhumen Digestion" //can eat rotten food, organs, poison berries, and drink murky water
#define TRAIT_NOFALLDAMAGE1 		"Minor Fall Damage Immunity"
#define TRAIT_NOFALLDAMAGE2 		"Total	 Fall Damage Immunity"
#define TRAIT_DEATHSIGHT "Veiled Whispers" // Is notified when a player character dies, but not told exactly where or how.
#define TRAIT_CYCLOPS_LEFT				"Cyclops (Left)" //poked left eye
#define TRAIT_CYCLOPS_RIGHT				"Cyclops (Right)" //poked right eye
#define TRAIT_ASSASSIN					"Assassin Training" //used for the assassin drifter's unique mechanics.
#define TRAIT_BARDIC_TRAINING			"Bardic Training"
#define TRAIT_GRAVEROBBER				"Graverobber"	// Prevents getting the cursed debuff when unearthing a grave, but permanent -1 LUC to whoever has it.
#define TRAIT_BLESSED					"Once Blessed"	// prevents blessings stackings
#define TRAIT_MIRACULOUS_FORAGING		"Miracle Foraging"	// makes bushes much more generous
#define TRAIT_MISSING_NOSE				"Missing Nose" //halved stamina regeneration
#define TRAIT_DISFIGURED				"Disfigured"
#define TRAIT_SPELLBLOCK				"Bewitched" //prevents spellcasting
#define TRAIT_ANTIMAGIC					"Anti-Magic"
#define TRAIT_ANTISCRYING				"Anti-Scrying"
#define TRAIT_SHOCKIMMUNE				"Shock Immunity"
#define TRAIT_LEGENDARY_ALCHEMIST		"Expert Herb Finder"
#define TRAIT_LIGHT_STEP				"Light Step" //Can't trigger /obj/structure/trap/'s
#define TRAIT_THIEVESGUILD				"Thieves Guild Member"
#define TRAIT_ENGINEERING_GOGGLES		"Engineering Goggles"
#define TRAIT_SEEPRICES				    "Golden Blood" //See prices

// Divine patron trait bonuses:
#define TRAIT_SOUL_EXAMINE				"Blessing of Necra"  //can check bodies to see if they have departed
#define TRAIT_ROT_EATER					"Blessing of Pestra" //can eat rotten food
#define TRAIT_KNEESTINGER_IMMUNITY		"Blessing of Dendor" //Can move through kneestingers.
#define TRAIT_LEECHIMMUNE				"Unleechable" //leeches drain very little blood
#define TRAIT_SHARPER_BLADES			"Sharper Blades" //Weapons lose less blade integrity
#define TRAIT_BETTER_SLEEP				"Better Sleep" //Recover more energy (blue bar) when sleeping
#define TRAIT_EXTEROCEPTION				"Exteroception" //See others' hunger and thirst
#define TRAIT_TUTELAGE					"Tutelage" //Slightly more sleep xp to you and xp to apprentices
#define TRAIT_APRICITY					"Apricity" //Decreased stamina regen time during "day"
#define TRAIT_BLACKLEG					"Blackleg" //Rig coin, dice, cards in your favor

// Inhumen patron trait bonuses:
#define TRAIT_ORGAN_EATER				"Blessing of Graggar"//Can eat organs (duh.) and raw meat
#define TRAIT_CRACKHEAD					"Blessing of Baotha" //No overdose on drugs.
#define TRAIT_CABAL                     "Of the Cabal" //Zizo cultists recognize each other too
#define TRAIT_MATTHIOS_EYES				"Eyes of Matthios" //Examine to see the most expensive item someone has

#define TRAIT_BASHDOORS "bashdoors"
#define TRAIT_NOMOOD "no_mood"
#define TRAIT_SIMPLE_WOUNDS "simple_wounds"
#define TRAIT_SCHIZO_AMBIENCE "schizo_ambience" //replaces all ambience with creepy shit
#define TRAIT_SCREENSHAKE "screenshake" //screen will always be shaking, you cannot stop it
#define TRAIT_PUNISHMENT_CURSE "PunishmentCurse"
#define TRAIT_BANDITCAMP "banditcamp"
#define TRAIT_KNOWBANDITS "knowbandits"
#define TRAIT_VAMPMANSION "vampiremansion"
#define TRAIT_VAMP_DREAMS "vamp_dreams"
#define TRAIT_INHUMENCAMP "inhumencamp"
#define TRAIT_INTRAINING "intraining" //allows certain roles to bypass the average skill limitation of training dummies
#define TRAIT_STEELHEARTED "steelhearted" //no bad mood from dismembering or seeing this
#define TRAIT_IWASREVIVED "iwasrevived" //prevents PQ gain from reviving the same person twice
#define TRAIT_IWASUNZOMBIFIED "iwasunzombified" //prevents PQ gain from curing a zombie twice
#define TRAIT_ZIZOID_HUNTED "zizoidhunted" // Used to signal character has been marked by death by the Zizoid cult
#define TRAIT_LEPROSY "Leprosy"
#define TRAIT_SCHIZO_FLAW "Schizophrenic"

// JOB RELATED TRAITS

#define TRAIT_MALUMFIRE "Professional Smith"
#define TRAIT_CRATEMOVER "Crate Mover"

// PATRON CURSE TRAITS
#define TRAIT_CURSE "Curse" //source
#define TRAIT_ATHEISM_CURSE "Curse of Atheism"
#define TRAIT_PSYDON_CURSE "Psydon's Curse"
#define TRAIT_ASTRATA_CURSE "Astrata's Curse"
#define TRAIT_NOC_CURSE "Noc's Curse"
#define TRAIT_RAVOX_CURSE "Ravox's Curse"
#define TRAIT_NECRA_CURSE "Necra's Curse"
#define TRAIT_XYLIX_CURSE "Xylix's Curse"
#define TRAIT_PESTRA_CURSE "Pestra's Curse"
#define TRAIT_EORA_CURSE "Eora's Curse"
#define TRAIT_ZIZO_CURSE "Zizo's Curse"
#define TRAIT_GRAGGAR_CURSE "Graggar's Curse"
#define TRAIT_MATTHIOS_CURSE "Matthios' Curse"
#define TRAIT_BAOTHA_CURSE "Baotha's Curse"

GLOBAL_LIST_INIT(roguetraits, list(
	TRAIT_WEBWALK = "I can move freely between webs.",
	TRAIT_NOSTINK = span_dead("My nose is numb to the smell of decay."),
	TRAIT_ZJUMP = "Time to reach a new height.",
	TRAIT_NOSEGRAB = "I love to grab idiots by their noses!",
	TRAIT_NUTCRACKER = "I love kicking idiots on the nuts!",
	TRAIT_SEEPRICES = "I can tell the prices of things down to the zenny.",
	TRAIT_STRONGBITE = "Stronger bites, critical bite attacks.",
	TRAIT_HATEWOMEN = "Double damage against female mobs.",
	TRAIT_SEEDKNOW = span_info("I know which seeds grow which crops."),
	TRAIT_NOBLE = span_blue("I'm of noble blood."),
	TRAIT_EMPATH = "I can notice when people are in pain.",
	TRAIT_BREADY = "Defensive stance does not passively fatigue me.",
	TRAIT_MEDIUMARMOR = "I can move freely in medium armor.",
	TRAIT_HEAVYARMOR = "I can move freely in heavy armor.",
	TRAIT_DODGEEXPERT = "I can dodge easily while only wearing light armor.",
	TRAIT_VILLAIN = "I am a devious, conniving villain!",
	TRAIT_CRITICAL_RESISTANCE = "I am resistant to wounds that would be life threatening to others.",
	TRAIT_CRITICAL_WEAKNESS = span_danger("I am weak to wounds that others could survive."),
	TRAIT_MANIAC_AWOKEN = span_danger("I am <b>WAKING UP</b> and the sheeple know this. They will resist."),
	TRAIT_NOSTAMINA = "I have boundless energy, I will never tire.",
	TRAIT_NOSLEEP = span_warning("I can't sleep."),
	TRAIT_NUDIST = "I <b>refuse</b> to wear clothes. They are a hindrance to my freedom.",
	TRAIT_KNEESTINGER_IMMUNITY = "I am immune to the shock of kneestingers.",
	TRAIT_INHUMANE_ANATOMY = "My anatomy is inhumen, preventing me from wearing hats and shoes.",
	TRAIT_NASTY_EATER = span_dead("I can eat bad food, and water that would be toxic to humen will not affect me."),
	TRAIT_NOFALLDAMAGE1 = span_info("I can easily handle minor falls."),
	TRAIT_NOFALLDAMAGE2 = span_info("I can handle a fall from any height."),
	TRAIT_ROT_EATER = span_necrosis("I can eat rotten food."),
	TRAIT_ORGAN_EATER = span_bloody("I can eat organs and raw flesh."),
	TRAIT_CRACKHEAD = span_love("I can use drugs as much as I want!"),
	TRAIT_SOUL_EXAMINE = span_deadsay("I know when someone's soul has departed after checking their heartbeat."),
	TRAIT_CYCLOPS_LEFT = span_warning("My left eye has been poked out..."),
	TRAIT_CYCLOPS_RIGHT = span_warning("My right eye has been poked out..."),
	TRAIT_LEECHIMMUNE = "Leeches are reluctant to drain my blood.",
	TRAIT_ASSASSIN = "My soul has been tainted by Graggar, god of murder.",
	TRAIT_BARDIC_TRAINING = "Xylixian inspiration grants my songs boons and ailments.",
	TRAIT_GRAVEROBBER = "Necra favors my grim deeds, I can unearth graves without being cursed by her.",
	TRAIT_MISSING_NOSE = span_warning("I struggle to breathe."),
	TRAIT_DISFIGURED = span_warning("No one can recognize me..."),
	TRAIT_SPELLBLOCK = span_warning("I cannot cast any spells."),
	TRAIT_ANTIMAGIC = "I am immune to most forms of magic.",
	TRAIT_ANTISCRYING = "I am immune to most forms of magical divination.",
	TRAIT_SHOCKIMMUNE = "I am immune to electrical shocks.",
	TRAIT_INTRAINING = "I'm going to be a knight someday! I can use training dummies more effectively than others.",
	TRAIT_MALUMFIRE = "My hands are blessed by Malum to forge items of superb quality.",
	TRAIT_DEATHSIGHT = span_info("I can feel when someone nearby draws the Undermaiden's attention, a tiny voice whispering 'Someone has died,' in my ear."),
	TRAIT_CABAL = span_purple("In secret, I have studied the ways of Her ascension, and know of others of the Cabal."),
	TRAIT_LEGENDARY_ALCHEMIST = span_info("An expert in the art of finding herbs in the wild."),
	TRAIT_DECEIVING_MEEKNESS = "People look at me and think I am a weakling. They are mistaken.",
	TRAIT_THIEVESGUILD = "I am a member of the thieves guild!",
	TRAIT_LEPROSY = span_necrosis("I'm a disgusting leper..."),
	TRAIT_LIGHT_STEP = span_info("I will never trip a trap plate."),
	TRAIT_NOFIRE = span_info("I am immune to most scorching flames."),
	TRAIT_ENGINEERING_GOGGLES = span_info("I can find out more information from mechanical devices."),
	TRAIT_SHARPER_BLADES = "My weapons lose their sharpness slower.",
	TRAIT_BETTER_SLEEP = "I recover more energy when sleeping.",
	TRAIT_EXTEROCEPTION = "I can see when others are hungry or thirsty.",
	TRAIT_TUTELAGE = "I am a capable tutor to those who apprentice under me.",
	TRAIT_APRICITY = "The warmth of the sun rejuvenates me, allowing me to regain my stamina quicker.",
	TRAIT_BLACKLEG = "I can cheat by rigging coin and dice, and peek at cards.",
	TRAIT_MATTHIOS_EYES = span_notice("I have a sense for what the most valuable item someone has is."),
	TRAIT_CRATEMOVER = "I am able to drag heavy objects without any difficulty."
	))

// trait accessor defines
#define ADD_TRAIT(target, trait, source) \
	do { \
		var/list/_L; \
		if (!target.status_traits) { \
			target.status_traits = list(); \
			_L = target.status_traits; \
			_L[trait] = list(source); \
			SEND_GLOBAL_SIGNAL(COMSIG_ATOM_ADD_TRAIT, target, trait); \
		} else { \
			_L = target.status_traits; \
			if (_L[trait]) { \
				_L[trait] |= list(source); \
			} else { \
				_L[trait] = list(source); \
			} \
			SEND_GLOBAL_SIGNAL(COMSIG_ATOM_ADD_TRAIT, target, trait);\
		} \
	} while (0)
#define REMOVE_TRAIT(target, trait, sources) \
	do { \
		var/list/_L = target.status_traits; \
		var/list/_S; \
		if (sources && !islist(sources)) { \
			_S = list(sources); \
		} else { \
			_S = sources\
		}; \
		if (_L && _L[trait]) { \
			for (var/_T in _L[trait]) { \
				if ((!_S && (_T != ROUNDSTART_TRAIT)) || (_T in _S)) { \
					_L[trait] -= _T \
				} \
			};\
			if (!length(_L[trait])) { \
				_L -= trait; \
				SEND_GLOBAL_SIGNAL(COMSIG_ATOM_REMOVE_TRAIT, target, trait); \
			}; \
			if (!length(_L)) { \
				target.status_traits = null \
			}; \
		} \
	} while (0)
#define REMOVE_TRAITS_NOT_IN(target, sources) \
	do { \
		var/list/_L = target.status_traits; \
		var/list/_S = sources; \
		if (_L) { \
			for (var/_T in _L) { \
				_L[_T] &= _S;\
				if (!length(_L[_T])) { \
					_L -= _T } \
				};\
				if (!length(_L)) { \
					target.status_traits = null\
				};\
		}\
	} while (0)

#define HAS_TRAIT(target, trait) (target.status_traits ? (target.status_traits[trait] ? TRUE : FALSE) : FALSE)
#define HAS_TRAIT_FROM(target, trait, source) (target.status_traits ? (target.status_traits[trait] ? (source in target.status_traits[trait]) : FALSE) : FALSE)

/*
Remember to update _globalvars/traits.dm if you're adding/removing/renaming traits.
*/

//mob traits
#define TRAIT_INCAPACITATED		"incapacitated"
#define TRAIT_BLIND 			"blind"
#define TRAIT_MUTE				"mute"
#define TRAIT_ZOMBIE_SPEECH 	"zombie_speech"
#define TRAIT_GARGLE_SPEECH		"gargle_speech"
#define TRAIT_EMOTEMUTE			"emotemute"
#define TRAIT_DEAF				"deaf"
#define TRAIT_NEARSIGHT			"nearsighted"
#define TRAIT_FAT				"fat"
#define TRAIT_HUSK				"husk"
#define TRAIT_CHUNKYFINGERS		"chunkyfingers" //means that you can't use weapons with normal trigger guards.
#define TRAIT_DUMB				"dumb"
#define TRAIT_MONKEYLIKE		"monkeylike" //sets IsAdvancedToolUser to FALSE
#define TRAIT_PACIFISM			"pacifism"
#define TRAIT_IGNORESLOWDOWN	"ignoreslow"
#define TRAIT_IGNOREDAMAGESLOWDOWN "ignoredamageslowdown"
#define TRAIT_DEATHCOMA			"deathcoma" //Causes death-like unconsciousness
#define TRAIT_FAKEDEATH			"fakedeath" //Makes the owner appear as dead to most forms of medical examination
#define TRAIT_STUNIMMUNE		"stun_immunity"
#define TRAIT_STUNRESISTANCE    "stun_resistance"
#define TRAIT_SLEEPIMMUNE		"sleep_immunity"
#define TRAIT_PUSHIMMUNE		"push_immunity"
#define TRAIT_STABLEHEART		"stable_heart"
#define TRAIT_NOPAINSTUN		"no_pain-stun"
#define TRAIT_RESISTHEAT		"resist_heat"
#define TRAIT_RESISTHEATHANDS	"resist_heat_handsonly" //For when you want to be able to touch hot things, but still want fire to be an issue.
#define TRAIT_RESISTCOLD		"resist_cold"
#define TRAIT_RESISTHIGHPRESSURE	"resist_high_pressure"
#define TRAIT_RESISTLOWPRESSURE	"resist_low_pressure"
#define TRAIT_RADIMMUNE			"rad_immunity"
#define TRAIT_PIERCEIMMUNE		"pierce_immunity"
#define TRAIT_NODISMEMBER		"dismember_immunity"
#define TRAIT_NOFIRE			"nonflammable"
#define TRAIT_NOGUNS			"no_guns"
#define TRAIT_NOHUNGER			"no_hunger"
#define TRAIT_NOMETABOLISM		"no_metabolism"
#define TRAIT_TOXIMMUNE			"toxin_immune"
#define TRAIT_EASYDISMEMBER		"easy_dismember"
#define TRAIT_LIMBATTACHMENT 	"limb_attach"
#define TRAIT_NOLIMBDISABLE		"no_limb_disable"
#define TRAIT_EASYLIMBDISABLE	"easy_limb_disable"
#define TRAIT_TOXINLOVER		"toxinlover"
#define TRAIT_NOBREATH			"no_breath"
#define TRAIT_HOLY				"holy"
#define TRAIT_NOCRITDAMAGE		"no_crit"
#define TRAIT_NOSLIPWATER		"noslip_water"
#define TRAIT_NOSLIPALL			"noslip_all"
#define TRAIT_NODEATH			"nodeath"
#define TRAIT_NOHARDCRIT		"nohardcrit"
#define TRAIT_NOSOFTCRIT		"nosoftcrit"
#define TRAIT_MINDSHIELD		"mindshield"
#define TRAIT_DISSECTED			"dissected"
#define TRAIT_SIXTHSENSE		"sixth_sense" //I can hear dead people
#define TRAIT_FEARLESS			"fearless"
#define TRAIT_PARALYSIS_L_ARM	"para-l-arm" //These are used for brain-based paralysis, where replacing the limb won't fix it
#define TRAIT_PARALYSIS_R_ARM	"para-r-arm"
#define TRAIT_PARALYSIS_L_LEG	"para-l-leg"
#define TRAIT_PARALYSIS_R_LEG	"para-r-leg"
#define TRAIT_NOMOBSWAP         "no-mob-swap"
#define TRAIT_XRAY_VISION       "xray_vision"
#define TRAIT_THERMAL_VISION    "thermal_vision"
#define TRAIT_ABDUCTOR_TRAINING "abductor-training"
#define TRAIT_ABDUCTOR_SCIENTIST_TRAINING "abductor-scientist-training"
#define TRAIT_SURGEON           "surgeon"
#define TRAIT_STRONG_GRABBER	"strong_grabber"
#define TRAIT_MAGIC_CHOKE		"magic_choke"
#define TRAIT_SOOTHED_THROAT    "soothed-throat"
#define TRAIT_LAW_ENFORCEMENT_METABOLISM "law-enforcement-metabolism"
#define TRAIT_ALWAYS_CLEAN      "always-clean"
#define TRAIT_BOOZE_SLIDER      "booze-slider"
#define TRAIT_QUICK_CARRY		"quick-carry"
#define TRAIT_QUICKER_CARRY		"quicker-carry"
#define TRAIT_UNINTELLIGIBLE_SPEECH "unintelligible-speech"
#define TRAIT_LANGUAGE_BARRIER	"language-barrier"
#define TRAIT_PASSTABLE			"passtable"
#define TRAIT_NOFLASH			"noflash" //Makes you immune to flashes
#define TRAIT_NOPAIN			"no_pain"
#define TRAIT_DRUQK				"druqk"
#define TRAIT_BURIED_COIN_GIVEN "buried_coin_given" // prevents a human corpse from being used for a corpse multiple times
#define TRAIT_BLOODLOSS_IMMUNE "bloodloss_immune" // can bleed, but will never die from blood loss
#define TRAIT_ROTMAN "rotman" //you are a rotman and need occasional maintenance
#define TRAIT_ZOMBIE_IMMUNE "zombie_immune" //immune to zombie infection
#define TRAIT_NO_BITE "no_bite" //prevents biting
#define TRAIT_HARDDISMEMBER		"hard_dismember"
///trait determines if this mob can breed given by /datum/component/breeding
#define TRAIT_MOB_BREEDER "mob_breeder"
#define TRAIT_UNTARGETTABLE "untargettable" //can't be targetted by basic mobs
#define TRAIT_IMPERCEPTIBLE "imperceptible" //! can't be percieved in any way

//bodypart traits
#define TRAIT_PARALYSIS	"paralysis" //Used for limb-based paralysis and full body paralysis
#define TRAIT_BRITTLE "brittle" //The limb is more susceptible to fractures
#define TRAIT_FINGERLESS "fingerless" //The limb has no fingies

//item traits
#define TRAIT_NODROP            "nodrop"
#define TRAIT_NOEMBED			"noembed"
#define TRAIT_NO_TELEPORT		"no-teleport" //you just can't

// common trait sources
#define TRAIT_GENERIC "generic"
#define UNCONSCIOUS_BLIND "unconscious_blind"
#define EYE_DAMAGE "eye_damage"
#define GENETIC_MUTATION "genetic"
#define OBESITY "obesity"
#define MAGIC_TRAIT "magic"
#define TRAUMA_TRAIT "trauma"
#define DISEASE_TRAIT "disease"
#define SPECIES_TRAIT "species"
#define ORGAN_TRAIT "organ"
#define CRIT_TRAIT "crit"
#define ROUNDSTART_TRAIT "roundstart" //cannot be removed without admin intervention
#define JOB_TRAIT "job"
#define CYBORG_ITEM_TRAIT "cyborg-item"
#define ADMIN_TRAIT "admin" // (B)admins only.
#define CHANGELING_TRAIT "changeling"
#define CULT_TRAIT "cult"
#define CURSED_ITEM_TRAIT "cursed-item" // The item is magically cursed
#define ABSTRACT_ITEM_TRAIT "abstract-item"
#define STATUS_EFFECT_TRAIT "status-effect"
#define CLOTHING_TRAIT "clothing"
#define HELMET_TRAIT "helmet"
#define GLASSES_TRAIT "glasses"
#define VEHICLE_TRAIT "vehicle" // inherited from riding vehicles
#define INNATE_TRAIT "innate"

// unique trait sources, still defines
#define TRAIT_BESTIALSENSE "bestial-sense"
#define TRAIT_DARKVISION "darkvision"
#define CLONING_POD_TRAIT "cloning-pod"
#define STATUE_MUTE "statue"
#define CHANGELING_DRAIN "drain"
#define CHANGELING_HIVEMIND_MUTE "ling_mute"
#define ABYSSAL_GAZE_BLIND "abyssal_gaze"
#define HIGHLANDER "highlander"
#define TRAIT_HULK "hulk"
#define STASIS_MUTE "stasis"
#define GENETICS_SPELL "genetics_spell"
#define EYES_COVERED "eyes_covered"
#define CULT_EYES "cult_eyes"
#define TRAIT_SANTA "santa"
#define SCRYING_ORB "scrying-orb"
#define ABDUCTOR_ANTAGONIST "abductor-antagonist"
#define NUKEOP_TRAIT "nuke-op"
#define DEATHSQUAD_TRAIT "deathsquad"
#define CLOWN_NUKE_TRAIT "clown-nuke"
#define STICKY_MOUSTACHE_TRAIT "sticky-moustache"
#define CHAINSAW_FRENZY_TRAIT "chainsaw-frenzy"
#define CHRONO_GUN_TRAIT "chrono-gun"
#define REVERSE_BEAR_TRAP_TRAIT "reverse-bear-trap"
#define CURSED_MASK_TRAIT "cursed-mask"
#define HIS_GRACE_TRAIT "his-grace"
#define HAND_REPLACEMENT_TRAIT "magic-hand"
#define HOT_POTATO_TRAIT "hot-potato"
#define SABRE_SUICIDE_TRAIT "sabre-suicide"
#define ABDUCTOR_VEST_TRAIT "abductor-vest"
#define CAPTURE_THE_FLAG_TRAIT "capture-the-flag"
#define EYE_OF_GOD_TRAIT "eye-of-god"
#define SHAMEBRERO_TRAIT "shamebrero"
#define CHRONOSUIT_TRAIT "chronosuit"
#define LOCKED_HELMET_TRAIT "locked-helmet"
#define ANTI_DROP_IMPLANT_TRAIT "anti-drop-implant"
#define SLEEPING_CARP_TRAIT "sleeping_carp"
#define MADE_UNCLONEABLE "made-uncloneable"
#define TIMESTOP_TRAIT "timestop"
#define ADVENTURER_TRAIT "adventurer"
#define TRAIT_LONGSTRIDER "longstrider"
#define TRAIT_GUIDANCE "guidance"

#define TRAIT_I_AM_INVISIBLE_ON_A_BOAT "invisible_on_tram"
