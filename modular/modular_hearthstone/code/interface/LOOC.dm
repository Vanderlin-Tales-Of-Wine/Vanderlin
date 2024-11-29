/datum/keybinding/looc
	category = CATEGORY_CLIENT
	weight = WEIGHT_HIGHEST
	hotkey_keys = list("U")
	name = "LOOC"
	full_name = "LOOC Chat"
	description = "Local OOC Chat."

/datum/keybinding/looc/down(client/user)
	user.get_looc()
	return TRUE

/client/proc/get_looc()
	var/msg = input(src, null, "looc \"text\"") as text|null
	do_looc(msg)

/client/verb/looc(msg as text)
	set name = "LOOC"
	set desc = "Local OOC, seen only by those in view."
	set category = "OOC"

	do_looc(msg)

/client/proc/do_looc(msg as text)

	if(GLOB.say_disabled)	//This is here to try to identify lag problems
		to_chat(usr, "<span class='danger'> Speech is currently admin-disabled.</span>")
		return

	if(!mob)
		return

	msg = copytext_char(sanitize(msg), 1, MAX_MESSAGE_LEN)
	if(!msg)
		return

	if(!(prefs.chat_toggles & CHAT_OOC))
		to_chat(src, "<span class='danger'> You have OOC muted.</span>")
		return

	if(!holder)
		if(findtext(msg, "byond://"))
			to_chat(src, "<B>Advertising other servers is not allowed.</B>")
			log_admin("[key_name(src)] has attempted to advertise in LOOC: [msg]")
			return


	msg = emoji_parse(msg)

	mob.log_talk(msg, LOG_LOOC)

	var/prefix = "LOOC"
	for(var/mob/M in range(7,src))
		var/client/C = M.client
		if(!M.client)
			continue
		if (isobserver(M))
			continue //Also handled later.

		if(C.prefs.chat_toggles & CHAT_OOC)
			to_chat(C, "<font color='["#6699CC"]'><b><span class='prefix'>[prefix]:</span> <EM>[src.mob.name]:</EM> <span class='message'>[msg]</span></b></font>")

	for(var/client/C in GLOB.admins)
		to_chat(C, "<font color='["#6699CC"]'><b><span class='prefix'>[prefix]:</span> <EM>[src.mob.name]([src.mob.ckey]):</EM> <span class='message'>[msg]</span></b></font>")

	to_chat(usr, "<font color='["#6699CC"]'><b><span class='prefix'>[prefix]:</span> <EM>[src.mob.name]:</EM> <span class='message'>[msg]</span></b></font>")
