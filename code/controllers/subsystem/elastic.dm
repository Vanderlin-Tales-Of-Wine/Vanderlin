/datum/config_entry/flag/elastic_middleware_enabled

/datum/config_entry/string/elastic_endpoint
	protection = CONFIG_ENTRY_HIDDEN

/datum/config_entry/string/metrics_api_token
	protection = CONFIG_ENTRY_HIDDEN

SUBSYSTEM_DEF(elastic)
	name = "Elastic Middleware"
	wait = 30 SECONDS
	runlevels = RUNLEVEL_LOBBY | RUNLEVEL_SETUP | RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	flags = SS_KEEP_TIMING // This needs to ingest every 30 IRL seconds, not ingame seconds.
	/// The TIMEOFDAY when /world was created. Set in Genesis.
	var/world_init_time = 0
	/// Compiled round list data. Interfaced with [proc/add_list_data]
	var/list/assoc_list_data = list() //! ### This NEEDS NEEDS NEEDS NEEDS NEEDS to be an assoclist. When 516 is in this will be an alist
	///abstract information - basically want to keep track of spell casts over the round? do it like this
	var/list/abstract_information = list()

/datum/controller/subsystem/elastic/Initialize(start_timeofday)
	if(!CONFIG_GET(flag/elastic_middleware_enabled))
		flags |= SS_NO_FIRE // Disable firing to save CPU
	set_abstract_data_zeros()
	return ..()

/datum/controller/subsystem/elastic/fire(resumed)
	send_data()

/datum/controller/subsystem/elastic/proc/send_data()
	var/datum/http_request/request = new()
	request.prepare(RUSTG_HTTP_METHOD_POST, CONFIG_GET(string/elastic_endpoint), get_compiled_data(), list(
		"Authorization" = "ApiKey [CONFIG_GET(string/metrics_api_token)]",
		"Content-Type" = "application/json"
	))
	request.begin_async()

/datum/controller/subsystem/elastic/proc/get_compiled_data()
	var/list/compiled = list()
	//DON'T CHANGE ANY OF THIS BLOCK EVER OR THIS WILL ALL BREAK
	compiled["@timestamp"] = time_stamp_metric()
	compiled["cpu"] = world.cpu
	compiled["elapsed_process_time"] = world.time
	compiled["elapsed_real_time"] = (REALTIMEOFDAY - world_init_time)
	compiled["client_count"] = length(GLOB.clients)
	compiled["round_id"] = GLOB.rogue_round_id // if you are on literally any other server change this to a text2num(GLOB.round_id)
	compiled |= assoc_list_data // you see why this needs to be an assoc list now?

	// down here is specific to vanderlin so if you are porting this you can take this out
	compiled["round_data"] = get_round_data()

	assoc_list_data = list()
	return json_encode(compiled)

/datum/controller/subsystem/elastic/proc/get_round_data()
	var/list/round_data = list()

	round_data["blood_lost"] = round(GLOB.vanderlin_round_stats[STATS_BLOOD_SPILT] / 100, 1)
	round_data["ankles_broken"] = GLOB.vanderlin_round_stats[STATS_ANKLES_BROKEN]
	round_data["deaths"] = GLOB.vanderlin_round_stats[STATS_DEATHS]
	round_data["noble_deaths"] = GLOB.vanderlin_round_stats[STATS_NOBLE_DEATHS]
	round_data["moat_fallers"] = GLOB.vanderlin_round_stats[STATS_MOAT_FALLERS]
	round_data["smited"] = GLOB.vanderlin_round_stats[STATS_PEOPLE_SMITTEN]
	round_data["gibbed"] = GLOB.vanderlin_round_stats[STATS_PEOPLE_GIBBED]
	round_data["triumph_gained"] = GLOB.vanderlin_round_stats[STATS_TRIUMPHS_AWARDED]
	round_data["triumph_lost"] = GLOB.vanderlin_round_stats[STATS_TRIUMPHS_STOLEN]
	round_data["snorted_drugs"] = GLOB.vanderlin_round_stats[STATS_DRUGS_SNORTED]
	round_data["beards_shaved"] = GLOB.vanderlin_round_stats[STATS_BEARDS_SHAVED]
	round_data["trees_cut"] = GLOB.vanderlin_round_stats[STATS_TREES_CUT]
	round_data["prayers_made"] = GLOB.vanderlin_round_stats[STATS_PRAYERS_MADE]
	round_data["fish_caught"] = GLOB.vanderlin_round_stats[STATS_FISH_CAUGHT]
	round_data["items_pickpocketed"] = GLOB.vanderlin_round_stats[STATS_ITEMS_PICKPOCKETED]
	round_data["masterworks_forged"] = GLOB.vanderlin_round_stats[STATS_MASTERWORKS_FORGED]
	round_data["taxes_collected"] = GLOB.vanderlin_round_stats[STATS_TAXES_COLLECTED]
	round_data["organs_eaten"] = GLOB.vanderlin_round_stats[STATS_ORGANS_EATEN]
	round_data["kisses_made"] = GLOB.vanderlin_round_stats[STATS_KISSES_MADE]
	round_data["laughs_made"] = GLOB.vanderlin_round_stats[STATS_LAUGHS_MADE]
	round_data["graves_consecrated"] = GLOB.vanderlin_round_stats[STATS_GRAVES_CONSECRATED]
	round_data["potions_brewed"] = GLOB.vanderlin_round_stats[STATS_POTIONS_BREWED]
	round_data["astrata_revivals"] = GLOB.vanderlin_round_stats[STATS_ASTRATA_REVIVALS]
	round_data["plants_harvested"] = GLOB.vanderlin_round_stats[STATS_PLANTS_HARVESTED]
	round_data["humen_deaths"] = GLOB.vanderlin_round_stats[STATS_HUMEN_DEATHS]
	round_data["laws_made"] = GLOB.vanderlin_round_stats[STATS_LAWS_MADE]
	round_data["alive_nobles"] = GLOB.vanderlin_round_stats[STATS_ALIVE_NOBLES]
	round_data["books_printed"] = GLOB.vanderlin_round_stats[STATS_BOOKS_PRINTED]
	round_data["literacy_taught"] = GLOB.vanderlin_round_stats[STATS_LITERACY_TAUGHT]
	round_data["illiterates"] = GLOB.vanderlin_round_stats[STATS_ILLITERATES]
	round_data["skills_learned"] = GLOB.vanderlin_round_stats[STATS_SKILLS_LEARNED]
	round_data["graves_robbed"] = GLOB.vanderlin_round_stats[STATS_GRAVES_ROBBED]
	round_data["deadites_killed"] = GLOB.vanderlin_round_stats[STATS_DEADITES_KILLED]
	round_data["vampires_killed"] = GLOB.vanderlin_round_stats[STATS_VAMPIRES_KILLED]
	round_data["wounds_healed"] = GLOB.vanderlin_round_stats[STATS_WOUNDS_SEWED]
	round_data["souls_reincarnated"] = GLOB.vanderlin_round_stats[STATS_SOULS_REINCARNATED]
	round_data["animals_bred"] = GLOB.vanderlin_round_stats[STATS_ANIMALS_BRED]
	round_data["werevolves"] = GLOB.vanderlin_round_stats[STATS_WEREVOLVES]
	round_data["dendor_sacrifices"] = GLOB.vanderlin_round_stats[STATS_DENDOR_SACRIFICES]
	round_data["combat_skills"] = GLOB.vanderlin_round_stats[STATS_COMBAT_SKILLS]
	round_data["parries"] = GLOB.vanderlin_round_stats[STATS_PARRIES]
	round_data["warcries"] = GLOB.vanderlin_round_stats[STATS_WARCRIES]
	round_data["yields"] = GLOB.vanderlin_round_stats[STATS_YIELDS]
	round_data["games_rigged"] = GLOB.vanderlin_round_stats[STATS_GAMES_RIGGED]
	round_data["people_mocked"] = GLOB.vanderlin_round_stats[STATS_PEOPLE_MOCKED]
	round_data["crits_made"] = GLOB.vanderlin_round_stats[STATS_CRITS_MADE]
	round_data["ores_mined"] = GLOB.vanderlin_round_stats[STATS_ROCKS_MINED]
	round_data["craft_skills"] = GLOB.vanderlin_round_stats[STATS_CRAFT_SKILLS]
	round_data["abyssor_remembered"] = GLOB.vanderlin_round_stats[STATS_ABYSSOR_REMEMBERED]
	round_data["leeches_embedded"] = GLOB.vanderlin_round_stats[STATS_LEECHES_EMBEDDED]
	round_data["marriages"] = GLOB.vanderlin_round_stats[STATS_MARRIAGES]
	round_data["hugs_made"] = GLOB.vanderlin_round_stats[STATS_HUGS_MADE]
	round_data["clingy_people"] = GLOB.vanderlin_round_stats[STATS_CLINGY_PEOPLE]
	round_data["zizo_praised"] = GLOB.vanderlin_round_stats[STATS_ZIZO_PRAISED]
	round_data["deadites_alive"] = GLOB.vanderlin_round_stats[STATS_DEADITES_ALIVE]
	round_data["priest_deaths"] = GLOB.vanderlin_round_stats[STATS_CLERGY_DEATHS]
	round_data["assassinations"] = GLOB.vanderlin_round_stats[STATS_ASSASSINATIONS]
	round_data["alcohol_consumed"] = GLOB.vanderlin_round_stats[STATS_ALCOHOL_CONSUMED]
	round_data["alcoholics"] = GLOB.vanderlin_round_stats[STATS_ALCOHOLICS]
	round_data["junkies"] = GLOB.vanderlin_round_stats[STATS_JUNKIES]
	round_data["shrine_value"] = GLOB.vanderlin_round_stats[STATS_SHRINE_VALUE]
	round_data["tomb_deaths"] = GLOB.vanderlin_round_stats[STATS_GREEDY_PEOPLE]
	round_data["kleptomaniacs"] = GLOB.vanderlin_round_stats[STATS_KLEPTOMANIACS]
	round_data["parents"] = GLOB.vanderlin_round_stats[STATS_PARENTS]
	round_data["skills_dreamed"] = GLOB.vanderlin_round_stats[STATS_SKILLS_DREAMED]
	round_data["alive_tieflings"] = GLOB.vanderlin_round_stats[STATS_ALIVE_TIEFLINGS]

	return round_data

/datum/controller/subsystem/elastic/proc/add_list_data(main_cat = ELASCAT_GENERIC, list/assoc_data)
	if(!main_cat || !length(assoc_data))
		return

	assoc_list_data |= main_cat
	if(!length(assoc_list_data[main_cat]))
		assoc_list_data[main_cat] = list()
	assoc_list_data[main_cat] |= assoc_data

/// Inserts `(|=)` a datapoint into an elasticsearch category's data packet.
/proc/add_elastic_data(main_cat, list/assoc_data)
	if(!main_cat || !length(assoc_data))
		return
	SSelastic.add_list_data(main_cat, assoc_data)
	return TRUE

/// Inserts `(|=)` and immediately sends the provided data packet to elasticsearch.
/// This should be used for logging purposes, such as runtimes or wanting to track "player x did y".
/proc/add_elastic_data_immediate(main_cat, list/assoc_data)
	if(add_elastic_data(main_cat, assoc_data))
		SSelastic.send_data()
		return TRUE

/// Adds `(+=)` a numerical value to an elasticsearch data point.
/// Think "x event ran 12 times this packet" since you're updating the number with the total ran anyway.
/proc/add_abstract_elastic_data(main_cat, abstract_name, abstract_value, maximum)
	if(!main_cat || !isnum(abstract_value))
		return

	SSelastic.abstract_information |= abstract_name
	SSelastic.abstract_information[abstract_name] += abstract_value
	if(maximum)
		SSelastic.abstract_information[abstract_name] = min(maximum, SSelastic.abstract_information[abstract_name])

	var/list/data = list("[abstract_name]" = SSelastic.abstract_information[abstract_name])
	SSelastic.add_list_data(main_cat, data)
	return TRUE

/// Zeroes out some abstract data values.
/// This really exists if you want data to start at 0, useful for timeseries data without round filtering.
/proc/set_abstract_data_zeros()
	add_abstract_elastic_data(ELASCAT_COMBAT, ELASDATA_FIGHT_REVIVES, 0)
	add_abstract_elastic_data(ELASCAT_COMBAT, ELASDATA_COIN_REVIVES, 0)
	add_abstract_elastic_data(ELASCAT_COMBAT, ELASDATA_EATEN_BODIES, 0)
	add_abstract_elastic_data(ELASCAT_COMBAT, ELASDATA_DECAPITATIONS, 0)

	add_abstract_elastic_data(ELASCAT_ECONOMY, ELASDATA_MAMMONS_GAINED, 0)
	add_abstract_elastic_data(ELASCAT_ECONOMY, ELASDATA_MAMMONS_SPENT, 0)
