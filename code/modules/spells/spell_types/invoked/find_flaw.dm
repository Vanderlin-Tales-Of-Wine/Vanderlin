/obj/effect/proc_holder/spell/invoked/find_flaw
	name = "Find Flaw"
	overlay_state = "tragedy"
	range = 7
	invocation_type = "none"
	recharge_time = 30 SECONDS
	antimagic_allowed = TRUE
	uses_mana = FALSE

/obj/effect/proc_holder/spell/invoked/find_flaw/cast(list/targets, mob/user = usr)
	var/mob/living/carbon/human/target = targets[1]
	if(!istype(target))
		return FALSE

	if(target == user)
		to_chat(user, span_warning("You already know your own flaw! Don't you?"))
		return FALSE

	if(target.stat == DEAD)
		to_chat(user, span_warning("This one's biggest flaw is being dead."))
		return FALSE

	if(target.charflaw && !istype(target.charflaw, /datum/charflaw/noflaw) && !istype(target.charflaw, /datum/charflaw/eznoflaw))
		to_chat(user, span_green("You discover [target]'s flaw: <b>[target.charflaw.name]</b>!"))
		SEND_SIGNAL(user, COMSIG_FLAW_FOUND, target.charflaw, target)
	else
		to_chat(user, span_warning("\The [target] has no flaws! How could this be?!"))

	return ..()
