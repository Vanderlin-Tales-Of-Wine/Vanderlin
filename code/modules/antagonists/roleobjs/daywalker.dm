/datum/antagonist/daywalker
	name = "Daywalker"
	antagpanel_category = "Inquisition"
	roundend_category = "Inquisition"
	show_name_in_check_antagonists = TRUE
	increase_votepwr = FALSE
	isgoodguy = TRUE
	antag_flags = FLAG_FAKE_ANTAG

/datum/antagonist/daywalker/on_gain()
	if(!(locate(/datum/objective/daywalker) in objectives))
		var/datum/objective/daywalker/escape_objective = new
		escape_objective.owner = owner
		objectives += escape_objective
		return
	return ..()


/datum/antagonist/daywalker/examine_friendorfoe(datum/antagonist/examined_datum,mob/examiner,mob/examined)
	if(get_dist(examiner, examined) < 3)
		if(istype(examined_datum, /datum/antagonist/vampirelord))
			return span_bloody("Smells like a vampire...")

/datum/antagonist/daywalker/on_removal()
	return ..()


/datum/antagonist/daywalker/greet()
	owner.announce_objectives()
	..()

/datum/objective/daywalker
	explanation_text = "Your investigation has brought you here. Find the vampire lord and kill it. It's open season on all suckheads."

/datum/objective/daywalker/check_completion()
	return (GLOB.daywalker_vlords || GLOB.daywalker_vlessers >= 4) //still give him a W if he killed 4 lessers

/datum/antagonist/daywalker/roundend_report()
	var/str = "The [name] [owner.name] killed [GLOB.daywalker_vlords ? "0"] vampire lords and [GLOB.daywalker_vlessers ? "0"] lesser vampires."
	if(GLOB.daywalker_vlords || GLOB.daywalker_vlessers >= 4)
		to_chat(world, span_greentext(str))
	else
		to_chat(world, span_redtext(str))

