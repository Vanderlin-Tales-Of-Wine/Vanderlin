/datum/objective/grave_robbery
	name = "Rob Graves"
	var/graves_robbed = 0
	var/graves_required = 2

/datum/objective/grave_robbery/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_GRAVE_ROBBED, PROC_REF(on_grave_robbed))
	update_explanation_text()

/datum/objective/grave_robbery/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_GRAVE_ROBBED)
	return ..()

/datum/objective/grave_robbery/proc/on_grave_robbed(datum/source, mob/user)
	SIGNAL_HANDLER
	if(completed || user != owner.current)
		return

	graves_robbed++
	if(graves_robbed >= graves_required)
		complete_objective()
	else
		to_chat(owner.current, span_notice("Grave robbed! Rob [graves_required - graves_robbed] more to complete Matthios' task."))

/datum/objective/grave_robbery/proc/complete_objective()
	to_chat(owner.current, span_greentext("You've robbed enough graves to earn Matthios' respect!"))
	owner.current.adjust_triumphs(triumph_count)
	completed = TRUE
	adjust_storyteller_influence("Matthios", 15)
	escalate_objective()
	UnregisterSignal(owner.current, COMSIG_GRAVE_ROBBED)

/datum/objective/grave_robbery/update_explanation_text()
	explanation_text = "Rob at least [graves_required] graves to earn Matthios' respect."
