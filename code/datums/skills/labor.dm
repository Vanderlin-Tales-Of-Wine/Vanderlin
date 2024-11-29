/datum/skill/labor
	abstract_type = /datum/skill/labor
	name = "Labor"
	desc = ""

/datum/skill/labor/mining
	name = "Mining"

/datum/skill/labor/mining/get_skill_speed_modifier(level)
	switch(level)
		if(SKILL_LEVEL_NONE)
			return 1.3
		if(SKILL_LEVEL_NOVICE)
			return 1.2
		if(SKILL_LEVEL_APPRENTICE)
			return 1.1
		if(SKILL_LEVEL_JOURNEYMAN)
			return 1
		if(SKILL_LEVEL_EXPERT)
			return 0.9
		if(SKILL_LEVEL_MASTER)
			return 0.75
		if(SKILL_LEVEL_LEGENDARY)
			return 0.5

/datum/skill/labor/farming
	name = "Farming"

/datum/skill/labor/taming
	name = "Taming"

/datum/skill/labor/mathematics
	name = "Mathematics"

/datum/skill/labor/fishing
	name = "Fishing"

/datum/skill/labor/butchering
	name = "Butchering"

/datum/skill/labor/lumberjacking
	name = "Lumberjacking"
	dreams = list(
		"...splinters fly off as a tree falls down on the ground, sending a thundering boom throughout the forest..."
	)
