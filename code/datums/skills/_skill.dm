/datum/skill
	abstract_type = /datum/skill
	var/name = "Skill"
	var/desc = ""
	var/list/int_reqs = list(5,7,9,12,14,17)

	var/dream_cost_base = 2
	var/dream_cost_per_level = 0.5
	var/dream_legendary_extra_cost = 1
	var/list/specific_dream_costs
	var/list/dreams
	var/randomable_dream_xp = TRUE

/datum/skill/proc/get_skill_speed_modifier(level)
	return

/datum/skill/proc/skill_level_effect(level, datum/mind/mind)
	return

/datum/skill/proc/get_dream_cost_for_level(level)
	if(length(specific_dream_costs) >= level)
		return specific_dream_costs[level]
	var/cost = FLOOR(dream_cost_base + (dream_cost_per_level * (level - 1)), 1)
	if(level == SKILL_LEVEL_LEGENDARY)
		cost += dream_legendary_extra_cost
	return cost

/datum/skill/proc/get_random_dream()
	if(!dreams)
		return null
	return pick(dreams)

/datum/skill/Topic(href, href_list) //This calls for the skill's description, when they click the ? in mind/print_levels
	. = ..()
	switch(href_list["action"])
		if("examine")
			to_chat(usr, span_info(desc))
			return
