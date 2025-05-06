/datum/objective/eat_organs
	name = "Organ Feast"
	var/organs_eaten = 0
	var/hearts_eaten = 0
	triumph_count = 0

/datum/objective/eat_organs/update_explanation_text()
	. = ..()
	explanation_text = "Consume 3 organs and 2 hearts!"
