/datum/skill/labor
	abstract_type = /datum/skill/labor
	name = "Labor"
	dreams = list(
		"...all work, no play... all work, no play... all work, no play..."
	)

/datum/skill/labor/mining
	name = "Mining"
	dreams = list(
		"...your masters scream as the man and his guards are slain by the knight... your brothers tremble, screaming and staring as the horror looms over the hero. you grab your pick, and begin to break the chains..."
	)

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
	dreams = list(
		"...you plant your thumb into the dirt, before pulling it back - gently placing a seed into the crevice..."
	)

/datum/skill/labor/taming
	name = "Taming"
	dreams = list(
		"...the water is stillborne, quiet... pristine, as if untouched... the line bobs down, and you let it writhe as you stare down at your reflection..."
	)

/datum/skill/labor/mathematics
	name = "Mathematics"
	dreams = list(
		"...the hydra, a mathematically perfect beast... you lop one head off, two sprout, then four, eight, sixteen, thirty-two, sixty-four... there is a symmetry to this... the trees are like blood, vascular like the erosion of the canyons... the beat of the music marches to your heart..."
	)

/datum/skill/labor/fishing
	name = "Fishing"
	dreams = list(
		"...my only friend, the worm upon my hook. wriggling, writhing, struggling to surmount the mortal pointlessness that permeates this barren world. i am alone. i am empty. and yet, i fish. ..."
	)

/datum/skill/labor/butchering
	name = "Butchering"
	dreams = list(
		"...you dream of chiseling a marble statue, a small rabbit... and when you open your eyes, the skin is seperated from the flesh..."
	)

/datum/skill/labor/lumberjacking
	name = "Lumberjacking"
	dreams = list(
		"...splinters fly off as a tree falls down on the ground, sending a thundering boom throughout the forest..."
	)
