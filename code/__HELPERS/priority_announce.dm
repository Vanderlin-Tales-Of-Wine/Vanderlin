/proc/priority_announce(text, title = "", sound, type , sender_override, list/mob/players)
	if(!text)
		return

	var/announcement

	if(title && length(title) > 0)
		announcement += "<h1 class='alert'>[title]</h1>"
	announcement += "<br><span class='alert'>[strip_html_simple(text)]</span>"

	if(!players)
		players = GLOB.player_list

	var/sound_to_play = sound(sound)
	for(var/mob/target in players)
		if(!isnewplayer(target) && target.can_hear())
			to_chat(target, announcement)
			if((target.client.prefs.toggles & SOUND_ANNOUNCEMENTS) && sound_to_play)
				target.playsound_local(target, sound_to_play, 100)

/proc/minor_announce(message, title = "", alert, html_encode = TRUE, list/mob/players)
	if(!message)
		return

	if(html_encode)
		title = html_encode(title)
		message = html_encode(message)

	if(!players)
		players = GLOB.player_list

	for(var/mob/target in players)
		if(!isnewplayer(target) && target.can_hear())
			to_chat(target, "[span_minorannounce("<font color = purple>[title]</font color><BR>[message]")]<BR>")
			if(target.client.prefs.toggles & SOUND_ANNOUNCEMENTS)
				target.playsound_local(target, 'sound/misc/alert.ogg', 100)
