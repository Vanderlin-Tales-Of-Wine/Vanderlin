/datum/objective/retainer
	name = "Recruit Retainer"
	triumph_count = 0
	var/retainers_recruited = 0

/obj/effect/proc_holder/spell/self/convertrole/retainer
	name = "Recruit Retainer"
	new_role = "Retainer"
	overlay_state = "recruit_guard"
	recruitment_faction = "Household"
	recruitment_message = "Join my household as a retainer, %RECRUIT!"
	accept_message = "I pledge my service to your household!"
	refuse_message = "I must decline your offer."

/datum/objective/retainer/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(SSdcs, COMSIG_GLOB_ROLE_CONVERTED, PROC_REF(on_retainer_recruited))
	update_explanation_text()

/datum/objective/retainer/Destroy()
	UnregisterSignal(SSdcs, COMSIG_GLOB_ROLE_CONVERTED)
	return ..()

/datum/objective/retainer/proc/on_retainer_recruited(datum/source, mob/living/carbon/human/recruiter, mob/living/carbon/human/recruit, new_role)
	SIGNAL_HANDLER
	if(recruiter != owner.current || new_role != "Retainer")
		return

	retainers_recruited++
	if(retainers_recruited >= 1 && !completed)
		complete_objective()

/datum/objective/retainer/proc/complete_objective()
	to_chat(owner.current, span_greentext("You have recruited a retainer and strengthened your household!"))
	owner.current.adjust_triumphs(1)
	completed = TRUE
	adjust_storyteller_influence("Nobility", 10)
	escalate_objective()

/datum/objective/retainer/update_explanation_text()
	explanation_text = "Recruit at least one retainer to serve your household and demonstrate your noble status."
