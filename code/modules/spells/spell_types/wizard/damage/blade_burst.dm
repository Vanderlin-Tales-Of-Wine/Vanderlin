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
		/datum/attunement/earth = 0.5,
	)
	var/delay = 7
	var/damage = 45

/obj/effect/proc_holder/spell/invoked/blade_burst/set_attuned_strength(list/incoming_attunements)
	var/total_value = 1
	for(var/datum/attunement/attunement as anything in attunements)
		if(!(attunement in incoming_attunements))
			continue
		total_value += incoming_attunements[attunement] * attunements[attunement]
	attuned_strength = total_value
	attuned_strength = max(attuned_strength, 0.5)
	return

/obj/effect/proc_holder/spell/invoked/blade_burst/cast(list/targets, mob/user)
	var/turf/T = get_turf(targets[1])
	var/play_cleave = FALSE
	var/scaled_delay = max(3, round(delay / attuned_strength)) // Faster with higher attunement
	var/scaled_damage = round(damage * attuned_strength)

	new /obj/effect/temp_visual/trap(T)
	playsound(T, 'sound/magic/blade_burst.ogg', 80, TRUE, soundping = TRUE)
	sleep(scaled_delay)
	new /obj/effect/temp_visual/blade_burst(T)
	for(var/mob/living/L in T.contents)
		var/def_zone = pick(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
		L.apply_damage(scaled_damage, BRUTE, def_zone)
		// Higher attunement = higher wound chance
		if(prob(33 * attuned_strength))
			var/obj/item/bodypart/BP = L.get_bodypart(def_zone)
			if(BP)
				BP?.add_wound(/datum/wound/fracture)
		play_cleave = TRUE
		L.adjustBruteLoss(scaled_damage)
		playsound(T, "genslash", 80, TRUE)
		to_chat(L, span_userdanger("I'm cut by arcyne force!"))
	if(play_cleave)
		playsound(T,'sound/combat/newstuck.ogg', 80, TRUE, soundping = TRUE)
	return TRUE

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
