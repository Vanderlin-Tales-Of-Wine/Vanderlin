/obj/effect/spawner/lootdrop
	icon = 'icons/effects/landmarks_static.dmi'
	icon_state = "random_loot"
	layer = OBJ_LAYER
	var/lootcount = 1		//how many items will be spawned
	var/datum/loot_table/loot			//a list of possible items to spawn e.g. list(/obj/item, /obj/structure, /obj/effect)
	var/fan_out_items = FALSE //Whether the items should be distributed to offsets 0,1,-1,2,-2,3,-3.. This overrides pixel_x/y on the spawner itself

/obj/effect/spawner/lootdrop/Initialize(mapload)
	..()
	if(loot)
		loot = new loot
		for(var/i in 1 to lootcount)
			loot.spawn_loot(loot)
	return INITIALIZE_HINT_QDEL

/obj/effect/spawner/lootdrop/Destroy()
	. = ..()
	QDEL_NULL(loot)
