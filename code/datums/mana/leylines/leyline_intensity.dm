GLOBAL_LIST_INIT(leyline_intensities, list(
	/datum/leyline_variable/leyline_intensity/none = 200,
	/datum/leyline_variable/leyline_intensity/minimal = 8000,
	/datum/leyline_variable/leyline_intensity/extremely_low = 11000,
	/datum/leyline_variable/leyline_intensity/low = 5000,
	/datum/leyline_variable/leyline_intensity/below_average = 1000,
	/datum/leyline_variable/leyline_intensity/average = 500,
	/datum/leyline_variable/leyline_intensity/above_average = 100,
	/datum/leyline_variable/leyline_intensity/high = 2,
	/datum/leyline_variable/leyline_intensity/extreme = 1
))

// ^ Only pass integers in since its used for pickweight

/// "Intensities" that will be applied to leylines. Should influence the average capacity/recharge rate/whatever of the leyline.
/datum/leyline_variable/leyline_intensity
	var/overall_mult
	var/thickness

/datum/leyline_variable/leyline_intensity/none
	overall_mult = 0
	name = "None"
	thickness = 0

/datum/leyline_variable/leyline_intensity/minimal
	overall_mult = 0.1
	name = "Minimal"
	thickness = 0

/datum/leyline_variable/leyline_intensity/extremely_low
	overall_mult = 0.2
	name = "Extremely Low"
	thickness = 1

/datum/leyline_variable/leyline_intensity/low
	overall_mult = 1
	name = "Low"
	thickness = 1

/datum/leyline_variable/leyline_intensity/below_average
	overall_mult = 1.4
	name = "Below average"
	thickness = 1

/datum/leyline_variable/leyline_intensity/average
	overall_mult = 2
	name = "Average"
	thickness = 2

/datum/leyline_variable/leyline_intensity/above_average
	overall_mult = 2.6
	name = "Above average"
	thickness = 2

/datum/leyline_variable/leyline_intensity/high
	overall_mult = 4
	name = "High"
	thickness = 2

/datum/leyline_variable/leyline_intensity/extreme
	overall_mult = 10
	name = "Extreme"
	thickness = 3
