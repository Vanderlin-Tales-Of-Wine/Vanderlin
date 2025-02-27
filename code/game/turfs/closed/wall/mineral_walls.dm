/turf/closed/wall/mineral
	canSmoothWith = null
	desc = ""
	smooth = SMOOTH_FALSE
	smooth_diag = FALSE
	sheet_type = null
	baseturfs = list(/turf/open/floor/dirt/road)
	wallclimb = TRUE
	explosion_block = 10
	damage_deflection = 0
	icon = 'icons/turf/roguewall.dmi'

	var/smooth_icon = null
	var/last_event = 0
	var/active = null

/turf/closed/wall/mineral/examine()
	. += ..()
	if(max_integrity)
		var/healthpercent = (turf_integrity/max_integrity) * 100
		switch(healthpercent)
			if(50 to 99)
				. += "It looks slightly damaged."
			if(25 to 50)
				. += "It appears heavily damaged."
			if(1 to 25)
				. +=  "<span class='warning'>It's falling apart!</span>"

/turf/closed/wall/mineral/Initialize()
	if(smooth_icon)
		icon = smooth_icon
	. = ..()
