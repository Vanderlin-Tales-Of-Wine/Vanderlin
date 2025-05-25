/datum/objective/marriage_broker
	name = "Arrange Marriage"
	triumph_count = 0

/datum/objective/marriage_broker/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(SSdcs, COMSIG_GLOBAL_MARRIAGE, PROC_REF(on_global_marriage))
	update_explanation_text()

/datum/objective/marriage_broker/Destroy()
	UnregisterSignal(SSdcs, COMSIG_GLOBAL_MARRIAGE)
	return ..()

/datum/objective/marriage_broker/proc/on_global_marriage(datum/source, mob/living/groom, mob/living/bride)
	SIGNAL_HANDLER
	if(completed)
		return

	to_chat(owner.current, span_greentext("A marriage has occurred in the world, completing Eora's objective!"))
	owner.current.adjust_triumphs(1)
	completed = TRUE
	adjust_storyteller_influence("Eora", 15)
	escalate_objective()
	UnregisterSignal(SSdcs, COMSIG_GLOBAL_MARRIAGE)

/datum/objective/marriage_broker/update_explanation_text()
	explanation_text = "Be a matchmaker! Make any marriage happen to please Eora!"
