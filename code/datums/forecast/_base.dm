/datum/forecast
	var/name = "Base Forecast"

	var/list/dusk_weather = list()
	var/list/day_weather = list()
	var/list/night_weather = list()
	var/list/dawn_weather = list()

	var/dawn_prob  = 25
	var/day_prob  = 5
	var/night_prob  = 40
	var/dusk_prob = 33

/datum/forecast/proc/pick_weather(time_of_day)
	switch(time_of_day)
		if("dusk")
			if(!prob(dusk_prob))
				return
			return pickweight(dusk_weather)
		if("night")
			if(!prob(night_prob))
				return
			return pickweight(night_weather)
		if("dawn")
			if(!prob(dawn_prob))
				return
			return pickweight(dawn_weather)
		if("day")
			if(!prob(day_prob))
				return
			return pickweight(day_weather)
