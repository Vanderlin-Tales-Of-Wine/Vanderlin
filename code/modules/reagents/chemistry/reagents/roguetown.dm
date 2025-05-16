/datum/reagent/miasmagas
	name = "Miasma"
	description = "."
	reagent_state = GAS
	color = "#801E28" // rgb: 128, 30, 40
	taste_description = "ugly"
	metabolization_rate = 1

/datum/reagent/miasmagas/on_mob_life(mob/living/carbon/M)
	if(!HAS_TRAIT(M, TRAIT_NOSTINK))
		if(M.has_flaw(/datum/charflaw/addiction/maniac))
			M.add_stress(/datum/stressevent/miasmagasmaniac)
		else
			M.add_nausea(3)
			M.add_stress(/datum/stressevent/miasmagas)
	return ..()

/datum/reagent/rogueacid
	name = "Acid"
	description = "."
	reagent_state = LIQUID
	color = "#5eff00"
	taste_description = "burning"
	self_consuming = TRUE

/datum/reagent/rogueacid/reaction_mob(mob/living/M, method=TOUCH, reac_volume)
	M.adjustFireLoss(35, 0)
	..()

/datum/reagent/blastpowder
	name = "Blastpowder"
	description = "."
	reagent_state = SOLID
	color = "#6b0000"
	taste_description = "spicy"
	self_consuming = TRUE
