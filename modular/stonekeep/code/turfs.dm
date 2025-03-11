/* * * * * * * * * * * **
 *						*
 *		 Turfs			*
 *						*
 *						*
 * * * * * * * * * * * **/


/*--------------\
| Better Floors |
\--------------*/

/turf/open/floor/wood
	smooth_icon = 'modular/stonekeep/icons/wood.dmi'
/turf/open/floor/wood/nosmooth
	smooth_icon = 'modular/stonekeep/icons/wood.dmi'

/turf/open/floor/woodturned
	smooth_icon = 'modular/stonekeep/icons/wood_turned.dmi'
/turf/open/floor/woodturned/nosmooth/saiga
	smooth_icon = 'modular/stonekeep/icons/wood_turned.dmi'


/*	..................   Stone floors   ................... */
/turf/open/floor/hexstone
	icon = 'modular/stonekeep/icons/turfs.dmi'

/turf/open/floor/cobble
	icon = 'modular/stonekeep/icons/turfs.dmi'
	canSmoothWith = list(/turf/open/floor/dirt,
						/turf/open/floor/grass,
						/turf/open/floor/ruinedwood,
						/turf/open/floor/wood,
						/turf/open/floor/blocks,
						/turf/open/floor/cobblerock
						)

/turf/open/floor/herringbone
	icon = 'modular/stonekeep/icons/turfs.dmi'

/turf/open/floor/carpet/green
	icon = 'modular/stonekeep/icons/turfs.dmi'

/turf/open/floor/cobblerock
	icon = 'modular/stonekeep/icons/turfs.dmi'
	neighborlay = "cobblerock"
	smooth = SMOOTH_TRUE
	canSmoothWith = list()

/turf/open/floor/cobblerock/alt
	icon_state = "cobblerock_alt"
	icon = 'modular/stonekeep/icons/turfs.dmi'
	neighborlay = "cobblerock_alt"
	smooth = SMOOTH_BORDER
	canSmoothWith = list(/turf/open/floor/dirt,
						/turf/open/floor/dirt/road,
						/turf/open/floor/grass,
						/turf/open/floor/grass/red,
						/turf/open/floor/grass/yel,
						/turf/open/floor/grass/cold,
						/turf/open/floor/snow,
						/turf/open/floor/snow/patchy,
						/turf/open/floor/snow/rough)

/turf/open/floor/cobblerock/alt/cardinal_smooth(adjacencies)
	smooth(adjacencies)

/turf/open/floor/cobblerock/alt/Initialize()
	. = ..()
	dir = pick(GLOB.cardinals)

/turf/open/floor/cobblerock/red
	icon = 'modular/stonekeep/icons/turfs.dmi'
	icon_state = "cobblerock_red"
	neighborlay = "cobblerock_red"
	smooth = SMOOTH_MORE


/turf/open/floor/cobble/mossy
	icon = 'modular/stonekeep/icons/turfs.dmi'
	icon_state = "mossystone1"
	neighborlay = "mossyedge"
/turf/open/floor/cobble/mossy/Initialize()
	. = ..()
	dir = pick(GLOB.cardinals)

/turf/open/floor/blocks/carved
	icon_state = "carvedstone"

/turf/open/floor/sandstone
	icon = 'modular/stonekeep/icons/turfs.dmi'
	icon_state = "sandstone"
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
						/turf/open/floor/snow/rough,
						/turf/open/floor/sandstone,
						/turf/open/floor/sandstone/temple)

/turf/open/floor/sandstone/shaded
	color = "#e5dfdf"

/turf/open/floor/sandstone/temple
	icon_state = "temple"
/turf/open/floor/sandstone/temple/Initialize()
	dir = pick(GLOB.cardinals)
	. = ..()

/turf/open/floor/sandstone/old
	icon_state = "sandstone_old"

/turf/open/floor/cobblemoss
	icon = 'modular/stonekeep/icons/turfs.dmi'
	icon_state = "cobstonemoss"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'sound/foley/jumpland/stoneland.wav'
	neighborlay = "cobstonemoss"
	smooth = SMOOTH_TRUE
	canSmoothWith = list(/turf/open/floor/dirt,
						/turf/open/floor/grass)
	max_integrity = 1200

/turf/open/floor/cobblemoss/turf_destruction(damage_flag)
	. = ..()
	ChangeTurf(/turf/open/floor/dirt, flags = CHANGETURF_INHERIT_AIR)
	new /obj/item/natural/stone(src)

/turf/open/floor/cobblemoss/cardinal_smooth(adjacencies)
	smooth(adjacencies)

/turf/open/floor/cobblemoss/Initialize()
	. = ..()
	dir = pick(GLOB.cardinals)

/turf/open/floor/blocks/moss
	icon = 'modular/stonekeep/icons/turfs.dmi'
	icon_state = "blockmoss"

/turf/open/floor/herringbone
	smooth = SMOOTH_MORE
	canSmoothWith = list(/turf/open/floor/herringbone,
						/turf/open/floor/blocks,
						/turf/open/floor/dirt,
						/turf/open/floor/grass,
						/turf/open/floor/grass/red,
						/turf/open/floor/grass/yel,
						/turf/open/floor/grass/cold,
						/turf/open/floor/snow,
						/turf/open/floor/snow/patchy,
						/turf/open/floor/snow/rough,
						/turf/open/floor/tile/masonic)


/*	..................   Grasses   ................... */
/turf/open/floor/grass
	desc = "Grass, a feast for gotes."
	canSmoothWith = list(
						/turf/open/floor/snow,
						/turf/open/floor/snow/patchy,
						/turf/open/floor/snow/rough,
						/turf/open/floor/cobblerock)

/turf/open/floor/grass/mixyel/under_tree
	color = "#ff3535"
/turf/open/floor/grass/mixyel/under_tree/Initialize()
	color = "#ffffff"
	. = ..()

/turf/open/floor/grass/mixyel
	smooth = SMOOTH_MORE
	canSmoothWith = list(/turf/open/floor/grass,
	/turf/open/floor/grass/yel,
	/turf/open/floor/grass/old,
	/turf/open/floor/snow,
	/turf/open/floor/dirt,
	/turf/open/floor/dirt/old,
	/turf/open/floor/cobblerock)

/turf/open/floor/grass/yel
	icon = 'modular/stonekeep/icons/turfs.dmi'
	smooth = SMOOTH_MORE
	canSmoothWith = list(/turf/open/floor/grass,
	/turf/open/floor/snow,
	/turf/open/floor/cobblerock,
	/turf/open/floor/dirt,
	)

/turf/open/floor/grass/red
	name = "red grass"
	desc = "Grass, ripe with Dendor's blood."
	icon_state = "grass_red"
	neighborlay = "grass_rededge"
	smooth = SMOOTH_MORE
	canSmoothWith = list(/turf/open/floor/grass,
	/turf/open/floor/grass/mixyel,
	/turf/open/floor/grass/yel,
	/turf/open/floor/grass/old,
	/turf/open/floor/snow,
	/turf/open/floor/dirt,
	/turf/open/floor/dirt/old,
	/turf/open/floor/cobblerock
	)

/turf/open/floor/grass/old
	desc = "Grass, sodden in mud and bogwater."
	icon = 'modular/stonekeep/icons/turfs.dmi'
	icon_state = "oldgrass"
	neighborlay = "oldgrass"
/turf/open/floor/grass/old/Initialize()
	. = ..()
	dir = pick(GLOB.alldirs)


/*	..................   Snow   ................... */
/turf/open/floor/snow/patchy
	icon = 'modular/stonekeep/icons/turfs.dmi'
	canSmoothWith = list(/turf/open/floor/naturalstone,
						/turf/open/floor/grass,
						/turf/open/floor/grass/red,
						/turf/open/floor/grass/yel,
						/turf/open/floor/grass/cold
						)

/turf/open/floor/snow
	icon = 'modular/stonekeep/icons/turfs.dmi'
	canSmoothWith = list(/turf/open/floor/naturalstone,
						/turf/open/floor/grass,
						/turf/open/floor/grass/red,
						/turf/open/floor/grass/yel,
						/turf/open/floor/grass/cold,
						/turf/open/floor/snow,
						/turf/open/floor/snow/patchy,
						/turf/open/floor/snow/rough)

/turf/open/floor/snow/rough
	icon = 'icons/turf/roguefloor.dmi'



/*	..................   Dirt   ................... */

/turf/open/floor/dirt
	canSmoothWith = list(/turf/open/floor/grass,
						/turf/open/floor/grass/red,
						/turf/open/floor/grass/yel,
						/turf/open/floor/grass/cold,
	//					/turf/open/floor/snow,
	//					/turf/open/floor/snow/patchy,
	//					/turf/open/floor/snow/rough,
						/turf/open/floor/hay)

/turf/open/floor/dirt/road/old
	icon = 'modular/stonekeep/icons/turfs.dmi'
	icon_state = "oldroad"
	neighborlay = "oldroad"


/turf/open/floor/dirt/old
	desc = "The dirt is dark and smell ancient."
	icon_state = "olddirt"
	icon = 'modular/stonekeep/icons/turfs.dmi'
	neighborlay = "olddirt"

/turf/open/floor/dirt/old/become_muddy()
	if(!muddy)
		water_level = max(water_level-100,0)
		muddy = TRUE
		icon_state = "oldmud[rand (1,3)]"
		name = "oldmud"
		slowdown = 2
		footstep = FOOTSTEP_MUD
		barefootstep = FOOTSTEP_MUD
		heavyfootstep = FOOTSTEP_MUD
		bloodiness = 20

/turf/open/floor/dirt/muddie
	desc = "Your feet sink into this soft ground easily."
	icon_state = "mud1"
	icon = 'modular/stonekeep/icons/turfs.dmi'
	neighborlay = "mud1"
	muddy = TRUE
	footstep = FOOTSTEP_MUD
	barefootstep = FOOTSTEP_MUD
	heavyfootstep = FOOTSTEP_MUD

/turf/open/floor/dirt/muddie/Initialize()
	. = ..()
	icon_state = "mud[rand (1,3)]"
	dir = pick(GLOB.cardinals)



// =================================================================
// ====================		Misc floors		========================

/turf/open/water/bath
	wash_in = FALSE


/turf/open/floor/naturalstone/rough
	icon_state = "digstone_rough"
	icon = 'modular/stonekeep/icons/turfs.dmi'
	slowdown = 3
/turf/open/floor/naturalstone/rough/Initialize()
	. = ..()
	dir = pick(GLOB.cardinals)


/turf/open/floor/hay
	icon = 'modular/stonekeep/icons/turfs.dmi'
	icon_state = "hay"
	footstep = FOOTSTEP_GRASS
	barefootstep = FOOTSTEP_SOFT_BAREFOOT
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	tiled_dirt = FALSE
	landsound = 'sound/foley/jumpland/grassland.wav'
	slowdown = 0
	neighborlay = "hayedge"
	canSmoothWith = list(
//						/turf/open/floor/dirt,
//						/turf/open/floor/grass,
						/turf/open/floor/,
//						/turf/open/floor/grass/red,
//						/turf/open/floor/grass/yel,
//						/turf/open/floor/grass/cold
						)

/turf/open/floor/hay/cardinal_smooth(adjacencies)
	smooth(adjacencies)

/*	..................   Kaizoku Sand   ................... */
/turf/open/floor/sand
	icon = 'modular/stonekeep/icons/turfs.dmi'
	icon_state = "sand"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SOFT_BAREFOOT
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'sound/foley/jumpland/dirtland.wav'
	neighborlay = "sandedges"
	smooth = SMOOTH_TRUE
	canSmoothWith = list(
		/turf/closed/mineral,
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
		/turf/open/floor/snow/rough
	)

/turf/open/floor/sand/cardinal_smooth(adjacencies)
	smooth(adjacencies)

/turf/open/floor/sand/Initialize()
	dir = pick(GLOB.cardinals)
	. = ..()


/turf/open/floor/carpet/hamlet
	icon = 'modular/stonekeep/icons/carpet_hamlet.dmi'
	canSmoothWith = list(/turf/open/floor/carpet/hamlet)
	smooth = SMOOTH_TRUE


// more roofing
/turf/open/floor/rooftop/dark
	icon = 'modular/stonekeep/icons/turfs.dmi'
	icon_state = "roofd-arw"
/turf/open/floor/rooftop/dark/Initialize()
	. = ..()
	icon_state = "roofd"

/turf/open/floor/rooftop/dark/corner1
	icon_state = "roofdc-arw"
/turf/open/floor/rooftop/dark/corner1/Initialize()
	. = ..()
	icon_state = "roofdc"

// =================================================================
// =========================	WALLS	============================
// Sandstone brick wall
/turf/closed/wall/mineral/stonebrick/sandstone
	name = "sandstone wall"
	icon = 'modular/stonekeep/icons/sandstonebrick.dmi'


// Nonsmooth brick wall
/turf/closed/wall/mineral/sbrick_nonsmooth
	name = "stonebrick wall"
	desc = ""
	icon = 'icons/turf/roguewall.dmi'
	icon_state = "stonebrick"
	smooth = SMOOTH_MORE
	blade_dulling = DULLING_BASH
	max_integrity = 1200
	sheet_type = /obj/item/natural/stone
	break_sound = 'sound/combat/hits/onstone/stonedeath.ogg'
	attacked_sound = list('sound/combat/hits/onstone/wallhit.ogg', 'sound/combat/hits/onstone/wallhit2.ogg', 'sound/combat/hits/onstone/wallhit3.ogg')
	canSmoothWith = list(/turf/closed/wall/mineral/stone)
	above_floor = /turf/open/floor/blocks
	baseturfs = list(/turf/open/floor/blocks)
	neighborlay = "dirtedge"
	climbdiff = 1
	damage_deflection = 10
	hardness = 3


/turf/closed/wall/mineral/sbrick_nonsmooth/alt
	icon_state = "stonebrick1"
/turf/closed/wall/mineral/sbrick_nonsmooth/alto
	icon_state = "stonebrick2"

/turf/closed/wall/mineral/sbrick_nonsmooth/window
	name = "stonebrick wall"
	desc = ""
	opacity = FALSE
	max_integrity = 800
	explosion_block = 2
