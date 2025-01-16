/datum/charflaw/schizophrenic
	name = "Schizophrenic"
	desc = "Even since I was young, I have seen and heard things that others cannot."

/datum/charflaw/schizophrenic/on_mob_creation(mob/user)
	. = ..()
	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		H.add_curse(/datum/curse/schizophrenic, silent = TRUE)
