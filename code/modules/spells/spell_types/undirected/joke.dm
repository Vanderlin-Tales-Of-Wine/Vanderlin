/datum/action/cooldown/spell/undirected/joke
	name = "Comedia"
	desc = "Say something funny to someone in high spirits, it will brighten their mood."
	button_icon_state = "comedy"
	antimagic_flags = NONE

	invocation_type = INVOCATION_SHOUT

	charge_drain = FALSE
	cooldown_time = 1 MINUTES

	var/message

/datum/action/cooldown/spell/undirected/joke/before_cast(atom/cast_on)
	. = ..()
	if(. & SPELL_CANCEL_CAST)
		return
	message = browser_input_text(owner, "Say something funny!", "XLYIX")
	if(QDELETED(src) || QDELETED(cast_on) || !can_cast_spell())
		return . | SPELL_CANCEL_CAST
	if(!message)
		reset_cooldown()
		return . | SPELL_CANCEL_CAST

	invocation = message

	return TRUE

/datum/action/cooldown/spell/undirected/joke/cast(atom/cast_on)
	. = ..()
	for(var/mob/living/carbon/C in get_hearers_in_view(DEFAULT_MESSAGE_RANGE, owner))
		if(C.stat > CONSCIOUS)
			continue
		if(C.stress <= 0)
			continue
		addtimer(CALLBACK(src, PROC_REF(reaction), C), rand(2 SECONDS, 2.5 SECONDS))

/datum/action/cooldown/spell/undirected/joke/proc/reaction(mob/living/carbon/cast_on)
	cast_on.add_stress(/datum/stressevent/joke)
	cast_on.emote(pick("laugh", "chuckle", "giggle"), forced = TRUE)
