/datum/action/cooldown/spell/undirected/command_undead
	name = "Command Undead"
	desc = "Message your undead minions."
	button_icon_state = "raiseskele"
	antimagic_flags = NONE
	sound = 'sound/magic/magnet.ogg'

	invocation = "Zuth'gorash vel'thar dral'oth!"
	invocation_type = INVOCATION_SHOUT

	charge_required = FALSE
	cooldown_time = 15 SECONDS

	var/message

/datum/action/cooldown/spell/undirected/command_undead/before_cast(atom/cast_on)
	. = ..()
	if(. & SPELL_CANCEL_CAST)
		return
	message = browser_input_text(owner, "Speak to your minions!", "LICH", multiline = TRUE)
	if(QDELETED(src) || QDELETED(cast_on) || !can_cast_spell())
		return . | SPELL_CANCEL_CAST
	if(!message)
		reset_cooldown()
		return . | SPELL_CANCEL_CAST

	return TRUE

/datum/action/cooldown/spell/undirected/command_undead/cast(atom/cast_on)
	. = ..()
	var/mob/living/carbon/human/lich_player = owner

	message_admins("[lich_player.real_name], the Lich, commands his minions: [message]")
	lich_player.log_message("[lich_player.real_name], the Lich, commands his minions: [message]", LOG_GAME)

	to_chat(lich_player, span_boldannounce("I command: [message]"))
	for(var/mob/player in lich_player.minions)
		if(player.mind)
			to_chat(player, span_boldannounce("Lich [lich_player.real_name] commands: [message]"))
