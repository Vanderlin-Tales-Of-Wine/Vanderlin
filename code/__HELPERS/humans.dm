/mob/living/carbon/human/proc/is_noble()
	var/noble = FALSE
	if (job in GLOB.noble_positions)
		noble = TRUE
	if (HAS_TRAIT(src, TRAIT_NOBLE))
		noble = TRUE

	return noble

/mob/living/carbon/human/proc/is_yeoman()
	return FALSE

/mob/living/carbon/human/proc/is_courtier()
	return FALSE
