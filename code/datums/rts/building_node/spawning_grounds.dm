/obj/effect/building_node/spawning_grounds
	name = "Spawning Grounds"
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "nest"

	var/spawning = FALSE


/obj/effect/building_node/spawning_grounds/override_click(mob/camera/strategy_controller/user)
	if(spawning)
		return FALSE

	spawning = TRUE
	if(!do_after(src, 60 SECONDS, src))
		spawning = FALSE
		return FALSE
	spawning = FALSE
	user.create_new_worker_mob(get_turf(src))
	return TRUE

///THIS IS ACTUALLY USED, DON"T REMOVE IT
/proc/do_atom(atom/movable/user, time = 3 SECONDS, atom/movable/target, uninterruptible = 0,datum/callback/extra_checks = null)
	if(!user || !target)
		return TRUE
	var/user_loc = user.loc

	var/target_loc = target.loc

	var/endtime = world.time+time
	. = TRUE
	while (world.time < endtime)
		stoplag(1)
		if(QDELETED(user) || QDELETED(target))
			. = 0
			break
		if(uninterruptible)
			continue

		if((user.loc != user_loc) || (target.loc != target_loc) || (extra_checks && !extra_checks.Invoke()))
			. = FALSE
			break
