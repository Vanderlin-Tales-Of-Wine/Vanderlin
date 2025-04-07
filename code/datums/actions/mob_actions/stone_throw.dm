/datum/action/cooldown/mob_cooldown/stone_throw
	name = "Stone Throw"
	button_icon = 'icons/effects/effects.dmi'
	button_icon_state = "explosion"
	desc = "Chucks a stone at someone"
	cooldown_time = 15 SECONDS
	check_flags = null

/datum/action/cooldown/mob_cooldown/stone_throw/Activate(atom/target)
	chuck_stone(target)
	StartCooldown()
	return TRUE

/datum/action/cooldown/mob_cooldown/stone_throw/proc/chuck_stone(atom/target)
	if(!target)
		return
	owner.visible_message(span_boldwarning("[owner] chucks a huge stone rock!"))
	playsound(owner.loc, 'sound/combat/shieldraise.ogg', 100)
	var/turf/target_turf = get_turf(target)
	new /obj/effect/temp_visual/target/orcthrow(target_turf)


/obj/effect/temp_visual/stone_throw
	icon = 'icons/roguetown/items/natural.dmi'
	icon_state = "stonebig1"
	name = "stone"
	desc = "You should scram..."
	layer = FLY_LAYER
	plane = GAME_PLANE_UPPER
	randomdir = FALSE
	duration = 1 SECONDS
	pixel_z = 270

/obj/effect/temp_visual/stone_throw/Initialize(mapload, incoming_duration = 9)
	duration = incoming_duration
	. = ..()
	animate(src, pixel_z = 0, time = duration)

/obj/effect/temp_visual/target/orcthrow
	icon = 'icons/mob/actions/actions_spells.dmi'
	icon_state = "projectile"
	exp_heavy = 1
	exp_light = 3
	exp_fire = 0
	explode_sound = list('sound/misc/explode/bomb.ogg')

/obj/effect/temp_visual/target/orcthrow/fall()
	var/turf/hit_turf = get_turf(src)
	new /obj/effect/temp_visual/stone_throw(hit_turf, duration)
	sleep(duration)
	if(ismineralturf(hit_turf))
		var/turf/closed/mineral/rock_turf = hit_turf
		rock_turf.gets_drilled()
	for(var/mob/living/mob in hit_turf.contents)
		mob.take_overall_damage(30)
		to_chat(mob, span_userdanger("You're hit by a big rock!"))
	explosion(hit_turf, -1, exp_heavy, exp_light, exp_flash, 0, flame_range = exp_fire, hotspot_range = exp_hotspot, soundin = explode_sound)
