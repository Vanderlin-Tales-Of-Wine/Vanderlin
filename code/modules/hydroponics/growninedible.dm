// **********************
// Other harvested materials from plants (that are not food)
// **********************

/obj/item/grown // Grown weapons
	name = "grown_weapon"
	icon = 'icons/obj/hydroponics/harvest.dmi'
	resistance_flags = FLAMMABLE
	var/obj/item/neuFarm/seed/seed = null // type path, gets converted to item on New(). It's safe to assume it's always a seed item.

/obj/item/grown/Initialize(newloc, obj/item/neuFarm/seed/new_seed)
	. = ..()
	create_reagents(50)

	pixel_x = base_pixel_x + rand(-5, 5)
	pixel_y = base_pixel_y + rand(-5, 5)

/obj/item/grown/Destroy()
	if(seed)
		QDEL_NULL(seed)
	return ..()

/obj/item/grown/proc/add_juice()
	if(reagents)
		return 1
	return 0

/obj/item/grown/heating_act()
	return
