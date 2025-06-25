/datum/objective/ultimate_sacrifice
	name = "Ravox's Ultimate Sacrifice"
	triumph_count = 0

/datum/objective/ultimate_sacrifice/on_creation()
	. = ..()
	if(owner?.current)
		owner.current.mind.AddSpell(new /obj/effect/proc_holder/spell/self/ultimate_sacrifice)
	update_explanation_text()

/datum/objective/ultimate_sacrifice/update_explanation_text()
	explanation_text = "Use Ravox's gift of Ultimate Sacrifice to revive another at the cost of your own life. You cannot be revived after using this power."
