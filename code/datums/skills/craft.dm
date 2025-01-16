/datum/skill/craft
	abstract_type = /datum/skill/craft
	name = "Craft"
	desc = ""

/datum/skill/craft/crafting
	name = "Crafting"
	desc = ""
	dreams = list(
		"...you feel grass under you feet as you peer onto a meadow, you prepare a campfire and a tent and drift off into deeper slumber.."
	)

/datum/skill/craft/weaponsmithing
	name = "Weaponsmithing"
	dreams = list(
		"...you gently grasp the tang of the blade. without water nor oil, you turn over to the basin, slicing your hand, and letting the blood fill the void... you quench the blade."
	)

/datum/skill/craft/armorsmithing
	name = "Armorsmithing"
	dreams = list(
		"...you are assailed by a faceless adversary. he pummels you - crack, crack, crack... it hurts, you scream... he tires, you do not..."
	)

/datum/skill/craft/blacksmithing
	name = "Blacksmithing"
	dreams = list(
		"...CLANG! Clang! Clang... you feel the weight of the hammer reverberate up your arm, past your shoulder, through your spine... the hits march to the drums of your heart. you feel attuned to the metal."
	)

/datum/skill/craft/smelting
	name = "Smelting"
	dreams = list(
		"...the heat brings warmth to you on this dreary night. your feet ache, and your arms remain sore - but the stress of the day melts away, along with the snow around you - becoming just another distant memory."
	)

/datum/skill/craft/carpentry
	name = "Carpentry"
	dreams = list(
		"...in the bitter cold, you stay in your cabin... in the dreary fire, the chair you made burns... the effort wasted, and yet you live..."
	)

/datum/skill/craft/masonry
	name = "Masonry"
	dreams = list(
		"...you chisel and chisel at the marble, the hammer slipping and smacking you square in the thumb... blood gently trickles over the stone, as the statue reflects the scars of its artisan..."
	)

/datum/skill/craft/traps
	name = "Trapping"
	dreams = list(
		"...you hear a quick snap in the distance... you rush over, and notice a small cabbit with a snare wrapped around its leg... you gently unsheath your knife, and loom over the poor, frightened thing..."
	)

/datum/skill/craft/cooking
	name = "Cooking"
	dreams = list(
		"...you sit by the table in your dreary hovel, staring at the wooden bowl of soup given to you by your mother... you blink and look around the tavern, before your vision returns to the bowl... you feel comforted..."
	)

/datum/skill/craft/medicine
	name = "Medicinecraft"
	dreams = list(
		"...you exhume the last meal he ate... keeling over and examining the empty void, you see the inklings of a garden sprouting inside the cadaver..."
	)

/datum/skill/craft/alchemy
	name = "Alchemy"
	dreams = list(
		"...the smell of sulfur singes your nostrils... you taste iron... the smoke clears as you stare down at the reflection in your cauldron... the Queen stares back at you... she looks like she's crying..."
	)

/datum/skill/craft/alchemy/skill_level_effect(level, datum/mind/mind)
	if(level > SKILL_LEVEL_MASTER)
		ADD_TRAIT(mind?.current, TRAIT_LEGENDARY_ALCHEMIST, type)
		//SEND_GLOBAL_SIGNAL(COMSIG_ATOM_ADD_TRAIT, (mind?.current, TRAIT_LEGENDARY_ALCHEMIST)
	else if(HAS_TRAIT(mind?.current, TRAIT_LEGENDARY_ALCHEMIST))
		REMOVE_TRAIT(mind?.current, TRAIT_LEGENDARY_ALCHEMIST, type)
		//SEND_GLOBAL_SIGNAL(COMSIG_ATOM_ADD_TRAIT, (mind?.current, TRAIT_LEGENDARY_ALCHEMIST)

/datum/skill/craft/bombs
	name = "Bombcrafting"
	dreams = list(
		"...you pour the powder down the barrel of the cannon, and without a projectile to follow the dust, you cut off a finger, and toss it in there... you turn to light the fuse..."
	)

/datum/skill/craft/engineering
	name = "Engineering"
	dreams = list(
		"...visions plague your mind. you toss and turn this nite. you see mechanical beasts gutting their masters with bare hands, fire raging acrost unknown streets... you grab a brick off the road and peer below into an infinite void... you inhale, and feel the steam burn your lungs..."
	)

/datum/skill/craft/tanning
	name = "Skincrafting"
	desc = ""

/datum/skill/craft/tailor
	name = "Clothesmaking"
	desc = ""
