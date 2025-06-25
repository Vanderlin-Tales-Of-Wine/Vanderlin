/datum/objective/kick_groin
	name = "Zizo's Sacred Kick"
	triumph_count = 0

/datum/objective/kick_groin/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_MOB_KICK, PROC_REF(on_kick_attempted))
	update_explanation_text()

/datum/objective/kick_groin/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_MOB_KICK)
	return ..()

/datum/objective/kick_groin/proc/on_kick_attempted(datum/source, mob/living/target, zone_hit, damage_blocked)
	SIGNAL_HANDLER
	if(completed || zone_hit != BODY_ZONE_PRECISE_GROIN)
		return
	if(damage_blocked)
		to_chat(owner.current, span_warning("Your kick to [target]'s groin was blocked by armor!"))
	else
		complete_objective(target)

/datum/objective/kick_groin/proc/complete_objective(mob/living/target)
	to_chat(owner.current, span_greentext("You've delivered Zizo's sacred kick to [target]'s groin!"))
	owner.current.adjust_triumphs(1)
	completed = TRUE
	adjust_storyteller_influence("Zizo", 15)
	escalate_objective()
	UnregisterSignal(owner.current, COMSIG_MOB_KICK)

/datum/objective/kick_groin/update_explanation_text()
	explanation_text = "Kick someone in the groin to honor Zizo's divine will."
