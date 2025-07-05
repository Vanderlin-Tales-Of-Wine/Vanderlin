/datum/action/cooldown/spell/undirected/shadow_step
	name = "Shadow Step"
	desc = "Step into the shadows, becoming invisible for a duration."
	sound = 'sound/misc/area.ogg'
	associated_skill = /datum/skill/misc/sneaking

	charge_time = 1 SECONDS
	charge_drain = 15
	cooldown_time = 5 MINUTES
	spell_cost = 0

	attunements = list(
		/datum/attunement/dark = 0.4
	)

/datum/action/cooldown/spell/undirected/shadow_step/cast(atom/cast_on)
	. = ..()
	if(!isliving(owner))
		return
	var/mob/living/L = owner
	L.visible_message(
		span_warning("[target] starts to fade into thin air!"),
		span_notice("You start to become invisible!")
	)
	animate(L, alpha = 0, time = 1 SECONDS, easing = EASE_OUT)
	L.apply_status_effect(/datum/status_effect/invisibility, 7 SECONDS)
