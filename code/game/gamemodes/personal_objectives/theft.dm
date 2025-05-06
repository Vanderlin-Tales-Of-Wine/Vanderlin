
/datum/objective/steal_items
	name = "Steal Items"
	var/items_stolen = 0
	var/required_count = 3
	triumph_count = 0

/datum/objective/steal_items/update_explanation_text()
	. = ..()
	explanation_text = "Successfully steal [required_count] items!"
