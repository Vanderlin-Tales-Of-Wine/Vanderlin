/datum/stockpile
	var/list/stored_materials = list(
		MAT_STONE = 0,
		MAT_WOOD = 0,
		MAT_GEM = 0,
		MAT_ORE = 0,
		MAT_INGOT = 0,
		MAT_COAL = 0,
		MAT_GRAIN = 5,
		MAT_MEAT = 0,
		MAT_VEG = 0,
		MAT_FRUIT = 0,
	)

/datum/stockpile/proc/has_resources(list/resources_to_spend)
	for(var/resource in resources_to_spend)
		if(!(resource in stored_materials))
			return FALSE
		if(stored_materials[resource] < resources_to_spend[resource])
			return FALSE
	return TRUE

/datum/stockpile/proc/has_any_resources(list/resources_to_spend)
	var/has_any = FALSE
	for(var/resource in resources_to_spend)
		if(!(resource in stored_materials))
			continue
		if(stored_materials[resource] >= 0)
			has_any = TRUE
	return has_any

/datum/stockpile/proc/add_resources(list/resources_to_spend)
	for(var/resource in resources_to_spend)
		if(!(resource in stored_materials))
			continue
		stored_materials[resource] += resources_to_spend[resource]
	return TRUE

/datum/stockpile/proc/remove_resources(list/resources_to_spend)
	for(var/resource in resources_to_spend)
		if(!(resource in stored_materials))
			continue
		stored_materials[resource] -= resources_to_spend[resource]
	return TRUE
