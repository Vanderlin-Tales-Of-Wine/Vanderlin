/// designed as a drop in replacement for alert(); functions the same. (outside of needing User specified)
/proc/tgalert(mob/user, Message, Title, Button1="So be it", Button2, Button3, StealFocus = 1, Timeout = 6000)
	if(!user)
		user = usr

	if(!istype(user))
		if(isclient(user))
			var/client/client = user
			user = client.mob
		else
			return null

	if(isnull(user.client))
		return null

	var/list/buttons = list(Button1)
	if(Button2)
		buttons += Button2
	if(Button3)
		buttons += Button3

	var/datum/browser/modal/alert/alert = new(user, Message, Title, buttons, StealFocus, Timeout)
	alert.open()
	alert.wait()
	if(alert)
		. = alert.selectedbutton
		qdel(alert)

/proc/browser_alert(mob/user, message = "", title, list/buttons = list("So be it"), timeout = 6000, autofocus = TRUE)
	if(!user)
		user = usr

	if(!istype(user))
		if(isclient(user))
			var/client/client = user
			user = client.mob
		else
			return null

	if(isnull(user.client))
		return null

	var/datum/browser/modal/alert/alert = new(user, message, title, buttons, timeout, autofocus)
	alert.open()
	alert.wait()
	if(alert)
		. = alert.selectedbutton
		qdel(alert)

/datum/browser/modal/alert/New(mob/user, message, title, list/buttons, timeout, autofocus)
	if(!user)
		return

	var/list/options = list()
	for(var/button in buttons)
		options += "<a href='byond://?src=[REF(src)];action=choose;choice=[button]'>[button]</a>"

	var/output =  {"
	<center><b>[message]</b></center>
	<br/>
	<div style="display: flex; justify-content: space-between;">
		[options.Join("\n")]
	</div>"}

	..(user, ckey("[user]-[message]-[title]-[world.time]-[rand(1,10000)]"), title, 350, 150, src, autofocus, timeout)
	set_content(output)

/datum/browser/modal/alert/Topic(href,href_list)
	if (href_list["close"] || !user || !user.client)
		opentime = 0
		return
	if (href_list["button"])
		var/button = text2num(href_list["button"])
		if (button <= 3 && button >= 1)
			selectedbutton = button
	opentime = 0
	close()
