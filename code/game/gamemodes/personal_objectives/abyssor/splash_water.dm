/datum/objective/abyssor_splash
	name = "Abyssor's Rage"
	triumph_count = 0

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
	if(completed)
		return

	// Calculate total water volume (including subtypes)
	var/water_volume = 0
	for(var/reagent_type in reagents_splashed)
		if(ispath(reagent_type, /datum/reagent/water))
			water_volume += reagents_splashed[reagent_type]

	if(water_volume >= 10)
		complete_objective(target)
	else
		to_chat(owner.current, span_warning("You need at least 10 units of water to satisfy Abyssor's rage!"))

/datum/objective/abyssor_splash/proc/complete_objective(mob/target)
	to_chat(owner.current, span_greentext("You've unleashed Abyssor's rage upon [target]!"))
	owner.current.adjust_triumphs(1)
	completed = TRUE
	adjust_storyteller_influence("Abyssor", 15)
	escalate_objective()
	UnregisterSignal(owner.current, COMSIG_SPLASHED_MOB)

/datum/objective/abyssor_splash/update_explanation_text()
	explanation_text = "Splash someone with water to unleash Abyssor's rage."
