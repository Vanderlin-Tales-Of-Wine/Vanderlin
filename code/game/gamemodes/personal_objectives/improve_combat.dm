/datum/objective/improve_combat
	name = "Improve Combat Skills"
	triumph_count = 0
	var/levels_gained = 0
	var/required_levels = 2

/datum/objective/improve_combat/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_SKILL_RANK_INCREASED, PROC_REF(on_skill_improved))
	update_explanation_text()

/datum/objective/improve_combat/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_SKILL_RANK_INCREASED)
	return ..()

/datum/objective/improve_combat/proc/on_skill_improved(datum/source, datum/skill/skill_ref, new_level, old_level)
	SIGNAL_HANDLER
	if(completed)
		return

	if(!istype(skill_ref, /datum/skill/combat))
		return

	var/real_old = (old_level == SKILL_LEVEL_NONE && !(skill_ref in owner.current.mind.known_skills)) ? SKILL_LEVEL_NONE : old_level

	if(new_level <= real_old)
		return

	var/level_diff = new_level - real_old
	levels_gained += level_diff

	if(levels_gained >= required_levels)
		to_chat(owner.current, span_greentext("You've improved your combat skills enough to satisfy Ravox!"))
		owner.current.adjust_triumphs(1)
		completed = TRUE
		adjust_storyteller_influence("Ravox", 15)
		escalate_objective()
		UnregisterSignal(owner.current, COMSIG_SKILL_RANK_INCREASED)
	else
		var/remaining = required_levels - levels_gained
		to_chat(owner.current, span_notice("Combat skill improved! [remaining] more level[remaining == 1 ? "" : "s"] needed to fulfill Ravox's task!"))

/datum/objective/improve_combat/update_explanation_text()
	explanation_text = "Improve your combat skills by gaining [required_levels] new skill levels through practice or dreams. For Ravox!"
