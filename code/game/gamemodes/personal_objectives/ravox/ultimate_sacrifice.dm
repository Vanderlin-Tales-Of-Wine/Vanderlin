/datum/objective/ultimate_sacrifice
	name = "Ultimate Sacrifice"
	triumph_count = 3

/datum/objective/ultimate_sacrifice/on_creation()
	. = ..()
	if(owner?.current)
		owner.current.mind.AddSpell(new /obj/effect/proc_holder/spell/self/ultimate_sacrifice)
	update_explanation_text()

/datum/objective/ultimate_sacrifice/update_explanation_text()
	explanation_text = "Make the highest sacrifice by giving your own life to save truly innocent and worthy soul in the name of Ravox."
