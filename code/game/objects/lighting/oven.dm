

/obj/machinery/light/fueled/oven
	icon = 'icons/roguetown/misc/lighting.dmi'
	name = "oven"
	icon_state = "oven1"
	base_state = "oven"
	density = FALSE
	on = FALSE
	temperature_change = 45
	var/lastsmoke = 0

/obj/machinery/light/fueled/oven/Initialize()
	. = ..()
	AddComponent(/datum/component/storage/concrete/grid/food/cooking/oven)
	AddComponent(/datum/component/container_craft, subtypesof(/datum/container_craft/oven))
	AddComponent(/datum/component/food_burner, 2 MINUTES, TRUE, CALLBACK(src, PROC_REF(can_burn)))

/obj/machinery/light/fueled/oven/attack_hand(mob/living/carbon/human/user)
	. = ..()
	SEND_SIGNAL(src, COMSIG_TRY_STORAGE_SHOW, user, TRUE)

/obj/machinery/light/fueled/oven/proc/can_burn()
	if(on)
		return TRUE
	return FALSE

/obj/machinery/light/fueled/oven/OnCrafted(dirin, mob/user)
	dir = turn(dirin, 180)
	pixel_x = base_pixel_x
	pixel_y = base_pixel_y
	switch(dir)
		if(SOUTH)
			pixel_y += 32
		if(NORTH)
			pixel_y -= 32
		if(WEST)
			pixel_x += 32
		if(EAST)
			pixel_x -= 32
	return ..()

/obj/machinery/light/fueled/oven/Crossed(atom/movable/AM, oldLoc)
	return

/obj/machinery/light/fueled/oven/south
	dir = SOUTH
	SET_BASE_PIXEL(0, 32)

/obj/machinery/light/fueled/oven/west
	dir = WEST
	SET_BASE_PIXEL(32, 0)

/obj/machinery/light/fueled/oven/east
	dir = EAST
	SET_BASE_PIXEL(-32, 0)

/obj/machinery/light/fueled/oven/Initialize()
	. = ..()
	update_overlays()

/obj/machinery/light/fueled/oven/update_icon()
	icon_state = "[base_state][on]"

/obj/machinery/light/fueled/oven/update_overlays()
	. = ..()
	underlays.Cut()
	for(var/obj/item/I in contents)
		I.pixel_x = I.base_pixel_x
		I.pixel_y = I.base_pixel_y
		var/mutable_appearance/M = mutable_appearance(I.icon, I.icon_state)
		M.color = I.color
		M.transform *= 0.5
		M.pixel_y = rand(-2,4) // WHY WOULD YOU WANT TO HIDE THE ENTIRE SPRITE?? Fixed now
		M.layer = 4.24
		underlays += M
	var/mutable_appearance/M = mutable_appearance(icon, "oven_under")
	M.layer = 4.23
	underlays += M
