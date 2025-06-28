/datum/objective/abyssor_splash
	name = "Splash Water"

/datum/objective/abyssor_splash/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_SPLASHED_MOB, PROC_REF(on_mob_splashed))
	update_explanation_text()

/datum/objective/abyssor_splash/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_SPLASHED_MOB)
	return ..()

/datum/objective/abyssor_splash/proc/on_mob_splashed(datum/source, mob/target, list/reagents_splashed)
	SIGNAL_HANDLER
	if(completed || target == owner.current || target.stat == DEAD || !target.client)
		return

	var/water_volume = 0
	for(var/datum/reagent/reagent_type as anything in reagents_splashed)
		if(istype(reagent_type, /datum/reagent/water))
			water_volume += reagent_type.volume

	if(water_volume >= 30)
		complete_objective(target)

/datum/objective/abyssor_splash/proc/complete_objective(mob/target)
	to_chat(owner.current, span_greentext("You've unleashed Abyssor's rage, completing the objective!"))
	owner.current.adjust_triumphs(triumph_count)
	completed = TRUE
	adjust_storyteller_influence("Abyssor", 15)
	escalate_objective()
	UnregisterSignal(owner.current, COMSIG_SPLASHED_MOB)

/datum/objective/abyssor_splash/update_explanation_text()
	explanation_text = "Abyssor is RAGING! Splash some ingrate who forgot his name with a bucket full of water!"
