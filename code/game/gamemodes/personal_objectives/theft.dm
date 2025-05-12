/datum/objective/steal_items
	name = "Steal Items"
	triumph_count = 0
	var/stolen_count = 0
	var/required_count = 3

/datum/objective/steal_items/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_ITEM_STOLEN, PROC_REF(on_item_stolen))
	update_explanation_text()

/datum/objective/steal_items/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_ITEM_STOLEN)
	return ..()

/datum/objective/steal_items/proc/on_item_stolen(datum/source, mob/living/victim)
	SIGNAL_HANDLER
	if(completed)
		return

	stolen_count++
	if(stolen_count >= required_count)
		to_chat(owner.current, span_greentext("You have stolen enough items to complete Matthios' objective!"))
		owner.current.adjust_triumphs(1)
		completed = TRUE
		adjust_storyteller_influence("Matthios", 10)
		escalate_objective()
		UnregisterSignal(owner.current, COMSIG_ITEM_STOLEN)
	else
		to_chat(owner.current, span_notice("Item stolen! Steal [required_count - stolen_count] more to complete Matthios' objective."))

/datum/objective/steal_items/update_explanation_text()
	explanation_text = "Steal [required_count] item\s from others to prove your cunning to Matthios!"
