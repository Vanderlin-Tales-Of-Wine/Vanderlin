/*
	Keep in mind the thing stored on the mind is a key
	Thus we mus convert it to a ckey
*/
/datum/mind/proc/adjust_triumphs(amt, counted = TRUE)
	if(!key)
		return
	var/ckeey = ckey(key)
	SStriumphs.triumph_adjust(amt, ckeey)
	SStriumphs.adjust_leaderboard(key)

	if(amt > 0)
		if(counted)
			SSticker.tri_gained += amt
		if(current)
			to_chat(current, "\n<font color='purple'>[amt] TRIUMPH(S) awarded.</font>")
	else if(amt < 0)
		if(counted)
			SSticker.tri_lost += amt
		if(current)
			to_chat(current, "\n<font color='purple'>[amt*-1] TRIUMPH(S) lost.</font>")



/*
	A client will only exist when a client is live
	So we can always get a ckey.
*/
/client/proc/adjust_triumphs(amt, counted = TRUE)
	if(!amt)
		return

	SStriumphs.triumph_adjust(amt, ckey)
	SStriumphs.adjust_leaderboard(key)

	if(amt > 0)
		if(counted)
			SSticker.tri_gained += amt
		to_chat(src, "\n<font color='purple'>[amt] TRIUMPH(S) awarded.</font>")
	else if(amt < 0)
		if(counted)
			SSticker.tri_lost += amt
		to_chat(src, "\n<font color='purple'>[amt*-1] TRIUMPH(S) lost.</font>")

/*
	mobs also got ckeys p simple
*/
/mob/proc/adjust_triumphs(amt, counted = TRUE)
	if(!ckey)
		return
	else
		SStriumphs.triumph_adjust(amt, ckey)
		SStriumphs.adjust_leaderboard(key)

	if(amt > 0)
		if(counted)
			SSticker.tri_gained += amt
		to_chat(src, "\n<font color='purple'>[amt] TRIUMPH(S) awarded.</font>")
	else if(amt < 0)
		if(counted)
			SSticker.tri_lost += amt
		to_chat(src, "\n<font color='purple'>[amt*-1] TRIUMPH(S) lost.</font>")
