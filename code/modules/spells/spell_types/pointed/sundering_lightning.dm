/datum/action/cooldown/spell/sundering_lightning
	name = "Sundering Lightning"
	desc = "Summons forth dangerous rapid lightning strikes."
	button_icon_state = "sundering"
	sound = 'sound/weather/rain/thunder_1.ogg'

	point_cost = 8
	cast_range = 4
	attunements = list(
		/datum/attunement/electric = 0.9
	)

	charge_time = 5 SECONDS
	charge_drain = 1
	charge_slowdown = 3
	cooldown_time = 2 MINUTES
	spell_cost = 60

/datum/action/cooldown/spell/sundering_lightning/cast(atom/cast_on)
	. = ..()
	addtimer(src, CALLBACK(PROC_REF(create_lightning), get_turf(cast_on)), 3 SECONDS)

/datum/action/cooldown/spell/sundering_lightning/proc/create_lightning(turf/victim)
	var/last_dist = 0
	for(var/turf/T as anything in spiral_range_turfs(4, victim))
		if(T.density)
			continue
		var/dist = get_dist(victim, T)
		if(dist > last_dist)
			last_dist = dist
			sleep(2 + min(4 - last_dist, 12) * 0.5)
		new /obj/effect/temp_visual/lightning(T)
		playsound(T, 'sound/weather/rain/thunder_1.ogg', 80, TRUE)
		for(var/mob/living/L in T)
			L.electrocute_act(50)

/obj/effect/temp_visual/lightning
	name = "lightning bolt"
	icon = 'icons/effects/32x200.dmi'
	icon_state = "lightning"
	light_color = COLOR_PALE_BLUE_GRAY
	light_outer_range = 15
	light_power = 25
	duration = 12
	plane = GAME_PLANE_UPPER
	randomdir = FALSE
	duration = 12

/obj/effect/temp_visual/lightning/Initialize(mapload)
	. = ..()
	add_overlay(mutable_appearance(icon, icon_state, plane = EMISSIVE_PLANE))
