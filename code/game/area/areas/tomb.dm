// Areas for the tomb
// Copied from other areas but they all have the "Tomb of Matthios" name
// The only real difference is audio

/area/rogue/under/tomb
	name = "Tomb of Matthios"
	icon_state = "basement"
	first_time_text = "THE TOMB OF MATTHIOS"
	custom_area_sound = 'sound/misc/stings/TombSting.ogg'
	soundenv = 5
	droning_index = DRONING_BASEMENT
	ambient_index = AMBIENCE_DUNGEON
	background_track = 'sound/music/area/catacombs.ogg'
	background_track_dusk = null
	background_track_night = null

/area/rogue/under/tomb/indoors
	icon_state = "indoors"

// Some nice sounds for rest areas
/area/rogue/under/tomb/indoors/rest
	icon_state = "shelter"
	droning_index = DRONING_TOWN_DAY
	droning_index_night = DRONING_TOWN_NIGHT
	background_track = 'sound/music/area/townstreets.ogg'
	background_track_dusk = 'sound/music/area/septimus.ogg'
	background_track_night = 'sound/music/area/sleeping.ogg'

/area/rogue/under/tomb/indoors/magic
	icon_state = "magician"
	ambient_index = AMBIENCE_MYSTICAL
	background_track = 'sound/music/area/magiciantower og mix.ogg'

/area/rogue/under/tomb/indoors/royal
	icon_state = "manor"
	background_track = 'sound/music/area/manor2.ogg'

/area/rogue/under/tomb/indoors/church
	icon_state = "church"
	background_track = 'sound/music/area/churchnight.ogg'

/area/rogue/under/tomb/wilds
	icon_state = "woods"
	soundenv = 15
	droning_index = DRONING_FOREST_DAY
	droning_index_night = DRONING_FOREST_NIGHT
	ambient_index = AMBIENCE_BIRDS
	ambient_index_night = AMBIENCE_FOREST
	background_track = 'sound/music/area/forest.ogg'
	background_track_dusk = 'sound/music/area/septimus.ogg'
	background_track_night = 'sound/music/area/forestnight.ogg'

/area/rogue/under/tomb/wilds/ambush

/area/rogue/under/tomb/wilds/bog
	icon_state = "bog"
	droning_index = DRONING_BOG_DAY
	droning_index_night = DRONING_BOG_NIGHT
	ambient_index = AMBIENCE_FROG
	ambient_index_night = AMBIENCE_GENERIC
	background_track = 'sound/music/area/bog.ogg'
	background_track_dusk = null
	background_track_night = null

/area/rogue/under/tomb/sewer
	icon_state = "sewer"
	droning_index = DRONING_CAVE_WET
	ambient_index = AMBIENCE_RAT
	background_track = 'sound/music/area/sewers.ogg'

/area/rogue/under/tomb/lake
	icon_state = "lake"
	droning_index = DRONING_LAKE
	ambient_index = AMBIENCE_CAVE

/area/rogue/under/tomb/cave
	icon_state = "cave"
	soundenv = 8
	droning_index = DRONING_CAVE_GENERIC
	background_track = 'sound/music/area/caves.ogg'

/area/rogue/under/tomb/cave/lava
	icon_state = "cavelava"
	droning_index = DRONING_CAVE_LAVA
	background_track = 'sound/music/area/decap.ogg'

/area/rogue/under/tomb/cave/wet
	icon_state = "cavewet"
	droning_index = DRONING_CAVE_WET

/area/rogue/under/tomb/cave/spider
	icon_state = "spider"
	background_track = 'sound/music/area/spidercave.ogg'
