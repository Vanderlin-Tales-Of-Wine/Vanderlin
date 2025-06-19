// Areas for the tomb
// Copied from other areas but they all have the "Tomb of Matthios" name
// The only real difference is audio

/area/rogue/under/tomb
	name = "Tomb of Matthios"
	icon_state = "basement"
	first_time_text = "THE TOMB OF MATTHIOS"
	soundenv = 5
	ambient_index = AMBIENCE_BASEMENT
	ambient_spooky_index = AMBIENCE_SPOOKY_DUNGEON
	droning_sound = 'sound/music/area/catacombs.ogg'
	droning_sound_dusk = null
	droning_sound_night = null

/area/rogue/under/tomb/indoors
	icon_state = "indoors"

// Some nice sounds for rest areas
/area/rogue/under/tomb/indoors/rest
	icon_state = "shelter"
	ambient_index = AMBIENCE_TOWN_DAY
	ambient_night_index = AMBIENCE_TOWN_NIGHT
	droning_sound = 'sound/music/area/townstreets.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'sound/music/area/sleeping.ogg'

/area/rogue/under/tomb/indoors/magic
	icon_state = "magician"
	ambient_spooky_index = AMBIENCE_SPOOKY_MYSTICAL
	droning_sound = 'sound/music/area/magiciantower og mix.ogg'

/area/rogue/under/tomb/indoors/royal
	icon_state = "manor"
	droning_sound = 'sound/music/area/manor2.ogg'

/area/rogue/under/tomb/indoors/church
	icon_state = "church"
	droning_sound = 'sound/music/area/churchnight.ogg'

/area/rogue/under/tomb/wilds
	icon_state = "woods"
	soundenv = 15
	ambient_index = AMBIENCE_FOREST_DAY
	ambient_night_index = AMBIENCE_FOREST_NIGHT
	ambient_spooky_index = AMBIENCE_SPOOKY_BIRDS
	ambient_spooky_night_index = AMBIENCE_SPOOKY_FOREST
	droning_sound = 'sound/music/area/forest.ogg'
	droning_sound_dusk = 'sound/music/area/septimus.ogg'
	droning_sound_night = 'sound/music/area/forestnight.ogg'

/area/rogue/under/tomb/wilds/ambush

/area/rogue/under/tomb/wilds/bog
	icon_state = "bog"
	ambient_index = AMBIENCE_BOG_DAY
	ambient_night_index = AMBIENCE_BOG_NIGHT
	ambient_spooky_index = AMBIENCE_SPOOKY_FROG
	ambient_spooky_night_index = AMBIENCE_SPOOKY_GENERIC
	droning_sound = 'sound/music/area/bog.ogg'
	droning_sound_dusk = null
	droning_sound_night = null

/area/rogue/under/tomb/sewer
	icon_state = "sewer"
	ambient_index = AMBIENCE_CAVE_WET
	ambient_spooky_index = AMBIENCE_SPOOKY_RAT
	droning_sound = 'sound/music/area/sewers.ogg'

/area/rogue/under/tomb/lake
	icon_state = "lake"
	ambient_index = AMBIENCE_LAKE
	ambient_spooky_index = AMBIENCE_SPOOKY_CAVE

/area/rogue/under/tomb/cave
	icon_state = "cave"
	soundenv = 8
	ambient_index = AMBIENCE_CAVE_GENERIC
	droning_sound = 'sound/music/area/caves.ogg'

/area/rogue/under/tomb/cave/lava
	icon_state = "cavelava"
	ambient_index = AMBIENCE_CAVE_LAVA
	droning_sound = 'sound/music/area/decap.ogg'

/area/rogue/under/tomb/cave/wet
	icon_state = "cavewet"
	ambient_index = AMBIENCE_CAVE_WET

/area/rogue/under/tomb/cave/spider
	icon_state = "spider"
	droning_sound = 'sound/music/area/spidercave.ogg'
