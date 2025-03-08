///Splashing blood makes a tiny bit of this
/datum/pollutant/metallic_scent
	name = "Metallic Scent"
	pollutant_flags = POLLUTANT_SMELL
	smell_intensity = 1
	descriptor = "smell"
	scent = "a metallic scent"

/datum/pollutant/rot
	name = "Rotten Scent"
	pollutant_flags = POLLUTANT_SMELL|POLLUTANT_BREATHE_ACT
	smell_intensity = 1
	descriptor = "smell"
	scent = "a rotten scent"
	color = "#76b418"

/datum/pollutant/rot/breathe_act(mob/living/carbon/victim, amount)
	. = ..()
	victim.reagents.add_reagent(/datum/reagent/miasmagas , 1)

/datum/pollutant/steam
	name = "Steam Scent"
	pollutant_flags = POLLUTANT_SMELL
	smell_intensity = 0.75
	descriptor = "smell"
	scent = "a steamy scent"
	color = "#ffffff"
