// Census
#define STATS_ALIVE_NORTHERN_HUMANS "alive_northern_humans"
#define STATS_ALIVE_DWARVES "alive_dwarves"
#define STATS_ALIVE_DARK_ELVES "alive_dark_elves"
#define STATS_ALIVE_SNOW_ELVES "alive_snow_elves"
#define STATS_ALIVE_HALF_ELVES "alive_half_elves"
#define STATS_ALIVE_HALF_ORCS "alive_half_orcs"
#define STATS_ALIVE_KOBOLDS "alive_kobolds"
#define STATS_ALIVE_RAKSHARI "alive_rakshari"
#define STATS_ALIVE_AASIMAR "alive_aasimar"
#define STATS_ALIVE_TIEFLINGS "alive_tieflings"
#define STATS_MONARCH_PATRON "monarch_patron"
#define STATS_MARRIED "married"
#define STATS_MALE_POPULATION "male_population"
#define STATS_FEMALE_POPULATION "female_population"
#define STATS_OTHER_GENDER "other_gender"
#define STATS_CHILD_POPULATION "child_population"
#define STATS_ELDERLY_POPULATION "elderly_population"

// General statistics
#define STATS_MOAT_FALLERS "moat_fallers"
#define STATS_ANKLES_BROKEN "ankles_broken"
#define STATS_PEOPLE_SMITTEN "people_smitten"
#define STATS_TRIUMPHS_AWARDED "triumphs_awarded"
#define STATS_TRIUMPHS_STOLEN "triumphs_stolen"
#define STATS_PRAYERS_MADE "prayers_made"
#define STATS_KISSES_MADE "kisses_made"
#define STATS_SKILLS_LEARNED "skills_learned"
#define STATS_DEADITES_ALIVE "deadites_alive"
#define STATS_KLEPTOMANIACS "kleptomaniacs"

// Influence related statistics

// Psydon
#define STATS_HUMEN_DEATHS "humen_deaths"

// Astrata
#define STATS_LAWS_AND_DECREES_MADE "laws_and_decrees_made"
#define STATS_ALIVE_NOBLES "alive_nobles"
#define STATS_NOBLE_DEATHS "noble_deaths"
#define STATS_ASTRATA_REVIVALS "astrata_revivals"
#define STATS_TAXES_COLLECTED "taxes_collected"

// Noc
#define STATS_BOOKS_PRINTED "books_printed"
#define STATS_LITERACY_TAUGHT "literacy_taught"
#define STATS_ILLITERATES "illiterates"
#define STATS_SKILLS_DREAMED "skills_dreamed"
#define STATS_MANA_SPENT "mana_spent"

// Necra
#define STATS_DEATHS "deaths"
#define STATS_GRAVES_CONSECRATED "graves_consecrated"
#define STATS_GRAVES_ROBBED "graves_robbed"
#define STATS_DEADITES_KILLED "deadites_killed"
#define STATS_VAMPIRES_KILLED "vampires_killed"

// Pestra
#define STATS_POTIONS_BREWED "potions_brewed"
#define STATS_WOUNDS_SEWED "wounds_healed"
#define STATS_SOULS_REINCARNATED "souls_reincarnated"
#define STATS_ANIMALS_BRED "animals_bred"
#define STATS_FOOD_ROTTED "food_rotted"

// Dendor
#define STATS_TREES_CUT "trees_cut"
#define STATS_PLANTS_HARVESTED "plants_harvested"
#define STATS_WEREVOLVES "werevolves"
#define STATS_DENDOR_SACRIFICES "dendor_sacrifices"
#define STATS_FOREST_DEATHS "forest_deaths"

// Ravox
#define STATS_COMBAT_SKILLS "combat_skills"
#define STATS_PARRIES "parries"
#define STATS_WARCRIES "warcries"
#define STATS_YIELDS "yields"
#define STATS_UNDERWORLD_DUELS "underworld_duels"

// Xylix
#define STATS_LAUGHS_MADE "laughs_made"
#define STATS_GAMES_RIGGED "games_rigged"
#define STATS_PEOPLE_MOCKED "people_mocked"
#define STATS_CRITS_MADE "crits_made"
#define STATS_SONGS_PLAYED "songs_played"

// Malum
#define STATS_MASTERWORKS_FORGED "masterworks_forged"
#define STATS_ROCKS_MINED "ores_mined"
#define STATS_CRAFT_SKILLS "craft_skills"
#define STATS_BEARDS_SHAVED "beards_shaved"
#define STATS_BLACKSTEEL_SMELTED "blacksteel_smelted"

// Abyssor
#define STATS_WATER_CONSUMED "water_consumed"
#define STATS_FISH_CAUGHT "fish_caught"
#define STATS_ABYSSOR_REMEMBERED "abyssor_remembered"
#define STATS_LEECHES_EMBEDDED "leeches_embedded"
#define STATS_PEOPLE_DROWNED "people_drowned"

// Eora
#define STATS_PARENTS "parents"
#define STATS_MARRIAGES "marriages"
#define STATS_HUGS_MADE "hugs_made"
#define STATS_CLINGY_PEOPLE "clingy_people"
#define STATS_PACIFISTS "pacifists"

// Zizo
#define STATS_ZIZO_PRAISED "zizo_praised"
#define STATS_DEADITES_WOKEN_UP "deadites_woken_up"
#define STATS_CLERGY_DEATHS "priest_deaths"
#define STATS_TORTURES "tortures"

// Graggar
#define STATS_BLOOD_SPILT "blood_spilt"
#define STATS_ORGANS_EATEN "organs_eaten"
#define STATS_PEOPLE_GIBBED "people_gibbed"
#define STATS_ASSASSINATIONS "assassinations"
#define STATS_LIMBS_BITTEN "limbs_bitten"

// Baotha
#define STATS_DRUGS_SNORTED "drugs_snorted"
#define STATS_ALCOHOL_CONSUMED "alcohol_consumed"
#define STATS_ALCOHOLICS "alcoholics"
#define STATS_JUNKIES "junkies"
#define STATS_LUXURIOUS_FOOD_EATEN "luxurious_food_eaten"

// Matthios
#define STATS_ITEMS_PICKPOCKETED "items_pickpocketed"
#define STATS_SHRINE_VALUE "shrine_value"
#define STATS_GREEDY_PEOPLE "greedy_people"
#define STATS_DODGES "dodges"
#define STATS_LOCKS_PICKED "locks_picked"

GLOBAL_LIST_INIT(vanderlin_round_stats, list(
	STATS_DEATHS = 0,
	STATS_NOBLE_DEATHS = 0,
	STATS_MOAT_FALLERS = 0,
	STATS_ANKLES_BROKEN = 0,
	STATS_PEOPLE_SMITTEN = 0,
	STATS_BLOOD_SPILT = 0,
	STATS_PEOPLE_GIBBED = 0,
	STATS_TRIUMPHS_AWARDED = 0,
	STATS_TRIUMPHS_STOLEN = 0,
	STATS_DRUGS_SNORTED = 0,
	STATS_BEARDS_SHAVED = 0,
	STATS_TREES_CUT = 0,
	STATS_PRAYERS_MADE = 0,
	STATS_FISH_CAUGHT = 0,
	STATS_ITEMS_PICKPOCKETED = 0,
	STATS_MASTERWORKS_FORGED = 0,
	STATS_TAXES_COLLECTED = 0,
	STATS_ORGANS_EATEN = 0,
	STATS_KISSES_MADE = 0,
	STATS_LAUGHS_MADE = 0,
	STATS_GRAVES_CONSECRATED = 0,
	STATS_POTIONS_BREWED = 0,
	STATS_ASTRATA_REVIVALS = 0,
	STATS_PLANTS_HARVESTED = 0,
	STATS_LAWS_AND_DECREES_MADE = 0,
	STATS_ALIVE_NOBLES = 0,
	STATS_BOOKS_PRINTED = 0,
	STATS_LITERACY_TAUGHT = 0,
	STATS_ILLITERATES = 0,
	STATS_SKILLS_LEARNED = 0,
	STATS_GRAVES_ROBBED = 0,
	STATS_DEADITES_KILLED = 0,
	STATS_VAMPIRES_KILLED = 0,
	STATS_WOUNDS_SEWED = 0,
	STATS_SOULS_REINCARNATED = 0,
	STATS_ANIMALS_BRED = 0,
	STATS_WEREVOLVES = 0,
	STATS_DENDOR_SACRIFICES = 0,
	STATS_COMBAT_SKILLS = 0,
	STATS_PARRIES = 0,
	STATS_WARCRIES = 0,
	STATS_YIELDS = 0,
	STATS_GAMES_RIGGED = 0,
	STATS_PEOPLE_MOCKED = 0,
	STATS_CRITS_MADE = 0,
	STATS_ROCKS_MINED = 0,
	STATS_CRAFT_SKILLS = 0,
	STATS_ABYSSOR_REMEMBERED = 0,
	STATS_LEECHES_EMBEDDED = 0,
	STATS_MARRIAGES = 0,
	STATS_HUGS_MADE = 0,
	STATS_CLINGY_PEOPLE = 0,
	STATS_ZIZO_PRAISED = 0,
	STATS_DEADITES_ALIVE = 0,
	STATS_CLERGY_DEATHS = 0,
	STATS_ASSASSINATIONS = 0,
	STATS_ALCOHOL_CONSUMED = 0,
	STATS_ALCOHOLICS = 0,
	STATS_JUNKIES = 0,
	STATS_SHRINE_VALUE = 0,
	STATS_GREEDY_PEOPLE = 0,
	STATS_KLEPTOMANIACS = 0,
	STATS_HUMEN_DEATHS = 0,
	STATS_PARENTS = 0,
	STATS_SKILLS_DREAMED = 0,
	STATS_ALIVE_NORTHERN_HUMANS = 0,
	STATS_ALIVE_DWARVES = 0,
	STATS_ALIVE_DARK_ELVES = 0,
	STATS_ALIVE_SNOW_ELVES = 0,
	STATS_ALIVE_HALF_ELVES = 0,
	STATS_ALIVE_HALF_ORCS = 0,
	STATS_ALIVE_KOBOLDS = 0,
	STATS_ALIVE_RAKSHARI = 0,
	STATS_ALIVE_AASIMAR = 0,
	STATS_ALIVE_TIEFLINGS = 0,
	STATS_PEOPLE_DROWNED = 0,
	STATS_MANA_SPENT = 0,
	STATS_WATER_CONSUMED  = 0,
	STATS_LIMBS_BITTEN = 0,
	STATS_UNDERWORLD_DUELS = 0,
	STATS_LOCKS_PICKED = 0,
	STATS_SONGS_PLAYED = 0,
	STATS_FOOD_ROTTED = 0,
	STATS_BLACKSTEEL_SMELTED = 0,
	STATS_PACIFISTS = 0,
	STATS_FOREST_DEATHS = 0,
	STATS_TORTURES = 0,
	STATS_LUXURIOUS_FOOD_EATEN = 0,
	STATS_DEADITES_WOKEN_UP = 0,
	STATS_DODGES = 0,
	STATS_MARRIED = 0,
	STATS_MONARCH_PATRON = "None",
	STATS_MALE_POPULATION = 0,
	STATS_FEMALE_POPULATION = 0,
	STATS_OTHER_GENDER = 0,
	STATS_CHILD_POPULATION = 0,
	STATS_ELDERLY_POPULATION = 0,
))

GLOBAL_LIST_EMPTY(patron_follower_counts)

// Featured stats of the round
#define FEATURED_STATS_TREE_FELLERS "tree_fellers"
#define FEATURED_STATS_THIEVES "thieves"
#define FEATURED_STATS_ALCHEMISTS "alchemists"

GLOBAL_LIST_INIT(featured_stats, list(
	FEATURED_STATS_TREE_FELLERS = list(
		"name" = "TOP 10 Lumberjacks",
		"color" = "#9b6937",
		"entries" = list()
	),
	FEATURED_STATS_ALCHEMISTS = list(
		"name" = "TOP 10 Alchemists",
		"color" = "#6b256e",
		"entries" = list()
	),
	FEATURED_STATS_THIEVES = list(
		"name" = "TOP 10 Thieves",
		"color" = "#6e4a25",
		"entries" = list()
	),
))

/proc/get_featured_stat_display(stat_id)
	var/list/stat_data = GLOB.featured_stats[stat_id]
	if(!stat_data)
		stat_id = GLOB.featured_stats[1]
		stat_data = GLOB.featured_stats[stat_id]

	return "<font color='[stat_data["color"]]'><span class='bold'>[stat_data["name"]]:</span></font><br>" + \
	       format_top_ten(stat_id)

/proc/format_top_ten(stat_category)
	var/list/stat_data = GLOB.featured_stats[stat_category]
	if(!stat_data || !stat_data["entries"])
		return "No data available"

	var/list/entries = list()
	for(var/key in stat_data["entries"])
		entries += list(list("name" = key, "count" = stat_data["entries"][key]))

	entries = sortList(entries, /proc/cmp_stat_count_desc)

	var/list/result = list()
	for(var/i in 1 to min(10, entries.len)) // Show top 10 instead of just 3
		var/list/entry = entries[i]
		result += "[i]. [entry["name"]] - [entry["count"]]"

	return result.Join("<br>")

/proc/cmp_stat_count_desc(list/a, list/b)
    return b["count"] - a["count"]

/proc/record_featured_stat(stat_category, mob/living/user, increment = 1)
	if(!stat_category || !user?.real_name || !GLOB.featured_stats[stat_category])
		return

	var/list/stat_data = GLOB.featured_stats[stat_category]
	var/job_title = ""

	if(user.mind?.assigned_role)
		job_title = " ([user.mind.assigned_role.title])"
	else if(user.job)
		job_title = " ([user.job])"

	var/key = "[user.real_name][job_title]"

	if(!stat_data["entries"])
		stat_data["entries"] = list()

	stat_data["entries"][key] = (stat_data["entries"][key] || 0) + increment
