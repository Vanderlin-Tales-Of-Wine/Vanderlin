/datum/antagonist/daywalker
	name = "Daywalker"
	antagpanel_category = "Inquisition"
	roundend_category = "Inquisition"
	show_name_in_check_antagonists = TRUE
	increase_votepwr = FALSE
	isgoodguy = TRUE
	antag_flags = FLAG_FAKE_ANTAG | ROLE_DAYWALKER

/datum/antagonist/daywalker/on_gain()
	if(owner.current && ishuman(owner.current))
		var/mob/carbon/H = owner.current
		ADD_TRAIT(H, TRAIT_ZJUMP, TRAIT_GENERIC)
		var/obj/item/organ/eyes/eyes = H.getorganslot(ORGAN_SLOT_EYES)
		if(eyes)
			eyes.Remove(H,1)
			QDEL_NULL(eyes)
		eyes = new /obj/item/organ/eyes/night_vision/zombie
		eyes.Insert(H)
		H.verbs |= /mob/living/carbon/human/proc/torture_victim //ARE YOU A FUCKING VAMPIRE?
		H.cmode_music = 'sound/music/cmode/antag/combat_vamp2.ogg'

	if(!(locate(/datum/objective/daywalker) in objectives))
		var/datum/objective/daywalker/escape_objective = new
		escape_objective.owner = owner
		objectives += escape_objective
		return
	return ..()

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
	var/str = "The [name] [owner.name] killed [GLOB.daywalker_vlords ? GLOB.daywalker_vlords : "0"] vampire lords and [GLOB.daywalker_vlessers ? GLOB.daywalker_vlords : "0"] lesser vampires."
	if(GLOB.daywalker_vlords || GLOB.daywalker_vlessers >= 4)
		to_chat(world, span_greentext(str))
	else
		to_chat(world, span_redtext(str))

