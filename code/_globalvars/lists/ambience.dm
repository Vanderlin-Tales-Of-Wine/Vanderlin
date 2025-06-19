//======== Regular

GLOBAL_LIST_INIT(ambience_town_day, list('sound/ambience/townday.ogg'))
GLOBAL_LIST_INIT(ambience_town_night, list(
	'sound/ambience/townnight (1).ogg',
	'sound/ambience/townnight (2).ogg',
	'sound/ambience/townnight (3).ogg'))

GLOBAL_LIST_INIT(ambience_forest_day, list('sound/ambience/forestday.ogg'))
GLOBAL_LIST_INIT(ambience_forest_night, list('sound/ambience/forestnight.ogg'))

GLOBAL_LIST_INIT(ambience_bog_day, list(
	'sound/ambience/bogday (1).ogg',
	'sound/ambience/bogday (2).ogg',
	'sound/ambience/bogday (3).ogg'))
GLOBAL_LIST_INIT(ambience_bog_night, list('sound/ambience/bognight.ogg'))

GLOBAL_LIST_INIT(ambience_jungle_day, list('sound/ambience/jungleday.ogg'))
GLOBAL_LIST_INIT(ambience_jungle_night, list('sound/ambience/junglenight.ogg'))

GLOBAL_LIST_INIT(ambience_river_day, list(
	'sound/ambience/riverday (1).ogg',
	'sound/ambience/riverday (2).ogg',
	'sound/ambience/riverday (3).ogg'))
GLOBAL_LIST_INIT(ambience_river_night, list(
	'sound/ambience/rivernight (1).ogg',
	'sound/ambience/rivernight (2).ogg',
	'sound/ambience/rivernight (3).ogg'))

GLOBAL_LIST_INIT(ambience_indoors, list('sound/ambience/indoorgen.ogg'))
GLOBAL_LIST_INIT(ambience_basement, list('sound/ambience/basement.ogg'))

GLOBAL_LIST_INIT(ambience_mountain, list(
	'sound/ambience/MOUNTAIN (1).ogg',
	'sound/ambience/MOUNTAIN (2).ogg'))

GLOBAL_LIST_INIT(ambience_lake, list(
	'sound/ambience/lake (1).ogg',
	'sound/ambience/lake (2).ogg',
	'sound/ambience/lake (3).ogg'))

GLOBAL_LIST_INIT(ambience_boat, list(
	'sound/ambience/boat (1).ogg',
	'sound/ambience/boat (2).ogg'))

GLOBAL_LIST_INIT(ambience_rain_indoors, list('sound/ambience/rainin.ogg'))
GLOBAL_LIST_INIT(ambience_rain_outdoors, list('sound/ambience/rainout.ogg'))
GLOBAL_LIST_INIT(ambience_rain_sewer, list('sound/ambience/rainsewer.ogg'))

//======== Cave

GLOBAL_LIST_INIT(ambience_cave_generic, list('sound/ambience/cave.ogg'))
GLOBAL_LIST_INIT(ambience_cave_wet, list(
	'sound/ambience/cavewater (1).ogg',
	'sound/ambience/cavewater (2).ogg',
	'sound/ambience/cavewater (3).ogg'))
GLOBAL_LIST_INIT(ambience_cave_lava, list(
	'sound/ambience/cavelava (1).ogg',
	'sound/ambience/cavelava (2).ogg',
	'sound/ambience/cavelava (3).ogg'))

//======== Spooky

GLOBAL_LIST_INIT(ambience_spooky_generic, list(
	'sound/ambience/noises/genspooky (1).ogg',
	'sound/ambience/noises/genspooky (2).ogg',
	'sound/ambience/noises/genspooky (3).ogg',
	'sound/ambience/noises/genspooky (4).ogg',
	'sound/ambience/noises/genspooky (5).ogg'))

// Places

GLOBAL_LIST_INIT(ambience_spooky_cave, list(
	'sound/ambience/noises/cave (1).ogg',
	'sound/ambience/noises/cave (2).ogg',
	'sound/ambience/noises/cave (3).ogg'))

GLOBAL_LIST_INIT(ambience_spooky_forest, list(
	'sound/ambience/noises/owl.ogg',
	'sound/ambience/noises/wolf (1).ogg',
	'sound/ambience/noises/wolf (2).ogg',
	'sound/ambience/noises/wolf (3).ogg',))

GLOBAL_LIST_INIT(ambience_spooky_dungeon, list(
	'sound/ambience/noises/dungeon (1).ogg',
	'sound/ambience/noises/dungeon (2).ogg',
	'sound/ambience/noises/dungeon (3).ogg',
	'sound/ambience/noises/dungeon (4).ogg',
	'sound/ambience/noises/dungeon (5).ogg'))

// Animals

GLOBAL_LIST_INIT(ambience_spooky_rat, list(
	'sound/ambience/noises/RAT1.ogg',
	'sound/ambience/noises/RAT2.ogg'))

GLOBAL_LIST_INIT(ambience_spooky_frog, list(
	'sound/ambience/noises/frog (1).ogg',
	'sound/ambience/noises/frog (2).ogg'))

GLOBAL_LIST_INIT(ambience_spooky_birds, list(
	'sound/ambience/noises/birds (1).ogg',
	'sound/ambience/noises/birds (1).ogg',
	'sound/ambience/noises/birds (3).ogg',
	'sound/ambience/noises/birds (4).ogg',
	'sound/ambience/noises/birds (5).ogg',
	'sound/ambience/noises/birds (6).ogg',
	'sound/ambience/noises/birds (7).ogg'))

// Misc

GLOBAL_LIST_INIT(ambience_spooky_mystical, list(
	'sound/ambience/noises/mystical (1).ogg',
	'sound/ambience/noises/mystical (1).ogg',
	'sound/ambience/noises/mystical (3).ogg',
	'sound/ambience/noises/mystical (4).ogg',
	'sound/ambience/noises/mystical (5).ogg',
	'sound/ambience/noises/mystical (6).ogg'))

GLOBAL_LIST_INIT(ambience_assoc_tod, list(
	AMBIENCE_TOWN_DAY = GLOB.ambience_town_day,
	AMBIENCE_TOWN_NIGHT = GLOB.ambience_town_night,
	AMBIENCE_FOREST_DAY = GLOB.ambience_forest_day,
	AMBIENCE_FOREST_NIGHT = GLOB.ambience_forest_night,
	AMBIENCE_BOG_DAY = GLOB.ambience_bog_day,
	AMBIENCE_BOG_NIGHT = GLOB.ambience_bog_night,
	AMBIENCE_JUNGLE_DAY = GLOB.ambience_jungle_day,
	AMBIENCE_JUNGLE_NIGHT = GLOB.ambience_jungle_night,
	AMBIENCE_RIVER_DAY = GLOB.ambience_river_day,
	AMBIENCE_RIVER_NIGHT = GLOB.ambience_river_night,
))

GLOBAL_LIST_INIT(ambience_assoc_places, list(
	AMBIENCE_INDOORS = GLOB.ambience_indoors,
	AMBIENCE_BASEMENT = GLOB.ambience_basement,
	AMBIENCE_MOUNTAIN = GLOB.ambience_mountain,
	AMBIENCE_LAKE = GLOB.ambience_lake,
	AMBIENCE_BOAT = GLOB.ambience_boat))

GLOBAL_LIST_INIT(ambience_assoc_spooky, list(
	AMBIENCE_SPOOKY_GENERIC = GLOB.ambience_spooky_generic,
	AMBIENCE_SPOOKY_CAVE = GLOB.ambience_spooky_cave,
	AMBIENCE_SPOOKY_FOREST = GLOB.ambience_spooky_forest,
	AMBIENCE_SPOOKY_DUNGEON = GLOB.ambience_spooky_dungeon,
	AMBIENCE_SPOOKY_RAT = GLOB.ambience_spooky_rat,
	AMBIENCE_SPOOKY_FROG = GLOB.ambience_spooky_frog,
	AMBIENCE_SPOOKY_BIRDS = GLOB.ambience_spooky_birds,
	AMBIENCE_SPOOKY_MYSTICAL = GLOB.ambience_spooky_mystical))

GLOBAL_LIST_INIT(ambience_assoc_cave, list(
	AMBIENCE_CAVE_GENERIC = GLOB.ambience_cave_generic,
	AMBIENCE_CAVE_WET = GLOB.ambience_cave_wet,
	AMBIENCE_CAVE_LAVA = GLOB.ambience_cave_lava))

GLOBAL_LIST_INIT(ambience_assoc_rain, list(
	AMBIENCE_RAIN_IN = GLOB.ambience_rain_indoors,
	AMBIENCE_RAIN_OUT = GLOB.ambience_rain_outdoors,
	AMBIENCE_RAIN_SEWER = GLOB.ambience_rain_sewer))

GLOBAL_LIST_INIT(ambience_assoc, build_all_ambience())

/proc/build_all_ambience()
	var/static/list/ambience_assoc = list(
		GLOB.ambience_assoc_tod,
		GLOB.ambience_assoc_places,
		GLOB.ambience_assoc_spooky,
		GLOB.ambience_assoc_cave,
		GLOB.ambience_assoc_rain,
	)
	var/list/all_ambience_assoc = list()
	for(var/list/ambience as anything in ambience_assoc)
		LAZYADDASSOCLIST(all_ambience_assoc, ambience, ambience[ambience])
	return all_ambience_assoc
