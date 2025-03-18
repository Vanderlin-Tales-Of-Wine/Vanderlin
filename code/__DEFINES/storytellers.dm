
//Could be bitflags, but that would require a good amount of translations, which eh, either way works for me
/// When the event is combat oriented (spawning monsters, inherently hostile antags)
#define TAG_GOD "god"                          // (Base tag)
#define TAG_BOON "boon"                        // Eora
#define TAG_CURSE "curse"                      // (Unused by gods, reserved/defined)
#define TAG_HAUNTED "haunted"                  // Noc, Necra
#define TAG_COMBAT "combat"                    // (Unused by gods, reserved/defined)
#define TAG_RAID "raid"                        // Ravox
#define TAG_TRADE "trade"                      // Abyssor, Matthios
#define TAG_WIDESPREAD "widespread"            // Eora
#define TAG_VILLIAN "villian"                  // (Unused by gods, reserved/defined)
#define TAG_MEDICAL "medical"                  // Pestra
#define TAG_ALCHEMY "alchemy"                  // Pestra
#define TAG_NATURE "nature"                    // Pestra, Dendor
#define TAG_WORK "work"                        // Malum
#define TAG_WATER "water"                      // Abyssor
#define TAG_MAGICAL "magical"                  // Noc, Zizo
#define TAG_BATTLE "battle"                    // Graggar
#define TAG_BLOOD "blood"                      // Graggar
#define TAG_WAR "war"                          // Graggar
#define TAG_GAMBLE "gamble"                    // Zizo
#define TAG_TRICKERY "trickery"                // Zizo
#define TAG_UNEXPECTED "unexpected"            // Zizo
#define TAG_INSANITY "insanity"                // Baotha
#define TAG_MAGIC "magic"                      // Baotha
#define TAG_DISASTER "disaster"                // Baotha
#define TAG_CORRUPTION "corruption"            // Matthios
#define TAG_LOOT "loot"                        // Matthios

#define EVENT_TRACK_MUNDANE "Mundane"
#define EVENT_TRACK_MODERATE "Moderate"
#define EVENT_TRACK_INTERVENTION "God Intervention"
#define EVENT_TRACK_CHARACTER_INJECTION "Character Injection"
#define EVENT_TRACK_OMENS "Omen"
#define EVENT_TRACK_RAIDS "Raids"

#define ALL_EVENTS "All"
#define UNCATEGORIZED_EVENTS "Uncategorized"

#define STORYTELLER_WAIT_TIME 5 SECONDS

#define EVENT_POINT_GAINED_PER_SECOND 0.08

#define TRACK_FAIL_POINT_PENALTY_MULTIPLIER 0.75

#define GAMEMODE_PANEL_MAIN "Main"
#define GAMEMODE_PANEL_VARIABLES "Variables"

#define MUNDANE_POINT_THRESHOLD 40
#define MODERATE_POINT_THRESHOLD 70
#define MAJOR_POINT_THRESHOLD 130
#define ROLESET_POINT_THRESHOLD 150
#define OBJECTIVES_POINT_THRESHOLD 170

#define MUNDANE_MIN_POP 4
#define MODERATE_MIN_POP 6
#define MAJOR_MIN_POP 20
#define CHARACTER_INJECTION_MIN_POP 0
#define OBJECTIVES_MIN_POP 20

/// Defines for how much pop do we need to stop applying a pop scalling penalty to event frequency.
#define MUNDANE_POP_SCALE_THRESHOLD 25
#define MODERATE_POP_SCALE_THRESHOLD 32
#define MAJOR_POP_SCALE_THRESHOLD 45
#define ROLESET_POP_SCALE_THRESHOLD 45
#define OBJECTIVES_POP_SCALE_THRESHOLD 45
#define RAID_POP_SCALE_THRESHOLD 55

/// The maximum penalty coming from pop scalling, when we're at the most minimum point, easing into 0 as we reach the SCALE_THRESHOLD. This is treated as a percentage.
#define MUNDANE_POP_SCALE_PENALTY 35
#define MODERATE_POP_SCALE_PENALTY 35
#define MAJOR_POP_SCALE_PENALTY 35
#define ROLESET_POP_SCALE_PENALTY 35
#define OBJECTIVES_POP_SCALE_PENALTY 35
#define RAID_POP_SCALE_PENALTY 55

#define STORYTELLER_VOTE "storyteller"

#define EVENT_TRACKS list(EVENT_TRACK_MUNDANE, EVENT_TRACK_MODERATE, EVENT_TRACK_INTERVENTION, EVENT_TRACK_CHARACTER_INJECTION, EVENT_TRACK_OMENS, EVENT_TRACK_RAIDS)
#define EVENT_PANEL_TRACKS list(EVENT_TRACK_MUNDANE, EVENT_TRACK_MODERATE, EVENT_TRACK_INTERVENTION, EVENT_TRACK_CHARACTER_INJECTION, EVENT_TRACK_OMENS, EVENT_TRACK_RAIDS, UNCATEGORIZED_EVENTS, ALL_EVENTS)

/// Defines for the antag cap to prevent midround injections.
#define ANTAG_CAP_FLAT 3
#define ANTAG_CAP_DENOMINATOR 30

///Below are defines for roundstart point pool. The GAIN ones are multiplied by ready population
#define ROUNDSTART_MUNDANE_BASE 20
#define ROUNDSTART_MUNDANE_GAIN 0.5

#define ROUNDSTART_MODERATE_BASE 35
#define ROUNDSTART_MODERATE_GAIN 1.2

#define ROUNDSTART_MAJOR_BASE 40
#define ROUNDSTART_MAJOR_GAIN 2

#define ROUNDSTART_ROLESET_BASE 60
#define ROUNDSTART_ROLESET_GAIN 2

#define ROUNDSTART_OBJECTIVES_BASE 40
#define ROUNDSTART_OBJECTIVES_GAIN 2

#define SHARED_HIGH_THREAT	"high threat event"
#define SHARED_ANOMALIES	"anomalous event"
#define SHARED_MINOR_THREAT "minor event"
