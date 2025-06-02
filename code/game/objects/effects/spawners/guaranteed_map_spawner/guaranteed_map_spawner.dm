/// guaranteed to spawn items
/obj/effect/spawner/guaranteed_map_spawner
	icon = 'icons/obj/structures_spawners.dmi'
	icon_state = "map_spawner"
	/// Whether the items should be distributed to offsets 0,1,-1,2,-2,3,-3
	var/fan_out_items = TRUE
	/**
	 * - if listed type - assoc list with key as typepath and value as amount of items to spawn
	 * - if single type - typepath to the item
	*/
	var/atom/movable/spawned
	abstract_type = /obj/effect/spawner/guaranteed_map_spawner

// this will qdel after returning parent value
/obj/effect/spawner/guaranteed_map_spawner/Initialize(mapload, ...)
	. = ..()
	if(!spawned)
		stack_trace("[src.type] has no items to spawn!")
		return
	parse_items()

/obj/effect/spawner/guaranteed_map_spawner/proc/spawn_item(atom/movable/thing_to_spawn)
	var/atom/movable/spawned_thing = new(loc)
	if(fan_out_items)
		spawned_thing.pixel_x += rand(-16, 16)
		spawned_thing.pixel_y += rand(-16, 16)

/obj/effect/spawner/guaranteed_map_spawner/proc/parse_items()
	CRASH("[type] detected at [x], [y], [z], use single or listed subtypes instead!")

/obj/effect/spawner/guaranteed_map_spawner/single
	abstract_type = /obj/effect/spawner/guaranteed_map_spawner/single
	/// amount to spawn of this item, made for mapper varediting simplicity
	var/amount = 1

/obj/effect/spawner/guaranteed_map_spawner/single/parse_items()
	if(islist(spawned))
		CRASH("[type] has a list of items to spawn instead of a single typepath, use the listed subtype if you want to use a list!")
	for(var/i in 1 to amount)
		spawn_item(spawned)

/obj/effect/spawner/guaranteed_map_spawner/listed
	abstract_type = /obj/effect/spawner/guaranteed_map_spawner/listed
	spawned = list()

/obj/effect/spawner/guaranteed_map_spawner/listed/parse_items()
	if(!islist(spawned))
		stack_trace("[type] spawned isn't a list! use the single subtype if you want to spawng only one subtype!")
		spawned = list(spawned)
	for(var/atom/movable/typepath_to_spawn in spawned)
		for(var/i in 1 to spawned[typepath_to_spawn])
			spawn_item(typepath_to_spawn)
