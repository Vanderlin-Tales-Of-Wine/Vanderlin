///Splashing blood makes a tiny bit of this
/datum/pollutant/metallic_scent
	name = "Metallic Scent"
	pollutant_flags = POLLUTANT_SMELL
	smell_intensity = 1
	descriptor = "smell"
	scent = "a metallic scent"

/datum/pollutant/rot
	color = "#76b418"

/datum/pollutant/rot/breathe_act(mob/living/carbon/victim, amount)
	. = ..()
	victim.reagents.add_reagent(/datum/reagent/miasmagas , 1)

/datum/pollutant/steam
	color = "#ffffff"
