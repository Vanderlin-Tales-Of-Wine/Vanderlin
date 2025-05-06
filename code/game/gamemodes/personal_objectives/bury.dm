/datum/objective/burial
	name = "Proper Burials"
	var/buried_count = 0
	var/required_count = 2
	triumph_count = 0

/datum/objective/burial/update_explanation_text()
	. = ..()
	explanation_text = "Give [required_count] corpses proper burials!"
