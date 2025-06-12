/obj/effect/proc_holder/spell/invoked/meteor_storm
	name = "Meteor storm"
	desc = "Summons forth dangerous meteors from the sky to scatter and smash foes."
	cost = 8
	releasedrain = 110
	chargedrain = 1
	chargetime = 25 SECONDS
	recharge_time = 50 SECONDS
	warnie = "spellwarning"
	no_early_release = TRUE
	movement_interrupt = TRUE
	charging_slowdown = 2
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	attunements = list(
		/datum/attunement/fire = 1.2
	)
	overlay_state = "fireball_greater"

/obj/effect/proc_holder/spell/invoked/meteor_storm/cast(list/targets, mob/user = usr)
	var/turf/T = get_turf(targets[1])
//	var/list/affected_turfs = list()
	playsound(T,'sound/magic/meteorstorm.ogg', 80, TRUE)
	sleep(2)
	spawn(0)
		create_meteors(T)
	return TRUE

/obj/effect/proc_holder/spell/invoked/meteor_storm/set_attuned_strength(list/incoming_attunements)
	var/total_value = 1
	for(var/datum/attunement/attunement as anything in attunements)
		if(istype(attunement, /datum/attunement/blood))
			total_value -= incoming_attunements[attunement] * 0.5
		if(!(attunement in incoming_attunements))
			continue
		total_value += incoming_attunements[attunement] - attunements[attunement]

	attuned_strength = total_value
	attuned_strength = max(attuned_strength, 0.5)
	return

//meteor storm and lightstorm.
/obj/effect/proc_holder/spell/invoked/meteor_storm/proc/create_meteors(atom/target)
	if(!target)
		return
	target.visible_message(span_boldwarning("Fire rains from the sky!"))
	var/turf/targetturf = get_turf(target)
	var/value = 20 * attuned_strength
	while(value > 0)
		for(var/turf/turf as anything in RANGE_TURFS(6,targetturf))
			if(prob(min(20, value)))
				new /obj/effect/temp_visual/target(turf)
		value -= 100
		sleep(rand(15, 25))

/obj/effect/temp_visual/fireball
	icon = 'icons/obj/projectiles.dmi'
	icon_state = "meteor"
	name = "meteor"
	desc = "Get out of the way!"
	layer = FLY_LAYER
	plane = GAME_PLANE_UPPER
	randomdir = FALSE
	duration = 9
	pixel_z = 270

/obj/effect/temp_visual/fireball/Initialize(mapload, incoming_duration = 9)
	duration = incoming_duration
	. = ..()
	animate(src, pixel_z = 0, time = duration)

/obj/effect/temp_visual/target
	icon = null
	icon_state = null
	layer = BELOW_MOB_LAYER
	plane = GAME_PLANE
	light_outer_range = 2
	duration = 9
	var/exp_heavy = 0
	var/exp_light = 3
	var/exp_flash = 0
	var/exp_fire = 3
	var/exp_hotspot = 0
	var/explode_sound = list('sound/misc/explode/incendiary (1).ogg','sound/misc/explode/incendiary (2).ogg')

/obj/effect/temp_visual/target/Initialize(mapload, list/flame_hit)
	duration = rand(9, 15)
	. = ..()
	INVOKE_ASYNC(src, PROC_REF(fall), flame_hit)

/obj/effect/temp_visual/target/proc/fall(list/flame_hit)	//Potentially minor explosion at each impact point
	var/turf/T = get_turf(src)
	playsound(T,'sound/magic/meteorstorm.ogg', 80, TRUE)
	new /obj/effect/temp_visual/fireball(T, duration)
	sleep(duration)
	if(ismineralturf(T))
		var/turf/closed/mineral/M = T
		M.gets_drilled()
	new /obj/effect/hotspot(T)
	for(var/mob/living/L in T.contents)
		if(islist(flame_hit) && !flame_hit[L])
			L.adjustFireLoss(40)
			L.adjust_fire_stacks(8)
			L.IgniteMob()
			to_chat(L, span_userdanger("You're hit by a meteor!"))
			flame_hit[L] = TRUE
		else
			L.adjustFireLoss(10) //if we've already hit them, do way less damage
	explosion(T, -1, exp_heavy, exp_light, exp_flash, 0, flame_range = exp_fire, hotspot_range = exp_hotspot, soundin = explode_sound)
