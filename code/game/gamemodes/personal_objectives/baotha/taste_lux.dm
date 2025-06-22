/datum/objective/taste_lux
	name = "Taste Divine Essence"
	triumph_count = 0

/datum/objective/taste_lux/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_LUX_TASTED, PROC_REF(on_lux_tasted))
	update_explanation_text()

/datum/objective/taste_lux/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_LUX_TASTED)
	return ..()

/datum/objective/taste_lux/proc/on_lux_tasted()
	SIGNAL_HANDLER
	to_chat(owner.current, span_greentext("You have tasted the divine essence, completing Baotha's objective!"))
	owner.current.adjust_triumphs(2)
	completed = TRUE
	adjust_storyteller_influence("Baotha", 20)
	escalate_objective()
	UnregisterSignal(owner.current, COMSIG_LUX_TASTED)

/datum/objective/taste_lux/update_explanation_text()
	explanation_text = "Experience the divine by tasting the forbidden Lux essence! Baotha is watching..."
