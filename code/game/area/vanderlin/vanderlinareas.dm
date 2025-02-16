// Malum's Anvil Areas

/area/rogue/under/mountains/anvil
	name = "malum's anvil generic under (don't use)"
	icon_state = "rogue"
	ambientsounds = AMB_MOUNTAIN
	ambientnight = AMB_MOUNTAIN
	spookysounds = SPOOKY_GEN
	spookynight = SPOOKY_GEN
	droning_sound = 'sound/music/area/townstreets.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'sound/music/area/sleeping.ogg'
	converted_type = /area/rogue/outdoors/mountains/anvil/snowy
	soundenv = 8
	plane = INDOOR_PLANE

/area/rogue/under/mountains/anvil/lower
	name = "malum's anvil under lower caves"
	icon_state = "lowercavemalum"
	first_time_text = "MALUM'S ANVIL"
	ambush_types = list(
				/turf/open/floor/rogue/dirt,
				/turf/open/floor/rogue/cobblerock)
	ambush_mobs = list(
				/mob/living/simple_animal/hostile/retaliate/rogue/mole = 40,
				/mob/living/carbon/human/species/goblin/npc/ambush/cave = 30,
				/mob/living/carbon/human/species/rousman/ambush = 30,
				/mob/living/carbon/human/species/orc/ambush = 20,
				/mob/living/simple_animal/hostile/retaliate/rogue/troll = 5)

/area/rogue/under/mountains/anvil/upper
	name = "malum's anvil under upper caves"
	icon_state = "uppercavemalum"
	ambush_types = list(
				/turf/open/floor/rogue/naturalstone)
	ambush_mobs = list(
				/mob/living/simple_animal/hostile/retaliate/rogue/mole = 60,
				/mob/living/carbon/human/species/rousman/ambush = 20,
				/mob/living/carbon/human/species/goblin/npc/ambush/cave = 30,)

/area/rogue/under/mountains/anvil/lower/building
	name = "malum's anvil cave building"
	icon_state = "cavebuildingmalum"
	first_time_text = null
	ambush_types = null
	ambush_mobs = null

/area/rogue/under/mountains/anvil/dungeon
	name = "malum's anvil upper dungeon"
	icon_state = "dungeonupper"

/area/rogue/under/mountains/anvil/dungeon/can_craft_here()
	return FALSE

/area/rogue/under/mountains/anvil/dungeon/lower
	name = "malum's anvil lower dungeon"
	icon_state = "dungeonlower"

/area/rogue/under/mountains/anvil/dungeon/lower/can_craft_here()
	return FALSE

/area/rogue/outdoors/mountains/anvil
	name = "malum's anvil generic outdoors (don't use)"
	icon_state = "rogue"
	outdoors = TRUE
	ambientrain = RAIN_OUT
//	ambientsounds = list('sound/ambience/wamb.ogg')
	ambientsounds = AMB_TOWNDAY
	ambientnight = AMB_TOWNNIGHT
	spookysounds = SPOOKY_CROWS
	spookynight = SPOOKY_GEN
	droning_sound = 'sound/music/area/townstreets.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'sound/music/area/sleeping.ogg'
	converted_type = /area/rogue/indoors/shelter

/area/rogue/outdoors/mountains/anvil/peak
	name = "malum's anvil peak"
	icon_state = "anvilpeakmalum"
	droning_sound = 'sound/music/area/decap.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	first_time_text = "THE PEAK OF MALUM'S ANVIL"

/area/rogue/outdoors/mountains/anvil/snowy
	name = "malum's anvil snow"
	icon_state = "snowypeakmalum"
	droning_sound = 'sound/music/area/decap.ogg'
	droning_sound_dusk = null
	droning_sound_night = null

/area/rogue/outdoors/mountains/anvil/snowyforest
	name = "malum's anvil forest"
	icon_state = "snowyforestmalum"
	droning_sound = 'sound/music/area/decap.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	ambush_types = list(
				/turf/open/floor/rogue/grass/cold,
				/turf/open/floor/rogue/snow/patchy)
	ambush_mobs = list(
				/mob/living/simple_animal/hostile/retaliate/rogue/wolf = 40,
				/mob/living/carbon/human/species/goblin/npc/ambush = 30,
				/mob/living/carbon/human/species/rousman/ambush = 20,
				/mob/living/carbon/human/species/orc/ambush = 20)

/area/rogue/outdoors/mountains/anvil/castle
	name = "malum's anvil castle"
	icon_state = "castlemalum"
	droning_sound = 'sound/music/area/decap.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	ambush_types = list(
				/turf/open/floor/rogue/cobblerock)
	ambush_mobs = list(
				/mob/living/carbon/human/species/goblin/npc/ambush = 30,
				/mob/living/carbon/human/species/rousman/ambush = 20,
				/mob/living/carbon/human/species/orc/ambush = 20)

/area/rogue/outdoors/mountains/anvil/grove
	name = "malum's anvil hidden grove"
	icon_state = "grovemalum"
	ambush_types = list(
				/turf/open/floor/rogue/dirt,
				/turf/open/floor/rogue/grass)
	ambush_mobs = list(
				/mob/living/simple_animal/hostile/retaliate/rogue/wolf = 10)

/area/rogue/outdoors/mountains/anvil/lavaexposed
	name = "malum's anvil exposed lava" // Mostly exists so lava exposed to the sky will act like it is
	icon_state = "exposedlavamalum"

/area/rogue/indoors/mountains/anvil
	name = "malum's anvil generic indoors (don't use)"
	icon_state = "indoors"
	ambientrain = RAIN_IN
	ambientsounds = AMB_INGEN
	ambientnight = AMB_INGEN
	spookysounds = SPOOKY_GEN
	spookynight = SPOOKY_GEN
	droning_sound = 'sound/music/area/indoor.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'sound/music/area/sleeping.ogg'
	plane = INDOOR_PLANE
	converted_type = /area/rogue/outdoors/mountains/anvil/snowy

/area/rogue/indoors/mountains/anvil/surface
	name = null
	icon_state = null


/area/rogue/indoors/mountains/anvil/surface/building
	name = "malum's anvil surface building"
	icon_state = "surfacebuildingmalum"
