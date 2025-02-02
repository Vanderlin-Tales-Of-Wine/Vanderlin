/obj/effect/spawner/roguemap
	icon = 'icons/obj/structures_spawners.dmi'
	///Chance to bother spawning anything
	var/probby = 100
	var/list/spawned		//a list of possible items to spawn e.g. list(/obj/item, /obj/structure, /obj/effect), can be weighted
	var/lootmin = 1		//how many items will be spawned, at least.
	var/lootmax = 1		//how many items will be spawned, at most
	var/lootdoubles = TRUE	//if the same item can be spawned twice
	var/fan_out_items = FALSE //Whether the items should be distributed to offsets 0,1,-1,2,-2,3,-3.. This overrides pixel_x/y on the spawner itself
/obj/effect/spawner/roguemap/proc/do_spawn()
	if(prob(probby))
		var/obj/new_type = pickweight(spawned)
		new new_type(get_turf(src))

/obj/effect/spawner/roguemap/Initialize(mapload)
	..()
	if(!prob(probby))
		return INITIALIZE_HINT_QDEL
	if(spawned && spawned.len > 1)
		var/turf/T = get_turf(src)
		var/loot_spawned = 0
		var/chosenamout = rand(lootmin,lootmax)
		for(var/i in 1 to chosenamout)
			if(!spawned.len)
				break
			var/lootspawn = pickweight(spawned)
			while(islist(lootspawn))
				lootspawn = pickweight(lootspawn)
			if(!lootdoubles)
				spawned.Remove(lootspawn)

			if(lootspawn)
				var/atom/movable/spawned_loot = new lootspawn(T)
				if (!fan_out_items)
					if (pixel_x != 0)
						spawned_loot.pixel_x = pixel_x
					if (pixel_y != 0)
						spawned_loot.pixel_y = pixel_y
				else
					if (loot_spawned)
						spawned_loot.pixel_x = spawned_loot.pixel_y = ((!(loot_spawned%2)*loot_spawned/2)*-1)+((loot_spawned%2)*(loot_spawned+1)/2*1)
			loot_spawned++
	else
		do_spawn()
	return INITIALIZE_HINT_QDEL

/obj/effect/spawner/roguemap/pit
	icon_state = "pit"

/obj/effect/spawner/roguemap/pit/do_spawn()
	var/turf/T = get_turf(src)
	var/turf/below = get_step_multiz(src, DOWN)
	if(below)
		T.ChangeTurf(/turf/open/transparent/openspace)
		below.ChangeTurf(/turf/open/floor/rogue/dirt/road)

/obj/effect/spawner/roguemap/tree
	icon_state = "tree"
	name = "Tree spawner"
	probby = 80
	spawned = list(/obj/structure/flora/roguetree)

/obj/effect/spawner/roguemap/treeorbush
	icon_state = "Treeorbush"
	name = "Tree or bush spawner"
	probby = 50
	spawned = list(/obj/structure/flora/roguetree, /obj/structure/flora/roguegrass/bush_meagre)

/obj/effect/spawner/roguemap/treeorstump
	icon_state = "treeorstump"
	name = "Tree or stump spawner"
	probby = 50
	spawned = list(/obj/structure/flora/roguetree, /obj/structure/table/wood/treestump)

/obj/effect/spawner/roguemap/stump
	icon_state = "stump"
	name = "stump spawner"
	probby = 75
	spawned = list(/obj/structure/table/wood/treestump)

/obj/effect/spawner/roguemap/shroud
	icon_state = "shroud"
	name = "shroud sp"
	probby = 30
	spawned = list(/turf/closed/wall/shroud)

/obj/effect/spawner/roguemap/hauntpile
	icon_state = "hauntpile"
	name = "hauntpile"
	probby = 23
	spawned = list(/obj/structure/bonepile)

/obj/effect/spawner/roguemap/beartrap
	icon_state = "beartrap"
	name = "beartrap"
	probby = 50
	spawned = list(/obj/item/restraints/legcuffs/beartrap/armed/camouflage)

/obj/effect/spawner/roguemap/tallgrass
	icon_state = "grass"
	name = "grass tile loot spawner"
	probby = 75
	spawned = list(/obj/structure/flora/roguegrass/bush_meagre = 10, /obj/structure/flora/roguegrass = 60, /obj/item/natural/stone = 8, /obj/item/natural/rock = 7, /obj/item/grown/log/tree/stick = 3, /obj/structure/closet/dirthole/closed/loot=0.1)

/obj/effect/spawner/roguemap/grass_low
	icon_state = "grass"
	name = "grass tile low loot spawner"
	probby = 50
	spawned = list(/obj/structure/flora/roguegrass/bush_meagre = 5, /obj/structure/flora/roguegrass = 60, /obj/item/natural/stone = 8, /obj/item/natural/rock = 4, /obj/item/grown/log/tree/stick = 2)

