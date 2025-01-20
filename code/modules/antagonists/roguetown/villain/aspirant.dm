/datum/antagonist/aspirant
	name = "Aspirant"
	roundend_category = "aspirant"
	antagpanel_category = "Aspirant"
	job_rank = ROLE_ASPIRANT
	show_name_in_check_antagonists = TRUE
	show_in_roundend = TRUE
	confess_lines = list(
		"THE CHOSEN MUST TAKE THE THRONE!",
	)
	increase_votepwr = FALSE

/datum/antagonist/aspirant/supporter
	name = "Supporter"
	show_name_in_check_antagonists = TRUE
	show_in_roundend = TRUE

/datum/antagonist/aspirant/loyalist
	name = "Loyalist"
	show_name_in_check_antagonists = TRUE
	show_in_roundend = TRUE

/datum/antagonist/aspirant/ruler
	name = "Ruler"
	show_name_in_check_antagonists = TRUE
	show_in_roundend = FALSE

/datum/antagonist/aspirant/on_gain()
	. = ..()
	owner.special_role = ROLE_ASPIRANT

/datum/antagonist/aspirant/greet()
	to_chat(owner, span_danger("I have grown weary of being near the throne, but never on it. I have decided that it is time I ruled Vanderlin."))
	..()

/datum/antagonist/aspirant/loyalist/greet()
	to_chat(owner, span_danger("Long live the Monarch! I love my ruler. But I have heard that some seek to overthrow them. I cannot let that happen."))

/datum/antagonist/aspirant/supporter/greet()
	to_chat(owner, span_danger("Long live the Monarch! But not this one. I have been approached by an Aspirant and swayed to their cause. I must ensure they take the throne."))

/datum/antagonist/aspirant/ruler/greet() // No alert for the ruler to always keep them guessing.

/datum/antagonist/aspirant/on_gain()
	. = ..()
	create_objectives()
	if(istype(src, /datum/antagonist/aspirant/ruler))
		return
	owner.announce_objectives()

/datum/antagonist/aspirant/on_removal()
	remove_objectives()
	. = ..()

/datum/antagonist/aspirant/proc/create_objectives()
	if(istype(src, /datum/antagonist/aspirant/ruler))
		var/datum/objective/aspirant/loyal/one/G = new
		objectives += G
		return
	if(istype(src, /datum/antagonist/aspirant/loyalist))
		var/datum/objective/aspirant/loyal/two/G = new
		objectives += G
		G.initialruler = SSticker.rulermob
		return
	if(istype(src, /datum/antagonist/aspirant/supporter))
		var/datum/game_mode/chaosmode/C = SSticker.mode
		var/datum/objective/aspirant/coup/three/G = new
		objectives += G
		for(var/datum/mind/aspirant in C.aspirants)
			if(aspirant.special_role == "Aspirant")
				G.aspirant = aspirant.current
		return
	else
		var/datum/objective/aspirant/coup/one/G = new
		objectives += G
		if(prob(50))
			var/datum/objective/aspirant/coup/two/M = new
			objectives += M
			M.initialruler = SSticker.rulermob


/datum/antagonist/aspirant/proc/remove_objectives()

// OBJECTIVES
/datum/objective/aspirant/coup/one
	name = "Aspirant"
	explanation_text = "I must ensure that I am crowned as the Monarch."
	triumph_count = 5

/datum/objective/aspirant/coup/one/check_completion()
	if(owner.current == SSticker.rulermob)
		return TRUE
	else
		return FALSE

/datum/objective/aspirant/coup/two
	name = "Moral"
	explanation_text = "I am no kinslayer, I must make sure that the Monarch doesn't die."
	triumph_count = 10
	var/initialruler

/datum/objective/aspirant/coup/three
	name = "Hopeful"
	explanation_text = "I must ensure that the Aspirant takes the throne."
	var/aspirant

/datum/objective/aspirant/coup/two/check_completion()
	var/mob/living/carbon/human/kin = initialruler
	if(!initialruler)
		return FALSE
	if(!kin.stat)
		return TRUE
	else return FALSE

/datum/objective/aspirant/loyal/one
	name = "Ruler"
	explanation_text = "I must remain the ruler."
	triumph_count = 3

/datum/objective/aspirant/loyal/one/check_completion()
	if(owner.current == SSticker.rulermob)
		return TRUE
	else
		return FALSE

/datum/objective/aspirant/loyal/two
	name = "Loyalist"
	explanation_text = "I must ensure that the Monarch continues to reign."
	triumph_count = 3
	var/initialruler

/datum/objective/aspirant/loyal/two/check_completion()
	if(!initialruler)
		return FALSE
	if(SSticker.rulermob == initialruler)
		return TRUE
	else return FALSE

/datum/antagonist/aspirant/roundend_report()
	to_chat(world, span_header(" * [name] * "))

	if(objectives.len)
		var/win = TRUE
		var/objective_count = 1
		for(var/datum/objective/objective in objectives)
			if(objective.check_completion())
				to_chat(world, "<B>Goal #[objective_count]</B>: [objective.explanation_text] <span class='greentext'>TRIUMPH!</span>")
				owner.adjust_triumphs(objective.triumph_count)
			else
				to_chat(world, "<B>Goal #[objective_count]</B>: [objective.explanation_text] <span class='redtext'>FAIL.</span>")
				win = FALSE
			objective_count++
		if(win)
			to_chat(world, span_greentext("The Aspirant has ascended! SUCCESS!"))
		else
			to_chat(world, span_redtext("The Aspirant was thwarted! FAIL!"))

/datum/antagonist/aspirant/ruler/roundend_report()
	to_chat(owner, span_header(" * [name] * "))

	if(objectives.len)
		var/win = TRUE
		var/objective_count = 1
		for(var/datum/objective/objective in objectives)
			if(objective.check_completion())
				to_chat(owner, "<B>Goal #[objective_count]</B>: [objective.explanation_text] <span class='greentext'>TRIUMPH!</span>")
				owner.adjust_triumphs(objective.triumph_count)
			else
				to_chat(owner, "<B>Goal #[objective_count]</B>: [objective.explanation_text] <span class='redtext'>FAIL.</span>")
				win = FALSE
			objective_count++
		if(win)
			to_chat(owner, span_greentext("You defended your throne! SUCCESS!"))
		else
			to_chat(owner, span_redtext("You were deposed! FAIL!"))

/datum/antagonist/aspirant/supporter/roundend_report()
	to_chat(owner, span_header(" * [name] * "))

	if(objectives.len)
		var/win = TRUE
		var/objective_count = 1
		for(var/datum/objective/objective in objectives)
			if(objective.check_completion())
				to_chat(owner, "<B>Goal #[objective_count]</B>: [objective.explanation_text] <span class='greentext'>TRIUMPH!</span>")
				owner.adjust_triumphs(objective.triumph_count)
			else
				to_chat(owner, "<B>Goal #[objective_count]</B>: [objective.explanation_text] <span class='redtext'>FAIL.</span>")
				win = FALSE
			objective_count++
		if(win)
			to_chat(owner, span_greentext("Your claimant took the throne! SUCCESS!"))
		else
			to_chat(owner, span_redtext("Your claimant failed! FAIL!"))

/datum/antagonist/aspirant/loyalist/roundend_report()
	to_chat(owner, span_header(" * [name] * "))

	if(objectives.len)
		var/win = TRUE
		var/objective_count = 1
		for(var/datum/objective/objective in objectives)
			if(objective.check_completion())
				to_chat(owner, "<B>Goal #[objective_count]</B>: [objective.explanation_text] <span class='greentext'>TRIUMPH!</span>")
				owner.adjust_triumphs(objective.triumph_count)
			else
				to_chat(owner, "<B>Goal #[objective_count]</B>: [objective.explanation_text] <span class='redtext'>FAIL.</span>")
				win = FALSE
			objective_count++
		if(win)
			to_chat(owner, span_greentext("Your ruler retained the throne! SUCCESS!"))
		else
			to_chat(owner, span_redtext("Your ruler was deposed! FAIL!"))
