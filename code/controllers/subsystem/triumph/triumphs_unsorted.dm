




/mob/proc/show_triumphs_list()
	return SStriumphs.show_triumph_leaderboard(src.client)

/mob/proc/get_triumphs()
	if(!ckey)
		return
	return SStriumphs.get_triumphs(ckey)

/client/proc/adjusttriumph()
	set category = "GameMaster"
	set name = "Adjust Triumphs"
	var/input = input(src, "how much") as num
	if(mob && input)
		mob.adjust_triumphs(input)





