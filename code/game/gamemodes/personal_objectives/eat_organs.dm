/datum/objective/consume_organs
	name = "Consume Organs"
	triumph_count = 0
	var/organs_consumed = 0
	var/hearts_consumed = 0
	var/organs_required = 2
	var/hearts_required = 1

/datum/objective/consume_organs/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_ORGAN_CONSUMED, PROC_REF(on_organ_consumed))
	update_explanation_text()

/datum/objective/consume_organs/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_ORGAN_CONSUMED)
	return ..()

/datum/objective/consume_organs/proc/on_organ_consumed(datum/source, organ_type)
	SIGNAL_HANDLER
	if(completed)
		return

	organs_consumed++

	if(ispath(organ_type, /obj/item/reagent_containers/food/snacks/organ/heart))
		hearts_consumed++
		to_chat(owner.current, span_cult("You feel Graggar's pleasure as you consume a heart!"))
	else
		to_chat(owner.current, span_notice("Organ consumed! [organs_required - organs_consumed] more organ\s needed."))

	if(organs_consumed >= organs_required && hearts_consumed >= hearts_required)
		complete_objective()

/datum/objective/consume_organs/proc/complete_objective()
	to_chat(owner.current, span_greentext("You have consumed enough organs and hearts to satisfy Graggar!"))
	owner.current.adjust_triumphs(1)
	completed = TRUE
	adjust_storyteller_influence("Graggar", 15)
	escalate_objective()
	UnregisterSignal(owner.current, COMSIG_ORGAN_CONSUMED)

/datum/objective/consume_organs/update_explanation_text()
	explanation_text = "Consume [organs_required] organ\s, including [hearts_required] heart\s, to appease Graggar!"
