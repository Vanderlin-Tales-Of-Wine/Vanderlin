/* HOW TO USE:
add/remove verbs with add_verb(verb_path) & remove_verb(verb_path).
both support lists which are better to use if you're adding/removing multiple verbs at once.
to make verbs appear in the panel. You'll need to set the verb's category to one of ("craft","verb","emotes","gpc","cross","crown","fangs","dead","villain")
and set its desc to what you want the verb to appear as in the statpanel.
*/

/// Duck check to see if text looks like a ckey
/proc/valid_ckey(text)
	var/static/regex/matcher = new (@"^[a-z0-9]{1,30}$")
	return matcher.Find_char(text)

/// Get the client associated with ckey text if it is currently connected
/proc/ckey2client(text)
	RETURN_TYPE(/client)
	if (valid_ckey(text))
		for (var/client/C as anything in GLOB.clients)
			if (C.ckey == text)
				return C

/// Null, or a client if thing is a client, a mob with a client, a connected ckey, or null
/proc/resolve_client(client/thing)
	RETURN_TYPE(/client)
	if (istype(thing))
		return thing
	if (!thing)
		thing = usr
	if (ismob(thing))
		var/mob/M = thing
		return M.client
	return ckey2client(thing)

/client
	var/scrollbarready = 0
	var/statpanel_loaded = FALSE
	var/list/stat_tabs = list()
	var/current_button
	var/list/html_verbs = list()

/typeverb
	var/name as text
	var/desc as text
	var/category as text
	var/hidden as num


/client/proc/add_verbs(path)
	verbs |= path
	mob?.updateStatPanel()


/client/proc/remove_verbs(path)
	verbs -= path
	mob?.updateStatPanel()

/mob/add_verbs(path)
	verbs |= path
	updateStatPanel()

/mob/remove_verbs(path)
	verbs -= path
	updateStatPanel()

/atom/movable/proc/add_verbs(path)
	verbs |= path

/atom/movable/proc/remove_verbs(path)
	verbs -= path

/client/proc/init_panel()
	if(!statpanel_loaded)
		spawn(10)
			init_panel()
		return
	var/list/buttons = list("craft","verb","emotes","gpc","cross","crown","fangs","dead","villain")
	for(var/button in buttons)
		html_verbs.Remove(button)
	mob.updateStatPanel()
	newtext(mob.noteUpdate())
	current_button = "note"

/client/verb/debug_panel()
	init_panel()

/client/verb/ready()
	set hidden = 1
	set name = "doneRsc"

	pigReady = 1
	init_panel()

/client/verb/unready()
	set hidden = 1
	set name = "notdoneRsc"

	pigReady = 0

/mob/dead/new_player/Login()
	..()
	sleep(35)
	if(client)
		client.init_panel()

/mob/Login()
	..()
	client.init_panel()

/mob/living/carbon/human/proc/updateSmalltext()
	if(!client)
		return

	var/list/text = list()
	var/fulltext = ""

	for(var/T in text)
		fulltext += "[T]<br>"

	return fulltext

/proc/generateVerbHtml(verbname = "", displayname = "", number = 1)
	if(number % 2)
		return {"<a href='#' class='verb dim' onclick='window.location = "byond://winset?command=[verbname]"'>[displayname]</a>"}
	return {"<a href='#' class='verb' onclick='window.location = "byond://winset?command=[verbname]"'>[displayname]</a>"}

/proc/generateVerbList(list/verbs = list(), count = 1)
	var/html = ""
	var/counter = count
	for(var/list/L in verbs)
		counter++
		html += generateVerbHtml(L[1], L[2], counter) + "<BR>"

	return html

/client/proc/newtext(newcontent = "", id)
	if(!newcontent || newcontent == "")
		return
	src << output(list2params(list("[newcontent]")), "outputwindow.browser:InputMsg")

/client/proc/changebuttoncontent(idcontent = "", newcontent = "")
	return
	if(!statpanel_loaded)
		return
	src << output(list2params(list("[newcontent]", "[idcontent]")), "outputwindow.browser:changel")

/client/proc/addbutton(newcontent = "", selector = "")
	src << output(list2params(list("[newcontent]", "")), "outputwindow.browser:UpdateDynamicpanel")


/mob/proc/updateStatPanel()
	set waitfor = 0
	if(!client)
		return
	if(!client.statpanel_loaded)
		return

	var/list/buttons = list("options","chrome","verbs","emotes","fangs","dead","craft","gpc","cross","crown","villain","thanati")
	var/list/no_draw = list("options","chrome")
	var/list/new_default_buttons = no_draw
	var/pixelDistancing = 46
	var/buttonTimes = 0
	var/list/stat_verbs = list()
	var/list/verb_list = list()
	verb_list += verbs
	verb_list += client.verbs
	for(var/v in verb_list)
		var/typeverb/new_verb = v
		if(!new_verb)
			continue
		if(!buttons.Find(new_verb.category))
			continue
		if(!istext(new_verb.category))
			continue
		if(new_verb.hidden)
			continue
		if(!stat_verbs[new_verb.category])
			stat_verbs[new_verb.category] = list()
		stat_verbs[new_verb.category] += list(list(new_verb.name, new_verb.desc))

	var/buttonHTML
	var/current_content = FALSE
	for(var/button in buttons)
		var/add_top = buttonTimes < 2 ? 0 : 2
		var/distance = {"margin-top: -[50 - add_top]px; margin-left: [pixelDistancing * buttonTimes]px;"}
		if(stat_verbs[button] || new_default_buttons.Find(button))
			if(!new_default_buttons.Find(button))
				client.html_verbs[button] = "<table><tr><td>" + generateVerbList(stat_verbs[button]) +"</td></tr></table>"
			else if(!client.html_verbs[button])
				client.html_verbs[button] = client.defaultButton(button)
			if(button == client.current_button)
				client.newtext(client.html_verbs[button])
				current_content = TRUE
			if(!no_draw.Find(button))
				if(!buttonTimes)
					buttonHTML += {"<a href="byond://?_src_=stat;buttondynamic=[button]">"} + {"<div style="background-image: url(\'[button].png\'); margin-right: 8px;" id="[button]" class="button"></div></a>"}
				else
					buttonHTML += {"<a href="byond://?_src_=stat;buttondynamic=[button]">"} + {"<div style="background-image: url(\'[button].png\'); [distance]" id="[button]" class="button"></div></a>"}
				buttonTimes++
	if(!current_content)
		client.current_button = "note"
		client.newtext(noteUpdate())
	client.addbutton(buttonHTML, "#dynamicpanel")


/client/proc/optionsUpdate()
	. = "<tr><td>"
	var/list/options = list(list("OOC", "OOC"), list("Adminhelp", "Admin Help"), list(".togglefullscreen", "Toggle Fullscreen"), list("LobbyMusic", "Toggle Lobby Music"), list("FixChat", "Fix chat"))
	if(holder)
		options += list(list("Deadmin", "Deadmin"), list("Readmin", "Readmin"))
	. = "<tr><td>" + generateVerbList(options) + "</td></tr>"


/client/proc/chromeUpdate()
	return "<tr><td>" + generateVerbList(list(list("Slap", "Slap"), list("Nod", "Nod"), list("Praise", "Cross"), list("Hug", "Hug"), list("Bow", "Bow"), list("Scream", "Scream"), list("Whimper", "Whimper"), list("Laugh", "Laugh"), list("Sigh", "Sigh"), list("Clearthroat", "Clear Throat"), list("Collapse", "Collapse"), list("Kiss", "Kiss"), list("LickLips", "Lick Lips"), list("Cough", "Cough"), list("SpitonSomeone", "Spit on Someone"), list("Yawn", "Yawn"), list("Wink", "Wink"), list("Grumble", "Grumble"), list("Cry", "Cry"), list("Hem", "Hem"), list("Smile", "Smile")), 2) + "</td></tr>"

/mob/proc/noteUpdate()
	return

/mob/living/carbon/human/noteUpdate()
	var/newHTML = ""
	newHTML += {"\
	<span class='statstable'><table>\
		<tr>\
			<td><span class = 'ST smaller'>ST: [STASTR] <BR>CO: [STACON] <BR>EN: [STAEND] <BR>SP [STASPD] </span></th>\
			<td><span class = 'ST smaller MINOR'>PE: [STAPER] <BR>IN: [STAINT] <BR>LU: [STALUC] </span></th>\
		</tr>\
	</table></span>"}

	newHTML += "<span class='smallstat'>[src.updateSmalltext()]</span>"

	return newHTML

/mob/proc/verbUpdate()
	return

/mob/dead/new_player/noteUpdate()
	var/newHTML = ""
	var/lobby = ""

	if(SSticker.current_state < GAME_STATE_PLAYING)
		var/time_remaining = SSticker.GetTimeLeft()
		if(time_remaining > 0)
			lobby += "Time To Start: [round(time_remaining/10)]s<br>"
		else if(time_remaining == -10)
			lobby += "Time To Start: DELAYED<br>"
		else
			lobby += "Time To Start: SOON<br>"
		lobby += "Total players ready: [SSticker.totalPlayersReady]<br>"

	lobby += "Time of Day:[GLOB.tod]"

	newHTML += {"<span style='color:#600; font-weight:bold;'>[lobby]</span>"}
	return newHTML

/mob/dead/observer/noteUpdate()
	var/newHTML = ""
	var/note = ""
	newHTML += {"<span style='color:#600; font-weight:bold;'>[note]</span>"}
	return newHTML

/client/proc/defaultButton(button)
	var/newHTML
	switch(button)
		if("verbs")
			newHTML = {"<table><tr><td>[generateVerbList(list(list("DisguiseVoice", "Disguise Voice"), list("Warn", "Warn"), list("Dance", "Dance"), list("vomit", "Try to Vomit"), list("Pee", "Pee"), list(".asktostop", "Stop")))]</td>"} + {"<td>[generateVerbList(list(list("Notes", "Memories"), list("Pray", "Pray"), list("Clean", "Clean"), list("Masturbate", "Masturbate"), list("Poo", "Poo")), 2)]</td></tr></table>"}
		if("emotes")
			newHTML =  {"<table><tr><td>[generateVerbList(list(list("Slap", "Slap"), list("Nod", "Nod"), list("Praise", "Cross"), list("Hug", "Hug"), list("Bow", "Bow"), list("Scream", "Scream"), list("Whimper", "Whimper"), list("Laugh", "Laugh"), list("Sigh", "Sigh"), list("Clearthroat", "Clear Throat"), list("Collapse", "Collapse")))]</td>"} + {"<td>[generateVerbList(list(list("Kiss", "Kiss"), list("LickLips", "Lick Lips"), list("Cough", "Cough"), list("SpitonSomeone", "Spit on Someone"), list("Yawn", "Yawn"), list("Wink", "Wink"), list("Grumble", "Grumble"), list("Cry", "Cry"), list("Hem", "Hem"), list("Smile", "Smile")), 2)]</td></tr></table>"}
		if("craft")
			newHTML = {"<table><tr><td>[generateVerbList(list(list("Furniture", "Furniture"), list("Cult", "Cult"), list("Items", "Items"), list("Leather", "Leather"), list("Mason", "Mason"), list("Tanning", "Tanning"), list("Signs", "Signs")))]</td><td>[generateVerbList(list(list("Weapons", "Weapons"), list("Other", "Other")), 2)]</td></tr></table>"}
		if("options")
			newHTML = optionsUpdate()
		if("chrome")
			newHTML = chromeUpdate()
	return newHTML

/client/New()
	..()
	if(!holder)
		return
	winset(src, "outputwindow.csay", "is-visible=true")

/mob/living/carbon/human/Login()
	..()
	updateStatPanel()
