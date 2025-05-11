/datum/objective/tame_animal
	name = "Tame an Animal"
	triumph_count = 0
	var/tamed_count = 0
	var/required_tames = 1

/datum/objective/tame_animal/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_ANIMAL_TAMED, PROC_REF(on_animal_tamed))
	update_explanation_text()

/datum/objective/tame_animal/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_ANIMAL_TAMED)
	return ..()

/datum/objective/tame_animal/proc/on_animal_tamed(datum/source, mob/living/simple_animal/animal)
	SIGNAL_HANDLER
	if(completed)
		return

	tamed_count++
	if(tamed_count >= required_tames)
		complete_objective(animal)

/datum/objective/tame_animal/proc/complete_objective(mob/living/simple_animal/animal)
	to_chat(owner.current, span_greentext("You have tamed [animal], fulfilling Dendor's will!"))
	owner.current.adjust_triumphs(1)
	completed = TRUE
	adjust_storyteller_influence("Dendor", 15)
	escalate_objective()
	UnregisterSignal(owner.current, COMSIG_ANIMAL_TAMED)

/datum/objective/tame_animal/update_explanation_text()
	explanation_text = "Tame an animal, either by feeding it or any other means until it acknowledges you as a friend. Dendor wills it!"
