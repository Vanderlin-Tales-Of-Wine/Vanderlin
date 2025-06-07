
//Rain - goes down
/particles/weather/rain
	icon_state             = "drop"
	color                  = "#ccffff"
	position               = generator("box", list(-500,-256,0), list(400,500,0))
	grow			       = list(-0.01,-0.01)
	gravity                = list(0, -10, 0.5)
	drift                  = generator("circle", 0, 1) // Some random movement for variation
	friction               = 0.3  // shed 30% of velocity and drift every 0.1s
	transform 			   = null // Rain is directional - so don't make it "3D"
	//Weather effects, max values
	maxSpawning            = 250
	minSpawning            = 50
	wind                   = 2
	spin                   = 0 // explicitly set spin to 0 - there is a bug that seems to carry generators over from old particle effects

/datum/particle_weather/rain_gentle
	name = "Rain"
	desc = "Gentle Rain, la la description."
	particleEffectType = /particles/weather/rain

	scale_vol_with_severity = TRUE
	weather_sounds = list(/datum/looping_sound/rain)
	indoor_weather_sounds = list(/datum/looping_sound/indoor_rain)
	weather_messages = list("The rain cools your skin.")

	minSeverity = 1
	maxSeverity = 15
	maxSeverityChange = 2
	severitySteps = 5
	immunity_type = TRAIT_RAINSTORM_IMMUNE
	probability = 1
	target_trait = PARTICLEWEATHER_RAIN
	forecast_tag = "rain"

//Makes you a little chilly
/datum/particle_weather/rain_gentle/weather_act(mob/living/L)
	L.adjust_bodytemperature(-rand(1,3))

/datum/particle_weather/rain_storm
	name = "Rain"
	desc = "Gentle Rain, la la description."
	particleEffectType = /particles/weather/rain

	scale_vol_with_severity = TRUE
	weather_sounds = list(/datum/looping_sound/storm)
	indoor_weather_sounds = list(/datum/looping_sound/indoor_rain)
	weather_messages = list("The rain cools your skin.", "The storm is really picking up!")

	minSeverity = 4
	maxSeverity = 100
	maxSeverityChange = 50
	severitySteps = 50
	immunity_type = TRAIT_RAINSTORM_IMMUNE
	probability = 1
	target_trait = PARTICLEWEATHER_RAIN
	forecast_tag = "rain"

	COOLDOWN_DECLARE(thunder)

/datum/particle_weather/rain_storm/tick()
	if(!COOLDOWN_FINISHED(src, thunder))
		return


	var/lightning_strikes = 1
	for(var/i = 1 to lightning_strikes)
		var/atom/lightning_destination
		if(prob(100))
			var/list/viable_players = list()
			for(var/client/client in GLOB.clients)
				var/client_z = client.mob.z
				if(!isliving(client.mob))
					continue
				if(!("[client_z]" in GLOB.weatherproof_z_levels))
					if(SSmapping.level_has_any_trait(client_z, list(ZTRAIT_IGNORE_WEATHER_TRAIT)))
						GLOB.weatherproof_z_levels |= "[client_z]"
				if("[client_z]" in GLOB.weatherproof_z_levels)
					continue
				viable_players += client.mob

			lightning_destination = pick(viable_players)

		if(lightning_destination)
			var/list/turfs = list()
			for(var/turf/open/turf in range(lightning_destination, 7))
				if(!turf.outdoor_effect || turf.outdoor_effect.weatherproof)
					continue
				turfs |= turf
			if(!length(turfs))
				return
			lightning_destination = pick(turfs)

		else
			lightning_destination = pick(SSParticleWeather.weathered_turfs)

		new /obj/effect/temp_visual/lightning/storm(get_turf(lightning_destination))
		COOLDOWN_START(src, thunder, rand(5, 40) * 1 SECONDS)

//Makes you a bit chilly
/datum/particle_weather/rain_storm/weather_act(mob/living/L)
	L.adjust_bodytemperature(-rand(3,5))

/obj/effect/temp_visual/lightning/storm
	icon = 'icons/effects/32x200.dmi'

	light_system = MOVABLE_LIGHT
	light_color = COLOR_PALE_BLUE_GRAY
	light_outer_range = 15
	light_power = 25
	duration = 12

/obj/effect/temp_visual/lightning/storm/Initialize(mapload, list/flame_hit)
	. = ..()
	playsound(get_turf(src),'sound/weather/rain/thunder_1.ogg', 80, TRUE)
