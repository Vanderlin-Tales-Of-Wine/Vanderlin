/datum/objective/hug_beggar
	name = "Hug a Beggar"
	triumph_count = 0

/datum/objective/hug_beggar/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_MOB_HUGGED, PROC_REF(on_hug))
	update_explanation_text()

/datum/objective/hug_beggar/Destroy()
	UnregisterSignal(owner.current, COMSIG_MOB_HUGGED)
	return ..()

/datum/objective/hug_beggar/proc/on_hug(datum/source, mob/living/target)
	SIGNAL_HANDLER
	if(completed)
		return

	if(target.job == "Beggar" || istype(target.mind?.assigned_role, /datum/job/vagrant))
		to_chat(owner.current, span_greentext("You've hugged a beggar, completing Eora's objective!"))
		owner.current.adjust_triumphs(1)
		completed = TRUE
		adjust_storyteller_influence("Eora", 10)
		escalate_objective()
		UnregisterSignal(owner.current, COMSIG_MOB_HUGGED)

/datum/objective/hug_beggar/update_explanation_text()
	explanation_text = "Everyone deserves love! Hug a beggar to please Eora!"
