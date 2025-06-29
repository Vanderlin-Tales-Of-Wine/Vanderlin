/datum/objective/butcher_animals
	name = "Butcher Animals"
	var/animals_butchered = 0
	var/animals_required = 2

/datum/objective/butcher_animals/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_MOB_BUTCHERED, PROC_REF(on_animal_butchered))
	update_explanation_text()

/datum/objective/butcher_animals/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_MOB_BUTCHERED)
	return ..()

/datum/objective/butcher_animals/proc/on_animal_butchered(datum/source, mob/animal)
	SIGNAL_HANDLER
	if(completed)
		return

	animals_butchered++
	if(animals_butchered >= animals_required)
		complete_objective()
	else
		to_chat(owner.current, span_notice("Animal butchered! Butcher [animals_required - animals_butchered] more to complete Dendor's will."))

/datum/objective/butcher_animals/proc/complete_objective()
	to_chat(owner.current, span_greentext("You've butchered enough animals to satisfy Dendor!"))
	owner.current.adjust_triumphs(triumph_count)
	completed = TRUE
	adjust_storyteller_influence("Dendor", 15)
	escalate_objective()
	UnregisterSignal(owner.current, COMSIG_MOB_BUTCHERED)

/datum/objective/butcher_animals/update_explanation_text()
	explanation_text = "Butcher at least [animals_required] animals to satisfy Dendor."
