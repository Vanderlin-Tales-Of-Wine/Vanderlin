

//////////////////////////////////////////////////////////////////////////////////////////
					// MEDICINE REAGENTS
//////////////////////////////////////////////////////////////////////////////////////

// where all the reagents related to medicine go.

/datum/reagent/medicine
	name = "Medicine"
	taste_description = "bitterness"

/datum/reagent/medicine/on_mob_life(mob/living/carbon/M)
	current_cycle++
	. = ..()

/datum/reagent/medicine/salglu_solution
	name = "Saline-Glucose Solution"
	description = "Has a 33% chance per metabolism cycle to heal brute and burn damage. Can be used as a temporary blood substitute."
	reagent_state = LIQUID
	color = "#DCDCDC"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	overdose_threshold = 60
	taste_description = "sweetness and salt"
	var/last_added = 0
	var/maximum_reachable = BLOOD_VOLUME_NORMAL - 10	//So that normal blood regeneration can continue with salglu active

/datum/reagent/medicine/salglu_solution/on_mob_life(mob/living/carbon/M)
	if(last_added)
		M.blood_volume -= last_added
		last_added = 0
	if(M.blood_volume < maximum_reachable)	//Can only up to double my effective blood level.
		var/amount_to_add = min(M.blood_volume, volume*5)
		var/new_blood_level = min(M.blood_volume + amount_to_add, maximum_reachable)
		last_added = new_blood_level - M.blood_volume
		M.blood_volume = new_blood_level
	if(prob(33))
		M.adjustBruteLoss(-0.5*REM, 0)
		M.adjustFireLoss(-0.5*REM, 0)
		. = TRUE
	..()

/datum/reagent/medicine/salglu_solution/overdose_process(mob/living/M)
	if(prob(3))
		to_chat(M, "<span class='warning'>I feel salty.</span>")
		holder.add_reagent(/datum/reagent/consumable/sodiumchloride, 1)
		holder.remove_reagent(/datum/reagent/medicine/salglu_solution, 0.5)
	else if(prob(3))
		to_chat(M, "<span class='warning'>I feel sweet.</span>")
		holder.add_reagent(/datum/reagent/consumable/sugar, 1)
		holder.remove_reagent(/datum/reagent/medicine/salglu_solution, 0.5)
	if(prob(33))
		M.adjustBruteLoss(0.5*REM, FALSE, FALSE, BODYPART_ORGANIC)
		M.adjustFireLoss(0.5*REM, FALSE, FALSE, BODYPART_ORGANIC)
		. = TRUE
	..()
