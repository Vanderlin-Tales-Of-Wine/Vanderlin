/obj/structure/plough
	name = "plough"
	desc = "A wooden plough with iron blades to till the earth for crops."
	icon = 'icons/roguetown/misc/plough.dmi'
	icon_state = "plough"
	density = TRUE
	max_integrity = 600
	anchored = FALSE
	climbable = FALSE
	facepull = FALSE
	drag_slowdown = 6
	pixel_x = -12

/obj/structure/plough/Moved(oldLoc, movement_dir)
	. = ..()
	if((dir == WEST) || (dir == EAST))
		if(pulledby)
			user_tries_tilling(pulledby, get_turf(src))

/obj/structure/plough/proc/user_tries_tilling(mob/living/user, turf/location)
	if(istype(location, /turf/open/floor/rogue/grass))
		playsound(location,'sound/items/dig_shovel.ogg', 100, TRUE)
		location.ChangeTurf(/turf/open/floor/rogue/dirt, flags = CHANGETURF_INHERIT_AIR)
		if(user.buckled)
			apply_farming_fatigue(user, 5)
		else
			apply_farming_fatigue(user, 10)
		return
	if(istype(location, /turf/open/floor/rogue/dirt))
		playsound(location,'sound/items/dig_shovel.ogg', 100, TRUE)
		var/obj/structure/soil/soil = get_soil_on_turf(location)
		if(soil)
			soil.user_till_soil(user)
		else
			new /obj/structure/soil(location)
			if(user.buckled)
				apply_farming_fatigue(user, 5)
			else
				apply_farming_fatigue(user, 10)

		return
