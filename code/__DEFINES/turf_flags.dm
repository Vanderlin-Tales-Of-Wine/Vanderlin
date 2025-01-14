#define CHANGETURF_DEFER_CHANGE		1
#define CHANGETURF_IGNORE_AIR		2 // This flag prevents changeturf from gathering air from nearby turfs to fill the new turf with an approximation of local air
#define CHANGETURF_FORCEOP			4
#define CHANGETURF_SKIP				8 // A flag for PlaceOnTop to just instance the new turf instead of calling ChangeTurf. Used for uninitialized turfs NOTHING ELSE
#define CHANGETURF_INHERIT_AIR 16 // Inherit air from previous turf. Implies CHANGETURF_IGNORE_AIR
#define CHANGETURF_RECALC_ADJACENT 32 //Immediately recalc adjacent atmos turfs instead of queuing.

/// Can weather affect turf
#define TURF_WEATHER (1<<3)
/// Proof or not
#define TURF_WEATHER_PROOF (1<<4)
/// Glaaaasss???
#define TURF_TRANSPARENT (1<<5)
/// Effects
#define TURF_EFFECT_AFFECTABLE (1<<6)
