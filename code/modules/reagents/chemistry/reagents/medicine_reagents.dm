/datum/reagent/medicine
	name = "Medicine"
	taste_description = "bitterness"

/datum/reagent/medicine/on_mob_life(mob/living/carbon/M)
	current_cycle++
	. = ..()

/datum/reagent/medicine/atropine
	name = "Atropine"
	description = "If a patient is in critical condition, rapidly heals all damage types as well as regulating oxygen in the body. Excellent for stabilizing wounded patients, and said to neutralize blood-activated internal explosives found amongst clandestine black op agents."
	reagent_state = LIQUID
	color = "#1D3535" //slightly more blue, like epinephrine
	metabolization_rate = 0.25 * REAGENTS_METABOLISM
	overdose_threshold = 35

/datum/reagent/medicine/atropine/on_mob_life(mob/living/carbon/affected_mob, seconds_per_tick, times_fired)
	if(affected_mob.health <= affected_mob.crit_threshold)
		affected_mob.adjustToxLoss(-2 * REM * seconds_per_tick, FALSE)
		affected_mob.adjustBruteLoss(-2* REM * seconds_per_tick, FALSE)
		affected_mob.adjustFireLoss(-2 * REM * seconds_per_tick, FALSE)
		affected_mob.adjustOxyLoss(-5 * REM * seconds_per_tick, FALSE)
		. = TRUE
	if(affected_mob.blood_volume < BLOOD_VOLUME_NORMAL)
		affected_mob.blood_volume += 3 * REM * seconds_per_tick
	if(SPT_PROB(10, seconds_per_tick))
		affected_mob.Dizzy(10 SECONDS)
		affected_mob.Jitter(10 SECONDS)
	..()

/datum/reagent/medicine/atropine/overdose_process(mob/living/affected_mob, seconds_per_tick, times_fired)
	affected_mob.adjustToxLoss(0.5 * REM * seconds_per_tick, FALSE)
	. = TRUE
	affected_mob.Dizzy(2 SECONDS * REM * seconds_per_tick)
	affected_mob.Jitter(2 SECONDS * REM * seconds_per_tick)
	..()
