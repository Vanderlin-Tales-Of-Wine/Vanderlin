/// A subsystem that handles randomized travel tile location spawning.
SUBSYSTEM_DEF(random_travel_tiles)
	name = "Random Travel Tiles"
	flags = SS_NO_FIRE
	init_order = INIT_ORDER_RANDOM_TILES

/datum/controller/subsystem/random_travel_tiles/Initialize()
	while(length(GLOB.traveltile_spawners) > 0)
		var/obj/effect/spawner/traveltile_spawner/picked_spawner = pick(GLOB.traveltile_spawners)
		picked_spawner.spawn_tiles()
		for(var/obj/effect/spawner/traveltile_spawner/killed_spawner as anything in GLOB.traveltile_spawners)
			if(killed_spawner.travel_tile == picked_spawner.travel_tile)
				qdel(killed_spawner)
	return ..()

