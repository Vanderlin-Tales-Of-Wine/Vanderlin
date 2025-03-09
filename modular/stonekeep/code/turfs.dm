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

/turf/open/floor/hexstone
	icon = 'modular/stonekeep/icons/turfs.dmi'

/turf/open/floor/cobble
	icon = 'modular/stonekeep/icons/turfs.dmi'
	canSmoothWith = list(/turf/open/floor/dirt,
						/turf/open/floor/grass,
						/turf/open/floor/ruinedwood,
						/turf/open/floor/wood,
						/turf/open/floor/blocks
						)

/turf/open/floor/herringbone
	icon = 'modular/stonekeep/icons/turfs.dmi'

/turf/open/floor/carpet/green
	icon = 'modular/stonekeep/icons/turfs.dmi'

/turf/open/floor/cobblerock/alt
	icon_state = "cobblerock_alt"
	icon = 'modular/stonekeep/icons/turfs.dmi'
	neighborlay = "cobblerock_alt"
	smooth = SMOOTH_TRUE	// testing does it smooth with gras now?
	canSmoothWith = list(/turf/open/floor/dirt,
						/turf/open/floor/dirt/road,
						/turf/open/floor/grass,
						/turf/open/floor/grass/red,
						/turf/open/floor/grass/yel,
						/turf/open/floor/grass/cold,
						/turf/open/floor/snow,
						/turf/open/floor/snow/patchy,
						/turf/open/floor/snow/rough)

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

/turf/open/floor/grass/mixyel/under_tree
	color = "#ff3535"
/turf/open/floor/grass/Initialize()
	color = "#ffffff"
	. = ..()

/turf/open/floor/grass/mixyel
	smooth = SMOOTH_MORE
	canSmoothWith = list(/turf/open/floor/grass,
	/turf/open/floor/grass/yel,
	/turf/open/floor/snow,
	/turf/open/floor/dirt,
	/turf/open/floor/dirt/old)

/turf/open/floor/grass/yel
	icon = 'modular/stonekeep/icons/turfs.dmi'
	smooth = SMOOTH_MORE
	canSmoothWith = list(/turf/open/floor/grass,
	/turf/open/floor/snow)

/turf/open/floor/grass/red
	name = "red grass"
	desc = "Grass, ripe with Dendor's blood."
	icon_state = "grass_red"
	neighborlay = "grass_rededge"
	smooth = SMOOTH_MORE
	canSmoothWith = list(/turf/open/floor/grass,
	/turf/open/floor/grass/mixyel,
	/turf/open/floor/grass/yel,
	/turf/open/floor/snow,
	/turf/open/floor/dirt
	)

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

/turf/open/floor/cobblerock
	smooth = SMOOTH_MORE
	icon = 'modular/stonekeep/icons/turfs.dmi'

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


/turf/open/floor/grass/old
	icon = 'modular/stonekeep/icons/turfs.dmi'
	icon_state = "oldgrass"
	neighborlay = "oldgrass"
/turf/open/floor/grass/old/Initialize()
	. = ..()
	dir = pick(GLOB.alldirs)


/turf/open/floor/naturalstone/rough
	icon_state = "digstone_rough"
	icon = 'modular/stonekeep/icons/turfs.dmi'
	slowdown = 3
/turf/open/floor/naturalstone/rough/Initialize()
	. = ..()
	dir = pick(GLOB.cardinals)


// =================================================================================
/*--------\
| Washing |
\--------*/

/turf/open/water/bath
	wash_in = FALSE


/turf/open/floor/dirt
	canSmoothWith = list(/turf/open/floor/grass,
						/turf/open/floor/grass/red,
						/turf/open/floor/grass/yel,
						/turf/open/floor/grass/cold,
	//					/turf/open/floor/snow,
	//					/turf/open/floor/snow/patchy,
	//					/turf/open/floor/snow/rough,
						/turf/open/floor/hay)

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
	canSmoothWith = list(/turf/open/floor/dirt/road,
						/turf/open/floor/grass,
						/turf/open/floor/grass/red,
						/turf/open/floor/grass/yel,
						/turf/open/floor/grass/cold)

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


// ======================================================================

/turf/open/floor/carpet/hamlet
	icon = 'modular/stonekeep/icons/carpet_hamlet.dmi'
	canSmoothWith = list(/turf/open/floor/carpet/hamlet)
	smooth = SMOOTH_TRUE


// Sandstone brick wall
/turf/closed/wall/mineral/stonebrick/sandstone
	name = "sandstone wall"
	icon = 'modular/stonekeep/icons/sandstonebrick.dmi'
