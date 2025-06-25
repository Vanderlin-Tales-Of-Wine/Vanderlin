/datum/objective/abyssor_bath
	name = "Abyssor's Calm"
	triumph_count = 0

/datum/objective/abyssor_bath/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_BATH_TAKEN, PROC_REF(on_bath_taken))
	update_explanation_text()

/datum/objective/abyssor_bath/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_BATH_TAKEN)
	return ..()

/datum/objective/abyssor_bath/proc/on_bath_taken(datum/source)
	SIGNAL_HANDLER
	if(completed)
		return

	complete_objective()

/datum/objective/abyssor_bath/proc/complete_objective()
	to_chat(owner.current, span_greentext("The calming waters have pleased Abyssor!"))
	owner.current.adjust_triumphs(1)
	completed = TRUE
	adjust_storyteller_influence("Abyssor", 15)
	escalate_objective()
	UnregisterSignal(owner.current, COMSIG_BATH_TAKEN)

/datum/objective/abyssor_bath/update_explanation_text()
	explanation_text = "Take a bath to honor Abyssor and calm his temperament."
