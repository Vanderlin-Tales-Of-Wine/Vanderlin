/*
HOW THE SCALING WORKS:

1. DELVE LEVEL SCALING:
- Quantity: Higher delves spawn more items (base_min/max * delve_quantity_scaling^(delve_level-1))
- Quality: Rare items (low base weight) get exponentially better odds at higher delves
- Items with weight 1 become much more common at delve 5 vs delve 1
- Items with weight 50 see minimal change between delve levels

2. ITEM RARITY MULTIPLIER:
- Multiplicative with all other scaling
- item_rarity = 2.0 doubles all drop chances
- item_rarity = 0.5 halves all drop chances
- Works independently of delve scaling

3. COMBINED EFFECT:
- A rare item (weight 1) at delve 5 with 2.0 item rarity will be MUCH more common
- A common item (weight 100) sees less dramatic changes
- The system naturally creates better loot at higher delves while respecting player modifiers

CONFIGURATION:
- delve_quantity_scaling: How much more loot spawns per delve level (1.5 = 50% more per level)
- delve_rarity_scaling: How much rare items benefit from higher delves (1.3 = 30% bonus per level)
- min_delve_level/max_delve_level: Valid delve range for this table
*/

/datum/loot_table
	var/name = "generic table"
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
		STAT_FORTUNE = 0.99
	)

	///this is at bare minimum spawn at base
	var/base_min = 1
	///this is at bare minimum our maximum spawn count. Luck and the scaling factor is added to this
	var/base_max = 3
	///how much each point of luck affects the max and minimum
	var/scaling_factor = 0.4

	///delve level scaling for loot quantity (multiplier per delve level)
	var/delve_quantity_scaling = 1.1
	///delve level scaling for rare loot weights (multiplier per delve level)
	var/delve_rarity_scaling = 1.3
	///minimum delve level for this loot table (1-5)
	var/min_delve_level = 1
	///maximum delve level for this loot table (1-5)
	var/max_delve_level = 5

/datum/loot_table/proc/spawn_loot(mob/living/looter = null, delve_level = 1, item_rarity = 1.0)
	var/list/weighted_list = return_list(looter, delve_level, item_rarity)
	var/mob_stat_level = 0

	if(istype(looter))
		mob_stat_level = looter.get_stat_level(STAT_FORTUNE)

	// Apply delve level scaling to spawn counts
	var/delve_multiplier = delve_level >= min_delve_level ? (delve_quantity_scaling ** (delve_level - 1)) : 1

	var/adjusted_min = base_min + round(mob_stat_level * scaling_factor, 1)
	var/adjusted_max = base_max + round(mob_stat_level * scaling_factor, 1)

	// Scale by delve level - higher delves = more loot
	adjusted_min = round(adjusted_min * delve_multiplier, 1)
	adjusted_max = round(adjusted_max * delve_multiplier, 1)

	adjusted_min = min(adjusted_min, adjusted_max)
	var/spawn_count = rand(adjusted_min, adjusted_max)

	var/turf/spawn_location = looter ? get_turf(looter) : null

	var/list/loot = list()
	for(var/i = 1 to spawn_count)
		var/atom/spawn_path = pickweight(weighted_list)
		var/atom/movable/new_spawn = new spawn_path(spawn_location)
		if(spawn_location)
			if(istype(looter))
				looter.put_in_active_hand(new_spawn)
		loot += new_spawn
	return loot

/datum/loot_table/proc/return_list(mob/looter = null, delve_level = 1, item_rarity = 1.0)
	var/list/weighted_list = list()

	if(!istype(looter))
		for(var/thing in loot_table)
			if(islist(thing))
				var/list/temp_list = apply_delve_and_rarity_scaling(thing, delve_level, item_rarity)
				weighted_list |= temp_list
		return weighted_list

	for(var/thing in loot_table)
		if(islist(thing))
			var/list/temp_list = apply_delve_and_rarity_scaling(thing, delve_level, item_rarity)
			weighted_list |= temp_list
		if(thing in MOBSTATS)
			var/list/stat_list = return_stat_weight(thing, looter)
			var/list/scaled_stat_list = apply_delve_and_rarity_scaling(stat_list, delve_level, item_rarity)
			weighted_list |= scaled_stat_list
		if(ispath(thing, /datum/attribute/skill))
			var/list/skill_list = return_skill_weight(thing, looter)
			var/list/scaled_skill_list = apply_delve_and_rarity_scaling(skill_list, delve_level, item_rarity)
			weighted_list |= scaled_skill_list
	return weighted_list

/datum/loot_table/proc/apply_delve_and_rarity_scaling(list/input_list, delve_level = 1, item_rarity = 1.0)
	var/list/scaled_list = list()

	// Clamp delve level to valid range
	delve_level = max(min_delve_level, min(delve_level, max_delve_level))

	// Calculate delve scaling factor for rare items
	var/delve_rare_multiplier = delve_level >= min_delve_level ? (delve_rarity_scaling ** (delve_level - 1)) : 1

	for(var/item in input_list)
		if(isnum(item)) // Skip numeric delimiters
			continue

		var/base_weight = input_list[item]
		var/final_weight = base_weight

		// Apply delve level scaling (higher delves favor rarer items)
		// Items with lower base weights (rarer) get more benefit from higher delves
		if(base_weight > 0)
			// Rare items (low weight) benefit more from delve scaling
			var/rarity_factor = max(0.1, 1.0 / base_weight) // Lower weight = higher rarity factor
			var/delve_bonus = (delve_rare_multiplier - 1) * min(rarity_factor, 10) // Cap the bonus
			final_weight = base_weight * (1 + delve_bonus)

		// Apply item rarity multiplier (multiplicative)
		final_weight = final_weight * item_rarity

		scaled_list[item] = max(0.01, final_weight) // Ensure minimum weight

	return scaled_list

/datum/loot_table/proc/return_stat_weight(stat_key, mob/living/looter)
	var/list/weighted_list = list()
	var/list/pre_weight_list = loot_table[stat_key]

	var/mob_stat_level = looter?.get_stat_level(stat_key)
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
			continue
		var/base_weight = pre_weight_list[item]
		var/scaled_weight = base_weight * (1 + growth_factor ** mob_stat_level)
		if(mob_stat_level == 0)
			scaled_weight = base_weight
		weighted_list |= item
		weighted_list[item] = scaled_weight

	return weighted_list

/datum/loot_table/proc/return_skill_weight(datum/attribute/skill/skill_type, mob/living/looter)
	var/list/weighted_list = list()
	var/list/pre_weight_list = loot_table[skill_type]

	var/mob_skill_level = GET_MOB_SKILL_VALUE_OLD(looter, skill_type)
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
			continue
		var/base_weight = pre_weight_list[item]
		var/scaled_weight = base_weight * (1 + growth_factor ** mob_skill_level)
		if(mob_skill_level == 0)
			scaled_weight = base_weight
		weighted_list |= item
		weighted_list[item] = scaled_weight

	return weighted_list
