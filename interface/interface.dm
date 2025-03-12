//Please use mob or src (not usr) in these procs. This way they can be called in the same fashion as procs.
/client/verb/wiki(query as text)
	set name = "Wiki"
	set desc = ""
	set category = "Memory"
	var/wikiurl = CONFIG_GET(string/wikiurl)
	if(wikiurl)
		if(query)
			var/output = wikiurl + "?title=Special%3ASearch&search=" + query
			src << link(output)
		else if (query != null)
			src << link(wikiurl)
	else
		to_chat(src, "<span class='danger'>The wiki URL is not set in the server configuration.</span>")
	return

/client/verb/forum()
	set name = "forum"
	set desc = ""
	set hidden = 1
	var/forumurl = CONFIG_GET(string/forumurl)
	if(forumurl)
		if(alert("This will open the forum in your browser. Are you sure?",,"Yes","No")!="Yes")
			return
		src << link(forumurl)
	else
		to_chat(src, "<span class='danger'>The forum URL is not set in the server configuration.</span>")
	return

/client/verb/rules()
	set name = "Rules"
	set desc = ""
	set category = "Memory"
	var/rulesurl = CONFIG_GET(string/rulesurl)
	if(rulesurl)
		if(alert("This will open the rules in your browser. Are you sure?",,"Yes","No")!="Yes")
			return
		src << link(rulesurl)
	else
		to_chat(src, "<span class='danger'>The rules URL is not set in the server configuration.</span>")
	return

/client/verb/github()
	set name = "Github"
	set desc = ""
	set category = "Memory"
	var/githuburl = CONFIG_GET(string/githuburl)
	if(githuburl)
		if(alert("This will open the Github repository in your browser. Are you sure?",,"Yes","No")!="Yes")
			return
		src << link(githuburl)
	else
		to_chat(src, "<span class='danger'>The Github URL is not set in the server configuration.</span>")
	return

/client/verb/mentorhelp()
	set name = "Mentorhelp"
	set desc = ""
	set category = "Admin"
	if(mob)
		var/msg = input("Say your meditation:", "Voices in your head") as text|null
		if(msg)
			mob.schizohelp(msg)
	else
		to_chat(src, span_danger("You can't currently use Mentorhelp in the main menu."))

/client/verb/reportissue()
	set name = "Report a bug"
	set desc = "Report a bug"
	set category = "OOC"

	var/githuburl = CONFIG_GET(string/githuburl)
	if(!githuburl)
		to_chat(src, span_danger("The Github URL is not set in the server configuration."))
		return

	var/testmerge_data = GLOB.revdata.testmerge
	var/has_testmerge_data = (length(testmerge_data) != 0)

	var/message = "This will open the Github issue reporter in your browser. Are you sure?"
	if(has_testmerge_data)
		message += "<br>The following experimental changes are active and are probably the cause of any new or sudden issues you may experience. If possible, please try to find a specific thread for your issue instead of posting to the general issue tracker:<br>"
		message += GLOB.revdata.GetTestMergeInfo(FALSE)

	// We still use tgalert here because some people were concerned that if someone wanted to report that tgui wasn't working
	// then the report issue button being tgui-based would be problematic.
	if(tgalert(src, message, "Report Issue","Yes","No") != "Yes")
		return
	var/base_link = githuburl + "/issues/new?template=bug_report.yml"
	var/list/concatable = list(base_link)

	var/client_version = "[byond_version].[byond_build]"
	concatable += ("&reporting-version=" + client_version)

	// the way it works is that we use the ID's that are baked into the template YML and replace them with values that we can collect in game.
	if(GLOB.round_id)
		concatable += ("&round-id=" + GLOB.round_id)

	// Insert testmerges
	if(has_testmerge_data)
		var/list/all_tms = list()
		for(var/entry in testmerge_data)
			var/datum/tgs_revision_information/test_merge/tm = entry
			all_tms += "- \[[tm.title]\]([githuburl]/pull/[tm.number])"
		var/all_tms_joined = jointext(all_tms, "%0A") // %0A is a newline for URL encoding because i don't trust \n to not break

		concatable += ("&test-merges=" + all_tms_joined)

	DIRECT_OUTPUT(src, link(jointext(concatable, "")))

/client/verb/list_test_merges()
	set name = "List Test Merges"
	set desc = "See active Test Merges"
	set category = "OOC"

	var/testmerge_text = GLOB.revdata.GetTestMergeInfo()

	if(length(testmerge_text)) // is there even any text here? gotta check.
		to_chat(src, span_notice(testmerge_text))
		return

	to_chat(src, span_notice("No Test Merges active!"))


/client/verb/check_role_bans()
	set name = "Check Role Bans"
	set desc = ""
	set category = "OOC"

	var/datum/role_bans/bans = get_role_bans_for_ckey(ckey)
	var/list/dat = list()
	for(var/datum/role_ban_instance/instance as anything in bans.bans)
		if(!instance.permanent && world.realtime >= instance.apply_date + instance.duration)
			dat += "<b>EXPIRED</b><BR>"
		var/list/ban_string =  instance.get_ban_string_list()
		dat += ban_string.Join("<BR>")
		dat += "<HR>"
	var/datum/browser/popup = new(usr, "check_role_bans", "Role Bans", 550, 500)
	popup.set_content(dat.Join())
	popup.open()

/client/verb/changelog()
	set name = "Changelog"
	set category = "OOC"
	set hidden = 1
	src << browse('html/changelog.html', "window=changes;size=675x650")
	if(prefs.lastchangelog != GLOB.changelog_hash)
		prefs.lastchangelog = GLOB.changelog_hash
		prefs.save_preferences()
		winset(src, "infowindow.changelog", "font-style=;")

/client/verb/set_fixed()
	set name = "IconSize"
	set category = "Options"

	if(winget(src, "mapwindow.map", "icon-size") == "64")
		to_chat(src, "Stretch-to-fit... OK")
		winset(src, "mapwindow.map", "icon-size=0")
	else
		to_chat(src, "64x... OK")
		winset(src, "mapwindow.map", "icon-size=64")

/client/verb/set_stretch()
	set name = "IconScaling"
	set category = "Options"
	if(prefs)
		if(prefs.crt == TRUE)
			to_chat(src, "CRT mode is on.")
			winset(src, "mapwindow.map", "zoom-mode=blur")
			return
	if(winget(src, "mapwindow.map", "zoom-mode") == "normal")
		to_chat(src, "Pixel-perfect... OK")
		winset(src, "mapwindow.map", "zoom-mode=distort")
	else
		to_chat(src, "Anti-aliased... OK")
		winset(src, "mapwindow.map", "zoom-mode=normal")

/client/verb/crtmode()
	set category = "Options"
	set name = "ToggleCRT"
	if(!prefs)
		return
	if(prefs.crt == TRUE)
		winset(src, "mapwindow.map", "zoom-mode=normal")
		prefs.crt = FALSE
		prefs.save_preferences()
		to_chat(src, "CRT... OFF")
		for(var/atom/movable/screen/scannies/S in screen)
			S.alpha = 0
	else
		winset(src, "mapwindow.map", "zoom-mode=blur")
		prefs.crt = TRUE
		prefs.save_preferences()
		to_chat(src, "CRT... ON")
		for(var/atom/movable/screen/scannies/S in screen)
			S.alpha = 70

/client/verb/keybind_menu()
	set category = "Options"
	set name = "Adjust Keybinds"
	if(!prefs)
		return
	prefs.SetKeybinds(usr)

/client/verb/changefps()
	set category = "Options"
	set name = "ChangeFPS"
	if(!prefs)
		return
	var/newfps = input(usr, "Enter new FPS", "New FPS", 100) as null|num
	if (!isnull(newfps))
		prefs.clientfps = clamp(newfps, 1, 1000)
		fps = prefs.clientfps
		prefs.save_preferences()

/*
/client/verb/set_blur()
	set name = "AAOn"
	set category = "Options"

	winset(src, "mapwindow.map", "zoom-mode=blur")

/client/verb/set_normal()
	set name = "AAOff"
	set category = "Options"

	winset(src, "mapwindow.map", "zoom-mode=normal")*/
