/datum/action/cooldown/spell/status/frostbite
	name = "Frostbite"
	desc = "Freeze your enemy with an icy blast that does low damage, but reduces the target's Speed for a considerable length of time."
	button_icon_state = "frostbite"
	point_cost = 1
	sound = 'sound/magic/whiteflame.ogg'

	attunements = list(
		/datum/attunement/ice = 0.9
	)

	charge_time = 3 SECONDS
	charge_drain = 1
	cooldown_time = 25 SECONDS
	spell_cost = 50

	status_effect

/datum/action/cooldown/spell/status/frostbite/cast(mob/living/cast_on)
	. = ..()
	if(iscarbon(cast_on))
		var/mob/living/carbon/C = cast_on
		C.adjustFireLoss(25)

/datum/status_effect/debuff/frostbite
	id = "frostbite"
	alert_type = /atom/movable/screen/alert/status_effect/debuff/frostbite
	duration = 20 SECONDS
	effectedstats = list(STATKEY_SPD = -2)

/atom/movable/screen/alert/status_effect/debuff/frostbite
	name = "Frostbite"
	desc = "I can feel myself slowing down."
	icon_state = "debuff"
	color = "#00fffb"

/datum/status_effect/debuff/frostbite/on_apply()
	. = ..()
	var/mob/living/target = owner
	var/new_color = "#88BFFF"
	target.add_atom_colour(new_color, TEMPORARY_COLOUR_PRIORITY)
	addtimer(CALLBACK(target, TYPE_PROC_REF(/atom, remove_atom_colour), TEMPORARY_COLOUR_PRIORITY, new_color), 20 SECONDS)
	target.add_movespeed_modifier(MOVESPEED_ID_ADMIN_VAREDIT, update=TRUE, priority=100, multiplicative_slowdown=4, movetypes=GROUND)

/datum/status_effect/debuff/frostbite/on_remove()
	. = ..()
	var/mob/living/target = owner
	target.remove_movespeed_modifier(MOVESPEED_ID_ADMIN_VAREDIT, TRUE)


