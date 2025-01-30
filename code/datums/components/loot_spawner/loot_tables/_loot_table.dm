/datum/loot_table
	///okay this is quite the different thing, essentially this works with 2 things, either a an assoc list of stat or skill
	///to list of items with weights. Or Just raw list with weights, these then get added in with bonuses based on their skills based on a minimum
	///you can set the minimum value in the second list or leave it default which is 0
	///if a number is in the list ie item_path = 5, 12 if you aren't higher then that level it just ends there
	///this does mean that you should structure it lowest to highest or you will run into issues
	var/list/loot_table = list()

	///this is our minimum skill list
	var/list/minimum_skill_list = list()
	///our growth factor for each skill
	var/list/growth_factor_list = list(
		STATKEY_LCK = 0.99
	)

	var/base_min = 1
	var/base_max = 3
	var/scaling_factor = 0.4

/datum/loot_table/proc/spawn_loot(mob/living/looter)
	var/list/weighted_list = return_list(looter)
	var/mob_stat_level = looter.return_stat_level(STATKEY_LCK)

	var/adjusted_min = base_min + round(mob_stat_level * scaling_factor, 1)
	var/adjusted_max = base_max + round(mob_stat_level * scaling_factor, 1)
	adjusted_min = min(adjusted_min, adjusted_max)

	var/spawn_count = rand(adjusted_min, adjusted_max)

	for(var/i = 1 to spawn_count)
		var/atom/spawn_path = pickweight(weighted_list)
		var/atom/movable/new_spawn = new spawn_path(get_turf(looter))
		looter.put_in_active_hand(new_spawn)

/datum/loot_table/proc/return_list(mob/looter)
	var/list/weighted_list = list()

	for(var/thing in loot_table)
		if(islist(thing))
			weighted_list |= thing
		if(thing in MOBSTATS)
			weighted_list |= return_stat_weight(thing, looter)
		if(ispath(thing, /datum/skill))
			weighted_list |= return_skill_weight(thing, looter)
	return weighted_list

/datum/loot_table/proc/return_stat_weight(stat_key, mob/living/looter)
	var/list/weighted_list = list()
	var/list/pre_weight_list = loot_table[stat_key]

	var/mob_stat_level = looter.return_stat_level(stat_key)
	var/minimum_stat_level = 0
	var/growth_factor = 1.02
	if(stat_key in growth_factor_list)
		growth_factor = growth_factor_list[stat_key]
	if(stat_key in minimum_skill_list)
		minimum_stat_level = minimum_skill_list[stat_key]
	mob_stat_level -= minimum_stat_level

	for(var/item in pre_weight_list)
		if(isnum(item))
			if(item > mob_stat_level)
				break
		var/base_weight = pre_weight_list[item]
		var/scaled_weight = base_weight * (1 + growth_factor ** mob_stat_level)
		if(mob_stat_level == 0)
			scaled_weight = base_weight
		weighted_list |= item
		weighted_list[item] = scaled_weight

	return weighted_list

/datum/loot_table/proc/return_skill_weight(datum/skill/skill_type, mob/living/looter)
	var/list/weighted_list = list()
	var/list/pre_weight_list = loot_table[skill_type]

	var/mob_skill_level = looter.mind?.get_skill_level(skill_type)
	var/minimum_skill_level = 0
	var/growth_factor = 1.05
	if(skill_type in growth_factor_list)
		growth_factor = growth_factor_list[skill_type]
	if(skill_type in minimum_skill_list)
		minimum_skill_level = minimum_skill_list[skill_type]
	mob_skill_level -= minimum_skill_level

	for(var/item in pre_weight_list)
		if(isnum(item))
			if(item > mob_skill_level)
				break
		var/base_weight = pre_weight_list[item]
		var/scaled_weight = base_weight * (1 + growth_factor ** mob_skill_level)
		if(mob_skill_level == 0)
			scaled_weight = base_weight
		weighted_list |= item
		weighted_list[item] = scaled_weight

	return weighted_list
