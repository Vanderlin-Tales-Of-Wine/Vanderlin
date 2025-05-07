/datum/objective/proper_burial
	name = "Consecrate Graves"
	var/burials_completed = 0
	var/required_burials = 2
	triumph_count = 0

/datum/objective/proper_burial/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_GRAVE_CONSECRATED, PROC_REF(on_grave_consecrated))
	update_explanation_text()

/datum/objective/proper_burial/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_GRAVE_CONSECRATED)
	return ..()

/datum/objective/proper_burial/proc/on_grave_consecrated(datum/source, obj/structure/closet/dirthole/hole)
	SIGNAL_HANDLER
	if(completed)
		return

	burials_completed++
	if(burials_completed >= required_burials)
		complete_objective()
	else
		to_chat(owner.current, span_notice("Grave consecrated! [required_burials - burials_completed] more to complete Necra's trial."))

/datum/objective/proper_burial/proc/complete_objective()
	to_chat(owner.current, span_greentext("You have properly consecrated enough graves to satisfy Necra!"))
	owner.current.adjust_triumphs(1)
	completed = TRUE
	adjust_storyteller_influence("Necra", 15)
	UnregisterSignal(owner.current, COMSIG_GRAVE_CONSECRATED)

/datum/objective/proper_burial/update_explanation_text()
	explanation_text = "Consecrate [required_burials] graves to earn Necra's approval."
