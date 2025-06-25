/datum/objective/ass_slap
	name = "Baotha's Desire"
	triumph_count = 0
	var/slaps_completed = 0
	var/slaps_required = 3

/datum/objective/ass_slap/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_ASS_SLAPPED, PROC_REF(on_ass_slapped))
	update_explanation_text()

/datum/objective/ass_slap/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_ASS_SLAPPED)
	return ..()

/datum/objective/ass_slap/proc/on_ass_slapped(datum/source, mob/target)
	SIGNAL_HANDLER
	if(completed)
		return

	slaps_completed++
	if(slaps_completed >= slaps_required)
		complete_objective()
	else
		to_chat(owner.current, span_notice("Ass slapped! [slaps_required - slaps_completed] more to go!"))

/datum/objective/ass_slap/proc/complete_objective()
	to_chat(owner.current, span_greentext("You've satisfied Baotha's desires with your slaps!"))
	owner.current.adjust_triumphs(1)
	completed = TRUE
	adjust_storyteller_influence("Baotha", 15)
	escalate_objective()
	UnregisterSignal(owner.current, COMSIG_ASS_SLAPPED)

/datum/objective/ass_slap/update_explanation_text()
	explanation_text = "Slap at least [slaps_required] asses to satisfy Baotha's desires."
