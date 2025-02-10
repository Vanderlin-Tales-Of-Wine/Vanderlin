// **********************
// Other harvested materials from plants (that are not food)
// **********************

/obj/item/grown // Grown weapons
	name = "grown_weapon"
	icon = 'icons/obj/hydroponics/harvest.dmi'
	resistance_flags = FLAMMABLE
	var/obj/item/seeds/seed = null // type path, gets converted to item on New(). It's safe to assume it's always a seed item.

/obj/item/grown/Initialize(newloc, obj/item/seeds/new_seed)
	. = ..()
	create_reagents(50)

	if(new_seed)
		seed = new_seed.Copy()
	else if(ispath(seed))
		// This is for adminspawn or map-placed growns. They get the default stats of their seed type.
		seed = new seed()
		seed.adjust_potency(50-seed.potency)

	pixel_x = rand(-5, 5)
	pixel_y = rand(-5, 5)

	if(seed)
		for(var/datum/plant_gene/trait/T in seed.genes)
			T.on_new(src, newloc)

		if(istype(src, seed.product)) // no adding reagents if it is just a trash item
			seed.prepare_result(src)
		transform *= TRANSFORM_USING_VARIABLE(seed.potency, 100) + 0.5
		add_juice()

/obj/item/grown/proc/add_juice()
	if(reagents)
		return 1
	return 0

/obj/item/grown/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(!..()) //was it caught by a mob?
		if(seed)
			for(var/datum/plant_gene/trait/T in seed.genes)
				T.on_throw_impact(src, hit_atom)

/obj/item/grown/heating_act()
	return

/obj/item/grown/on_grind()
	for(var/i in 1 to grind_results.len)
		grind_results[grind_results[i]] = round(seed.potency)


/obj/item/grown/log
	name = "tower-cap log"
	desc = ""
	icon_state = "logs"
	force = 10
	throwforce = 10
	w_class = WEIGHT_CLASS_HUGE
	throw_speed = 2
	throw_range = 3
	attack_verb = list("bashed", "battered", "bludgeoned", "whacked")
	grid_width = 64
	grid_height = 32
	var/plank_name = "wooden planks"
	var/static/list/accepted = typecacheof(list(/*/obj/item/reagent_containers/food/snacks/grown/tobacco,
	/obj/item/reagent_containers/food/snacks/produce/wheat*/))

/obj/item/grown/log/proc/CheckAccepted(obj/item/I)
	return is_type_in_typecache(I, accepted)


/obj/structure/punji_sticks
	name = "punji sticks"
	desc = ""
	icon = 'icons/obj/hydroponics/equipment.dmi'
	icon_state = "punji"
	resistance_flags = FLAMMABLE
	max_integrity = 30
	density = FALSE
	anchored = TRUE

/obj/structure/punji_sticks/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/caltrop, 20, 30, 100, CALTROP_BYPASS_SHOES)
