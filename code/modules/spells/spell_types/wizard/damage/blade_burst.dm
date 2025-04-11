/obj/effect/proc_holder/spell/invoked/blade_burst
	name = "Blade Burst"
	desc = "Summon a storm of arcyne force in an area that damages through armor, wounding anything in that location after a delay."
	cost = 2
	releasedrain = 30
	chargedrain = 1
	chargetime = 20
	recharge_time = 10 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = FALSE
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	overlay_state = "blade_burst"
	attunements = list(
		/datum/attunement/earth = 0.4,
	)
	var/delay = 7
	var/damage = 45

/obj/effect/temp_visual/trap
	icon = 'icons/effects/effects.dmi'
	icon_state = "trap"
	light_outer_range =  2
	duration = 7
	layer = ABOVE_ALL_MOB_LAYER //this doesnt render above mobs? it really should

/obj/effect/temp_visual/blade_burst
	icon = 'icons/effects/effects.dmi'
	icon_state = "purplesparkles"
	name = "rippeling arcyne energy"
	desc = "Get out of the way!"
	randomdir = FALSE
	duration = 1 SECONDS
	layer = ABOVE_ALL_MOB_LAYER

/obj/effect/proc_holder/spell/invoked/blade_burst/cast(list/targets, mob/user)
	var/turf/T = get_turf(targets[1])
	var/play_cleave = FALSE
	new /obj/effect/temp_visual/trap(T)
	playsound(T, 'sound/magic/blade_burst.ogg', 80, TRUE, soundping = TRUE)
	sleep(delay)
	new /obj/effect/temp_visual/blade_burst(T)
	for(var/mob/living/L in T.contents)
		var/def_zone = pick(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
		L.apply_damage(damage, BRUTE, def_zone)
		if(prob(33))
			var/obj/item/bodypart/BP = L.get_bodypart(def_zone)
			if(BP)
				BP?.add_wound(/datum/wound/fracture)
		play_cleave = TRUE
		L.adjustBruteLoss(damage)
		playsound(T, "genslash", 80, TRUE)
		to_chat(L, span_userdanger("I'm cut by arcyne force!"))
	if(play_cleave)
		playsound(T,'sound/combat/newstuck.ogg', 80, TRUE, soundping = TRUE)
	return TRUE
