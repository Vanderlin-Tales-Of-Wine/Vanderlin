#define RNGCHEM_INPUT "input"
#define RNGCHEM_CATALYSTS "catalysts"
#define RNGCHEM_OUTPUT "output"

/datum/chemical_reaction/randomized
	name = "semi randomized reaction"

	var/persistent = FALSE
	var/persistence_period = 7 //Will reset every x days
	var/created //creation timestamp

	var/randomize_container = FALSE
	var/list/possible_containers = list()

	var/randomize_req_temperature = TRUE
	var/min_temp = 1
	var/max_temp = 600

	var/randomize_inputs = TRUE
	var/min_input_reagent_amount = 1
	var/max_input_reagent_amount = 10
	var/min_input_reagents = 2
	var/max_input_reagents = 5
	var/list/possible_reagents = list()
	var/min_catalysts = 0
	var/max_catalysts = 2
	var/list/possible_catalysts = list()

	var/randomize_results = FALSE
	var/min_output_reagent_amount = 1
	var/max_output_reagent_amount = 5
	var/min_result_reagents = 1
	var/max_result_reagents = 1
	var/list/possible_results = list()

/datum/chemical_reaction/randomized/proc/GenerateRecipe()
	created = world.time
	if(randomize_container)
		required_container = pick(possible_containers)
	if(randomize_req_temperature)
		required_temp = rand(min_temp,max_temp)
		is_cold_recipe = pick(TRUE,FALSE)

	if(randomize_results)
		results = list()
		var/list/remaining_possible_results = GetPossibleReagents(RNGCHEM_OUTPUT)
		var/out_reagent_count = min(rand(min_result_reagents,max_result_reagents),remaining_possible_results.len)
		for(var/i in 1 to out_reagent_count)
			var/r_id = pick_n_take(remaining_possible_results)
			results[r_id] = rand(min_output_reagent_amount,max_output_reagent_amount)

	if(randomize_inputs)
		var/list/remaining_possible_reagents = GetPossibleReagents(RNGCHEM_INPUT)
		var/list/remaining_possible_catalysts = GetPossibleReagents(RNGCHEM_CATALYSTS)
		//We're going to assume we're not doing any weird partial reactions for now.
		for(var/reagent_type in results)
			remaining_possible_catalysts -= reagent_type
			remaining_possible_reagents -= reagent_type

		var/in_reagent_count = min(rand(min_input_reagents,max_input_reagents),remaining_possible_reagents.len)
		if(in_reagent_count <= 0)
			return FALSE

		required_reagents = list()
		for(var/i in 1 to in_reagent_count)
			var/r_id = pick_n_take(remaining_possible_reagents)
			required_reagents[r_id] = rand(min_input_reagent_amount,max_input_reagent_amount)
			remaining_possible_catalysts -= r_id //Can't have same reagents both as catalyst and reagent. Or can we ?

		required_catalysts = list()
		var/in_catalyst_count = min(rand(min_catalysts,max_catalysts),remaining_possible_catalysts.len)
		for(var/i in 1 to in_catalyst_count)
			var/r_id = pick_n_take(remaining_possible_catalysts)
			required_catalysts[r_id] = rand(min_input_reagent_amount,max_input_reagent_amount)

	return TRUE

/datum/chemical_reaction/randomized/proc/GetPossibleReagents(kind)
	switch(kind)
		if(RNGCHEM_INPUT)
			return possible_reagents.Copy()
		if(RNGCHEM_CATALYSTS)
			return possible_catalysts.Copy()
		if(RNGCHEM_OUTPUT)
			return possible_results.Copy()

/datum/chemical_reaction/randomized/proc/HasConflicts()
	for(var/x in required_reagents)
		for(var/datum/chemical_reaction/R in GLOB.chemical_reactions_list[x])
			if(chem_recipes_do_conflict(R,src))
				return TRUE
	return FALSE

/datum/chemical_reaction/randomized/proc/unwrap_reagent_list(list/textreagents)
	. = list()
	for(var/R in textreagents)
		var/pathR = text2path(R)
		if(!pathR)
			return null
		.[pathR] = textreagents[R]

/datum/chemical_reaction/randomized/proc/LoadOldRecipe(recipe_data)
	created = text2num(recipe_data["timestamp"])

	var/req_reag = unwrap_reagent_list(recipe_data["required_reagents"])
	if(!req_reag)
		return FALSE
	required_reagents = req_reag

	var/req_catalysts = unwrap_reagent_list(recipe_data["required_catalysts"])
	if(!req_catalysts)
		return FALSE
	required_catalysts = req_catalysts

	required_temp = recipe_data["required_temp"]
	is_cold_recipe = recipe_data["is_cold_recipe"]

	var/temp_results = unwrap_reagent_list(recipe_data["results"])
	if(!temp_results)
		return FALSE
	results = temp_results
	var/containerpath = text2path(recipe_data["required_container"])
	if(!containerpath)
		return FALSE
	required_container =  containerpath
	return TRUE

#undef RNGCHEM_INPUT
#undef RNGCHEM_CATALYSTS
#undef RNGCHEM_OUTPUT
