/datum/objective/embrace_death
	name = "Embrace Death"
	triumph_count = 3

/datum/objective/embrace_death/on_creation()
	. = ..()
	if(owner?.current)
		owner.current.mind.AddSpell(new /obj/effect/proc_holder/spell/self/embrace_death)
	update_explanation_text()

/datum/objective/embrace_death/update_explanation_text()
	explanation_text = "Your time has come. Embrace death through Necra's gift to achieve final rest and secure your soul."
