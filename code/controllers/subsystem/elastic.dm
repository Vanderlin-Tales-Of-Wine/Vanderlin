/datum/config_entry/string/elastic_endpoint
	protection = CONFIG_ENTRY_HIDDEN

/datum/config_entry/string/metrics_api_token
	protection = CONFIG_ENTRY_HIDDEN

/datum/config_entry/flag/elastic_middleware_enabled

SUBSYSTEM_DEF(elastic)
	name = "Elastic Middleware"
	wait = 30 SECONDS
	runlevels = RUNLEVEL_LOBBY | RUNLEVEL_SETUP | RUNLEVEL_GAME | RUNLEVEL_POSTGAME
	flags = SS_KEEP_TIMING // This needs to ingest every 30 IRL seconds, not ingame seconds.
	///this is set in Genesis
	var/world_init_time = 0
	///this NEEDS NEEDS NEEDS NEEDS NEEDS to be assoclists when 516 is in this will be an alist
	var/list/assoc_list_data = list()
	///abstract information - basically want to keep track of spell casts over the round? do it like this
	var/list/abstract_information = list()

/datum/controller/subsystem/elastic/Initialize(start_timeofday)
	if(!CONFIG_GET(flag/elastic_middleware_enabled))
		flags |= SS_NO_FIRE // Disable firing to save CPU
	return ..()

/datum/controller/subsystem/elastic/fire(resumed)
	send_data()


/datum/controller/subsystem/elastic/proc/send_data(all_data = TRUE)
	var/datum/http_request/request = new()
	request.prepare(RUSTG_HTTP_METHOD_POST, CONFIG_GET(string/elastic_endpoint), get_compiled_data(all_data), list(
		"Authorization" = "ApiKey [CONFIG_GET(string/metrics_api_token)]",
		"Content-Type" = "application/json"
	))
	request.begin_async()

/datum/controller/subsystem/elastic/proc/get_compiled_data(all_data)
	var/list/compiled = list()
	//DON'T CHANGE THIS EVER OR THIS WILL ALL BREAK
	compiled["@timestamp"] = time_stamp_metric()
	compiled["cpu"] = world.cpu
	compiled["elapsed_process_time"] = world.time
	compiled["elapsed_real_time"] = (REALTIMEOFDAY - world_init_time)
	compiled["client_count"] = length(GLOB.clients)
	///if you are on literally any other server change this to a text2num(GLOB.round_id)
	compiled["round_id"] = GLOB.rogue_round_id
	///you see why this needs to be an assoc list now?
	compiled |= assoc_list_data

	///down here is specific to vanderlin so if you are porting this you can take this out
	compiled["round_data"] = get_round_data()
	assoc_list_data = list()
	return json_encode(compiled)

/datum/controller/subsystem/elastic/proc/get_round_data()
	var/list/round_data = list()

	round_data["blood_lost"] = round(SSticker.blood_lost / 100, 1)
	round_data["ankles_broken"] = SSticker.holefall
	round_data["deaths"] = SSticker.deaths
	round_data["moat_fallers"] = SSticker.moatfallers
	round_data["smited"] = SSticker.pplsmited
	round_data["gibbed"] = SSticker.gibbs
	round_data["triumph_gained"] = SSticker.tri_gained
	round_data["triumph_lost"] = SSticker.tri_lost
	round_data["snorted_drugs"] = SSticker.snort
	round_data["beards_shaved"] = SSticker.beardshavers

	return round_data

/datum/controller/subsystem/elastic/proc/add_list_data(main_cat = "generic", list/assoc_data)
	if(!main_cat || !length(assoc_data))
		return

	assoc_list_data |= main_cat
	if(!length(assoc_list_data[main_cat]))
		assoc_list_data[main_cat] = list()
	assoc_list_data[main_cat] |= assoc_data

///this is best for numerical data think x event ran 12 times since you're updating the number with the total run anyway.
/proc/add_elastic_data(main_cat, list/assoc_data)
	if(!main_cat || !length(assoc_data))
		return
	SSelastic.add_list_data(main_cat, assoc_data)
	return TRUE

///this should be used for logging purposes think runtimes, or wanting to track player x does y
/proc/add_elastic_data_immediate(main_cat, list/assoc_data)
	if(!main_cat || !length(assoc_data))
		return
	SSelastic.add_list_data(main_cat, assoc_data)
	SSelastic.send_data()
	return TRUE

///this is best for numerical data think x event ran 12 times since you're updating the number with the total run anyway.
/proc/add_abstract_elastic_data(main_cat, abstract_name, abstract_value)
	if(!isnum(abstract_value))
		return
	if(!main_cat)
		return
	SSelastic.abstract_information |= abstract_name
	SSelastic.abstract_information[abstract_name] += abstract_value
	var/list/data = list("[abstract_name]" = SSelastic.abstract_information[abstract_name])
	SSelastic.add_list_data(main_cat, data)
	return TRUE
