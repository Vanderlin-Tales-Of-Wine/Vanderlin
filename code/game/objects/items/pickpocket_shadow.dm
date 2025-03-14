/obj/item/pickpocket_shadow
	// This is a "fake" item, left on the hud until interacted with or used.

/obj/item/pickpocket_shadow/proc/mimic(obj/item/I)
	src.name = I.name
	src.icon = I.icon
	src.icon_state = I.icon_state
	src.color = I.color
	src.appearance = I.appearance

/obj/item/pickpocket_shadow/examine(mob/user)
	to_chat(user, span_danger("Someone took it!"))
	user.emote("gasp")
	if(user.has_flaw(/datum/charflaw/greedy))
		user.add_stress(/datum/stressevent/pickpocketed_greedy)
	else
		user.add_stress(/datum/stressevent/pickpocketed)
	qdel(src)

/obj/item/pickpocket_shadow/pickup(mob/user)
	to_chat(user, span_danger("Someone took it!"))
	if(user.has_flaw(/datum/charflaw/greedy))
		user.add_stress(/datum/stressevent/pickpocketed_greedy)
	else
		user.add_stress(/datum/stressevent/pickpocketed)
	user.emote("gasp")
	qdel(src)
	return ..()
