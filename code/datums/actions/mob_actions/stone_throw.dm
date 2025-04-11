/datum/action/cooldown/mob_cooldown/stone_throw
	name = "Stone Throw"
	button_icon = 'icons/effects/effects.dmi'
	button_icon_state = "explosion"
	desc = "Chucks a stone at someone"
	cooldown_time = 15 SECONDS
	check_flags = null

/datum/action/cooldown/mob_cooldown/stone_throw/Activate(atom/target)
	prepare_stone()
	addtimer(CALLBACK(src, PROC_REF(chuck_stone), target), 1 SECONDS)
	StartCooldown()
	return TRUE

/datum/action/cooldown/mob_cooldown/stone_throw/proc/prepare_stone(atom/target)
	var/static/list/transforms
	owner.visible_message(span_boldwarning("[owner] digs into the ground for rocks!"))
	playsound(owner,'sound/items/dig_shovel.ogg', 100, TRUE)

	if(!transforms)
		var/matrix/M1 = matrix()
		var/matrix/M2 = matrix()
		var/matrix/M3 = matrix()
		var/matrix/M4 = matrix()
		M1.Translate(-5, 0)
		M2.Translate(0, 2)
		M3.Translate(5, 0)
		M4.Translate(0, -2)
		transforms = list(M1, M2, M3, M4)

	animate(owner, transform=transforms[1], time=2.5 DECISECONDS)
	animate(transform=transforms[2], time= 2.5 DECISECONDS)
	animate(transform=transforms[3], time= 2.5 DECISECONDS)
	animate(transform=transforms[4], time=2.5 DECISECONDS)

/datum/action/cooldown/mob_cooldown/stone_throw/proc/chuck_stone(atom/target)
	if(!target)
		return

	owner.visible_message(span_boldwarning("[owner] chucks a huge stone rock!"))
	playsound(owner.loc, 'sound/combat/shieldraise.ogg', 100)
	var/turf/target_turf = get_turf(target)
	new /obj/effect/temp_visual/target/orcthrow(target_turf)

/datum/action/cooldown/mob_cooldown/stone_throw/proc/post_chuck_stone()

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
