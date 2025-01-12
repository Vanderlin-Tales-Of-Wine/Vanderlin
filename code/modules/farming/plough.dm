/obj/structure/plough
	name = "plough"
	desc = "A wooden plough with iron blades to till the earth for crops."
	icon = 'modular/Neu_Farming/icons/plough_big.dmi'
//	icon = 'modular/Neu_Farming/icons/plough.dmi'
	icon_state = "plough"
	density = TRUE
	max_integrity = 600
	anchored = FALSE
	climbable = FALSE
	facepull = FALSE
	drag_slowdown = 6
	pixel_x = -8

/obj/structure/plough/Moved(oldLoc, movement_dir)
	. = ..()
//	if(pulledby && pulledby.m_intent == MOVE_INTENT_SNEAK) replaced with bigger drag slowdown
	if((dir == WEST) || (dir == EAST))
		if(pulledby)
			user_tries_tilling(pulledby, get_turf(src))

/obj/structure/plough/proc/user_tries_tilling(mob/living/user, turf/location)
	if(istype(location, /turf/open/floor/rogue/grass))
		playsound(location,'sound/items/dig_shovel.ogg', 100, TRUE)
		location.ChangeTurf(/turf/open/floor/rogue/dirt, flags = CHANGETURF_INHERIT_AIR)
		if(user.buckled)
			apply_farming_fatigue(user, 4)
		else
			apply_farming_fatigue(user, 8)
		return
	if(istype(location, /turf/open/floor/rogue/dirt))
		playsound(location,'sound/items/dig_shovel.ogg', 100, TRUE)
		var/obj/structure/soil/soil = get_soil_on_turf(location)
		if(soil)
			soil.user_till_soil(user)
		else
			new /obj/structure/soil(location)
			if(user.buckled)
				apply_farming_fatigue(user, 4)
			else
				apply_farming_fatigue(user, 8)

		return
