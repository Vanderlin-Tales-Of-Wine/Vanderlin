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

/datum/objective/improve_combat/proc/on_skill_improved(datum/source, skill_type, rank, new_level)
	SIGNAL_HANDLER
	if(completed)
		return

	if(!ispath(skill_type, /datum/skill/combat))
		return

	var/old_level = owner.current.mind.get_skill_level(skill_type)
	var/level_diff = new_level - old_level

	if(level_diff > 0)
		levels_gained += level_diff

	if(levels_gained >= required_levels)
		to_chat(owner.current, span_greentext("You've improved your combat skills enough to satisfy Ravox!"))
		owner.current.adjust_triumphs(1)
		completed = TRUE
		adjust_storyteller_influence("Ravox", 15)
		UnregisterSignal(owner.current, COMSIG_SKILL_RANK_INCREASED)
	else if(level_diff > 0)
		to_chat(owner.current, span_notice("Combat skill improved! [required_levels - levels_gained] more levels needed to fulfill Ravox's task!"))

/datum/objective/improve_combat/update_explanation_text()
	explanation_text = "Improve your combat skills by gaining [required_levels] new skill levels through practice or dreams. For Ravox!"
