/obj/projectile/bullet/reusable
	name = "reusable bullet"
	desc = ""
	ammo_type = /obj/item/ammo_casing/caseless
	impact_effect_type = null

/obj/projectile/bullet/reusable/handle_drop()
	if(ammo_type)
		if(dropped)
			dropped.forceMove(get_turf(src))
		else
			dropped = new ammo_type(get_turf(src))

/obj/projectile/bullet/reusable/on_hit()
	if(!dropped && ammo_type)
		dropped = new ammo_type(src)
	return ..()

/obj/projectile/bullet/reusable/on_range()
	handle_drop()
	return ..()
