/datum/looping_sound/harpoon
	mid_sounds = list('sound/zipline_mid.ogg' = 1) // place holder
	volume = 5

/// Fire a projectile from this atom at another atom
/atom/proc/fire_projectile(projectile_type, atom/target, sound, firer)
	if (!isnull(sound))
		playsound(src, sound, vol = 100, vary = TRUE)

	var/turf/startloc = get_turf(src)
	var/obj/projectile/bullet = new projectile_type(startloc)
	bullet.starting = startloc
	bullet.firer = firer || src
	bullet.fired_from = src
	bullet.yo = target.y - startloc.y
	bullet.xo = target.x - startloc.x
	bullet.original = target
	bullet.preparePixelProjectile(target, src)
	bullet.fire()
	return bullet

/obj/item/harpoon_gun
	name = "harpoon gun"
	desc = "Steam powered harpoon gun, lets you fly around, and subdue outlaws."

	icon = 'icons/obj/harpoon.dmi'
	icon_state = "grapple_gun"

	var/static/mutable_appearance/hook_overlay = new(icon = 'icons/obj/harpoon.dmi', icon_state = "grapple_gun_hooked")

	///is the hook retracted
	var/retracted_hook = TRUE

	///the beam we draw
	var/datum/beam/zipline
	///our user currently ziplining
	var/datum/weakref/harpooner
	///ziplining sound
	var/datum/looping_sound/harpoon/harpoon_sound
	///our stored_launch
	var/atom/stored_launch

/obj/item/harpoon_gun/Initialize(mapload)
	. = ..()
	harpoon_sound = new(src)
	update_overlays()

/obj/item/harpoon_gun/afterattack(atom/target, mob/living/user, proximity)
	. = ..()

	if(isgroundlessturf(target))
		return

	if(target == user || !retracted_hook)
		return

	if(get_dist(user, target) > 9)
		return

	var/turf/attacked_atom = get_turf(target)
	if(isnull(attacked_atom))
		return

	var/list/turf_list = (getline(user, attacked_atom) - get_turf(src))
	for(var/turf/singular_turf as anything in turf_list)
		if(!is_blocked_turf(singular_turf))
			continue
		attacked_atom = singular_turf
		break

	if(user.CanReach(attacked_atom))
		return

	. |= TRUE

	var/atom/bullet = fire_projectile(/obj/projectile/grapple_hook, attacked_atom, 'sound/zipline_fire.ogg')
	zipline = user.Beam(bullet, icon_state = "chain", maxdistance = 9, time = INFINITY)
	retracted_hook = FALSE
	RegisterSignal(bullet, COMSIG_PROJECTILE_SELF_ON_HIT, PROC_REF(on_grapple_hit))
	RegisterSignal(bullet, COMSIG_PARENT_PREQDELETED, PROC_REF(on_grapple_fail))
	harpooner = WEAKREF(user)
	update_overlays()


/obj/item/harpoon_gun/proc/on_grapple_hit(datum/source, atom/movable/firer, atom/target, Angle)
	SIGNAL_HANDLER

	UnregisterSignal(source, list(COMSIG_PROJECTILE_SELF_ON_HIT, COMSIG_PARENT_PREQDELETED))
	QDEL_NULL(zipline)
	var/mob/living/user = harpooner?.resolve()
	if(isnull(user) || isnull(target))
		cancel_hook()
		return

	zipline = user.Beam(target, icon_state = "chain", maxdistance = 9, time = INFINITY)
	RegisterSignal(zipline, COMSIG_PARENT_PREQDELETED, PROC_REF(on_zipline_break))
	RegisterSignal(user, COMSIG_MOVABLE_MOVED, PROC_REF(determine_distance))
	RegisterSignal(user, COMSIG_MOVABLE_PRE_THROW, PROC_REF(apply_throw_traits))
	stored_launch = target

/obj/item/harpoon_gun/attack_self(mob/user)
	. = ..()
	launch_user(stored_launch)
	stored_launch = null

/obj/item/harpoon_gun/proc/on_grapple_fail(datum/source)
	SIGNAL_HANDLER
	cancel_hook()

/obj/item/harpoon_gun/proc/on_zipline_break(datum/source)
	SIGNAL_HANDLER
	zipline = null
	cancel_hook()


/obj/item/harpoon_gun/proc/determine_distance(atom/movable/source)
	SIGNAL_HANDLER

	if(isnull(zipline))
		return
	var/atom/target = zipline.target
	if(isnull(target))
		return
	if(get_dist(source, target) > zipline.max_distance)
		cancel_hook()

/obj/item/harpoon_gun/proc/apply_throw_traits(mob/living/source, list/arguements)
	SIGNAL_HANDLER
	var/atom/target_atom = arguements[1]
	if(isnull(target_atom))
		return
	var/dir_to_turn = Get_Angle(source, target_atom)
	if(dir_to_turn > 175 && dir_to_turn < 190)
		dir_to_turn = 0

/obj/item/harpoon_gun/proc/launch_user(atom/target_atom)
	var/mob/living/my_user = harpooner?.resolve()
	if(isnull(my_user) || isnull(target_atom) || my_user.buckled)
		cancel_hook()
		return
	harpoon_sound.start()
	RegisterSignal(my_user, COMSIG_MOVABLE_IMPACT, PROC_REF(strike_target))
	my_user.throw_at(target = target_atom, range = 9, speed = 0.5, spin = FALSE, callback = CALLBACK(src, PROC_REF(post_land)))

/obj/item/harpoon_gun/proc/strike_target(mob/living/source, mob/living/victim, datum/thrownthing/throwingdatum)
	SIGNAL_HANDLER

	if(!istype(victim))
		return

	victim.apply_damage(20)
	var/turf/target_turf = get_ranged_target_turf(victim, source.dir, 3)
	if(isnull(target_turf))
		return
	victim.throw_at(target = target_turf, speed = 1, spin = TRUE, range = 3)


/obj/item/harpoon_gun/proc/post_land()
	cancel_hook()

/obj/item/harpoon_gun/proc/cancel_hook()
	var/atom/my_zipliner = harpooner?.resolve()
	if(!isnull(my_zipliner))
		UnregisterSignal(my_zipliner, list(COMSIG_MOVABLE_IMPACT, COMSIG_MOVABLE_MOVED, COMSIG_MOVABLE_PRE_THROW))
	QDEL_NULL(zipline)
	harpooner = null
	retracted_hook = TRUE
	harpoon_sound.stop()
	update_overlays()

/obj/item/harpoon_gun/update_overlays()
	. = ..()
	if(retracted_hook)
		. += hook_overlay

/obj/projectile/grapple_hook
	name = "grapple hook"
	icon = 'icons/obj/harpoon.dmi'
	icon_state = "grapple_gun_hook"
	damage = 0
	range = 9
	speed = 0.7
	hitsound = 'sound/zipline_hit.ogg'
