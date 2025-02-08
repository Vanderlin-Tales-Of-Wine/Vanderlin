/obj/structure/water_dam
	name = "water dam"
	desc = "Blocks the flow of water"

	icon = 'icons/roguetown/misc/railing.dmi'
	icon_state = "border"
	alpha = 190
	redstone_structure = TRUE

	var/blocking = FALSE


/obj/structure/water_dam/redstone_triggered(mob/user)
	. = ..()
	toggle_blocking()

/obj/structure/water_dam/proc/toggle_blocking()
	var/turf/open/water/water = get_turf(src)
	if(!istype(water))
		return
	blocking = !blocking
	water.toggle_block_state(dir, blocking)

	if(blocking)
		alpha = 255
	else
		alpha = 190
