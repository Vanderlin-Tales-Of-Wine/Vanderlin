/datum/objective/inhumen_scorn
	name = "Scorn Inhumen"
	var/spits_done = 0
	var/spits_required = 2

/datum/objective/inhumen_scorn/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_SPAT_ON, PROC_REF(on_spit))
	update_explanation_text()

/datum/objective/inhumen_scorn/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_SPAT_ON)
	return ..()

/datum/objective/inhumen_scorn/proc/on_spit(datum/source, mob/living/carbon/human/target)
	SIGNAL_HANDLER
	if(completed || !istype(target) || target.stat == DEAD || (target.dna?.species.name in RACES_PLAYER_NONHERETICAL))
		return

	spits_done++

	if(spits_done < spits_required)
		to_chat(owner.current, span_notice("Inhumen scorned! Scorn [spits_required - spits_done] more to complete the objective!"))

	if(spits_done >= spits_required)
		to_chat(owner.current, span_greentext("You have scorned enough inhumen and completed Astrata's objective!"))
		owner.current.adjust_triumphs(triumph_count)
		completed = TRUE
		adjust_storyteller_influence("Astrata", 10)
		escalate_objective()
		UnregisterSignal(owner.current, COMSIG_SPAT_ON)

/datum/objective/inhumen_scorn/update_explanation_text()
	explanation_text = "Spit on [spits_required] inhumen to gain Astrata's approval!"
