
/datum/antagonist/purishep
	name = "Inquisition"
	antagpanel_category = "Inquisition"
	roundend_category = "Inquisition"
	show_name_in_check_antagonists = TRUE
	increase_votepwr = FALSE
	isgoodguy = TRUE

/datum/antagonist/purishep/on_gain()
	if(!(locate(/datum/objective/purishep) in objectives))
		var/datum/objective/purishep/escape_objective = new
		escape_objective.owner = owner
		objectives += escape_objective
		return
	return ..()

/datum/antagonist/purishep/on_removal()
	return ..()


/datum/antagonist/purishep/greet()
	owner.announce_objectives()
	..()

/datum/objective/purishep
	explanation_text = "Hunt down and bring to heel all evils that infest Vanderlin. Deliver their confessions."

/datum/objective/purishep/check_completion()
	if(GLOB.confessors)
		if(GLOB.confessors.len >= 1)
			return TRUE

/datum/antagonist/purishep/roundend_report()
	var/traitorwin = TRUE
	if(objectives.len)
		for(var/datum/objective/objective in objectives)
			if(!objective.check_completion())
				traitorwin = FALSE
				break
	if(traitorwin)
		to_chat(world, "<span class='greentext'>The [name] member [owner.name] has TRIUMPHED!</span>")
		if(owner?.current)
			owner.current.playsound_local(get_turf(owner.current), 'sound/magic/forgotten_bell.ogg', 100, FALSE, pressure_affected = FALSE)
	else
		to_chat(world, "<span class='redtext'>The [name] member [owner.name] has FAILED!</span>")
		if(owner?.current)
			owner.current.playsound_local(get_turf(owner.current), 'sound/misc/hel.ogg', 100, FALSE, pressure_affected = FALSE)


