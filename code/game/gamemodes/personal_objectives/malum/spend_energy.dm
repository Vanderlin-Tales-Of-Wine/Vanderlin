/datum/objective/energy_expenditure
	name = "Spend Energy"
	var/energy_spent = 0
	var/energy_required = 1000

/datum/objective/energy_expenditure/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_MOB_ENERGY_SPENT, PROC_REF(on_energy_spent))
	update_explanation_text()

/datum/objective/energy_expenditure/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_MOB_ENERGY_SPENT)
	return ..()

/datum/objective/energy_expenditure/proc/on_energy_spent(datum/source, amount)
	SIGNAL_HANDLER
	if(completed)
		return

	energy_spent += amount
	if(energy_spent >= energy_required)
		complete_objective()

/datum/objective/energy_expenditure/proc/complete_objective()
	to_chat(owner.current, span_greentext("You've spent enough energy working to satisfy Malum!"))
	owner.current.adjust_triumphs(triumph_count)
	completed = TRUE
	adjust_storyteller_influence("Malum", 15)
	escalate_objective()
	UnregisterSignal(owner.current, COMSIG_MOB_ENERGY_SPENT)

/datum/objective/energy_expenditure/update_explanation_text()
	explanation_text = "Don't be a slacker! Spend at least [energy_required] energy working to satisfy Malum."
