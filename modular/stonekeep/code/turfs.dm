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
	smooth = SMOOTH_TRUE	// needed ?

/turf/open/floor/cobblerock/alt/Initialize()
	. = ..()
	dir = pick(GLOB.cardinals)

/turf/open/floor/cobblerock/red
	icon = 'modular/stonekeep/icons/turfs.dmi'
	icon_state = "cobblerock_red"
	neighborlay = "cobblerock_red"

/turf/open/floor/blocks/carved
	icon_state = "carvedstone"

/turf/open/floor/cobblerock/cardinal_smooth(adjacencies)
	smooth(adjacencies)

/turf/open/floor/cobble/mossy
	smooth = SMOOTH_FALSE	// does this prevent n side dark stripe?
/turf/open/floor/cobble/mossy/Initialize()
	. = ..()
	dir = pick(GLOB.cardinals)

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
	canSmoothWith = list(/turf/open/floor/grass,
	/turf/open/floor/grass/yel,
	/turf/open/floor/snow,
	/turf/open/floor/dirt,)

/turf/open/floor/grass/yel
	icon = 'modular/stonekeep/icons/turfs.dmi'
	canSmoothWith = list(/turf/open/floor/grass,
	/turf/open/floor/snow)

/turf/open/floor/grass/red
	name = "red grass"
	desc = "Grass, ripe with Dendor's blood."
	icon_state = "grass_red"
	neighborlay = "grass_rededge"
	canSmoothWith = list(/turf/open/floor/grass,
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
/*	..................   Map Generators   ................... */
/datum/mapGenerator/forest
	modules = list(/datum/mapGeneratorModule/ambushing,/datum/mapGeneratorModule/forestgrassturf,/datum/mapGeneratorModule/forest,/datum/mapGeneratorModule/forestroad,/datum/mapGeneratorModule/forestgrass,/datum/mapGeneratorModule/forestswampwaterturf,/datum/mapGeneratorModule/forestwaterturf, /datum/mapGeneratorModule/forest_undertree)


/datum/mapGeneratorModule/forest
	spawnableAtoms = list(/obj/structure/flora/newtree = 4,
							/obj/structure/flora/grass/bush_meagre = 4,
							/obj/structure/flora/grass/thorn_bush = 2,
							/obj/structure/flora/grass = 80,
							/obj/structure/flora/grass/herb/random = 7,
							/obj/item/natural/stone = 5,
							/obj/item/natural/rock = 6,
							/obj/item/grown/log/tree/stick = 5,
							/obj/structure/chair/bench/ancientlog = 3,
							/obj/structure/table/wood/treestump = 4,
							/obj/structure/closet/dirthole/closed/loot=6,
							/obj/item/restraints/legcuffs/beartrap/armed=0.1)
	spawnableTurfs = list(/turf/open/floor/dirt/road=80,
						/turf/open/water/swamp=25)
	allowed_areas = list(/area/rogue/outdoors/woods)

/datum/mapGeneratorModule/forestgrass
	clusterCheckFlags = CLUSTER_CHECK_SAME_ATOMS
	allowed_turfs = list(/turf/open/floor/grass)
	excluded_turfs = list(/turf/open/floor/grass/mixyel/under_tree)
	allowed_areas = list(/area/rogue/outdoors/woods)
	spawnableAtoms = list(/obj/structure/flora/tree = 0,
							/obj/structure/flora/grass/bush_meagre = 6,
							/obj/structure/flora/grass = 80,
							/obj/structure/flora/rogueflower/random = 6,
							/obj/structure/flora/grass/herb/random = 2,
							/obj/structure/flora/grass/pyroclasticflowers = 1,
							/obj/item/natural/stone = 6,
							/obj/item/natural/rock = 5,
							/obj/item/grown/log/tree/stick = 3,
							/obj/structure/chair/bench/ancientlog = 5)

/datum/mapGeneratorModule/forestwaterturf
	spawnableAtoms = list(/obj/structure/flora/grass/water = 20,
	                        /obj/structure/flora/grass/water/reeds = 25,
							/obj/structure/flora/grass/stalky = 5,
	                        /obj/structure/kneestingers = 5)

/datum/mapGeneratorModule/forest_undertree
	clusterCheckFlags = CLUSTER_CHECK_SAME_ATOMS
	allowed_turfs = list(/turf/open/floor/grass/mixyel/under_tree)
	excluded_turfs = list()
	allowed_areas = list(/area/rogue/outdoors/woods)
	spawnableAtoms = list(/obj/structure/innocent_web = 10,
							/obj/structure/flora/rogueflower/random = 6,
							/obj/item/grown/log/tree/stick = 3,
							/obj/structure/flora/rogueflower/fallenleaves = 30)


// ======================================================================
/*	..................   Areas   ................... */
/area/rogue/indoors/cave/volf
	name = "volf cave"
	icon_state = "cave"

/area/rogue/indoors/cave/spider
	name = "spider cave"
	icon_state = "cave"

/area/rogue/outdoors/town/amphitheatre
	name = "town (amphitheatre)"


// ======================================================================
/*	..................   Bandit Traveltile Landmark   ................... */ // This is so shit but cant be arsed to make the RW One work
/obj/effect/landmark/map_load_mark/bandit_traveltile
	name = "Bandit_travel"
	templates = list( "bandit_tile1","bandit_tile2","bandit_tile3","bandit_tile4"  )

/datum/map_template/bandittravela
	name = "Bandit_travel_A"
	id = "bandit_tile1"
	mappath = "_maps/map_files/candlelight/templates/bantravel_a.dmm"

/datum/map_template/bandittravelb
	name = "Bandit_travel_B"
	id = "bandit_tile2"
	mappath = "_maps/map_files/candlelight/templates/bantravel_b.dmm"

/datum/map_template/bandittravelc
	name = "Bandit_travel_C"
	id = "bandit_tile3"
	mappath = "_maps/map_files/candlelight/templates/bantravel_c.dmm"

/datum/map_template/bandittraveld
	name = "Bandit_travel_D"
	id = "bandit_tile4"
	mappath = "_maps/map_files/candlelight/templates/bantravel_d.dmm"


/area/rogue/outdoors/mountains/deception
	name = "deception"
	icon_state = "deception"
	first_time_text = "THE CANYON OF DECEPTION"
	ambush_types = list(
				/turf/open/floor/dirt)
	ambush_mobs = list(
				/mob/living/simple_animal/hostile/retaliate/troll = 20,
				/mob/living/carbon/human/species/skeleton/skilled/fighter = 15,
				/mob/living/carbon/human/species/goblin/skilled/ambush/hell = 50)

/area/rogue/outdoors/mountains/decap
	name = "mt decapitation"
	icon_state = "decap"
	ambush_types = list(
				/turf/open/floor/dirt)
	ambush_mobs = list(
				/mob/living/simple_animal/hostile/retaliate/troll = 15,
				/mob/living/carbon/human/species/skeleton/skilled/unarmed = 25,
				/mob/living/carbon/human/species/skeleton/skilled/fighter = 25)
	droning_sound = 'sound/music/area/decap.ogg'
	droning_sound_dusk = null
	droning_sound_night = null
	first_time_text = "MOUNT DECAPITATION"
	ambush_times = list("night","dawn","dusk","day")
	converted_type = /area/rogue/indoors/shelter/mountains/decap


/area/rogue/outdoors/woods/stone
	ambush_types = list(
				/turf/open/floor/grass)
	ambush_mobs = list(
				/mob/living/simple_animal/hostile/retaliate/wolf = 20,
				/mob/living/simple_animal/hostile/retaliate/spider/hairy = 10)
	first_time_text = "HOWLING FOREST"
	converted_type = /area/rogue/indoors/shelter/woods


/area/rogue/outdoors/beach
	name = "beach"
	droning_sound = 'modular/stonekeep/kaizoku/sound/ambience/Oceansanct.ogg'
	droning_sound_dusk = 'modular/stonekeep/kaizoku/sound/ambience/Town_in_Rogue.ogg'
	droning_sound_night = 'modular/stonekeep/kaizoku/sound/ambience/Defenestration.ogg'

/area/rogue/under/cave/abandoned_mine
	name = "abandoned mine"
	first_time_text = "Abandoned Mine"
	ambush_types = list(
				/turf/open/floor/dirt)
	ambush_mobs = list(
				/mob/living/simple_animal/hostile/retaliate/bigrat = 30,
				/mob/living/carbon/human/species/goblin/skilled/ambush/cave = 20)



/area/rogue/under/catacombs
	name = "catacombs"
	icon_state = "cavewet"
	first_time_text = "The Catacombs"
	ambientsounds = AMB_CAVEWATER
	ambientnight = AMB_CAVEWATER
	spookysounds = SPOOKY_CAVE
	spookynight = SPOOKY_CAVE
	droning_sound = 'sound/music/area/caves.ogg'
	droning_sound_dusk = 'modular/stonekeep/kaizoku/sound/ambience/Bucolic.ogg'
	droning_sound_night = 'modular/stonekeep/kaizoku/sound/ambience/Nebula.ogg'
	ambush_times = list("night","dawn","dusk","day")
	ambush_types = list(
				/turf/open/water/swamp)
	ambush_mobs = list(
				/mob/living/carbon/human/species/skeleton/skilled/unarmed = 30,
				/mob/living/simple_animal/hostile/retaliate/bigrat = 10)
	converted_type = /area/rogue/outdoors/caves

/area/rogue/under/catacombs/dwarfoutpost
	name = "underrock outpost"
	first_time_text = "Underrock Outpost"
	ambush_types = list(
				/turf/open/water/swamp)
	ambush_mobs = list(
				/mob/living/simple_animal/hostile/retaliate/lamia = 30,
				/mob/living/simple_animal/hostile/retaliate/headless = 20)

/area/rogue/under/catacombs/dwarfoutpost/orcy
	ambush_types = list(
				/turf/open/floor/blocks/newstone/alt)
	ambush_mobs = list(
				/mob/living/carbon/human/species/orc/skilled/savage = 50)

/area/rogue/under/town/caverogue/saltmine
	name = "salt mine"
	first_time_text = "Salt Mine"
