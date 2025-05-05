/datum/forecast/rosewood
	day_weather = list(/datum/particle_weather/rain_gentle = 2, /datum/particle_weather/snow_gentle = 10)
	dawn_weather = list(/datum/particle_weather/rain_gentle = 2, /datum/particle_weather/snow_gentle = 10, /datum/particle_weather/fog = 4)
	dusk_weather = list(/datum/particle_weather/fog = 8, /datum/particle_weather/snow_gentle = 20, /datum/particle_weather/snow_storm = 8)
	night_weather =  list(/datum/particle_weather/fog = 8, /datum/particle_weather/snow_gentle = 20, /datum/particle_weather/snow_storm = 8)

	temp_ranges = list(
		"dawn" = list(-10, 3),
		"day" = list(3, 12),
		"dusk" = list(-5, -10),
		"night" = list(-10, -20),
	)
