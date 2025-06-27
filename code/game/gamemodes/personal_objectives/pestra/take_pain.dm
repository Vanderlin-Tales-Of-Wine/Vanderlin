/datum/objective/take_pain
	name = "Take Pain"
	triumph_count = 2
	var/total_pain_taken = 0
	var/target_pain = 1250

/datum/objective/take_pain/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_PAIN_TRANSFERRED, PROC_REF(on_pain_transferred))
	update_explanation_text()

/datum/objective/take_pain/Destroy()
	UnregisterSignal(owner.current, COMSIG_PAIN_TRANSFERRED)
	return ..()

/datum/objective/take_pain/proc/on_pain_transferred(datum/source, amount)
	SIGNAL_HANDLER
	if(completed)
		return

	total_pain_taken += amount

	var/progress_ratio = total_pain_taken / target_pain
	if(progress_ratio < 0.25)
		to_chat(owner.current, span_green("You feel a small amount of pain flow through you. Pestra is pleased, but there is much more suffering to relieve."))
	else if(progress_ratio < 0.5)
		to_chat(owner.current, span_green("The pain you've taken weighs heavily upon you. Keep going, Pestra's work is not yet done."))
	else if(progress_ratio < 0.75)
		to_chat(owner.current, span_green("The agony you've absorbed is substantial. You're making good progress in Pestra's name."))
	else if(progress_ratio < 1)
		to_chat(owner.current, span_green("The pain is nearly overwhelming, but you can sense you're close to completing Pestra's task."))

	if(total_pain_taken >= target_pain)
		to_chat(owner.current, span_greentext("You have taken enough pain from others, completing Pestra's objective! Your sacrifice is rewarded."))
		owner.current.adjust_triumphs(triumph_count)
		completed = TRUE
		adjust_storyteller_influence("Pestra", 15)
		escalate_objective()
		UnregisterSignal(owner.current, COMSIG_PAIN_TRANSFERRED)

/datum/objective/take_pain/update_explanation_text()
	explanation_text = "Take enough pain from others upon yourself as an act of mercy and devotion to Pestra."
