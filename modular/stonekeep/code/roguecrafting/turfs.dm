/datum/crafting_recipe/roguetown/turfs
	craftdiff = 0
	skillcraft = /datum/skill/craft/crafting

///WOOD

/datum/crafting_recipe/roguetown/turfs/woodfloor
	name = "floor (rough wood)"
	craftdiff = 0

/datum/crafting_recipe/roguetown/turfs/woodwall
	name = "wall (rough wood)"

/datum/crafting_recipe/roguetown/turfs/daubwall
	name = "wall (daub)"

/datum/crafting_recipe/roguetown/turfs/woodwindow
	name = "murder hole (wood)"
	result = /turf/closed/wall/mineral/wood/window

/datum/crafting_recipe/roguetown/turfs/dwoodwall
	name = "wall (dark wood)"
	craftdiff = 2

/datum/crafting_recipe/roguetown/turfs/dwoodwindow
	name = "murderhole (dark wood)"


/datum/crafting_recipe/roguetown/turfs/woodfloorplank
	name = "floor (plank)"
	result = /turf/open/floor/wood
	reqs = list(/obj/item/grown/log/tree/small = 1)
	skillcraft = /datum/skill/craft/carpentry
	craftdiff = 2

/datum/crafting_recipe/roguetown/turfs/woodfloorchevron
	name = "floor (patterned wood)"
	result = /turf/open/floor/ruinedwood/spiral
	reqs = list(/obj/item/grown/log/tree/small = 2)
	skillcraft = /datum/skill/craft/carpentry
	craftdiff = 3


/// STONE
/datum/crafting_recipe/roguetown/turfs/stonefloor
	name = "floor (cobblestone)"
	result = /turf/open/floor/cobble
	reqs = list(/obj/item/natural/stone = 1)
	skillcraft = /datum/skill/craft/masonry
	craftdiff = 0
/datum/crafting_recipe/roguetown/turfs/stonefloor/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor))
		return
	return TRUE

/datum/crafting_recipe/roguetown/turfs/stonefloor/cobblerock
	name = "road (cobblerock)"
	result = /turf/open/floor/cobblerock/alt
/datum/crafting_recipe/roguetown/turfs/stonefloor/cobblerock/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor/dirt))
		if(!istype(T, /turf/open/floor/grass))
			return
	return TRUE

/datum/crafting_recipe/roguetown/turfs/stonefloor/block
	name = "floor (stone block)"
	reqs = list(/obj/item/natural/stoneblock = 1)

/datum/crafting_recipe/roguetown/turfs/stonefloor/herring
	name = "floor (herringstone)"
	result = /turf/open/floor/herringbone
	reqs = list(/obj/item/natural/stoneblock = 1)
	craftdiff = 2


/datum/crafting_recipe/roguetown/turfs/stonewall
	name = "wall (rough stone)"
	result = /turf/closed/wall/mineral/stone
	reqs = list(/obj/item/natural/stone = 2)
/datum/crafting_recipe/roguetown/turfs/stonewall/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor))
		return
	return TRUE

/datum/crafting_recipe/roguetown/turfs/stonewindow
	name = "murder hole (stone)"
	reqs = list(/obj/item/natural/stoneblock = 2)
/datum/crafting_recipe/roguetown/turfs/stonewindow/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor))
		return
	return TRUE

/datum/crafting_recipe/roguetown/turfs/stonewall/brick
	name = "wall (stone brick)"
	result = /turf/closed/wall/mineral/stonebrick
	reqs = list(/obj/item/natural/stoneblock = 2)
	craftdiff = 2
/datum/crafting_recipe/roguetown/turfs/stonewall/brick/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor))
		return
	return TRUE

/datum/crafting_recipe/roguetown/turfs/fancyswall
	name = "wall (decorated stone)"
	reqs = list(/obj/item/natural/stoneblock = 2)
	craftdiff = 3
/datum/crafting_recipe/roguetown/turfs/fancyswall/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor))
		return
	return TRUE

/datum/crafting_recipe/roguetown/turfs/craftstone
	name = "wall (craftstone)"
	reqs = list(/obj/item/natural/stoneblock = 3)
	craftdiff = 4


/// TWIG AND TENT


/datum/crafting_recipe/roguetown/turfs/tentwall
	name = "tent wall"
	result = /turf/closed/wall/mineral/tent

/datum/crafting_recipe/roguetown/turfs/tentdoor
	name = "tent door"
	result = /obj/structure/roguetent

/datum/crafting_recipe/roguetown/turfs/twig
	name = "floor (twig)"
/datum/crafting_recipe/roguetown/turfs/twig/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor/dirt))
		if(!istype(T, /turf/open/floor/grass))
			return
	return TRUE






/* kaizoku ROGTODO
//Abyssariad Walls.
//Tier 'Plank' Abyssariad wall. Making a rough counterpart later.

/datum/crafting_recipe/roguetown/turfs/woodwall/abyssal
	name = "wagoya joinwall"
	result = /turf/closed/wall/mineral/wood/abyssal
	reqs = list(/obj/item/grown/log/tree/small = 2)
	skillcraft = /datum/skill/craft/carpentry
	craftdiff = 1

/datum/crafting_recipe/roguetown/turfs/woodwindow/abyssal
	name = "wagoya murderhole"
	result = /turf/closed/wall/mineral/wood/abyssal/window
	reqs = list(/obj/item/grown/log/tree/small = 2)
	skillcraft = /datum/skill/craft/carpentry
	craftdiff = 1

//Abyssariad Walls.
//Tier 'Stone' Abyssariad wall. Making a Stoneblock counterpart later.

/datum/crafting_recipe/roguetown/turfs/stonewall/abyssal
	name = "ishigaki wall"
	result = /turf/closed/wall/mineral/stone
	reqs = list(/obj/item/natural/stone = 2)
	skillcraft = /datum/skill/craft/masonry
	craftdiff = 1

/datum/crafting_recipe/roguetown/turfs/stonewindow/abyssal
	name = "ishigaki murderhole"
	result = /turf/closed/wall/mineral/stone/window
	reqs = list(/obj/item/natural/stoneblock = 2)
	skillcraft = /datum/skill/craft/masonry
	craftdiff = 1
*/
