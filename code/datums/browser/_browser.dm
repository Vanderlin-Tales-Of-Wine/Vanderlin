/datum/browser
	/// The mob that is using this browser.
	var/tmp/mob/user
	/// The object that owns this browser.
	var/tmp/datum/owner = null
	/// The window's title.
	var/final/title
	/// The ID used for browse and onclose.
	var/final/window_id
	/// The window's width in pixels.
	var/final/width
	/// The window's height in pixels.
	var/final/height
	/// Params for the window on creation.
	VAR_PROTECTED/window_options = "can_close=1;can_minimize=1;can_maximize=0;can_resize=1;titlebar=1;"
	/// A list of paths to CSS files.
	VAR_PRIVATE/final/list/stylesheets = list()
	/// A list of paths to JavaScript files.
	VAR_PRIVATE/final/list/scripts = list()
	/// Text containing the contents of the \<head\> element.
	VAR_PRIVATE/final/head = ""
	/// Text containing the contents of the \<body\> element.
	VAR_PRIVATE/final/body = ""

/datum/browser/New(mob/user, window_id, title = "", width = 0, height = 0, atom/owner = null)
	if(!user)
		CRASH("created a browser for no user")
	if(!window_id)
		CRASH("created a browser with no window id")
	src.user = user
	RegisterSignal(src, COMSIG_MOB_CLIENT_MOVED, PROC_REF(user_moved))
	src.window_id = window_id
	RegisterSignal(user, COMSIG_PARENT_QDELETING, PROC_REF(user_deleted))
	src.title = format_text(title)
	src.width = width
	src.height = height
	if(owner)
		src.owner = owner
		RegisterSignal(owner, COMSIG_PARENT_QDELETING, PROC_REF(owner_deleted))

/datum/browser/Destroy(force, ...)
	. = ..()
	if(!isnull(user))
		var/client/user_client = isclient(user) ? user : user.client
		UnregisterSignal(user_client, COMSIG_MOB_CLIENT_MOVED)
	user = null
	owner = null

/datum/browser/noclose
/datum/browser/noclose/New(mob/user, window_id, title = "", width, height, atom/owner)
	. = ..()
	var/client/user_client = isclient(user) ? user : user.client
	UnregisterSignal(user_client, COMSIG_MOB_CLIENT_MOVED)

/datum/browser/proc/user_deleted(datum/source)
	SIGNAL_HANDLER
	user = null

/datum/browser/proc/owner_deleted(datum/source)
	SIGNAL_HANDLER
	owner = null

/datum/browser/proc/user_moved(direction, old_direction)
	qdel(src)

/datum/browser/proc/set_window_options(nwindow_options)
	window_options = nwindow_options

/datum/browser/proc/add_stylesheet(name, file)
	if (istype(name, /datum/asset/spritesheet))
		var/datum/asset/spritesheet/sheet = name
		stylesheets["spritesheet_[sheet.name].css"] = "data/spritesheets/[sheet.name]"
	else
		var/asset_name = "[name].css"

		stylesheets[asset_name] = file

		if (!SSassets.cache[asset_name])
			SSassets.transport.register_asset(asset_name, file)

/datum/browser/proc/add_script(name, file)
	scripts["[ckey(name)].js"] = file
	SSassets.transport.register_asset("[ckey(name)].js", file)

/datum/browser/proc/set_head_content(head_content)
	head = head_content

/datum/browser/proc/set_content(content)
	body = content

/datum/browser/proc/add_content(content)
	body += content

/datum/browser/proc/build_page()
	var/head_content = head
	var/datum/asset/simple/namespaced/common/common_asset = get_asset_datum(/datum/asset/simple/namespaced/common)
	head_content += "<link rel='stylesheet' type='text/css' href='[common_asset.get_url_mappings()["common.css"]]'>"
	for(var/file in stylesheets)
		head_content += "<link rel='stylesheet' type='text/css' href='[SSassets.transport.get_asset_url(file)]'>"

	for(var/file in scripts)
		head_content += "<script type='text/javascript' src='[SSassets.transport.get_asset_url(file)]'></script>"

	return {"
		<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
		<html>
			<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
			<meta http-equiv="X-UA-Compatible" content="IE=edge">
			<head>
				[head_content]
			</head>
			<body scroll=auto>
				<div class='uiWrapper'>
					<div class='uiTitle'><tt>[title]</tt></div>
					<div class='uiContent'>
						[body]
					</div>
				</div>
			</body>
		</html>"}

/datum/browser/proc/open(use_onclose = TRUE)
	if(isnull(window_id))	//null check because this can potentially nuke goonchat
		stack_trace("Browser [title] tried to open with a null ID")
		to_chat(user, "<span class='danger'>The [title] browser you tried to open failed a sanity check! Please report this on github!</span>")
		return
	var/window_size = ""
	if (width && height)
		window_size = "size=[width]x[height];"
	var/datum/asset/simple/namespaced/common/common_asset = get_asset_datum(/datum/asset/simple/namespaced/common)
	common_asset.send(user)
	if (stylesheets.len)
		SSassets.transport.send_assets(user, stylesheets)
	if (scripts.len)
		SSassets.transport.send_assets(user, scripts)
	user << browse(build_page(), "window=[window_id];[window_size][window_options]")
	if (use_onclose)
		setup_onclose()

/datum/browser/proc/setup_onclose()
	set waitfor = 0 //winexists sleeps, so we don't need to.
	for (var/i in 1 to 10)
		if (user && winexists(user, window_id))
			onclose(user, window_id, owner)
			break

/datum/browser/proc/close()
	if(!isnull(window_id))//null check because this can potentially nuke goonchat
		user << browse(null, "window=[window_id]")
	else
		WARNING("Browser [title] tried to close with a null ID")

/datum/browser/modal/preflikepicker
	var/settings = list()
	var/icon/preview_icon = null
	var/datum/callback/preview_update

/datum/browser/modal/preflikepicker/New(User,Message,Title,Button1="Ok",Button2,Button3,StealFocus = 1, Timeout = FALSE,list/settings,inputtype="checkbox", width = 600, height, slidecolor)
	if (!User)
		return
	src.settings = settings

	..(User, ckey("[User]-[Message]-[Title]-[world.time]-[rand(1,10000)]"), Title, width, height, src, StealFocus, Timeout)
	set_content(ShowChoices(User))

/datum/browser/modal/preflikepicker/proc/ShowChoices(mob/user)
	if (settings["preview_callback"])
		var/datum/callback/callback = settings["preview_callback"]
		preview_icon = callback.Invoke(settings)
		if (preview_icon)
			user << browse_rsc(preview_icon, "previewicon.png")
	var/dat = ""

	for (var/name in settings["mainsettings"])
		var/setting = settings["mainsettings"][name]
		if (setting["type"] == "datum")
			if (setting["subtypesonly"])
				dat += "<b>[setting["desc"]]:</b> <a href='byond://?src=[REF(src)];setting=[name];task=input;subtypesonly=1;type=datum;path=[setting["path"]]'>[setting["value"]]</a><BR>"
			else
				dat += "<b>[setting["desc"]]:</b> <a href='byond://?src=[REF(src)];setting=[name];task=input;type=datum;path=[setting["path"]]'>[setting["value"]]</a><BR>"
		else
			dat += "<b>[setting["desc"]]:</b> <a href='byond://?src=[REF(src)];setting=[name];task=input;type=[setting["type"]]'>[setting["value"]]</a><BR>"

	if (preview_icon)
		dat += "<td valign='center'>"

		dat += "<div class='statusDisplay'><center><img src=previewicon.png width=[preview_icon.Width()] height=[preview_icon.Height()]></center></div>"

		dat += "</td>"

	dat += "</tr></table>"

	dat += "<hr><center><a href='byond://?src=[REF(src)];button=1'>Ok</a> "

	dat += "</center>"

	return dat

/datum/browser/modal/preflikepicker/Topic(href,href_list)
	if (href_list["close"] || !user || !user.client)
		closed = TRUE
		return
	if (href_list["task"] == "input")
		var/setting = href_list["setting"]
		switch (href_list["type"])
			if ("datum")
				var/oldval = settings["mainsettings"][setting]["value"]
				if (href_list["subtypesonly"])
					settings["mainsettings"][setting]["value"] = pick_closest_path(null, make_types_fancy(subtypesof(text2path(href_list["path"]))))
				else
					settings["mainsettings"][setting]["value"] = pick_closest_path(null, make_types_fancy(typesof(text2path(href_list["path"]))))
				if (isnull(settings["mainsettings"][setting]["value"]))
					settings["mainsettings"][setting]["value"] = oldval
			if ("string")
				settings["mainsettings"][setting]["value"] = stripped_input(user, "Enter new value for [settings["mainsettings"][setting]["desc"]]", "Enter new value for [settings["mainsettings"][setting]["desc"]]", settings["mainsettings"][setting]["value"])
			if ("number")
				settings["mainsettings"][setting]["value"] = input(user, "Enter new value for [settings["mainsettings"][setting]["desc"]]", "Enter new value for [settings["mainsettings"][setting]["desc"]]") as num
			if ("color")
				settings["mainsettings"][setting]["value"] = input(user, "Enter new value for [settings["mainsettings"][setting]["desc"]]", "Enter new value for [settings["mainsettings"][setting]["desc"]]", settings["mainsettings"][setting]["value"]) as color
			if ("boolean")
				settings["mainsettings"][setting]["value"] = input(user, "[settings["mainsettings"][setting]["desc"]]?") in list("Yes","No")
			if ("ckey")
				settings["mainsettings"][setting]["value"] = input(user, "[settings["mainsettings"][setting]["desc"]]?") in list("none") + GLOB.directory
		if (settings["mainsettings"][setting]["callback"])
			var/datum/callback/callback = settings["mainsettings"][setting]["callback"]
			settings = callback.Invoke(settings)
	if (href_list["button"])
		var/button = text2num(href_list["button"])
		if (button <= 3 && button >= 1)
			choice = button
	if (choice != 1)
		set_content(ShowChoices(user))
		open()
		return
	for (var/item in href_list)
		switch(item)
			if ("close", "button", "src")
				continue
	closed = TRUE
	close()

/proc/presentpreflikepicker(mob/User,Message, Title, Button1="Ok", Button2, Button3, StealFocus = 1,Timeout = 6000,list/settings, width, height, slidecolor)
	if (!istype(User))
		if (istype(User, /client/))
			var/client/C = User
			User = C.mob
		else
			return
	var/datum/browser/modal/preflikepicker/A = new(User, Message, Title, Button1, Button2, Button3, StealFocus,Timeout, settings, width, height, slidecolor)
	A.open()
	A.wait()
	if (A.choice)
		return list("button" = A.choice, "settings" = A.settings)

// Registers the on-close verb for a browse window (client/verb/.windowclose)
// this will be called when the close-button of a window is pressed.
//
// This is usually only needed for devices that regularly update the browse window,
// e.g. canisters, timers, etc.
//
// windowid should be the specified window name
// e.g. code is	: user << browse(text, "window=fred")
// then use 	: onclose(user, "fred")
//
// Optionally, specify the "ref" parameter as the controlled atom (usually src)
// to pass a "close=1" parameter to the atom's Topic() proc for special handling.
// Otherwise, the user mob's machine var will be reset directly.
//
/proc/onclose(mob/user, windowid, atom/ref=null)
	if(!user.client)
		return
	var/param = "null"
	if(ref)
		param = "[REF(ref)]"

	winset(user, windowid, "on-close=\".windowclose [param]\"")



// the on-close client verb
// called when a browser popup window is closed after registering with proc/onclose()
// if a valid atom reference is supplied, call the atom's Topic() with "close=1"
// otherwise, just reset the client mob's machine var.
//
/client/verb/windowclose(atomref as text)
	set hidden = 1						// hide this verb from the user's panel
	set name = ".windowclose"			// no autocomplete on cmd line

	if(atomref!="null")				// if passed a real atomref
		var/hsrc = locate(atomref)	// find the reffed atom
		var/href = "close=1"
		if(hsrc)
			usr = src.mob
			src.Topic(href, params2list(href), hsrc)	// this will direct to the atom's
			return										// Topic() proc via client.Topic()

	// no atomref specified (or not found)
	// so just reset the user mob's machine var
	if(src && src.mob)
		src.mob.unset_machine()
