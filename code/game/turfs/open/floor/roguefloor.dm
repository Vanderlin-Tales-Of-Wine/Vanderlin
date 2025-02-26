/*	..................   Wooden Floors   ................... */
/turf/open/floor/ruinedwood
	icon_state = "wooden_floor"
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_dirt = FALSE
	landsound = 'sound/foley/jumpland/woodland.wav'
//	smooth = SMOOTH_MORE
//	canSmoothWith = list(/turf/closed/mineral, /turf/closed/mineral, /turf/closed/wall/mineral/stonebrick, /turf/closed/wall/mineral/wood, /turf/closed/wall/mineral/wooddark, /turf/closed/wall/mineral/decowood, /turf/closed/wall/mineral/decostone, /turf/closed/wall/mineral/stone, /turf/closed/wall/mineral/stone/moss, /turf/open/floor/cobble, /turf/open/floor/dirt, /turf/open/floor/grass)
	neighborlay = "dirtedge"

/turf/open/floor/ruinedwood/Initialize()
	dir = pick(GLOB.cardinals)
	. = ..()

/turf/open/floor/ruinedwood/turned
	icon_state = "wooden_floort"

/turf/open/floor/ruinedwood/spiral
	icon_state = "weird1"
/turf/open/floor/ruinedwood/spiralfade
	icon_state = "weird3"
/turf/open/floor/ruinedwood/chevron
	icon_state = "weird2"

/*	..................   Darker version   ................... */
/turf/open/floor/ruinedwood/darker // here problem was opposite, too bright wood for bandit lair
	color = "#d9c9b0"
/turf/open/floor/ruinedwood/turned/darker
	color = "#d9c9b0"

/turf/open/floor/tile/kitchen // faded kitchen, too dark floors look bad IMO, this much nicer
	icon_state = "tavern"

/turf/open/floor/twig
	icon_state = "twig"
	footstep = FOOTSTEP_GRASS
	barefootstep = FOOTSTEP_SOFT_BAREFOOT
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_dirt = FALSE
	landsound = 'sound/foley/jumpland/grassland.wav'
	slowdown = 0
	damage_deflection = 6
	max_integrity = 300

/turf/open/floor/twig/Initialize()
	dir = pick(GLOB.cardinals)
	. = ..()

/turf/open/floor/twig/OnCrafted(dirin, mob/user)
	. = ..()
	dir = dirin

/turf/open/floor/wood
	smooth_icon = 'icons/turf/floors/wood.dmi'
	icon_state = "wooden_floor2"
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_dirt = FALSE
	smooth = SMOOTH_MORE
	landsound = 'sound/foley/jumpland/woodland.wav'
	canSmoothWith = list(/turf/open/floor/wood,
						/turf/open/floor/carpet)
	damage_deflection = 8
	max_integrity = 600

/turf/open/floor/wood/nosmooth //these are here so we can put wood floors next to each other but not have them smooth
	icon_state = "wooden_floor"
	smooth = SMOOTH_MORE
	canSmoothWith = list(/turf/open/floor/wood/nosmooth,/turf/open/floor/carpet)


/turf/open/floor/wood/turf_destruction(damage_flag)
	. = ..()
	ScrapeAway(flags = CHANGETURF_INHERIT_AIR)

/turf/open/floor/wood/nosmooth/saiga
	smooth_icon = 'icons/turf/floors/woodalt.dmi'
	canSmoothWith = list(/turf/open/floor/wood/nosmooth/saiga,/turf/open/floor/carpet)

/turf/open/floor/woodturned
	smooth_icon = 'icons/turf/floors/wood_turned.dmi'
	icon_state = "wooden_floor2t"
	smooth = SMOOTH_MORE
	canSmoothWith = list(/turf/open/floor/woodturned,/turf/open/floor/carpet)
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	damage_deflection = 8
	max_integrity = 600

/turf/open/floor/woodturned/turf_destruction(damage_flag)
	. = ..()
	ScrapeAway(flags = CHANGETURF_INHERIT_AIR)

/turf/open/floor/woodturned/nosmooth
	icon_state = "wooden_floort"
	smooth = SMOOTH_MORE
	canSmoothWith = list(/turf/open/floor/woodturned/nosmooth,/turf/open/floor/carpet)

/turf/open/floor/woodturned/nosmooth/saiga
	smooth_icon = 'icons/turf/floors/woodalt_turned.dmi'
	canSmoothWith = list(/turf/open/floor/woodturned/nosmooth/saiga,/turf/open/floor/carpet)

/turf/open/floor/rooftop
	name = "roof"
	icon_state = "roof-arw"
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_dirt = FALSE
	damage_deflection = 8
	max_integrity = 800

/turf/open/floor/rooftop/Initialize()
	. = ..()
	icon_state = "roof"

/turf/open/floor/rooftop/turf_destruction(damage_flag)
	. = ..()
	ScrapeAway(flags = CHANGETURF_INHERIT_AIR)

/turf/open/floor/rooftop/green
	icon_state = "roofg-arw"

/turf/open/floor/rooftop/green/Initialize()
	. = ..()
	icon_state = "roofg"
/*	..................   Grasses   ................... */
/turf/open/floor/grass
	name = "grass"
	desc = "Grass, sodden in mud and bogwater."
	icon_state = "grass"
	layer = MID_TURF_LAYER
	footstep = FOOTSTEP_GRASS
	barefootstep = FOOTSTEP_SOFT_BAREFOOT
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_dirt = FALSE
	landsound = 'sound/foley/jumpland/grassland.wav'
	slowdown = 0
	neighborlay = "grassedge"
	smooth = SMOOTH_TRUE
	canSmoothWith = list(
						/turf/open/floor/snow,
						/turf/open/floor/snow/patchy,
						/turf/open/floor/snow/rough)
	max_integrity = 1200

	spread_chance = 15
	burn_power = 6

/turf/open/floor/grass/Initialize()
	dir = pick(GLOB.cardinals)
//	GLOB.dirt_list += src
	. = ..()

/turf/open/floor/grass/cardinal_smooth(adjacencies)
	smooth(adjacencies)

/turf/open/floor/grass/turf_destruction(damage_flag)
	. = ..()
	ChangeTurf(/turf/open/floor/dirt, flags = CHANGETURF_INHERIT_AIR)

/turf/open/floor/grass/mixyel
	icon_state = "grass_yelmix"
	neighborlay = "grass_yelmixedge"
	canSmoothWith = list(/turf/open/floor/grass,
	/turf/open/floor/snow)

/turf/open/floor/grass/red
	name = "red grass"
	desc = "Grass, ripe with Dendor's blood."
	icon_state = "grass_red"
	neighborlay = "grass_rededge"
	canSmoothWith = list(/turf/open/floor/grass,
	/turf/open/floor/snow)

/turf/open/floor/grass/yel
	name = "yellow grass"
	desc = "Grass, blessed by Astrata's light."
	icon_state = "grass_yel"
	neighborlay = "grass_yeledge"
	canSmoothWith = list(/turf/open/floor/grass,
	/turf/open/floor/snow)

/turf/open/floor/grass/cold
	name = "tundra grass"
	desc = "Grass, frigid and touched by winter."
	icon_state = "grass_cold"
	neighborlay = "grass_coldedge"
	canSmoothWith = list(/turf/open/floor/grass,
	/turf/open/floor/snow)


/*	..................   Snow   ................... */

/turf/open/floor/snow
	name = "snow"
	desc = "A gentle blanket of snow."
	icon_state = "snow"
	layer = MID_TURF_LAYER
	footstep = FOOTSTEP_GRASS
	barefootstep = FOOTSTEP_SOFT_BAREFOOT
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_dirt = FALSE
	landsound = 'sound/foley/jumpland/grassland.wav'
	slowdown = 0
	smooth = SMOOTH_TRUE
	canSmoothWith = list(/turf/open/floor/grass,
						/turf/open/floor/grass/red,
						/turf/open/floor/grass/yel,
						/turf/open/floor/grass/cold,
						/turf/open/floor/snow,
						/turf/open/floor/snow/patchy,
						/turf/open/floor/snow/rough)
	neighborlay = "snowedge"
	spread_chance = 0

/turf/open/floor/snow/Initialize()
	dir = pick(GLOB.cardinals)
	. = ..()

/turf/open/floor/snow/cardinal_smooth(adjacencies)
	smooth(adjacencies)

/turf/open/floor/snow/rough
	name = "rough snow"
	desc = "A rugged blanket of snow."
	icon_state = "snowrough"
	layer = MID_TURF_LAYER
	footstep = FOOTSTEP_GRASS
	barefootstep = FOOTSTEP_SOFT_BAREFOOT
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_dirt = FALSE
	landsound = 'sound/foley/jumpland/grassland.wav'
	slowdown = 0
	smooth = SMOOTH_TRUE
	canSmoothWith = list(/turf/open/floor/grass,
						/turf/open/floor/grass/red,
						/turf/open/floor/grass/yel,
						/turf/open/floor/grass/cold,
						/turf/open/floor/snow,
						/turf/open/floor/snow/patchy,
						/turf/open/floor/snow/rough)
	neighborlay = "snowroughedge"

	spread_chance = 0

/turf/open/floor/snowrough/Initialize()
	dir = pick(GLOB.cardinals)
	. = ..()

/turf/open/floor/snowrough/cardinal_smooth(adjacencies)
	smooth(adjacencies)

/turf/open/floor/snow/patchy
	name = "patchy snow"
	desc = "Half-melted snow revealing the hardy grass underneath."
	icon_state = "snowpatchy_grass"
	layer = MID_TURF_LAYER
	footstep = FOOTSTEP_GRASS
	barefootstep = FOOTSTEP_SOFT_BAREFOOT
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_dirt = FALSE
	landsound = 'sound/foley/jumpland/grassland.wav'
	slowdown = 0
	smooth = SMOOTH_TRUE
	canSmoothWith = list(/turf/open/floor/grass,
						/turf/open/floor/grass/red,
						/turf/open/floor/grass/yel,
						/turf/open/floor/grass/cold,
						/turf/open/floor/snow,
						/turf/open/floor/snow/patchy,
						/turf/open/floor/snow/rough)
	neighborlay = "snowpatchy_grassedge"

/turf/open/floor/snowpatchy/cardinal_smooth(adjacencies)
	smooth(adjacencies)

/*	..................   Dirts   ................... */
/turf/open/floor/dirt/ambush
	name = "dirt"
	desc = "The dirt is pocked with the scars of countless wars."
	icon_state = "dirt"
	layer = MID_TURF_LAYER
	footstep = FOOTSTEP_GRASS
	barefootstep = FOOTSTEP_SOFT_BAREFOOT
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_dirt = FALSE
	landsound = 'sound/foley/jumpland/dirtland.wav'
	slowdown = 2
	smooth = SMOOTH_TRUE
	canSmoothWith = list(/turf/open/floor/grass,
						/turf/open/floor/grass/red,
						/turf/open/floor/grass/yel,
						/turf/open/floor/grass/cold,
						/turf/open/floor/snow,
						/turf/open/floor/snow/patchy,
						/turf/open/floor/snow/rough)
	neighborlay = "dirtedge"
	muddy = FALSE
	bloodiness = 20
	dirt_amt = 3

	spread_chance = 8

/turf/open/floor/dirt
	name = "dirt"
	desc = "The dirt is pocked with the scars of countless wars."
	icon_state = "dirt"
	layer = MID_TURF_LAYER
	footstep = FOOTSTEP_GRASS
	barefootstep = FOOTSTEP_SOFT_BAREFOOT
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_dirt = FALSE
	landsound = 'sound/foley/jumpland/dirtland.wav'
	slowdown = 2
	smooth = SMOOTH_TRUE
	canSmoothWith = list(/turf/open/floor/grass,
						/turf/open/floor/grass/red,
						/turf/open/floor/grass/yel,
						/turf/open/floor/grass/cold,
						/turf/open/floor/snow,
						/turf/open/floor/snow/patchy,
						/turf/open/floor/snow/rough)
	neighborlay = "dirtedge"
	var/muddy = FALSE
	var/bloodiness = 20
	var/obj/structure/closet/dirthole/holie
	var/obj/machinery/crop/planted_crop
	var/dirt_amt = 3
/*
/turf/open/floor/dirt/get_slowdown(mob/user)
	var/returned = slowdown
	for(var/obj/item/I in user.held_items)
		if(I.walking_stick)
			if(!I.wielded)
				var/mob/living/L = user
				if(!L.cmode)
					returned = max(returned-2, 0)
	return returned
*/

/turf/open/floor/dirt/attack_right(mob/user)
	if(isliving(user))
		var/mob/living/L = user
		if(L.stat != CONSCIOUS)
			return
		var/obj/item/I = new /obj/item/natural/dirtclod(src)
		if(L.put_in_active_hand(I))
			L.visible_message("<span class='warning'>[L] picks up some dirt.</span>")
			dirt_amt--
			if(dirt_amt <= 0)
				src.ChangeTurf(/turf/open/floor/dirt/road, flags = CHANGETURF_INHERIT_AIR)
		else
			qdel(I)
	.=..()

/turf/open/floor/dirt/Destroy()
	if(holie)
		QDEL_NULL(holie)
	if(planted_crop)
		QDEL_NULL(planted_crop)
	return ..()


/turf/open/floor/dirt/Crossed(atom/movable/O)
	..()
	if(ishuman(O))
		var/mob/living/carbon/human/H = O
		if(H.shoes)
			var/obj/item/clothing/shoes/S = H.shoes
			if(!S.can_be_bloody)
				return
			var/add_blood = 0
			if(bloodiness >= BLOOD_GAIN_PER_STEP)
				add_blood = BLOOD_GAIN_PER_STEP
			else
				add_blood = bloodiness
			S.bloody_shoes[BLOOD_STATE_MUD] = min(MAX_SHOE_BLOODINESS,S.bloody_shoes[BLOOD_STATE_MUD]+add_blood)
			S.blood_state = BLOOD_STATE_MUD
			update_icon()
			H.update_inv_shoes()
			if(planted_crop)
				planted_crop.crossed_turf()
		if(water_level)
			START_PROCESSING(SSwaterlevel, src)

/turf/open/floor/dirt/cardinal_smooth(adjacencies)
	smooth(adjacencies)

/turf/open/floor/dirt/Initialize()
	dir = pick(GLOB.cardinals)
	. = ..()
	update_water()

/turf/open/floor/dirt/update_water()
	water_level = max(water_level-10,0)
	if(water_level > 10) //this would be a switch on normal tiles
		color = "#95776a"
		if(planted_crop)
			planted_crop.rainedon()
	else
		color = null
	return TRUE

/turf/open/floor/dirt/road/update_water()
	water_level = max(water_level-10,0)
	for(var/D in GLOB.cardinals)
		var/turf/TU = get_step(src, D)
		if(istype(TU, /turf/open/water))
			if(!muddy)
				become_muddy()
			return TRUE //stop processing
	if(water_level > 10) //this would be a switch on normal tiles
		if(planted_crop)
			planted_crop.rainedon()
		if(!muddy)
			become_muddy()
//flood process goes here to spread to other turfs etc
//	if(water_level > 250)
//		return FALSE
	if(muddy)
		if(water_level <= 0)
			water_level = 0
			muddy = FALSE
			slowdown = initial(slowdown)
			icon_state = initial(icon_state)
			name = initial(name)
			footstep = initial(footstep)
			barefootstep = initial(barefootstep)
			clawfootstep = initial(clawfootstep)
			heavyfootstep = initial(heavyfootstep)
	return TRUE

/turf/open/floor/dirt/proc/become_muddy()
	if(!muddy)
		water_level = max(water_level-100,0)
		muddy = TRUE
		icon_state = "mud[rand (1,3)]"
		name = "mud"
		slowdown = 2
		footstep = FOOTSTEP_MUD
		barefootstep = FOOTSTEP_MUD
		heavyfootstep = FOOTSTEP_MUD
		bloodiness = 20

/turf/open/floor/dirt/road
	name = "dirt road"
	desc = "The dirt is pocked with the scars of countless steps."
	icon_state = "road"
	layer = MID_TURF_LAYER
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SOFT_BAREFOOT
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_dirt = FALSE
	landsound = 'sound/foley/jumpland/dirtland.wav'
	smooth = SMOOTH_TRUE
	canSmoothWith = list(/turf/open/floor,
						/turf/closed/mineral,
						/turf/closed/wall/mineral)
	neighborlay = "dirtedge"
	slowdown = 0

/turf/open/floor/dirt/road/attack_right(mob/user)
	return

/turf/open/floor/dirt/road/cardinal_smooth(adjacencies)
	smooth(adjacencies)


/turf/proc/smooth(adjacencies)
	var/list/New
	var/holder

	for(var/A in neighborlay_list)
		cut_overlay("[A]")
		neighborlay_list -= A
	var/usedturf
	if(adjacencies & N_NORTH)
		usedturf = get_step(src, NORTH)
		if(isturf(usedturf))
			var/turf/T = usedturf
			if(neighborlay_override)
				holder = "[neighborlay_override]-n"
				LAZYADD(New, holder)
				neighborlay_list += holder
			else if(T.neighborlay)
				holder = "[T.neighborlay]-n"
				LAZYADD(New, holder)
				neighborlay_list += holder
	if(adjacencies & N_SOUTH)
		usedturf = get_step(src, SOUTH)
		if(isturf(usedturf))
			var/turf/T = usedturf
			if(neighborlay_override)
				holder = "[neighborlay_override]-s"
				LAZYADD(New, holder)
				neighborlay_list += holder
			else if(T.neighborlay)
				holder = "[T.neighborlay]-s"
				LAZYADD(New, holder)
				neighborlay_list += holder
	if(adjacencies & N_WEST)
		usedturf = get_step(src, WEST)
		if(isturf(usedturf))
			var/turf/T = usedturf
			if(neighborlay_override)
				holder = "[neighborlay_override]-w"
				LAZYADD(New, holder)
				neighborlay_list += holder
			else if(T.neighborlay)
				holder = "[T.neighborlay]-w"
				LAZYADD(New, holder)
				neighborlay_list += holder
	if(adjacencies & N_EAST)
		usedturf = get_step(src, EAST)
		if(isturf(usedturf))
			var/turf/T = usedturf
			if(neighborlay_override)
				holder = "[neighborlay_override]-e"
				LAZYADD(New, holder)
				neighborlay_list += holder
			else if(T.neighborlay)
				holder = "[T.neighborlay]-e"
				LAZYADD(New, holder)
				neighborlay_list += holder

	if(New)
		add_overlay(New)
	return New


/turf/open/floor/dirt/road/Initialize()
	dir = pick(GLOB.cardinals)
	for(var/P in subtypesof(/turf/closed/wall/mineral))
		canSmoothWith += P
	for(var/P in subtypesof(/turf/closed/mineral))
		canSmoothWith += P
	for(var/P in subtypesof(/turf/open/floor))
//		if(prob(90))
		if(P == /turf/open/floor/dirt/road)
			continue
		canSmoothWith += P
//	queue_smooth(src)
	. = ..()

/turf/open/floor/underworld/road
	name = "ash"
	desc = "Smells like burnt wood."
	icon_state = "ash"
	layer = MID_TURF_LAYER
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SOFT_BAREFOOT
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_dirt = FALSE
	landsound = 'sound/foley/jumpland/dirtland.wav'
	smooth = SMOOTH_TRUE
	canSmoothWith = list(/turf/open/floor,
						/turf/closed/mineral,
						/turf/closed/wall/mineral)
	slowdown = 0

/turf/open/floor/underworld/road/Initialize()
	. = ..()
	dir = rand(0,8)

/turf/open/floor/underworld/arena
	name = "sandy ash"
	desc = "This has been pranced upon by countless skeletal fighters."
	icon_state = "ash3"
	layer = MID_TURF_LAYER
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SOFT_BAREFOOT
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_dirt = FALSE
	landsound = 'sound/foley/jumpland/dirtland.wav'
	smooth = SMOOTH_TRUE
	canSmoothWith = list(/turf/open/floor,
						/turf/closed/mineral,
						/turf/closed/wall/mineral)
	slowdown = 0

/turf/open/floor/underworld/arena/Initialize()
	. = ..()
	//dir = rand(0,8)   Need to add variants.

/turf/open/floor/underworld/space
	name = "void"
	desc = "The shifting blanket of Necra's realm."
	icon_state = "undervoid"
	layer = MID_TURF_LAYER
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SOFT_BAREFOOT
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_dirt = FALSE
	landsound = 'sound/foley/jumpland/dirtland.wav'
	smooth = SMOOTH_FALSE
	slowdown = 50

/turf/open/floor/underworld/space/sparkle_quiet
	name = "void"
	desc = "The shifting blanket of Necra's realm."
	icon_state = "undervoid2"

/turf/open/floor/underworld/space/quiet
	name = "void"
	desc = "The shifting blanket of Necra's realm."
	icon_state = "undervoid3"

/turf/open/floor/volcanic
	name = "dirt"
	desc = "The dirt is pocked with the scars of tectonic movement."
	icon_state = "lavafloor"
	layer = MID_TURF_LAYER
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SOFT_BAREFOOT
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_dirt = FALSE
	landsound = 'sound/foley/jumpland/dirtland.wav'
	smooth = SMOOTH_TRUE
	canSmoothWith = list(/turf/open/floor/dirt/road,
						/turf/open/floor/dirt)
	neighborlay = "lavedge"

/turf/open/floor/volcanic/Initialize()
	dir = pick(GLOB.cardinals)
	. = ..()

/*	..................   Stone Block Floors   ................... */
/turf/open/floor/blocks
	icon_state = "blocks"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'sound/foley/jumpland/stoneland.wav'
	smooth = SMOOTH_MORE
	canSmoothWith = list(/turf/closed/mineral,
						/turf/closed/mineral,
						/turf/closed/wall/mineral/stonebrick,
						/turf/closed/wall/mineral/wood,
						/turf/closed/wall/mineral/wooddark,
						/turf/closed/wall/mineral/stone,
						/turf/closed/wall/mineral/stone/moss,
						/turf/open/floor/grass,
						/turf/open/floor/grass/red,
						/turf/open/floor/grass/yel,
						/turf/open/floor/grass/cold,
						/turf/open/floor/snow,
						/turf/open/floor/snow/patchy,
						/turf/open/floor/snow/rough)
	damage_deflection = 10
	max_integrity = 2800

/turf/open/floor/blocks/Initialize()
	. = ..()
	dir = pick(GLOB.cardinals)

/turf/open/floor/blocks/stonered
	icon_state = "stoneredlarge"
/turf/open/floor/blocks/stonered/tiny
	icon_state = "stoneredtiny"
/turf/open/floor/blocks/green
	icon_state = "greenblocks"
/turf/open/floor/blocks/bluestone
	icon_state = "bluestone2"
/turf/open/floor/blocks/newstone
	icon_state = "newstone2"
/turf/open/floor/blocks/newstone/alt
	icon_state = "bluestone"

/turf/open/floor/blocks/paving
	icon_state = "paving"
/turf/open/floor/blocks/paving/vert
	icon_state = "paving-t"

/turf/open/floor/greenstone
	icon_state = "greenstone"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'sound/foley/jumpland/stoneland.wav'
	icon = 'icons/turf/greenstone.dmi'

/turf/open/floor/hexstone
	icon_state = "hexstone"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'sound/foley/jumpland/stoneland.wav'
	smooth = SMOOTH_MORE
	canSmoothWith = list(/turf/closed/mineral,
						/turf/open/floor/herringbone,
						/turf/closed/mineral,
						/turf/closed/wall/mineral/stonebrick,
						/turf/closed/wall/mineral/wood,
						/turf/closed/wall/mineral/wooddark,
						/turf/closed/wall/mineral/stone,
						/turf/closed/wall/mineral/stone/moss,
						/turf/open/floor/cobble,
						/turf/open/floor/dirt,
						/turf/open/floor/grass)
	damage_deflection = 10
	max_integrity = 800

/turf/open/floor/hexstone/cardinal_smooth(adjacencies)
	smooth(adjacencies)

/turf/open/floor/hexstone/Initialize()
	. = ..()
	dir = pick(GLOB.cardinals)

/turf/open/floor/hexstone/turf_destruction(damage_flag)
	. = ..()
	ScrapeAway(flags = CHANGETURF_INHERIT_AIR)

/*	..................   Church Floors   ................... */

/turf/open/floor/churchmarble
	icon_state = "church_marble"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'sound/foley/jumpland/stoneland.wav'
	smooth = SMOOTH_MORE
	canSmoothWith = list(/turf/closed/mineral,
						/turf/open/floor/herringbone,
						/turf/closed/mineral,
						/turf/closed/wall/mineral/stonebrick,
						/turf/closed/wall/mineral/wood,
						/turf/closed/wall/mineral/wooddark,
						/turf/closed/wall/mineral/stone,
						/turf/closed/wall/mineral/stone/moss,
						/turf/open/floor/cobble,
						/turf/open/floor/dirt,
						/turf/open/floor/grass)

	damage_deflection = 10
	max_integrity = 800

/turf/open/floor/churchmarble/cardinal_smooth(adjacencies)
	smooth(adjacencies)

/turf/open/floor/churchmarble/Initialize()
	. = ..()
	dir = pick(GLOB.cardinals)

/turf/open/floor/churchmarble/turf_destruction(damage_flag)
	. = ..()
	ScrapeAway(flags = CHANGETURF_INHERIT_AIR)

/turf/open/floor/church
	icon_state = "church"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'sound/foley/jumpland/stoneland.wav'
	smooth = SMOOTH_MORE
	canSmoothWith = list(/turf/closed/mineral,
						/turf/open/floor/herringbone,
						/turf/closed/mineral,
						/turf/closed/wall/mineral/stonebrick,
						/turf/closed/wall/mineral/wood,
						/turf/closed/wall/mineral/wooddark,
						/turf/closed/wall/mineral/stone,
						/turf/closed/wall/mineral/stone/moss,
						/turf/open/floor/cobble,
						/turf/open/floor/dirt,
						/turf/open/floor/grass,
						/turf/open/floor/grass/red,
						/turf/open/floor/grass/yel,
						/turf/open/floor/grass/cold,
						/turf/open/floor/snow,
						/turf/open/floor/snow/patchy,
						/turf/open/floor/snow/rough)
	damage_deflection = 10
	max_integrity = 800

/turf/open/floor/church/turf_destruction(damage_flag)
	. = ..()
	ScrapeAway(flags = CHANGETURF_INHERIT_AIR)

/turf/open/floor/church/cardinal_smooth(adjacencies)
	smooth(adjacencies)

/turf/open/floor/church/Initialize()
	. = ..()
	dir = pick(GLOB.cardinals)

/turf/open/floor/churchbrick
	icon_state = "church_brick"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'sound/foley/jumpland/stoneland.wav'
	smooth = SMOOTH_MORE
	canSmoothWith = list(/turf/closed/mineral,
						/turf/open/floor/herringbone,
						/turf/closed/mineral,
						/turf/closed/wall/mineral/stonebrick,
						/turf/closed/wall/mineral/wood,
						/turf/closed/wall/mineral/wooddark,
						/turf/closed/wall/mineral/stone,
						/turf/closed/wall/mineral/stone/moss,
						/turf/open/floor/cobble,
						/turf/open/floor/dirt,
						/turf/open/floor/grass,
						/turf/open/floor/grass/red,
						/turf/open/floor/grass/yel,
						/turf/open/floor/grass/cold,
						/turf/open/floor/snow,
						/turf/open/floor/snow/patchy,
						/turf/open/floor/snow/rough)
	damage_deflection = 10
	max_integrity = 800

/turf/open/floor/churchbrick/turf_destruction(damage_flag)
	. = ..()
	ScrapeAway(flags = CHANGETURF_INHERIT_AIR)

/turf/open/floor/churchbrick/cardinal_smooth(adjacencies)
	smooth(adjacencies)

/turf/open/floor/churchbrick/Initialize()
	. = ..()
	dir = pick(GLOB.cardinals)

/turf/open/floor/churchrough
	icon_state = "church_rough"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'sound/foley/jumpland/stoneland.wav'
	smooth = SMOOTH_MORE
	canSmoothWith = list(/turf/closed/mineral,
						/turf/open/floor/herringbone,
						/turf/closed/mineral,
						/turf/closed/wall/mineral/stonebrick,
						/turf/closed/wall/mineral/wood,
						/turf/closed/wall/mineral/wooddark,
						/turf/closed/wall/mineral/stone,
						/turf/closed/wall/mineral/stone/moss,
						/turf/open/floor/cobble,
						/turf/open/floor/dirt,
						/turf/open/floor/grass,
						/turf/open/floor/grass/red,
						/turf/open/floor/grass/yel,
						/turf/open/floor/grass/cold,
						/turf/open/floor/snow,
						/turf/open/floor/snow/patchy,
						/turf/open/floor/snow/rough)
	damage_deflection = 10
	max_integrity = 800

/turf/open/floor/churchrough/turf_destruction(damage_flag)
	. = ..()
	ScrapeAway(flags = CHANGETURF_INHERIT_AIR)

/turf/open/floor/churchrough/cardinal_smooth(adjacencies)
	smooth(adjacencies)

/turf/open/floor/churchrough/Initialize()
	. = ..()
	dir = pick(GLOB.cardinals)
//
/turf/open/floor/herringbone
	icon_state = "herringbone"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'sound/foley/jumpland/stoneland.wav'
	neighborlay = "herringedge"
	smooth = SMOOTH_TRUE
	canSmoothWith = list(/turf/open/floor/herringbone,
						/turf/open/floor/blocks,
						/turf/open/floor/dirt,
						/turf/open/floor/grass,
						/turf/open/floor/grass/red,
						/turf/open/floor/grass/yel,
						/turf/open/floor/grass/cold,
						/turf/open/floor/snow,
						/turf/open/floor/snow/patchy,
						/turf/open/floor/snow/rough)
	damage_deflection = 10
	max_integrity = 800


/turf/open/floor/herringbone/turf_destruction(damage_flag)
	. = ..()
	ScrapeAway(flags = CHANGETURF_INHERIT_AIR)

/turf/open/floor/herringbone/cardinal_smooth(adjacencies)
	smooth(adjacencies)

/turf/open/floor/herringbone/Initialize()
	. = ..()
	dir = pick(GLOB.cardinals)

/*	..................   Cobblestone   ................... */
/turf/open/floor/cobble
	icon_state = "cobblestone1"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'sound/foley/jumpland/stoneland.wav'
	neighborlay = "cobbleedge"
	smooth = SMOOTH_TRUE
	canSmoothWith = list(/turf/open/floor/dirt,
						/turf/open/floor/grass)
	max_integrity = 1200

/turf/open/floor/cobble/turf_destruction(damage_flag)
	. = ..()
	ChangeTurf(/turf/open/floor/dirt, flags = CHANGETURF_INHERIT_AIR)
	new /obj/item/natural/stone(src)



/turf/open/floor/cobble/cardinal_smooth(adjacencies)
	smooth(adjacencies)

/turf/open/floor/cobble/Initialize()
	. = ..()
	icon_state = "cobblestone[rand(1,3)]"

/turf/open/floor/cobble/mossy
	icon_state = "mossystone1"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'sound/foley/jumpland/stoneland.wav'
	neighborlay = "cobbleedge"
	smooth = SMOOTH_TRUE
	canSmoothWith = list(/turf/open/floor/dirt,
						/turf/open/floor/grass,
						/turf/open/floor/grass,
						/turf/open/floor/grass/red,
						/turf/open/floor/grass/yel,
						/turf/open/floor/grass/cold,
						/turf/open/floor/snow,
						/turf/open/floor/snow/patchy,
						/turf/open/floor/snow/rough)

/turf/open/floor/cobble/mossy/cardinal_smooth(adjacencies)
	smooth(adjacencies)

/turf/open/floor/cobble/mossy/Initialize()
	. = ..()
	icon_state = "mossystone[rand(1,3)]"

/turf/open/floor/cobblerock
	icon_state = "cobblerock"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'sound/foley/jumpland/stoneland.wav'
	neighborlay = "cobblerock"
	smooth = SMOOTH_TRUE
	canSmoothWith = list(/turf/open/floor/dirt,
						/turf/open/floor/grass,
						/turf/open/floor/grass/red,
						/turf/open/floor/grass/yel,
						/turf/open/floor/grass/cold,
						/turf/open/floor/snow,
						/turf/open/floor/snow/patchy,
						/turf/open/floor/snow/rough)

/turf/open/floor/cobblerock/cardinal_smooth(adjacencies)
	smooth(adjacencies)

/obj/effect/decal/cobbleedge
	name = ""
	desc = ""
	icon = 'icons/turf/roguefloor.dmi'
	icon_state = "cobblestone_edges"
	mouse_opacity = 0

/turf/open/floor/tile
	icon_state = "chess"
	landsound = 'sound/foley/jumpland/tileland.wav'
	footstep = FOOTSTEP_FLOOR
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	footstepstealth = TRUE
	smooth = SMOOTH_MORE
	canSmoothWith = list(/turf/closed/mineral,
						/turf/closed/mineral,
						/turf/closed/wall/mineral/stonebrick,
						/turf/closed/wall/mineral/wood,
						/turf/closed/wall/mineral/wooddark,
						/turf/closed/wall/mineral/stone,
						/turf/closed/wall/mineral/stone/moss,
						/turf/open/floor/cobble,
						/turf/open/floor/dirt,
						/turf/open/floor/grass,
						/turf/open/floor/grass/red,
						/turf/open/floor/grass/yel,
						/turf/open/floor/grass/cold,
						/turf/open/floor/snow,
						/turf/open/floor/snow/patchy,
						/turf/open/floor/snow/rough)

/turf/open/floor/cobble/alt
	icon_state = "cobblestonealt1"

/turf/open/floor/cobble/alt/Initialize()
	. = ..()
	icon_state = "cobblestonealt[rand(1,3)]"

/turf/open/floor/cobblerock/alt
	icon_state = "cobblealt"

/obj/effect/decal/cobbleedge/alt
	icon_state = "cobblestonealt_edges"

/turf/open/floor/cobble/mossy/alt
	icon_state = "mossystonealt1"

/turf/open/floor/cobble/mossy/alt/Initialize()
	. = ..()
	icon_state = "mossystonealt[rand(1,3)]"


/*	..................   Miscellany   ................... */

/turf/open/floor/tile/turf_destruction(damage_flag)
	. = ..()
	ScrapeAway(flags = CHANGETURF_INHERIT_AIR)

/turf/open/floor/tile/masonic
	icon_state = "masonic"
/turf/open/floor/tile/masonic/single
	icon_state = "masonicsingle"
/turf/open/floor/tile/masonic/inverted
	icon_state = "masonicsingleinvert"
/turf/open/floor/tile/masonic/spiral
	icon_state = "masonicspiral"

/turf/open/floor/tile/bath
	icon_state = "bathtile"
/turf/open/floor/tile/bfloorz
	icon_state = "bfloorz"
/turf/open/floor/tile/tilerg
	icon_state = "tilerg"
/turf/open/floor/tile/checker
	icon_state = "linoleum"
/turf/open/floor/tile/checkeralt
	icon_state = "tile"

/turf/open/floor/concrete
	icon_state = "concretefloor1"
	landsound = 'sound/foley/jumpland/stoneland.wav'
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	smooth = SMOOTH_MORE
	canSmoothWith = list(/turf/closed/mineral,
						/turf/closed/mineral,
						/turf/closed/wall/mineral/stonebrick,
						/turf/closed/wall/mineral/wood,
						/turf/closed/wall/mineral/wooddark,
						/turf/closed/wall/mineral/stone,
						/turf/closed/wall/mineral/stone/moss,
						/turf/open/floor/cobble,
						/turf/open/floor/dirt,
						/turf/open/floor/grass,
						/turf/open/floor/grass/red,
						/turf/open/floor/grass/yel,
						/turf/open/floor/grass/cold,
						/turf/open/floor/snow,
						/turf/open/floor/snow/patchy,
						/turf/open/floor/snow/rough)
	damage_deflection = 10
	max_integrity = 1200

/turf/open/floor/concrete/turf_destruction(damage_flag)
	. = ..()
	src.ChangeTurf(/turf/open/floor/dirt, flags = CHANGETURF_INHERIT_AIR)
	new /obj/item/natural/stone(src)

/turf/open/floor/concrete/Initialize()
	. = ..()
	icon_state = "concretefloor[rand(1,2)]"
	dir = pick(GLOB.cardinals)

/turf/open/floor/metal
	icon_state = "plating1"
	landsound = 'sound/foley/jumpland/metalland.wav'
	footstep = FOOTSTEP_PLATING
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	footstepstealth = TRUE
	smooth = SMOOTH_MORE
	canSmoothWith = list(/turf/closed/mineral,
						/turf/closed/mineral,
						/turf/closed/wall/mineral/stonebrick,
						/turf/closed/wall/mineral/wood,
						/turf/closed/wall/mineral/wooddark,
						/turf/closed/wall/mineral/stone,
						/turf/closed/wall/mineral/stone/moss,
						/turf/open/floor/cobble,
						/turf/open/floor/dirt,
						/turf/open/floor/grass,
						/turf/open/floor/grass/red,
						/turf/open/floor/grass/yel,
						/turf/open/floor/grass/cold,
						/turf/open/floor/snow,
						/turf/open/floor/snow/patchy,
						/turf/open/floor/snow/rough)
	damage_deflection = 16
	max_integrity = 1400


/turf/open/floor/metal/turf_destruction(damage_flag)
	. = ..()
	ScrapeAway(flags = CHANGETURF_INHERIT_AIR)

/turf/open/floor/metal/Initialize()
	. = ..()
	dir = pick(GLOB.cardinals)

/turf/open/floor/metal/barograte
	icon_state = "barograte"
/turf/open/floor/metal/barograte/open
	icon_state = "barograteopen"

/turf/open/floor/carpet
	icon_state = "carpet"
	landsound = 'sound/foley/jumpland/carpetland.wav'
	footstep = FOOTSTEP_CARPET
	barefootstep = FOOTSTEP_SOFT_BAREFOOT
	clawfootstep = FOOTSTEP_SOFT_BAREFOOT
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	smooth = SMOOTH_MORE
	canSmoothWith = list(/turf/closed/mineral,
						/turf/closed/mineral,
						/turf/closed/wall/mineral/stonebrick,
						/turf/closed/wall/mineral/wood,
						/turf/closed/wall/mineral/wooddark,
						/turf/closed/wall/mineral/stone,
						/turf/closed/wall/mineral/stone/moss,
						/turf/open/floor/cobble,
						/turf/open/floor/dirt,
						/turf/open/floor/grass,
						/turf/open/floor/grass/red,
						/turf/open/floor/grass/yel,
						/turf/open/floor/grass/cold,
						/turf/open/floor/snow,
						/turf/open/floor/snow/patchy,
						/turf/open/floor/snow/rough)
	damage_deflection = 10
	max_integrity = 800

/turf/open/floor/carpet/turf_destruction(damage_flag)
	. = ..()
	ScrapeAway(flags = CHANGETURF_INHERIT_AIR)

/turf/open/floor/carpet/lord
	icon = 'icons/turf/roguefloor.dmi'
	icon_state = ""

/turf/open/floor/carpet/lord/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/turf/open/floor/carpet/lord/Destroy()
	GLOB.lordcolor -= src
	return ..()

/turf/open/floor/carpet/lord/lordcolor(primary,secondary)
	if(!primary || !secondary)
		return
	var/mutable_appearance/M = mutable_appearance(icon, "[icon_state]_primary", -(layer+0.1))
	M.color = primary
	add_overlay(M)
	GLOB.lordcolor -= src

/turf/open/floor/carpet/lord/center
	icon_state = "carpet_c"

/turf/open/floor/carpet/lord/center/Initialize()
	dir = pick(GLOB.cardinals)
	..()

/turf/open/floor/carpet/lord/left
	icon_state = "carpet_l"

/turf/open/floor/carpet/lord/right
	icon_state = "carpet_r"

/turf/open/floor/carpet/green
	icon = 'icons/turf/roguefloor.dmi'
	icon_state = "carpet_inn"

/turf/open/floor/shroud
	name = "treetop"
	icon_state = "treetop1"
	landsound = 'sound/foley/jumpland/dirtland.wav'
	footstep = null
	barefootstep = null
	clawfootstep = null
	heavyfootstep = null
	slowdown = 4

/turf/open/floor/shroud/Entered(atom/movable/AM, atom/oldLoc)
	..()
	if(isliving(AM))
		if(istype(oldLoc, type))
			playsound(AM, "plantcross", 100, TRUE)

/turf/open/floor/shroud/Initialize()
	. = ..()
	icon_state = "treetop[rand(1,2)]"
	dir = pick(GLOB.cardinals)

/turf/open/floor/naturalstone
	icon_state = "digstone"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'sound/foley/jumpland/grassland.wav'

/turf/open/floor/plank
	icon_state = "plank"
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'sound/foley/jumpland/woodland.wav'

/turf/open/floor/plank/h
	icon_state = "plank2"

/turf/open/floor/tile/checker_green
	icon_state = "tile"
	color = "#94df5b"


/turf/open/floor/naturalstone/turf_destruction(damage_flag)
	. = ..()
	return

/turf/open/floor/sandstone
	icon_state = "sandstone"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'sound/foley/jumpland/grassland.wav'

