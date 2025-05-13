/datum/objective/baptism
	name = "Receive Baptism"
	triumph_count = 0

/datum/objective/baptism/on_creation()
	. = ..()
	if(owner?.current)
		if(owner.current.mana_pool?.intrinsic_recharge_sources & MANA_ALL_LEYLINES)
			on_baptism_received()
		else
			RegisterSignal(owner.current, COMSIG_BAPTISM_RECEIVED, PROC_REF(on_baptism_received))
	update_explanation_text()

/datum/objective/baptism/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_BAPTISM_RECEIVED)
	return ..()

/datum/objective/baptism/proc/on_baptism_received(datum/source, mob/living/baptizer)
	SIGNAL_HANDLER
	if(completed)
		return

	to_chat(owner.current, span_greentext("You have been baptized and completed Noc's objective!"))
	owner.current.adjust_triumphs(1)
	completed = TRUE
	adjust_storyteller_influence("Noc", 15)
	escalate_objective()
	UnregisterSignal(owner.current, COMSIG_BAPTISM_RECEIVED)

/datum/objective/baptism/update_explanation_text()
	explanation_text = "Receive mana baptism in Noc's name to gain their favor!"
