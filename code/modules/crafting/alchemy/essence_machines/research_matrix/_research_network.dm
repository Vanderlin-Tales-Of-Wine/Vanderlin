GLOBAL_DATUM_INIT(thaumic_research, /datum/thaumic_research_network, new())

/datum/thaumic_research_network
	var/list/unlocked_research = list()
	var/list/research_nodes = list()

/datum/thaumic_research_network/New()
	. = ..()
	// Initialize with basic research
	unlocked_research += /datum/thaumic_research_node/basic_understanding
	// Cache all research node types for easy access
	for(var/node_type in subtypesof(/datum/thaumic_research_node))
		var/datum/thaumic_research_node/node = new node_type
		research_nodes[node_type] = node

/datum/thaumic_research_network/proc/has_research(research_type)
	return research_type in unlocked_research

/datum/thaumic_research_network/proc/unlock_research(research_type)
	if(research_type in unlocked_research)
		return FALSE
	unlocked_research += research_type
	return TRUE

/datum/thaumic_research_network/proc/get_research_bonus(bonus_type)
	var/bonus = 1.0
	switch(bonus_type)
		if("splitting_efficiency")
			if(has_research(/datum/thaumic_research_node/basic_splitter))
				bonus += 0.20
			if(has_research(/datum/thaumic_research_node/advanced_splitter))
				bonus += 0.40
			if(has_research(/datum/thaumic_research_node/expert_splitter))
				bonus += 0.60
			if(has_research(/datum/thaumic_research_node/master_splitter))
				bonus += 1.0
			if(has_research(/datum/thaumic_research_node/splitter_output_four))
				bonus += 1.50
			if(has_research(/datum/thaumic_research_node/splitter_output_five))
				bonus += 2.00

		if("combining_output")
			if(has_research(/datum/thaumic_research_node/combiner_output))
				bonus += 0.30
			if(has_research(/datum/thaumic_research_node/combiner_output_two))
				bonus += 0.50
			if(has_research(/datum/thaumic_research_node/combiner_output_three))
				bonus += 0.80
			if(has_research(/datum/thaumic_research_node/combiner_output_four))
				bonus += 1.2
			if(has_research(/datum/thaumic_research_node/combiner_speed_five))
				bonus += 2

		if("gnome_hat_chance")
			if(has_research(/datum/thaumic_research_node/gnome_mastery))
				bonus -= 0.95 // Near-guaranteed hat spawning

	return bonus

/datum/thaumic_research_network/proc/get_cost_reduction(cost_type)
	var/reduction = 1.0
	switch(cost_type)
		if("life_tube")
			if(has_research(/datum/thaumic_research_node/gnome_efficency))
				reduction -= 0.1
			if(has_research(/datum/thaumic_research_node/gnome_efficeny_two))
				reduction -= 0.2
			if(has_research(/datum/thaumic_research_node/gnome_efficeny_three))
				reduction -= 0.2

	return max(reduction, 0.05) // Never reduce below 5% of original cost

/datum/thaumic_research_network/proc/get_speed_multiplier(speed_type)
	var/multiplier = 1.0
	switch(speed_type)
		if("test_tube")
			if(has_research(/datum/thaumic_research_node/gnome_speed))
				multiplier += 0.33
			if(has_research(/datum/thaumic_research_node/gnome_speed_two))
				multiplier += 0.50
			if(has_research(/datum/thaumic_research_node/gnome_speed_three))
				multiplier += 0.75

		if("essence_splitting")
			if(has_research(/datum/thaumic_research_node/splitter_speed))
				multiplier += 0.40
			if(has_research(/datum/thaumic_research_node/splitter_speed_two))
				multiplier += 0.70
			if(has_research(/datum/thaumic_research_node/splitter_speed_three))
				multiplier += 1.20

		if("essence_combining")
			if(has_research(/datum/thaumic_research_node/combiner_speed))
				multiplier += 0.35
			if(has_research(/datum/thaumic_research_node/combiner_speed_two))
				multiplier += 0.60
			if(has_research(/datum/thaumic_research_node/combiner_speed_three))
				multiplier += 1.00
			if(has_research(/datum/thaumic_research_node/combiner_speed_four))
				multiplier += 1.50
			if(has_research(/datum/thaumic_research_node/combiner_speed_five))
				multiplier += 3.00

		if("transmutation_speed")
			if(has_research(/datum/thaumic_research_node/transmutation))
				multiplier += 0.25

	return multiplier

/datum/thaumic_research_network/proc/can_use_machine(machine_type)
	switch(machine_type)
		if("test_tube")
			return has_research(/datum/thaumic_research_node/gnomes)
		if("resevoir_void")
			return has_research(/datum/thaumic_research_node/resevoir_decay)
	return TRUE

/datum/thaumic_research_network/proc/get_available_research()
	var/list/available = list()
	for(var/node_type in subtypesof(/datum/thaumic_research_node))
		if(node_type in unlocked_research)
			continue
		var/datum/thaumic_research_node/node = research_nodes[node_type]
		if(!node)
			continue
		var/can_research = TRUE
		for(var/prereq in node.prerequisites)
			if(!(prereq in unlocked_research))
				can_research = FALSE
				break
		if(can_research)
			available += node_type
	return available

/datum/thaumic_research_network/proc/can_research(datum/thaumic_research_node/node_type)
	return(node_type in get_available_research())
