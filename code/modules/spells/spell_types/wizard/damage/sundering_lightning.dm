/obj/effect/proc_holder/spell/invoked/sundering_lightning
	name = "Sundering Lightning"
	desc = "Summons forth dangerous rapid lightning strikes."
	cost = 8
	releasedrain = 50
	chargedrain = 1
	chargetime = 50
	recharge_time = 50 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = TRUE
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	range = 4
	attunements = list(
		/datum/attunement/electric = 0.9
	)
	overlay_state = "sundering"

/obj/effect/proc_holder/spell/invoked/sundering_lightning/cast(list/targets, mob/user = usr)
	var/turf/T = get_turf(targets[1])
//	var/list/affected_turfs = list()
	playsound(T,'sound/weather/rain/thunder_1.ogg', 80, TRUE)
	T.visible_message(span_boldwarning("The air feels crackling and charged!"))
	sleep(30)
	create_lightning(T)

//meteor storm and lightstorm.
/obj/effect/proc_holder/spell/invoked/sundering_lightning/proc/create_lightning(atom/target)
	if(!target)
		return
	var/turf/targetturf = get_turf(target)
	var/last_dist = 0
	for(var/t in spiral_range_turfs(range, targetturf))
		var/turf/T = t
		if(!T)
			continue
		var/dist = get_dist(targetturf, T)
		if(dist > last_dist)
			last_dist = dist
			sleep(2 + min(range - last_dist, 12) * 0.5) //gets faste
		new /obj/effect/temp_visual/targetlightning(T)


/obj/effect/temp_visual/lightning
	icon = 'icons/effects/32x96.dmi'
	icon_state = "lightning"
	name = "lightningbolt"
	desc = "ZAPP!!"
	layer = FLY_LAYER
	plane = GAME_PLANE_UPPER
	randomdir = FALSE
	duration = 7

/obj/effect/temp_visual/lightning/Initialize(mapload)
	. = ..()
	var/mutable_appearance/MA = mutable_appearance(icon, icon_state, plane = EMISSIVE_PLANE)
	overlays += MA

/obj/effect/temp_visual/targetlightning
	icon = 'icons/effects/effects.dmi'
	icon_state = "trap"
	layer = BELOW_MOB_LAYER
	plane = GAME_PLANE
	light_outer_range = 2
	duration =15
	var/explode_sound = list('sound/misc/explode/incendiary (1).ogg','sound/misc/explode/incendiary (2).ogg')

/obj/effect/temp_visual/targetlightning/Initialize(mapload, list/flame_hit)
	. = ..()
	INVOKE_ASYNC(src, PROC_REF(storm), flame_hit)

/obj/effect/temp_visual/targetlightning/proc/storm(list/flame_hit)	//electroshocktherapy
	var/turf/T = get_turf(src)
	sleep(duration)
	playsound(T,'sound/magic/lightning.ogg', 80, TRUE)
	new /obj/effect/temp_visual/lightning(T)

	for(var/mob/living/L in T.contents)
		L.electrocute_act(50)
		to_chat(L, span_userdanger("You're hit by lightning!!!"))
