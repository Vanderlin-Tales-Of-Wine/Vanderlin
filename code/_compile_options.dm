//#define TESTING				//By using the testing("message") proc you can create debug-feedback for people with this
								//uncommented, but not visible in the release version)

//#define DATUMVAR_DEBUGGING_MODE	//Enables the ability to cache datum vars and retrieve later for debugging which vars changed.

#define MATURESERVER
//#define TESTSERVER
#define ALLOWPLAY

#define RESPAWNTIME 0
//0 test
//12 minutes norma
//#define ROUNDTIMERBOAT (300 MINUTES)
#define INITIAL_ROUND_TIMER (99 MINUTES)
#define ROUND_EXTENSION_TIME (30 MINUTES)
#define ROUND_END_TIME (15 MINUTES)
#define ROUND_END_TIME_VERBAL "15 minutes"
//180 norma
//60 test

#define MODE_RESTART
//comment out if you want to restart the server instead of shutting down

#define DEBUG 1
// Comment this out if you are debugging problems that might be obscured by custom error handling in world/Error
#ifdef DEBUG
#define USE_CUSTOM_ERROR_HANDLER
#endif

#ifdef TESTING
#define DATUMVAR_DEBUGGING_MODE

//#define GC_FAILURE_HARD_LOOKUP	//makes paths that fail to GC call find_references before del'ing.
									//implies FIND_REF_NO_CHECK_TICK

//#define FIND_REF_NO_CHECK_TICK	//Sets world.loop_checks to false and prevents find references from sleeping


//#define VISUALIZE_ACTIVE_TURFS	//Highlights atmos active turfs in green
#endif

// #define UNIT_TESTS			//Enables unit tests

// If this is uncommented, will attempt to load and initialize prof.dll/libprof.so by default.
// Even if it's not defined, you can pass "tracy" via -params in order to try to load it.
// We do not ship byond-tracy. Build it yourself here: https://github.com/mafemergency/byond-tracy/
// #define USE_BYOND_TRACY

#if defined(CIBUILDING) && !defined(OPENDREAM)
#define UNIT_TESTS
#endif

#ifdef UNIT_TESTS
#define DEPLOY_TEST
#endif

#ifndef PRELOAD_RSC					//set to:
#define PRELOAD_RSC		0			//	0 to allow using external resources or on-demand behaviour;
#endif								//	1 to use the default behaviour;
									//	2 for preloading absolutely everything;

//#define LOWMEMORYMODE //uncomment this to load centcom and roguetest and thats it.

#ifdef LOWMEMORYMODE
#define FORCE_MAP "_maps/roguetest.json"
#endif

//Update this whenever you need to take advantage of more recent byond features
#define MIN_COMPILER_VERSION 515
#if DM_VERSION < MIN_COMPILER_VERSION
//Don't forget to update this part
#error Your version of BYOND is too out-of-date to compile this project. Go to https://secure.byond.com/download and update.
#error You need version 515 or higher
#endif

//Update this whenever you need to take advantage of more recent byond features
#define MIN_COMPILER_MINOR_VERSION 1643
#ifndef SPACEMAN_DMM
#if DM_BUILD < MIN_COMPILER_MINOR_VERSION
//Don't forget to update this part
#error Your version of BYOND is too out-of-date to compile this project. Go to https://secure.byond.com/download and update.
#error You need version 515.1643 or higher
#endif
#endif

//Additional code for the above flags.
#ifdef TESTING
#warn compiling in TESTING mode. testing() debug messages will be visible.
#endif

#ifdef CITESTING // avoids the above warning
#define TESTING
#endif

#ifdef GC_FAILURE_HARD_LOOKUP
#define FIND_REF_NO_CHECK_TICK
#endif

#ifdef TRAVISBUILDING
#define UNIT_TESTS
#endif

#ifdef TRAVISTESTING
#define TESTING
#endif
