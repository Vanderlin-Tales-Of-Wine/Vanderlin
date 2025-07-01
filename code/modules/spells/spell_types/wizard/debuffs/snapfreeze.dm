
/obj/effect/proc_holder/spell/invoked/snap_freeze
	name = "Snap Freeze"
	desc = "Freeze the air in a small area in an instant, slowing and mildly damaging those affected."
	cost = 2
	releasedrain = 30
	overlay = 'icons/effects/effects.dmi'
	overlay_state = "snapfreeze"
	chargedrain = 1
	chargetime = 15
	recharge_time = 30 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	attunements = list(
		/datum/attunement/blood = 0.3,
		/datum/attunement/ice = 0.4,
	)
	var/delay = 3
	var/damage = 50 // less then fireball, more then lighting bolt
	var/area_of_effect = 2

/obj/effect/temp_visual/trapice
	icon = 'icons/effects/effects.dmi'
	icon_state = "blueshatter"
	light_power = 1
	light_outer_range = 2
	light_color = "#4cadee"
	duration = 6
	plane = MASSIVE_OBJ_PLANE

/obj/effect/temp_visual/snap_freeze
	icon = 'icons/effects/effects.dmi'
	icon_state = "shieldsparkles"
	name = "rippeling arcyne ice"
	desc = "Get out of the way!"
	randomdir = FALSE
	duration = 1 SECONDS
	plane = MASSIVE_OBJ_PLANE

/obj/effect/proc_holder/spell/invoked/snap_freeze/cast(list/targets, mob/user)
	. = ..()
	var/turf/T = get_turf(targets[1])

	for(var/turf/affected_turf in view(area_of_effect, T))
		if(affected_turf.density)
			continue
		new /obj/effect/temp_visual/trapice(affected_turf)
	playsound(T, 'sound/combat/wooshes/blunt/wooshhuge (2).ogg', 80, TRUE, soundping = TRUE) // it kinda sounds like cold wind idk

	sleep(delay)
	var/play_cleave = FALSE

	for(var/turf/affected_turf in view(area_of_effect, T))
		new /obj/effect/temp_visual/snap_freeze(affected_turf)
		for(var/mob/living/L in affected_turf.contents)
			if(L.anti_magic_check())
				visible_message(span_warning("The ice fades away around you. [L] "))  //antimagic needs some testing
				playsound(get_turf(L), 'sound/magic/magic_nulled.ogg', 100)
				return
			play_cleave = TRUE
			L.adjustFireLoss(damage)
			L.apply_status_effect(/datum/status_effect/buff/frostbite5e)
			playsound(affected_turf, "genslash", 80, TRUE)
			to_chat(L, span_userdanger("The air chills your bones!"))

	if(play_cleave)
		playsound(T, 'sound/combat/newstuck.ogg', 80, TRUE, soundping = TRUE) // this also kinda sounds like ice ngl
