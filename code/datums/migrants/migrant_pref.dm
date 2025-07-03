/datum/migrant_pref
	/// Reference to our prefs
	var/datum/preferences/prefs
	/// Whether the user wants to be a migrant
	var/active = FALSE
	/// Role preferences of the user, the things he clicks on to be preferred to be
	var/list/role_preferences = list()
	///are we viewing the page?
	var/viewer = FALSE

/datum/migrant_pref/New(datum/preferences/passed_prefs)
	. = ..()
	prefs = passed_prefs

/datum/migrant_pref/proc/set_active(new_state, silent = FALSE)
	if(active == new_state)
		return
	active = new_state
	role_preferences.Cut()
	if(!silent && prefs.parent)
		if(new_state)
			to_chat(prefs.parent, span_notice("You are now in the migrant queue, and will join the game with them when they arrive"))
		else
			to_chat(prefs.parent, span_boldwarning("You are no longer in the migrant queue"))

/datum/migrant_pref/proc/toggle_role_preference(role_type)
	if(role_type in role_preferences)
		role_preferences -= role_type
	else
		// Currently only allow 1 role preffed up for clarity
		role_preferences.Cut()
		if(SSmigrants.can_be_role(prefs.parent, role_type))
			role_preferences += role_type
			var/datum/migrant_role/role = MIGRANT_ROLE(role_type)
			to_chat(prefs.parent, span_nicegreen("You have prioritized the [role.name]. This does not guarantee getting the role"))
		else
			to_chat(prefs.parent, span_warning("You can't be this role. (Wrong species, gender or age)"))

/datum/migrant_pref/proc/post_spawn()
	set_active(FALSE, TRUE)
	hide_ui()

/datum/migrant_pref/proc/show_ui()
	var/client/client = prefs.parent
	if(!client)
		return
	var/list/dat = list()
	var/current_migrants = SSmigrants.get_active_migrant_amount()
	dat += "WAVE: \Roman[SSmigrants.wave_number]"
	dat += "<center><b>BE A MIGRANT: <a href='byond://?src=[REF(src)];task=toggle_active'>[active ? "YES" : "NO"]</a></b></center>"
	dat += "<br><center>Wandering fools: [current_migrants ? "\Roman[current_migrants]" : "None"]</center>"
	if(!SSmigrants.current_wave)
		dat += "<br><center>The mist will clear out of the way in [(SSmigrants.time_until_next_wave / (1 SECONDS))] seconds...</center>"
	else
		var/datum/migrant_wave/wave = MIGRANT_WAVE(SSmigrants.current_wave)
		dat += "<br><center><b>[wave.name]</b></center>"
		for(var/role_type in wave.roles)
			var/datum/migrant_role/role = MIGRANT_ROLE(role_type)
			var/role_amount = wave.roles[role_type]
			var/role_name = role.name
			if(active  && (role_type in role_preferences))
				role_name = "<u><b>[role_name]</b></u>"
			var/stars_amount = SSmigrants.get_stars_on_role(role_type)
			var/stars_string = ""
			if(stars_amount)
				stars_string = "(*\Roman[stars_amount])"
			dat += "<center><a href='byond://?src=[REF(src)];task=toggle_role_preference;role=[role_type]'>[role_name]</a> - \Roman[role_amount] [stars_string]</center>"
		dat += "<br><center>They will arrive in [(SSmigrants.wave_timer / (1 SECONDS))] seconds...</center>"
	var/datum/browser/popup = new(client.mob, "migration", "<center>Find a purpose</center>", 330, 410, src)
	popup.set_content(dat.Join())
	popup.open()
	client.prefs.migrant.viewer = TRUE

/datum/migrant_pref/Topic(href, href_list)
	var/client/client = prefs.parent
	if(!client)
		return

	if(href_list["close"])
		if(active)
			client.prefs.migrant.set_active(FALSE)
		hide_ui()
		return

	switch(href_list["task"])
		if("toggle_active")
			set_active(!active)
		if("toggle_role_preference")
			var/role_type = text2path(href_list["role"])
			toggle_role_preference(role_type)
	show_ui()

/datum/migrant_pref/proc/hide_ui()
	var/client/client = prefs.parent
	if(!client)
		return
	client.mob << browse(null, "window=migration")
	client.prefs.migrant.viewer = FALSE

/mob/living/carbon/human/proc/adv_hugboxing_start()
	to_chat(src, span_warning("I will be in danger once I start moving."))
	status_flags |= GODMODE
	ADD_TRAIT(src, TRAIT_PACIFISM, "hugbox")
	RegisterSignal(src, COMSIG_MOVABLE_MOVED, PROC_REF(adv_hugboxing_moved), TRUE)
	//Lies, it goes away even if you don't move after enough time
	if(GLOB.adventurer_hugbox_duration_still)
		addtimer(CALLBACK(src, TYPE_PROC_REF(/mob/living/carbon/human, adv_hugboxing_end)), GLOB.adventurer_hugbox_duration_still)

/mob/living/carbon/human/proc/adv_hugboxing_moved()
	UnregisterSignal(src, COMSIG_MOVABLE_MOVED)
	to_chat(src, span_danger("I have [DisplayTimeText(GLOB.adventurer_hugbox_duration)] to begone!"))
	addtimer(CALLBACK(src, TYPE_PROC_REF(/mob/living/carbon/human, adv_hugboxing_end)), GLOB.adventurer_hugbox_duration)

/mob/living/carbon/human/proc/adv_hugboxing_end()
	if(QDELETED(src))
		return
	//hugbox already ended
	if(!(status_flags & GODMODE))
		return
	status_flags &= ~GODMODE
	REMOVE_TRAIT(src, TRAIT_PACIFISM, "hugbox")
	to_chat(src, span_danger("My joy is gone! Danger surrounds me."))

/mob/living/carbon/human/proc/adv_hugboxing_cancel()
	adv_hugboxing_end()
	SSrole_class_handler.cancel_class_handler(src)
