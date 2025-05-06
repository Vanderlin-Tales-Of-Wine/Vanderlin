/datum/objective/sniff_drugs
	name = "Sniff Drugs"
	var/drugs_sniffed = 0
	var/required_count = 3
	triumph_count = 0

/datum/objective/sniff_drugs/update_explanation_text()
	. = ..()
	explanation_text = "Sniff [required_count] different drugs!"
