/datum/objective/release_fish
	name = "Release Rare Fish"
	triumph_count = 0
	var/released_count = 0
	var/required_count = 1
	var/required_rarity_rank = 1

/datum/objective/release_fish/on_creation()
	. = ..()
	RegisterSignal(SSdcs, COMSIG_GLOBAL_FISH_RELEASED, PROC_REF(on_fish_released))
	update_explanation_text()

/datum/objective/release_fish/Destroy()
	UnregisterSignal(SSdcs, COMSIG_GLOBAL_FISH_RELEASED)
	return ..()

/datum/objective/release_fish/proc/on_fish_released(datum/source, fish_type, raritymod)
	SIGNAL_HANDLER
	if(completed || !owner?.current)
		return

	if(!(raritymod >= required_rarity_rank))
		return

	released_count++
	if(released_count >= required_count)
		complete_objective()

/datum/objective/release_fish/proc/complete_objective()
	to_chat(owner.current, span_greentext("A rare fish has been returned to the depths, pleasing Abyssor!"))
	owner.current.adjust_triumphs(1)
	completed = TRUE
	adjust_storyteller_influence("Abyssor", 15)
	escalate_objective()
	UnregisterSignal(SSdcs, COMSIG_GLOBAL_FISH_RELEASED)

/datum/objective/release_fish/update_explanation_text()
	explanation_text = "Have any rare or better fish returned to the water to honor Abyssor."
