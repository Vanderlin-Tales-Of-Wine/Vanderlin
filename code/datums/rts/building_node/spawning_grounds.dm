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
		return FALSE
	user.create_new_worker_mob(get_turf(src))
	return TRUE
