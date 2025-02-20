
/// This is used in handle_temperature_damage() for humans, and in reagents that affect body temperature. Temperature damage is multiplied by this amount.
#define TEMPERATURE_DAMAGE_COEFFICIENT		1.5

/// The natural temperature for a body
#define BODYTEMP_NORMAL						310.15
/// This is the divisor which handles how much of the temperature difference between the current body temperature and 310.15K (optimal temperature) humans auto-regenerate each tick. The higher the number, the slower the recovery. This is applied each tick, so long as the mob is alive.
#define BODYTEMP_AUTORECOVERY_DIVISOR		22
/// Minimum amount of kelvin moved toward 310K per tick. So long as abs(310.15 - bodytemp) is more than 50.
#define BODYTEMP_AUTORECOVERY_MINIMUM		12
///Similar to the BODYTEMP_AUTORECOVERY_DIVISOR, but this is the divisor which is applied at the stage that follows autorecovery. This is the divisor which comes into play when the human's loc temperature is lower than their body temperature. Make it lower to lose bodytemp faster.
#define BODYTEMP_COLD_DIVISOR				12
/// Similar to the BODYTEMP_AUTORECOVERY_DIVISOR, but this is the divisor which is applied at the stage that follows autorecovery. This is the divisor which comes into play when the human's loc temperature is higher than their body temperature. Make it lower to gain bodytemp faster.
#define BODYTEMP_HEAT_DIVISOR				30
/// The maximum number of degrees that your body can cool in 1 tick, due to the environment, when in a cold area.
#define BODYTEMP_COOLING_MAX				-100
/// The maximum number of degrees that your body can heat up in 1 tick, due to the environment, when in a hot area.
#define BODYTEMP_HEATING_MAX				30
/// The maximum number of degrees that your body can heat up to. (~800 kelvin is the temperature of lava)
#define BODYTEMP_MAX_TEMPERATURE			800
/// The minimum number of degrees that your body can cool down to. (0 Kelvin is ABSOLUTE 0)
#define BODYTEMP_MIN_TEMPERATURE			0

/// The limit the human body can take before it starts taking damage from heat.
#define BODYTEMP_HEAT_DAMAGE_LIMIT			(BODYTEMP_NORMAL + 50)
/// The limit the human body can take before it starts taking damage from coldness.
#define BODYTEMP_COLD_DAMAGE_LIMIT			(BODYTEMP_NORMAL - 50)
