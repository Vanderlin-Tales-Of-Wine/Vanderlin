/obj/effect/proc_holder/spell/invoked/shadowstep
	name = "Shadow Step"
	desc = "Step into the shadows making you invisible for a duration."
	overlay_state = "invisibility"
	releasedrain = 0
	chargedrain = 14
	chargetime = 1 SECONDS
	recharge_time = 60 SECONDS
	range = 3
	warnie = "sydwarning"
	movement_interrupt = FALSE
	sound = 'sound/misc/area.ogg'
	associated_skill = /datum/skill/misc/sneaking
	attunements = list(
		/datum/attunement/dark = 0.4
		)
	cost = 1

/obj/effect/proc_holder/spell/invoked/shadowstep/cast(list/targets, mob/living/user)
	if (isliving(targets[1]))
		var/mob/living/target = targets[1]
		if (target.anti_magic_check(TRUE, TRUE))
			return FALSE
		target.visible_message(
			span_warning("[target] starts to fade into thin air!"),
			span_notice("You start to become invisible!")
		)
		animate(target, alpha = 0, time = 1 SECONDS, easing = EASE_IN)
		target.apply_status_effect(/datum/status_effect/invisibility, 7 SECONDS)
		return TRUE
	revert_cast()
	return FALSE
