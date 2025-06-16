/obj/effect/proc_holder/spell/invoked/gravity // to do: get scroll icon
	name = "Gravity"
	desc = "Weighten space around someone, crushing them and knocking them to the floor. Stronger opponets will resist and be made off-balanced."
	cost = 2
	releasedrain = 20
	chargedrain = 1
	chargetime = 7
	recharge_time = 20 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	attunements = list(
		/datum/attunement/dark = 0.6,
	)
	overlay_state = "gravity"
	var/delay = 3
	var/damage = 0 // damage based off your str
	var/area_of_effect = 0

/obj/effect/proc_holder/spell/invoked/gravity/cast(list/targets, mob/user)
	. = ..()
	var/turf/T = get_turf(targets[1])

	for(var/turf/affected_turf in view(area_of_effect, T))
		if(affected_turf.density)
			continue

	for(var/turf/affected_turf in view(area_of_effect, T))
		new /obj/effect/temp_visual/gravity(affected_turf)
		playsound(T, 'modular/modular_azure/sound/gravity.ogg', 80, TRUE, soundping = FALSE)
		for(var/mob/living/L in affected_turf.contents)
			if(L.anti_magic_check())
				visible_message(span_warning("The gravity fades away around you [L]."))  //antimagic needs some testing
				playsound(get_turf(L), 'sound/magic/magic_nulled.ogg', 100)
				return
			if(L.STASTR <= 11)
				L.adjustBruteLoss(30)
				L.Knockdown(5)
				L.Immobilize(5)
				to_chat(L, span_userdanger("You're magically weighed down and lose your footing!"))
			else
				L.OffBalance(10)
				L.adjustBruteLoss(15)
				to_chat(L, span_userdanger("You're magically weighed down, but your strength resists!"))

/obj/effect/temp_visual/gravity
	icon = 'icons/effects/effects.dmi'
	icon_state = "hierophant_squares"
	name = "gravity magic"
	desc = "Get out of the way!"
	randomdir = FALSE
	duration = 3 SECONDS
	layer = MASSIVE_OBJ_LAYER
	light_power = 1
	light_outer_range = 2
	light_color = COLOR_PALE_PURPLE_GRAY
