/datum/objective/abyssor_bath
	name = "Take Bath"

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
	if(!owner.current)
		return

	var/amulet_found = FALSE
	for(var/obj/item/clothing/neck/current_item in owner.current.get_equipped_items(TRUE))
		if(current_item.type in list(/obj/item/clothing/neck/psycross/silver/abyssor))
			amulet_found = TRUE

	if(!amulet_found)
		return

	complete_objective()

/datum/objective/abyssor_bath/proc/complete_objective()
	to_chat(owner.current, span_greentext("You have honored Abyssor by taking a relaxing bath while wearing his amulet!"))
	owner.current.adjust_triumphs(triumph_count)
	completed = TRUE
	adjust_storyteller_influence("Abyssor", 10)
	escalate_objective()
	UnregisterSignal(owner.current, COMSIG_BATH_TAKEN)

/datum/objective/abyssor_bath/update_explanation_text()
	explanation_text = "Abyssor is calm at the moment. Take a relaxing bath while wearing his amulet to honor him!"
