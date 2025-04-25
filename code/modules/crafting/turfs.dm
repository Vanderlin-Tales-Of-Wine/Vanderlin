
///WOOD

/datum/crafting_recipe/turfs/woodfloor
	name = "wooden floor"
	result = /turf/open/floor/ruinedwood
	reqs = list(/obj/item/grown/log/tree/small = 1)
	skillcraft = /datum/skill/craft/carpentry
	craftdiff = 0

/datum/crafting_recipe/turfs/woodfloor/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor))
		return
	return TRUE

/datum/crafting_recipe/turfs/woodfloor/dark
	name = "wooden floor (dark)"
	result = /turf/open/floor/wood
	craftdiff = 0

/datum/crafting_recipe/turfs/woodplatform
	name = "platform (wood)"
	result = /turf/open/floor/ruinedwood/platform
	reqs = list(/obj/item/natural/wood/plank = 2)
	skillcraft = /datum/skill/craft/carpentry
	craftdiff = 1

/datum/crafting_recipe/turfs/woodplatform/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/transparent/openspace))
		if(!istype(T, /turf/open/water))
			return
	return TRUE

/datum/crafting_recipe/turfs/woodwall
	name = "wooden wall"
	result = /turf/closed/wall/mineral/wood
	reqs = list(/obj/item/grown/log/tree/small = 2)
	skillcraft = /datum/skill/craft/carpentry

/datum/crafting_recipe/turfs/woodwall/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor))
		return
	return TRUE

/datum/crafting_recipe/turfs/woodwindow
	name = "wooden murder hole"
	result = /turf/closed/wall/mineral/wood/window
	reqs = list(/obj/item/grown/log/tree/small = 2)
	skillcraft = /datum/skill/craft/carpentry

/datum/crafting_recipe/turfs/woodwindow/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor))
		return
	return TRUE

/datum/crafting_recipe/turfs/dwoodwall
	name = "dark wood wall"
	result = /turf/closed/wall/mineral/wooddark
	reqs = list(/obj/item/natural/wood/plank = 3)
	skillcraft = /datum/skill/craft/carpentry
	craftdiff = 2

/datum/crafting_recipe/turfs/dwoodwall/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor))
		return
	return TRUE

/datum/crafting_recipe/turfs/dwoodwindow
	name = "dark wood window"
	result = /turf/closed/wall/mineral/wooddark/window
	reqs = list(/obj/item/natural/wood/plank = 3)
	skillcraft = /datum/skill/craft/carpentry
	craftdiff = 2

/datum/crafting_recipe/turfs/dwoodwindow/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor))
		return
	return TRUE

/// STONE

/datum/crafting_recipe/turfs/stonefloor
	name = "stone floor"
	result = /turf/open/floor/cobblerock
	reqs = list(/obj/item/natural/stone = 1)
	verbage = "mason"
	verbage_tp = "masons"
	skillcraft = /datum/skill/craft/masonry
	craftdiff = 0

/datum/crafting_recipe/turfs/stonefloor/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor))
		return
	return TRUE

/datum/crafting_recipe/turfs/stonefloor/cobblestone
	name = "stone floor (cobblestone)"
	result = /turf/open/floor/cobble
	craftdiff = 0

/datum/crafting_recipe/turfs/stonefloor/cobblerock
	name = "stone floor (blocks)"
	result = /turf/open/floor/blocks
	reqs = list(/obj/item/natural/stoneblock = 1)
	craftdiff = 1

/datum/crafting_recipe/turfs/stonefloor/newstone
	name = "stone floor (newstone)"
	result = /turf/open/floor/blocks/newstone
	reqs = list(/obj/item/natural/stoneblock = 1)
	craftdiff = 1

/datum/crafting_recipe/turfs/stonefloor/bluestone
	name = "stone floor (bluestone)"
	result = /turf/open/floor/blocks/bluestone
	reqs = list(/obj/item/natural/stoneblock = 1)
	craftdiff = 1

/datum/crafting_recipe/turfs/stonefloor/herringbone
	name = "stone floor (herringbone)"
	result = /turf/open/floor/herringbone
	reqs = list(/obj/item/natural/stoneblock = 1)
	craftdiff = 2

/datum/crafting_recipe/turfs/stonefloor/hexstone
	name = "stone floor (hexstone)"
	result = /turf/open/floor/hexstone
	reqs = list(/obj/item/natural/stoneblock = 1)
	craftdiff = 2

/datum/crafting_recipe/turfs/stonewall
	name = "stone wall"
	result = /turf/closed/wall/mineral/stone
	reqs = list(/obj/item/natural/stone = 2)
	verbage = "mason"
	verbage_tp = "masons"
	skillcraft = /datum/skill/craft/masonry

/datum/crafting_recipe/turfs/stonewall/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor))
		return
	return TRUE

/datum/crafting_recipe/turfs/stonewindow
	name = "stone murder hole"
	result = /turf/closed/wall/mineral/stone/window
	reqs = list(/obj/item/natural/stone = 2)
	verbage = "mason"
	verbage_tp = "masons"
	skillcraft = /datum/skill/craft/masonry

/datum/crafting_recipe/turfs/stonewindow/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor))
		return
	return TRUE

/datum/crafting_recipe/turfs/stonebrick
	name = "stone wall (stonebrick)"
	result = /turf/closed/wall/mineral/stonebrick
	reqs = list(/obj/item/natural/stoneblock = 2)
	skillcraft = /datum/skill/craft/masonry
	verbage = "mason"
	verbage_tp = "masons"
	craftdiff = 2

/datum/crafting_recipe/turfs/stonebrick/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor))
		return
	return TRUE

/datum/crafting_recipe/turfs/fancyswall
	name = "decorated stone wall"
	result = /turf/closed/wall/mineral/decostone
	reqs = list(/obj/item/natural/stoneblock = 3)
	skillcraft = /datum/skill/craft/masonry
	verbage = "mason"
	verbage_tp = "masons"
	craftdiff = 2

/datum/crafting_recipe/turfs/fancyswall/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor))
		return
	return TRUE

/datum/crafting_recipe/turfs/craftstone
	name = "craftstone wall"
	result = /turf/closed/wall/mineral/craftstone
	reqs = list(/obj/item/natural/stoneblock = 3)
	skillcraft = /datum/skill/craft/masonry
	verbage = "mason"
	verbage_tp = "masons"
	craftdiff = 3

/datum/crafting_recipe/turfs/fancyswall/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor))
		return
	return TRUE

/datum/crafting_recipe/turfs/stoneplatform
	name = "platform (stone)"
	result = /turf/open/floor/blocks/platform
	reqs = list(/obj/item/natural/stoneblock = 2)
	verbage = "mason"
	verbage_tp = "masons"
	skillcraft = /datum/skill/craft/masonry
	craftdiff = 1

/datum/crafting_recipe/turfs/stoneplatform/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/transparent/openspace))
		if(!istype(T, /turf/open/water))
			return
	return TRUE

/// TWIG AND TENT

/datum/crafting_recipe/turfs/twig
	name = "twig floor"
	result = /turf/open/floor/twig
	reqs = list(/obj/item/grown/log/tree/stick = 2)
	skillcraft = /datum/skill/craft/crafting
	verbage = "assemble"
	verbage_tp = "assembles"
	craftdiff = 0

/datum/crafting_recipe/turfs/twig/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor))
		return
	if(!istype(T, /turf/open/transparent/openspace))
		if(!istype(T, /turf/open/floor/grass))
			return
	return TRUE

/datum/crafting_recipe/turfs/twigplatform
	name = "platform (twig)"
	result = /turf/open/floor/twig/platform
	reqs = list(/obj/item/grown/log/tree/stick = 3,
				/obj/item/rope = 1)
	skillcraft = /datum/skill/craft/crafting
	verbage = "assemble"
	verbage_tp = "assembles"
	craftdiff = 1

/datum/crafting_recipe/turfs/twigplatform/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/transparent/openspace))
		return
	return TRUE

/datum/crafting_recipe/turfs/tentwall
	name = "tent wall"
	result = /turf/closed/wall/mineral/tent
	reqs = list(/obj/item/grown/log/tree/stick = 1,
				/obj/item/natural/cloth = 1)
	verbage = "set up"
	verbage_tp = "sets up"
	skillcraft = /datum/skill/craft/crafting

/datum/crafting_recipe/turfs/tentwall/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor))
		return
	return TRUE

/datum/crafting_recipe/turfs/tentdoor
	name = "tent door"
	result = /obj/structure/roguetent
	reqs = list(/obj/item/grown/log/tree/stick = 1,
				/obj/item/natural/cloth = 1)
	verbage = "set up"
	verbage_tp = "sets up"
	skillcraft = /datum/skill/craft/crafting

/datum/crafting_recipe/turfs/tentdoor/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor))
		return
	return ..()

/datum/crafting_recipe/turfs/dirt
	name = "dirt road"
	result = /turf/open/floor/dirt/road
	reqs = list(/obj/item/natural/fibers = 1,
				/obj/item/natural/dirtclod = 3)
	verbage = "spreads out"
	verbage_tp = "spreads out"
	skillcraft = /datum/skill/craft/crafting
	craftdiff = 0

/datum/crafting_recipe/turfs/dirt/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor))
		return
	return ..()

/datum/crafting_recipe/turfs/daubwall
	name = "daub wall"
	result = /turf/closed/wall/mineral/decowood
	reqs = list(/obj/item/grown/log/tree/stick = 3, /obj/item/natural/dirtclod = 2)
	skillcraft = /datum/skill/craft/crafting
	verbage = "build"
	verbage_tp = "builds"

/datum/crafting_recipe/turfs/daubwall/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor))
		return
	return TRUE
