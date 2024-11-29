
///WOOD

/datum/crafting_recipe/roguetown/turfs/woodfloor
	name = "wooden floor"
	result = /turf/open/floor/rogue/ruinedwood
	reqs = list(/obj/item/grown/log/tree/small = 1)
	skillcraft = /datum/skill/craft/carpentry
	craftdiff = 0

/datum/crafting_recipe/roguetown/turfs/woodfloor/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor/rogue))
		if(!istype(T, /turf/open/transparent/openspace))
			return
	return TRUE

/datum/crafting_recipe/roguetown/turfs/woodwall
	name = "wooden wall"
	result = /turf/closed/wall/mineral/rogue/wood
	reqs = list(/obj/item/grown/log/tree/small = 2)
	skillcraft = /datum/skill/craft/carpentry

/datum/crafting_recipe/roguetown/turfs/daubwall
	name = "daub wall"
	result = /turf/closed/wall/mineral/rogue/decowood
	reqs = list(/obj/item/grown/log/tree/stick = 3, /obj/item/natural/dirtclod = 2)
	skillcraft = /datum/skill/craft/crafting
	verbage = "build"
	verbage_tp = "builds"

/datum/crafting_recipe/roguetown/turfs/woodwall/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor/rogue))
		return
	return TRUE

/datum/crafting_recipe/roguetown/turfs/woodwindow
	name = "wooden murder hole"
	result = /turf/closed/wall/mineral/rogue/wood/window
	reqs = list(/obj/item/grown/log/tree/small = 2)
	skillcraft = /datum/skill/craft/carpentry

/datum/crafting_recipe/roguetown/turfs/woodwindow/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor/rogue))
		return
	return TRUE

/datum/crafting_recipe/roguetown/turfs/dwoodwall
	name = "dark wood wall"
	result = /turf/closed/wall/mineral/rogue/wooddark
	reqs = list(/obj/item/grown/log/tree/small = 3)
	skillcraft = /datum/skill/craft/carpentry
	craftdiff = 2

/datum/crafting_recipe/roguetown/turfs/dwoodwall/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor/rogue))
		return
	return TRUE

/datum/crafting_recipe/roguetown/turfs/dwoodwindow
	name = "dark wood window"
	result = /turf/closed/wall/mineral/rogue/wooddark/window
	reqs = list(/obj/item/grown/log/tree/small = 3)
	skillcraft = /datum/skill/craft/carpentry
	craftdiff = 2

/datum/crafting_recipe/roguetown/turfs/dwoodwindow/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor/rogue))
		return
	return TRUE

/// STONE

/datum/crafting_recipe/roguetown/turfs/stonefloor
	name = "stone floor"
	result = /turf/open/floor/rogue/blocks
	reqs = list(/obj/item/natural/stone = 1)
	verbage = "mason"
	verbage_tp = "masons"
	skillcraft = /datum/skill/craft/masonry
	craftdiff = 0

/datum/crafting_recipe/roguetown/turfs/stonefloor/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor/rogue))
		if(!istype(T, /turf/open/transparent/openspace))
			return
	return TRUE

/datum/crafting_recipe/roguetown/turfs/stonewall
	name = "stone wall"
	result = /turf/closed/wall/mineral/rogue/stone
	reqs = list(/obj/item/natural/stone = 2)
	verbage = "mason"
	verbage_tp = "masons"
	skillcraft = /datum/skill/craft/masonry

/datum/crafting_recipe/roguetown/turfs/stonewall/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor/rogue))
		return
	return TRUE

/datum/crafting_recipe/roguetown/turfs/stonewindow
	name = "stone murder hole"
	result = /turf/closed/wall/mineral/rogue/stone/window
	reqs = list(/obj/item/natural/stone = 2)
	verbage = "mason"
	verbage_tp = "masons"
	skillcraft = /datum/skill/craft/masonry

/datum/crafting_recipe/roguetown/turfs/stonewindow/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor/rogue))
		return
	return TRUE

/datum/crafting_recipe/roguetown/turfs/fancyswall
	name = "decorated stone wall"
	result = /turf/closed/wall/mineral/rogue/decostone
	reqs = list(/obj/item/natural/stone = 3)
	skillcraft = /datum/skill/craft/masonry
	verbage = "mason"
	verbage_tp = "masons"
	craftdiff = 2

/datum/crafting_recipe/roguetown/turfs/fancyswall/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor/rogue))
		return
	return TRUE

/datum/crafting_recipe/roguetown/turfs/craftstone
	name = "craftstone wall"
	result = /turf/closed/wall/mineral/rogue/craftstone
	reqs = list(/obj/item/natural/stone = 3)
	skillcraft = /datum/skill/craft/masonry
	verbage = "mason"
	verbage_tp = "masons"
	craftdiff = 3

/datum/crafting_recipe/roguetown/turfs/fancyswall/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor/rogue))
		return
	return TRUE

/// TWIG AND TENT

/datum/crafting_recipe/roguetown/turfs/twig
	name = "twig floor"
	result = /turf/open/floor/rogue/twig
	reqs = list(/obj/item/grown/log/tree/stick = 2)
	skillcraft = /datum/skill/craft/crafting
	verbage = "assemble"
	verbage_tp = "assembles"
	craftdiff = 0

/datum/crafting_recipe/roguetown/turfs/twig/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor/rogue/dirt))
		if(!istype(T, /turf/open/transparent/openspace))
			if(!istype(T, /turf/open/floor/rogue/grass))
				return
	return TRUE

/datum/crafting_recipe/roguetown/turfs/tentwall
	name = "tent wall"
	result = /turf/closed/wall/mineral/rogue/tent
	reqs = list(/obj/item/grown/log/tree/stick = 1,
				/obj/item/natural/cloth = 1)
	verbage = "set up"
	verbage_tp = "sets up"
	skillcraft = /datum/skill/craft/crafting

/datum/crafting_recipe/roguetown/turfs/tentwall/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor/rogue))
		return
	return TRUE

/datum/crafting_recipe/roguetown/turfs/tentdoor
	name = "tent door"
	result = /obj/structure/roguetent
	reqs = list(/obj/item/grown/log/tree/stick = 1,
				/obj/item/natural/cloth = 1)
	verbage = "set up"
	verbage_tp = "sets up"
	skillcraft = /datum/skill/craft/crafting

/datum/crafting_recipe/roguetown/turfs/tentdoor/TurfCheck(mob/user, turf/T)
	if(isclosedturf(T))
		return
	if(!istype(T, /turf/open/floor/rogue))
		return
	return ..()
