
SUBSYSTEM_DEF(crediticons)
	name = "crediticons"
	wait = 20
	flags = SS_NO_INIT
	priority = 1
	var/list/processing = list()
	var/list/currentrun = list()

/datum/controller/subsystem/crediticons/fire(resumed = 0)
	if (!resumed)
		src.currentrun = processing.Copy()

	//cache for sanic speed (lists are references anyways)
	var/list/currentrun = src.currentrun

	while (currentrun.len)
		var/mob/living/carbon/human/thing = currentrun[currentrun.len]
		currentrun.len--
		if (!thing || QDELETED(thing))
			processing -= thing
			if (MC_TICK_CHECK)
				return
			continue
		thing.add_credit()
		STOP_PROCESSING(SScrediticons, thing)
		if (MC_TICK_CHECK)
			return

// if(show_in_credits)
	// 	SScrediticons.processing += H

/mob/living/carbon/human/proc/add_credit()
	if(!mind || !client)
		return
	var/thename = "[real_name]"
	var/datum/job/J = SSjob.GetJob(mind.assigned_role)
	var/used_title
	if(J)
		used_title = J.title
		if(gender == FEMALE && J.f_title)
			used_title = J.f_title
	if(used_title)
		thename = "[real_name] the [used_title]"
	GLOB.credits_icons[thename] = list()
	var/client/C = client
	var/datum/preferences/P = C.prefs
	if(!P)
		return
	var/icon/I = get_flat_human_icon(null, J, P, DUMMY_HUMAN_SLOT_MANIFEST, list(SOUTH))
	if(I)
		var/icon/female_s = icon("icon"='icons/mob/clothing/under/masking_helpers.dmi', "icon_state"="credits")
		I.Blend(female_s, ICON_MULTIPLY)
		I.Scale(96,96)
		GLOB.credits_icons[thename]["icon"] = I
		GLOB.credits_icons[thename]["vc"] = voice_color
