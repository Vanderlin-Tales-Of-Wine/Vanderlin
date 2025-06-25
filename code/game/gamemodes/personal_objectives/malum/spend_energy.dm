/datum/objective/energy_expenditure
	name = "Malum's Labor"
	triumph_count = 0
	var/energy_required = 100
	var/energy_spent = 0

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
	to_chat(owner.current, span_greentext("You've expended enough energy to satisfy Malum!"))
	owner.current.adjust_triumphs(1)
	completed = TRUE
	adjust_storyteller_influence("Malum", 15)
	escalate_objective()
	UnregisterSignal(owner.current, COMSIG_MOB_ENERGY_SPENT)

/datum/objective/energy_expenditure/update_explanation_text()
	explanation_text = "Spend at least [energy_required] energy points working to satisfy Malum."
