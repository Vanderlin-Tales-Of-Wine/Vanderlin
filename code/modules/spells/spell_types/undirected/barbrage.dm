/datum/action/cooldown/spell/undirected/barbrage
	name = "Rage"
	desc = "Enter a state of martial fervour, increasing offensive capabilities at the cost of making yourself vulnerable."
	button_icon_state = "bcry"
	sound = 'sound/magic/barbroar.ogg'

	antimagic_flags = NONE

	charge_required = FALSE
	cooldown_time = 2 MINUTES
	spell_cost = 0

/datum/action/cooldown/spell/undirected/barbrage/can_cast_spell(feedback)
	. = ..()
	if(!.)
		return

	if(!isliving(owner))
		if(feedback)
			to_chat(owner, span_warning("I can't seem to get angry..."))
		return FALSE

/datum/action/cooldown/spell/undirected/barbrage/cast(mob/living/cast_on)
	. = ..()
	cast_on.emote("rage", forced = TRUE)
	cast_on.apply_status_effect(/datum/status_effect/buff/barbrage)
