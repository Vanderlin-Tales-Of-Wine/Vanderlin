/proc/priority_announce(text, title = "", sound, type , sender_override)
	if(!text)
		return

	var/announcement

	if (title && length(title) > 0)
		announcement += "<h1 class='alert'>[title]</h1>"
//		GLOB.news_network.SubmitArticle(text, "Captain's Announcement", "Station Announcements", null)
/*
	else
		if(!sender_override)
			announcement += "<h1 class='alert'>[command_name()] Update</h1>"
		else
			announcement += "<h1 class='alert'>[sender_override]</h1>"
		if (title && length(title) > 0)
			announcement += "<br><h2 class='alert'>[html_encode(title)]</h2>"

		if(!sender_override)
			if(title == "")
				GLOB.news_network.SubmitArticle(text, "", "Station Announcements", null)
			else
				GLOB.news_network.SubmitArticle(title + "<br><br>" + text, "", "Station Announcements", null)
*/
	announcement += "<br><span class='alert'>[strip_html_simple(text)]</span>"
//	announcement += "<br>"

	var/s = sound(sound)
	for(var/mob/M in GLOB.player_list)
		if(M.can_hear())
			to_chat(M, announcement)
			if(M.client.prefs.toggles & SOUND_ANNOUNCEMENTS)
				if(sound)
					M.playsound_local(M, s, 100)

/proc/minor_announce(message, title = "", alert, html_encode = TRUE)
	if(!message)
		return

	if(html_encode)
		title = html_encode(title)
		message = html_encode(message)

	for(var/mob/M in GLOB.player_list)
		if(M.can_hear())
			to_chat(M, "<span class='big bold'><font color = purple>[title]</font color><BR>[message]</span><BR>")
			if(M.client.prefs.toggles & SOUND_ANNOUNCEMENTS)
				M.playsound_local(M, 'sound/misc/alert.ogg', 100)
