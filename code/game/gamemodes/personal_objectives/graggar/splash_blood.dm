/datum/objective/blood_splash
	name = "Graggar's Blood Rite"
	triumph_count = 0

/datum/objective/blood_splash/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_SPLASHED_MOB, PROC_REF(on_blood_splashed))
	update_explanation_text()

/datum/objective/blood_splash/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_SPLASHED_MOB)
	return ..()

/datum/objective/blood_splash/proc/on_blood_splashed(datum/source, mob/target, list/reagents_splashed)
	SIGNAL_HANDLER
	if(completed || target != owner.current)
		return

	// Check for sufficient blood content
	var/blood_amount = 0
	for(var/reagent_type in reagents_splashed)
		if(istype(reagent_type, /datum/reagent/blood))
			blood_amount += reagents_splashed[reagent_type]

	if(blood_amount >= 10) // At least 10 units of blood
		complete_objective()
	else
		to_chat(owner.current, span_warning("Not enough blood in that splash to satisfy Graggar!"))

/datum/objective/blood_splash/proc/complete_objective()
	to_chat(owner.current, span_greentext("The blood baptism pleases Graggar!"))
	owner.current.adjust_triumphs(1)
	completed = TRUE
	adjust_storyteller_influence("Graggar", 15)
	escalate_objective()
	UnregisterSignal(owner.current, COMSIG_SPLASHED_MOB)

/datum/objective/blood_splash/update_explanation_text()
	explanation_text = "Splash a bucket containing at least 10 units of blood on yourself to honor Graggar."
