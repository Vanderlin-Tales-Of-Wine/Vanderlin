/datum/objective/retainer
	name = "Recruit Retainer"
	var/retainers_recruited = 0

/datum/objective/retainer/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(SSdcs, COMSIG_GLOBAL_ROLE_CONVERTED, PROC_REF(on_retainer_recruited))
	update_explanation_text()

/datum/objective/retainer/Destroy()
	UnregisterSignal(SSdcs, COMSIG_GLOBAL_ROLE_CONVERTED)
	return ..()

/datum/objective/retainer/proc/on_retainer_recruited(datum/source, mob/living/carbon/human/recruiter, mob/living/carbon/human/recruit, new_role)
	SIGNAL_HANDLER
	if(completed || recruiter != owner.current || new_role != "Retainer of [recruiter.real_name]")
		return

	retainers_recruited++
	if(retainers_recruited >= 1 && !completed)
		complete_objective()

/datum/objective/retainer/proc/complete_objective()
	to_chat(owner.current, span_greentext("You have recruited a retainer and completed Astrata's objective!"))
	owner.current.adjust_triumphs(triumph_count)
	completed = TRUE
	adjust_storyteller_influence("Astrata", 15)
	escalate_objective()

/datum/objective/retainer/update_explanation_text()
	explanation_text = "Recruit at least one retainer to serve you and to demonstrate your ability to lead to Astrata."

/datum/action/cooldown/spell/undirected/list_target/convert_role/retainer
	name = "Recruit Retainer"
	button_icon_state = "recruit_servant"

	new_role = "Retainer"
	recruitment_faction = "Retainers"
	recruitment_message = "Join my service as a retainer, %RECRUIT!"
	accept_message = "I pledge my service to you!"
	refuse_message = "I must decline your offer."

/datum/action/cooldown/spell/undirected/list_target/convert_role/retainer/Grant(mob/grant_to)
	. = ..()
	if(!.)
		return
	new_role = "Retainer of [grant_to.real_name]"
