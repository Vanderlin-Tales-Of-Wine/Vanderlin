/datum/forecast/vanderlin
	day_weather = list(/datum/particle_weather/rain_gentle = 10)
	dawn_weather = list(/datum/particle_weather/rain_gentle = 10)
	dusk_weather = list(/datum/particle_weather/rain_gentle = 20, /datum/particle_weather/rain_storm = 12, /datum/particle_weather/fog = 4)
	night_weather = list(/datum/particle_weather/rain_gentle = 20, /datum/particle_weather/rain_storm = 12, /datum/particle_weather/fog = 4)

	temp_ranges = list(
		"dawn" = list(2, 12),
		"day" = list(12, 22),
		"dusk" = list(7, 22),
		"night" = list(2, 7),
	)
