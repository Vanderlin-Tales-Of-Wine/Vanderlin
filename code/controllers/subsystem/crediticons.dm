GLOBAL_LIST_EMPTY(credits_icons)

SUBSYSTEM_DEF(crediticons)
	name = "crediticons"
	wait = 20
	flags = SS_NO_INIT
	priority = 1
	var/list/processing = list()
	var/list/currentrun = list()

/datum/controller/subsystem/crediticons/fire(resumed = 0)
	if(!resumed)
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
		add_credit(thing)
		STOP_PROCESSING(SScrediticons, thing)
		if(MC_TICK_CHECK)
			return

/datum/controller/subsystem/crediticons/proc/add_credit(mob/living/carbon/human/actor)
	if(!actor.mind || !actor.client)
		return
	var/datum/mind/actor_mind = actor.mind
	var/client/actor_client = actor.client
	var/datum/job/job = actor_mind.assigned_role
	var/datum/preferences/preferences = actor_client.prefs
	if(!preferences)
		return

	var/thename = "[actor.real_name]"
	var/used_title = job.get_informed_title(actor)
	if(used_title)
		thename = "[thename]\nthe [used_title]"

	GLOB.credits_icons[thename] = list()
	var/icon/rendered_icon = get_flat_human_icon(null, job, preferences, DUMMY_HUMAN_SLOT_MANIFEST, list(SOUTH))
	if(rendered_icon)
		var/icon/female_s = icon("icon"='icons/mob/clothing/under/masking_helpers.dmi', "icon_state"="credits")
		rendered_icon.Blend(female_s, ICON_MULTIPLY)
		rendered_icon.Scale(96,96)
		GLOB.credits_icons[thename]["icon"] = rendered_icon
		GLOB.credits_icons[thename]["vc"] = actor.voice_color
