//max channel is 1024. Only go lower from here, because byond tends to pick the first availiable channel to play sounds on
#define CHANNEL_LOBBYMUSIC 1024
#define CHANNEL_ADMIN 1023 //USED FOR MUSIC
#define CHANNEL_VOX 1022
#define CHANNEL_JUKEBOX 1021
#define CHANNEL_JUSTICAR_ARK 1020
#define CHANNEL_HEARTBEAT 1019 //sound channel for heartbeats
#define CHANNEL_AMBIENCE 1018
#define CHANNEL_BUZZ 1017
#define CHANNEL_CHARGED_SPELL 1016
#define CHANNEL_RAIN 1015
#define CHANNEL_MUSIC 1014
#define CHANNEL_CMUSIC 1013
#define CHANNEL_WEATHER 1012
#define CHANNEL_IMSICK 1011

/// This is the lowest volume that can be used by playsound otherwise it gets ignored
/// Most sounds around 10 volume can barely be heard. Almost all sounds at 5 volume or below are inaudible
/// This is to prevent sound being spammed at really low volumes due to distance calculations
/// Recommend setting this to anywhere from 10-3 (or 0 to disable any sound minimum volume restrictions)
/// Ex. For a 70 volume sound, 17 tile range, 3 exponent, 2 falloff_distance:
/// Setting SOUND_AUDIBLE_VOLUME_MIN to 0 for the above will result in 17x17 radius (289 turfs)
/// Setting SOUND_AUDIBLE_VOLUME_MIN to 5 for the above will result in 14x14 radius (196 turfs)
/// Setting SOUND_AUDIBLE_VOLUME_MIN to 10 for the above will result in 11x11 radius (121 turfs)
#define SOUND_AUDIBLE_VOLUME_MIN 3

/* Calculates the max distance of a sound based on audible volume
 *
 * Note - you should NEVER pass in a volume that is lower than SOUND_AUDIBLE_VOLUME_MIN otherwise distance will be insanely large (like +250,000)
 *
 * Arguments:
 * * volume: The initial volume of the sound being played
 * * max_distance: The range of the sound in tiles (technically not real max distance since the furthest areas gets pruned due to SOUND_AUDIBLE_VOLUME_MIN)
 * * falloff_distance: Distance at which falloff begins. Sound is at peak volume (in regards to falloff) aslong as it is in this range.
 * * falloff_exponent: Rate of falloff for the audio. Higher means quicker drop to low volume. Should generally be over 1 to indicate a quick dive to 0 rather than a slow dive.
 * Returns: The max distance of a sound based on audible volume range
 */
#define CALCULATE_MAX_SOUND_AUDIBLE_DISTANCE(volume, max_distance, falloff_distance, falloff_exponent)\
	floor(((((-(max(max_distance - falloff_distance, 0) ** (1 / falloff_exponent)) / volume) * (SOUND_AUDIBLE_VOLUME_MIN - volume)) ** falloff_exponent) + falloff_distance))

/* Calculates the volume of a sound based on distance
 *
 * https://www.desmos.com/calculator/sqdfl8ipgf
 *
 * Arguments:
 * * volume: The initial volume of the sound being played
 * * distance: How far away the sound is in tiles from the source
 * * falloff_distance: Distance at which falloff begins. Sound is at peak volume (in regards to falloff) aslong as it is in this range.
 * * falloff_exponent: Rate of falloff for the audio. Higher means quicker drop to low volume. Should generally be over 1 to indicate a quick dive to 0 rather than a slow dive.
 * Returns: The max distance of a sound based on audible volume range
 */
#define CALCULATE_SOUND_VOLUME(volume, distance, max_distance, falloff_distance, falloff_exponent)\
	((max(distance - falloff_distance, 0) ** (1 / falloff_exponent)) / ((max(max_distance, distance) - falloff_distance) ** (1 / falloff_exponent)) * volume)

///Default range of a sound.
#define SOUND_RANGE 17
#define MEDIUM_RANGE_SOUND_EXTRARANGE -5
///default extra range for sounds considered to be quieter
#define SHORT_RANGE_SOUND_EXTRARANGE -9
///The range deducted from sound range for things that are considered silent / sneaky
#define SILENCED_SOUND_EXTRARANGE -11
///Percentage of sound's range where no falloff is applied
#define SOUND_DEFAULT_FALLOFF_DISTANCE 1 //For a normal sound this would be 1 tile of no falloff
///The default exponent of sound falloff
#define SOUND_FALLOFF_EXPONENT 6

//THIS SHOULD ALWAYS BE THE LOWEST ONE!
//KEEP IT UPDATED

#define CHANNEL_HIGHEST_AVAILABLE 1011


#define SOUND_MINIMUM_PRESSURE 10


//Ambience types

#define GENERIC list('sound/blank.ogg',\
								'sound/blank.ogg',\
								'sound/blank.ogg',\
								'sound/blank.ogg',\
								'sound/blank.ogg',\
								'sound/blank.ogg')

#define HOLY list('sound/blank.ogg',\
										'sound/blank.ogg',\
										'sound/blank.ogg')

#define HIGHSEC list('sound/blank.ogg')

#define RUINS list('sound/blank.ogg',\
									'sound/blank.ogg',\
									'sound/blank.ogg',\
									'sound/blank.ogg',\
									'sound/blank.ogg')

#define ENGINEERING list('sound/blank.ogg',\
										'sound/blank.ogg')

#define MINING list('sound/blank.ogg',\
											'sound/blank.ogg',\
											'sound/blank.ogg',\
											'sound/blank.ogg')

#define MEDICAL list('sound/blank.ogg')

#define SPOOKY list('sound/blank.ogg',\
										'sound/blank.ogg')

#define SPACE list('sound/blank.ogg')

#define MAINTENANCE list('sound/blank.ogg',\
											'sound/blank.ogg' )

#define AWAY_MISSION list('sound/blank.ogg',\
									'sound/blank.ogg',\
									'sound/blank.ogg',\
									'sound/blank.ogg',\
									'sound/blank.ogg')

#define REEBE list('sound/blank.ogg')



#define CREEPY_SOUNDS list('sound/blank.ogg',\
	'sound/blank.ogg',\
	'sound/blank.ogg',\
	'sound/blank.ogg',\
	'sound/blank.ogg')


#define RAIN_IN list('sound/ambience/rainin.ogg')

#define RAIN_SEWER list('sound/ambience/rainsewer.ogg')

#define RAIN_OUT list('sound/ambience/rainout.ogg')

#define AMB_GENCAVE list('sound/ambience/cave.ogg')

#define AMB_TOWNDAY list('sound/ambience/townday.ogg')

#define AMB_MOUNTAIN list('sound/ambience/MOUNTAIN (1).ogg',\
						'sound/ambience/MOUNTAIN (2).ogg')

#define AMB_TOWNNIGHT list('sound/ambience/townnight (1).ogg',\
						'sound/ambience/townnight (2).ogg',\
						'sound/ambience/townnight (3).ogg')

#define AMB_BOGDAY list('sound/ambience/bogday (1).ogg',\
						'sound/ambience/bogday (2).ogg',\
						'sound/ambience/bogday (3).ogg')

#define AMB_BOGNIGHT list('sound/ambience/bognight.ogg')

#define AMB_FORESTDAY list('sound/ambience/forestday.ogg')

#define AMB_FORESTNIGHT list('sound/ambience/forestnight.ogg')

#define AMB_INGEN list('sound/ambience/indoorgen.ogg')


#define AMB_BASEMENT list('sound/ambience/basement.ogg')

#define AMB_JUNGLENIGHT list('sound/ambience/jungleday.ogg')

#define AMB_JUNGLEDAY list('sound/ambience/jungleday.ogg')

#define AMB_BEACH list('sound/ambience/lake (1).ogg',\
						'sound/ambience/lake (2).ogg',\
						'sound/ambience/lake (3).ogg')

#define AMB_BOAT list('sound/ambience/boat (1).ogg',\
						'sound/ambience/boat (2).ogg')

#define AMB_RIVERDAY list('sound/ambience/riverday (1).ogg',\
						'sound/ambience/riverday (2).ogg',\
						'sound/ambience/riverday (3).ogg')

#define AMB_RIVERNIGHT list('sound/ambience/rivernight (1).ogg',\
						'sound/ambience/rivernight (2).ogg',\
						'sound/ambience/rivernight (3).ogg')

#define AMB_CAVEWATER list('sound/ambience/cavewater (1).ogg',\
						'sound/ambience/cavewater (2).ogg',\
						'sound/ambience/cavewater (3).ogg')

#define AMB_CAVELAVA list('sound/ambience/cavelava (1).ogg',\
						'sound/ambience/cavelava (2).ogg',\
						'sound/ambience/cavelava (3).ogg')

//******* SPOOKED YA

#define SPOOKY_CAVE list('sound/ambience/noises/cave (1).ogg',\
						'sound/ambience/noises/cave (2).ogg',\
						'sound/ambience/noises/cave (3).ogg')

#define SPOOKY_FOREST list('sound/ambience/noises/owl.ogg',\
						'sound/ambience/noises/wolf (1).ogg',\
						'sound/ambience/noises/wolf (2).ogg',\
						'sound/ambience/noises/wolf (3).ogg')

#define SPOOKY_GEN list('sound/ambience/noises/genspooky (1).ogg',\
						'sound/ambience/noises/genspooky (4).ogg',\
						'sound/ambience/noises/genspooky (2).ogg',\
						'sound/ambience/noises/genspooky (3).ogg',\
						'sound/ambience/noises/genspooky (5).ogg')

#define SPOOKY_DUNGEON list('sound/ambience/noises/dungeon (1).ogg',\
						'sound/ambience/noises/dungeon (4).ogg',\
						'sound/ambience/noises/dungeon (2).ogg',\
						'sound/ambience/noises/dungeon (3).ogg',\
						'sound/ambience/noises/dungeon (5).ogg')

#define SPOOKY_RATS list('sound/ambience/noises/RAT1.ogg',\
						'sound/ambience/noises/RAT2.ogg')

#define SPOOKY_FROG list('sound/ambience/noises/frog (1).ogg',\
						'sound/ambience/noises/frog (2).ogg')

#define SPOOKY_MYSTICAL list('sound/ambience/noises/mystical (1).ogg',\
						'sound/ambience/noises/mystical (2).ogg',\
						'sound/ambience/noises/mystical (3).ogg',\
						'sound/ambience/noises/mystical (4).ogg',\
						'sound/ambience/noises/mystical (5).ogg',\
						'sound/ambience/noises/mystical (6).ogg')

#define SPOOKY_CROWS list('sound/ambience/noises/birds (1).ogg',\
						'sound/ambience/noises/birds (2).ogg',\
						'sound/ambience/noises/birds (3).ogg',\
						'sound/ambience/noises/birds (4).ogg',\
						'sound/ambience/noises/birds (5).ogg',\
						'sound/ambience/noises/birds (6).ogg',\
						'sound/ambience/noises/birds (7).ogg')

#define SFX_SPARKS "sparks"
#define SFX_CHAIN_STEP	"chain_step"
#define SFX_PLATE_STEP	"plate_step"
#define SFX_PLATE_COAT_STEP	"plate_coat_step"
#define SFX_JINGLE_BELLS	"jingle_bells"
#define SFX_INQUIS_BOOT_STEP	"inquis_boot_step"
#define SFX_POWER_ARMOR_STEP	"power_armor_step"

#define INTERACTION_SOUND_RANGE_MODIFIER 0
#define EQUIP_SOUND_VOLUME 100
#define PICKUP_SOUND_VOLUME 100
#define DROP_SOUND_VOLUME 100
#define YEET_SOUND_VOLUME 100



GLOBAL_LIST_INIT(ambience_files, list(
	'sound/music/area/bath.ogg',
	'sound/music/area/bog.ogg',
	'sound/music/area/catacombs.ogg',
	'sound/music/area/caves.ogg',
	'sound/music/area/church.ogg',
	'sound/music/area/churchnight.ogg',
	'sound/music/area/decap.ogg',
	'sound/music/area/deliverer.ogg',
	'sound/music/area/dungeon.ogg',
	'sound/music/area/dwarf.ogg',
	'sound/music/area/field.ogg',
	'sound/music/area/forest.ogg',
	'sound/music/area/forestnight.ogg',
	'sound/music/area/indoor.ogg',
	'sound/music/area/magiciantower.ogg',
	'sound/music/area/manor.ogg',
	'sound/music/area/manor2.ogg',
	'sound/music/area/manorgarri.ogg',
	'sound/music/area/manorgarr_alt.ogg',
	'sound/music/area/night.ogg',
	'sound/music/area/sargoth.ogg',
	'sound/music/area/septimus.ogg',
	'sound/music/area/sewers.ogg',
	'sound/music/area/shop.ogg',
	'sound/music/area/sleeping.ogg',
	'sound/music/area/spidercave.ogg',
	'sound/music/area/towngen.ogg',
	'sound/music/area/townstreets.ogg',
	'sound/music/area/underworlddrone.ogg',
	))
