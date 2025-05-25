/datum/objective/retainer
	name = "Recruit Retainer"
	triumph_count = 0
	var/retainers_recruited = 0

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
	if(recruiter != owner.current || new_role != "Retainer of [recruiter.real_name]")
		return

	retainers_recruited++
	if(retainers_recruited >= 1 && !completed)
		complete_objective()

/datum/objective/retainer/proc/complete_objective()
	to_chat(owner.current, span_greentext("You have recruited a retainer and completed Astrata's objective!"))
	owner.current.adjust_triumphs(1)
	completed = TRUE
	adjust_storyteller_influence("Astrata", 10)
	escalate_objective()

/datum/objective/retainer/update_explanation_text()
	explanation_text = "Recruit atleast one retainer to serve you and to demonstrate your ability to lead to Astrata."

/obj/effect/proc_holder/spell/self/convertrole/retainer
	name = "Recruit Retainer"
	new_role = "Retainer"
	overlay_state = "recruit_guard"
	recruitment_faction = "Retainers"
	recruitment_message = "Join my service as a retainer, %RECRUIT!"
	accept_message = "I pledge my service to you!"
	refuse_message = "I must decline your offer."


/obj/effect/proc_holder/spell/self/convertrole/retainer/convert(mob/living/carbon/human/recruit, mob/living/carbon/human/recruiter)
	if(QDELETED(recruit) || QDELETED(recruiter))
		return FALSE

	new_role = "Retainer of [recruiter.real_name]"

	. = ..()
	if(!.)
		return FALSE
