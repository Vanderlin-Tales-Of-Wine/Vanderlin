/obj/effect/proc_holder/spell/invoked/featherfall
	name = "Featherfall"
	desc = "Grant yourself and any creatures adjacent to you some defense against falls."
	cost = 1
	school = "transmutation"
	releasedrain = 50
	chargedrain = 0
	chargetime = 10 SECONDS
	recharge_time = 2 MINUTES
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = TRUE
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	overlay_state = "jump"
	attunements = list(
		/datum/attunement/aeromancy = 0.5,
	)

/obj/effect/proc_holder/spell/invoked/featherfall/cast(list/targets, mob/user = usr)

	user.visible_message("[user] mutters an incantation and a dim pulse of light radiates out from them.")
	var/duration_increase = min(0, attuned_strength * 90 SECONDS)
	for(var/mob/living/L in range(max(1, FLOOR(attuned_strength, 1)), usr))
		L.apply_status_effect(/datum/status_effect/buff/duration_modification/featherfall, duration_increase)

	return TRUE
