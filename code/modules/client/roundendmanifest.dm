/client/proc/view_rogue_manifest()
	var/dat
	dat += "<h1>Round ID: [GLOB.rogue_round_id]</h1>"
	dat += "<h4>- Inhabitants of [SSmapping.config.map_name] -</h4>"
	for(var/X in GLOB.character_list)
		dat += "[GLOB.character_list[X]]"

	src << browse(dat, "window=manifest;size=387x420;can_close=1")

/client/proc/view_actors_manifest()
	var/dat
	for(var/X in GLOB.actors_list)
		dat += "[GLOB.actors_list[X]]"

	var/datum/browser/popup = new(src, "actors", "<center>The people of [SSmapping.config.map_name]</center>", 387, 420)
	popup.set_content(dat)
	popup.open(FALSE)
