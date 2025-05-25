/datum/objective/rotten_feast
	name = "Rotten Feast"
	triumph_count = 0
	var/meals_eaten = 0
	var/meals_required = 2

/datum/objective/rotten_feast/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_ROTTEN_FOOD_EATEN, PROC_REF(on_rotten_eaten))
	update_explanation_text()

/datum/objective/rotten_feast/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_ROTTEN_FOOD_EATEN)
	return ..()

/datum/objective/rotten_feast/proc/on_rotten_eaten(datum/source, obj/item/eaten_food)
	SIGNAL_HANDLER
	if(completed)
		return

	meals_eaten++
	if(meals_eaten >= meals_required)
		to_chat(owner.current, span_greentext("You have consumed enough rotten food to complete Pestra's objective!"))
		owner.current.adjust_triumphs(1)
		completed = TRUE
		adjust_storyteller_influence("Pestra", 10)
		escalate_objective()
		UnregisterSignal(owner.current, COMSIG_ROTTEN_FOOD_EATEN)
	else
		to_chat(owner.current, span_notice("Rotten meal consumed! Eat [meals_required - meals_eaten] more to complete Pestra's objective."))

/datum/objective/rotten_feast/update_explanation_text()
	explanation_text = "Let nothing go to waste! Consume [meals_required] pieces of rotten food to gain Pestra's favor!"
