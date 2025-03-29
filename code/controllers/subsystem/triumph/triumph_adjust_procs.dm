/proc/adjust_triumphs(datum/key_holder, amount, counted = TRUE, reason)
	if(!key_holder)
		return

	if(!amount)
		return

	if(!ismob(key_holder) && !ismind(key_holder) && !isclient(key_holder))
		return
	var/key = key_holder:key //sorry
	var/ckey = ckey(key)
	if(!key)
		return

	SStriumphs.triumph_adjust(amount, ckey)
	SStriumphs.adjust_leaderboard(key)

	var/adjustment_verb
	if(amount > 0)
		adjustment_verb = "awarded"
		if(counted)
			SSticker.tri_gained += amount
	else
		adjustment_verb = "lost"
		if(counted)
			SSticker.tri_lost += amount

	var/final_text = "[abs(amount)] TRIUMPH\s [adjustment_verb]."
	if(reason)
		final_text += " REASON: [reason]"

	to_chat(key_holder, "<font color='purple'>[final_text]</font>")

/*
	Keep in mind the thing stored on the mind is a key
	Thus we mus convert it to a ckey
*/
/datum/mind/proc/adjust_triumphs(amt, counted = TRUE, reason)
	if(!key)
		return
	call(/proc/adjust_triumphs)(src, amt, counted, reason) //sorry

/client/proc/adjust_triumphs(amt, counted = TRUE, reason)
	call(/proc/adjust_triumphs)(src, amt, counted, reason) //sorry

/mob/proc/adjust_triumphs(amt, counted = TRUE, reason)
	if(!key)
		return
	call(/proc/adjust_triumphs)(src, amt, counted, reason) //sorry
