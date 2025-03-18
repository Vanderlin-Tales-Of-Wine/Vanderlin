/proc/get_triumph_amount(ckey)
	return SStriumphs.get_triumphs(ckey)

/proc/check_triumphs_menu(ckey)
	if(!fexists("data/player_saves/[copytext(ckey,1,2)]/[ckey]/preferences.sav"))
		to_chat(usr, "<span class='boldwarning'>User does not exist.</span>")
	var/popup_window_data = "<center>[ckey]</center>"
	popup_window_data += "<center>Triumphs: [get_triumph_amount(ckey)])</center>"
	var/datum/browser/noclose/popup = new(usr, "playertriumphs", "", 390, 320)
	popup.set_content(popup_window_data)
	popup.open()

/mob/proc/show_triumphs_list()
	return SStriumphs.show_triumph_leaderboard(src.client)

/mob/proc/get_triumphs()
	if(!ckey)
		return
	return SStriumphs.get_triumphs(ckey)


