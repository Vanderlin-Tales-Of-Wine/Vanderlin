/*	..................   Wooden Floors   ................... */
/turf/open/floor/ruinedwood
	icon_state = "wooden_floor"
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'sound/foley/jumpland/woodland.wav'
	neighborlay = "dirtedge"
	damage_deflection = 8
	max_integrity = 600

/turf/open/floor/ruinedwood/Initialize()
	dir = pick(GLOB.cardinals)
	. = ..()

/turf/open/floor/ruinedwood/turf_destruction(damage_flag)
	. = ..()
	ScrapeAway(flags = CHANGETURF_INHERIT_AIR)

/turf/open/floor/ruinedwood/alt
	icon_state = "horzw"

/turf/open/floor/ruinedwood/turned
	icon_state = "wooden_floort"

/turf/open/floor/ruinedwood/turned/alt
	icon_state = "vertw"

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

/turf/open/floor/twig/turf_destruction(damage_flag)
	. = ..()
	ScrapeAway(flags = CHANGETURF_INHERIT_AIR)

/turf/open/floor/wood
	icon = 'icons/turf/smooth/floors/wood.dmi'
	icon_state = MAP_SWITCH("wood", "wood-0")
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'sound/foley/jumpland/woodland.wav'
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_OPEN_FLOOR + SMOOTH_GROUP_FLOOR_WOOD
	damage_deflection = 8
	max_integrity = 600
//these are here so we can put wood floors next to each other but not have them smooth
/turf/open/floor/wood/nosmooth

/turf/open/floor/wood/turf_destruction(damage_flag)
	. = ..()
	ScrapeAway(flags = CHANGETURF_INHERIT_AIR)

/turf/open/floor/wood/nosmooth/saiga
	icon = 'icons/turf/smooth/floors/wood_alt.dmi'

/turf/open/floor/woodturned
	icon = 'icons/turf/smooth/floors/wood_turned.dmi'
	icon_state = MAP_SWITCH("wood", "wood-0")
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'sound/foley/jumpland/woodland.wav'
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_OPEN_FLOOR + SMOOTH_GROUP_FLOOR_WOOD
	damage_deflection = 8
	max_integrity = 600

/turf/open/floor/woodturned/turf_destruction(damage_flag)
	. = ..()
	ScrapeAway(flags = CHANGETURF_INHERIT_AIR)

//these are here so we can put wood floors next to each other but not have them smooth
/turf/open/floor/woodturned/nosmooth

/turf/open/floor/woodturned/nosmooth/saiga
	icon = 'icons/turf/smooth/floors/wood_turned_alt.dmi'

/turf/open/floor/rooftop
	name = "roof"
	icon_state = MAP_SWITCH("roof", "roof-arw")
	footstep = FOOTSTEP_WOOD
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_WOOD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	damage_deflection = 8
	max_integrity = 800

/turf/open/floor/rooftop/turf_destruction(damage_flag)
	. = ..()
	ScrapeAway(flags = CHANGETURF_INHERIT_AIR)

/turf/open/floor/rooftop/green
	icon_state = MAP_SWITCH("roofg", "roofg-arw")

/*	..................   Grasses   ................... */
/turf/open/floor/grass
	name = "grass"
	desc = "Grass, sodden in mud and bogwater."
	icon_state = "grass"
	footstep = FOOTSTEP_GRASS
	barefootstep = FOOTSTEP_SOFT_BAREFOOT
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'sound/foley/jumpland/grassland.wav'
	slowdown = 0
	smoothing_flags = SMOOTH_EDGE
	smoothing_groups = SMOOTH_GROUP_OPEN_FLOOR + SMOOTH_GROUP_FLOOR_GRASS
	smoothing_list = SMOOTH_GROUP_FLOOR_DIRT_ROAD
	neighborlay = "grassedge"
	max_integrity = 1200
	spread_chance = 3
	burn_power = 60

/turf/open/floor/grass/Initialize()
	. = ..()
	dir = pick(GLOB.cardinals)

/turf/open/floor/grass/turf_destruction(damage_flag)
	. = ..()
	ChangeTurf(/turf/open/floor/dirt, flags = CHANGETURF_INHERIT_AIR)

/turf/open/floor/grass/mixyel
	icon_state = "grass_yelmix"
	neighborlay = "grass_yelmixedge"

/turf/open/floor/grass/red
	name = "red grass"
	desc = "Grass, ripe with Dendor's blood."
	icon_state = "grass_red"
	neighborlay = "grass_rededge"

/turf/open/floor/grass/yel
	name = "yellow grass"
	desc = "Grass, blessed by Astrata's light."
	icon_state = "grass_yel"
	neighborlay = "grass_yeledge"

/turf/open/floor/grass/cold
	name = "tundra grass"
	desc = "Grass, frigid and touched by winter."
	icon_state = "grass_cold"
	neighborlay = "grass_coldedge"

/turf/open/floor/grass/hell
	name = "hell grass"
	desc = "Grass, ominous and instilling uncomfort."
	icon_state = "hellgrass"
	neighborlay = "hellgrass"

/turf/open/floor/grass/eora
	icon_state = "hellgrass"
	neighborlay = "hellgrass"
/*	..................   Snow   ................... */

/turf/open/floor/snow
	name = "snow"
	desc = "A gentle blanket of snow."
	icon_state = "snow"
	footstep = FOOTSTEP_GRASS
	barefootstep = FOOTSTEP_SOFT_BAREFOOT
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'sound/foley/jumpland/grassland.wav'
	slowdown = 0
	smoothing_flags = SMOOTH_EDGE
	smoothing_groups = SMOOTH_GROUP_OPEN_FLOOR + SMOOTH_GROUP_FLOOR_SNOW
	smoothing_list = SMOOTH_GROUP_FLOOR_DIRT + SMOOTH_GROUP_FLOOR_DIRT_ROAD + SMOOTH_GROUP_FLOOR_GRASS + SMOOTH_GROUP_FLOOR_STONE
	neighborlay = "snowedge"
	spread_chance = 0

/turf/open/floor/snow/Initialize()
	dir = pick(GLOB.cardinals)
	. = ..()

/turf/open/floor/snow/rough
	name = "rough snow"
	desc = "A rugged blanket of snow."
	icon_state = "snowrough"
	neighborlay = "snowroughedge"

/turf/open/floor/snow/patchy
	name = "patchy snow"
	desc = "Half-melted snow revealing the hardy grass underneath."
	icon_state = "snowpatchy_grass"
	neighborlay = "snowpatchy_grassedge"

/*	..................   Dirts   ................... */
/turf/open/floor/dirt
	name = "dirt"
	desc = "The dirt is pocked with the scars of countless wars."
	icon_state = "dirt"
	footstep = FOOTSTEP_GRASS
	barefootstep = FOOTSTEP_SOFT_BAREFOOT
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'sound/foley/jumpland/dirtland.wav'
	slowdown = 2
	smoothing_flags = SMOOTH_EDGE
	smoothing_groups = SMOOTH_GROUP_OPEN_FLOOR + SMOOTH_GROUP_FLOOR_DIRT
	smoothing_list = SMOOTH_GROUP_FLOOR_DIRT_ROAD + SMOOTH_GROUP_FLOOR_GRASS + SMOOTH_GROUP_FLOOR_STONE
	neighborlay = "dirtedge"
	spread_chance = 1.6

	var/muddy = FALSE
	var/bloodiness = 20
	var/obj/structure/closet/dirthole/holie
	var/dirt_amt = 3

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
		if(water_level)
			START_PROCESSING(SSwaterlevel, src)

/turf/open/floor/dirt/Initialize()
	dir = pick(GLOB.cardinals)
	. = ..()
	update_water()

/turf/open/floor/dirt/update_water()
	water_level = max(water_level-10,0)
	if(water_level > 10) //this would be a switch on normal tiles
		color = "#95776a"
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

/turf/open/floor/dirt/ambush

/turf/open/floor/dirt/road
	name = "dirt road"
	desc = "The dirt is pocked with the scars of countless steps."
	icon_state = "road"
	footstep = FOOTSTEP_SAND
	smoothing_flags = NONE
	smoothing_groups = SMOOTH_GROUP_OPEN_FLOOR + SMOOTH_GROUP_FLOOR_DIRT_ROAD
	smoothing_list = null
	slowdown = 0
	path_weight = 10

/turf/open/floor/dirt/road/attack_right(mob/user)
	return

/turf/open/floor/dirt/turf_destruction(damage_flag)
	. = ..()
	ScrapeAway(flags = CHANGETURF_INHERIT_AIR)

/turf/open/floor/underworld/road
	name = "ash"
	desc = "Smells like burnt wood."
	icon_state = "ash"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SOFT_BAREFOOT
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'sound/foley/jumpland/dirtland.wav'
	slowdown = 0

/turf/open/floor/underworld/road/Initialize()
	. = ..()
	dir = rand(0,8)

/turf/open/floor/underworld/arena
	name = "sandy ash"
	desc = "This has been pranced upon by countless skeletal fighters."
	icon_state = "ash3"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SOFT_BAREFOOT
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'sound/foley/jumpland/dirtland.wav'
	slowdown = 0

/turf/open/floor/underworld/arena/Initialize()
	. = ..()
	//dir = rand(0,8)   Need to add variants.

/turf/open/floor/underworld/space
	name = "void"
	desc = "The shifting blanket of Necra's realm."
	icon_state = "undervoid"
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SOFT_BAREFOOT
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'sound/foley/jumpland/dirtland.wav'
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
	footstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SOFT_BAREFOOT
	clawfootstep = FOOTSTEP_SAND
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'sound/foley/jumpland/dirtland.wav'
	smoothing_flags = SMOOTH_EDGE
	smoothing_groups = SMOOTH_GROUP_OPEN_FLOOR + SMOOTH_GROUP_FLOOR_DIRT
	smoothing_list = SMOOTH_GROUP_FLOOR_DIRT_ROAD + SMOOTH_GROUP_FLOOR_GRASS + SMOOTH_GROUP_FLOOR_STONE
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
	damage_deflection = 10
	max_integrity = 2800

/turf/open/floor/blocks/Initialize()
	. = ..()
	dir = pick(GLOB.cardinals)

/turf/open/floor/blocks/turf_destruction(damage_flag)
	. = ..()
	ScrapeAway(flags = CHANGETURF_INHERIT_AIR)

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

/turf/open/floor/blocks/snow
	icon_state = "snowblocks"

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
	damage_deflection = 10
	max_integrity = 800
	break_sound = 'sound/combat/hits/onstone/stonedeath.ogg'
	attacked_sound = list('sound/combat/hits/onstone/wallhit.ogg', 'sound/combat/hits/onstone/wallhit2.ogg', 'sound/combat/hits/onstone/wallhit3.ogg')

/turf/open/floor/greenstone/turf_destruction(damage_flag)
	. = ..()
	ScrapeAway(flags = CHANGETURF_INHERIT_AIR)

/turf/open/floor/greenstone/runed
	icon_state = "greenstoneruned"

/turf/open/floor/greenstone/glyph1
	icon_state = "glyph1"

/turf/open/floor/greenstone/glyph2
	icon_state = "glyph2"

/turf/open/floor/greenstone/glyph3
	icon_state = "glyph3"

/turf/open/floor/greenstone/glyph4
	icon_state = "glyph4"

/turf/open/floor/greenstone/glyph5
	icon_state = "glyph5"

/turf/open/floor/greenstone/glyph6
	icon_state = "glyph6"

/turf/open/floor/hexstone
	icon_state = "hexstone"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'sound/foley/jumpland/stoneland.wav'
	damage_deflection = 10
	max_integrity = 800
	break_sound = 'sound/combat/hits/onstone/stonedeath.ogg'
	attacked_sound = list('sound/combat/hits/onstone/wallhit.ogg', 'sound/combat/hits/onstone/wallhit2.ogg', 'sound/combat/hits/onstone/wallhit3.ogg')

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

	damage_deflection = 10
	max_integrity = 800
	break_sound = 'sound/combat/hits/onstone/stonedeath.ogg'
	attacked_sound = list('sound/combat/hits/onstone/wallhit.ogg', 'sound/combat/hits/onstone/wallhit2.ogg', 'sound/combat/hits/onstone/wallhit3.ogg')
	shine = SHINE_SHINY

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
	damage_deflection = 10
	max_integrity = 800
	break_sound = 'sound/combat/hits/onstone/stonedeath.ogg'
	attacked_sound = list('sound/combat/hits/onstone/wallhit.ogg', 'sound/combat/hits/onstone/wallhit2.ogg', 'sound/combat/hits/onstone/wallhit3.ogg')

/turf/open/floor/church/turf_destruction(damage_flag)
	. = ..()
	ScrapeAway(flags = CHANGETURF_INHERIT_AIR)

/turf/open/floor/church/Initialize()
	. = ..()
	dir = pick(GLOB.cardinals)

/turf/open/floor/church/purple
	icon_state = "church_purple"

/turf/open/floor/churchbrick
	icon_state = "church_brick"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'sound/foley/jumpland/stoneland.wav'
	damage_deflection = 10
	max_integrity = 800
	break_sound = 'sound/combat/hits/onstone/stonedeath.ogg'
	attacked_sound = list('sound/combat/hits/onstone/wallhit.ogg', 'sound/combat/hits/onstone/wallhit2.ogg', 'sound/combat/hits/onstone/wallhit3.ogg')

/turf/open/floor/churchbrick/turf_destruction(damage_flag)
	. = ..()
	ScrapeAway(flags = CHANGETURF_INHERIT_AIR)

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
	damage_deflection = 10
	max_integrity = 800
	break_sound = 'sound/combat/hits/onstone/stonedeath.ogg'
	attacked_sound = list('sound/combat/hits/onstone/wallhit.ogg', 'sound/combat/hits/onstone/wallhit2.ogg', 'sound/combat/hits/onstone/wallhit3.ogg')

/turf/open/floor/churchrough/turf_destruction(damage_flag)
	. = ..()
	ScrapeAway(flags = CHANGETURF_INHERIT_AIR)

/turf/open/floor/churchrough/Initialize()
	. = ..()
	dir = pick(GLOB.cardinals)

/turf/open/floor/churchrough/purple
	icon_state = "church_rough_purple"

//
/turf/open/floor/herringbone
	icon_state = "herringbone"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'sound/foley/jumpland/stoneland.wav'
	smoothing_flags = SMOOTH_EDGE
	smoothing_groups = SMOOTH_GROUP_OPEN_FLOOR + SMOOTH_GROUP_FLOOR_STONE
	smoothing_list = SMOOTH_GROUP_FLOOR_DIRT_ROAD + SMOOTH_GROUP_FLOOR_GRASS
	neighborlay = "herringedge"

	damage_deflection = 10
	max_integrity = 800
	break_sound = 'sound/combat/hits/onstone/stonedeath.ogg'
	attacked_sound = list('sound/combat/hits/onstone/wallhit.ogg', 'sound/combat/hits/onstone/wallhit2.ogg', 'sound/combat/hits/onstone/wallhit3.ogg')

/turf/open/floor/herringbone/turf_destruction(damage_flag)
	. = ..()
	ScrapeAway(flags = CHANGETURF_INHERIT_AIR)

/*	..................   Cobblestone   ................... */
/turf/open/floor/cobble
	icon_state = "cobblestone1"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'sound/foley/jumpland/stoneland.wav'
	smoothing_flags = SMOOTH_EDGE
	smoothing_groups = SMOOTH_GROUP_OPEN_FLOOR + SMOOTH_GROUP_FLOOR_STONE
	smoothing_list = SMOOTH_GROUP_FLOOR_DIRT_ROAD + SMOOTH_GROUP_FLOOR_GRASS
	neighborlay = "cobbleedge"
	max_integrity = 1200

/turf/open/floor/cobble/turf_destruction(damage_flag)
	. = ..()
	ChangeTurf(/turf/open/floor/dirt, flags = CHANGETURF_INHERIT_AIR)
	new /obj/item/natural/stone(src)

/turf/open/floor/cobble/Initialize()
	. = ..()
	icon_state = "cobblestone[rand(1,3)]"

/turf/open/floor/cobble/alt
	icon_state = "cobblestonealt1"
	neighborlay = "cobbleedgealt"

/turf/open/floor/cobble/alt/Initialize()
	. = ..()
	icon_state = "cobblestonealt[rand(1,3)]"

/turf/open/floor/cobble/mossy
	icon_state = "mossystone1"
	neighborlay = "mossyedgealt"

/turf/open/floor/cobble/mossy/Initialize()
	. = ..()
	icon_state = "mossystone[rand(1,3)]"

/turf/open/floor/cobble/snow
	icon_state = "snowcobble1"
	neighborlay = "snowcobbleedge"

/turf/open/floor/cobble/snow/Initialize()
	. = ..()
	icon_state = "snowcobble[rand(1,3)]"

/turf/open/floor/cobblerock
	icon_state = "cobblerock"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'sound/foley/jumpland/stoneland.wav'
	smoothing_flags = SMOOTH_EDGE
	smoothing_groups = SMOOTH_GROUP_OPEN_FLOOR + SMOOTH_GROUP_FLOOR_STONE
	smoothing_list = SMOOTH_GROUP_FLOOR_DIRT_ROAD + SMOOTH_GROUP_FLOOR_GRASS
	neighborlay = "cobblerock"
	max_integrity = 1200

/turf/open/floor/cobblerock/turf_destruction(damage_flag)
	. = ..()
	ScrapeAway(flags = CHANGETURF_INHERIT_AIR)

/turf/open/floor/cobblerock/alt
	icon_state = "cobblealt"

/turf/open/floor/cobblerock/snow
	icon_state = "snowcobblerock"
	neighborlay = "snowcobblerock"

/*	..................   Bigger decals for mappers   ................... */
/obj/effect/decal/cobbleedge
	name = ""
	desc = ""
	icon = 'icons/turf/floors.dmi'
	icon_state = "cobblestone_edges"
	mouse_opacity = 0

/obj/effect/decal/cobbleedge/alt
	icon_state = "cobblestonealt_edges"

/obj/effect/decal/cobbleedge/mossy
	icon_state = "mossystonealt_edges"

/obj/effect/decal/cobbleedge/snow
	icon_state = "snowcobble_edges"

/obj/effect/decal/cobblerockedge
	name = ""
	desc = ""
	icon = 'icons/turf/floors.dmi'
	icon_state = "cobble_edges"
	mouse_opacity = 0

/obj/effect/decal/cobblerockedge/alt
	icon_state = "cobblealt_edges"

/*	..................   Miscellany   ................... */
/turf/open/floor/tile
	icon_state = "chess"
	landsound = 'sound/foley/jumpland/tileland.wav'
	footstep = FOOTSTEP_FLOOR
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	footstepstealth = TRUE
	damage_deflection = 10
	max_integrity = 800

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
	damage_deflection = 10
	max_integrity = 1200
	break_sound = 'sound/combat/hits/onstone/stonedeath.ogg'
	attacked_sound = list('sound/combat/hits/onstone/wallhit.ogg', 'sound/combat/hits/onstone/wallhit2.ogg', 'sound/combat/hits/onstone/wallhit3.ogg')

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
	damage_deflection = 16
	max_integrity = 1400
	attacked_sound = list('sound/combat/hits/onmetal/grille (1).ogg', 'sound/combat/hits/onmetal/grille (2).ogg', 'sound/combat/hits/onmetal/grille (3).ogg')

/turf/open/floor/metal/alt
	icon_state = "plating2"

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

/turf/open/floor/carpet/lord
	icon = 'icons/turf/floors.dmi'
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
	. = ..()
	dir = pick(GLOB.cardinals)

/turf/open/floor/carpet/lord/left
	icon_state = "carpet_l"

/turf/open/floor/carpet/lord/right
	icon_state = "carpet_r"

/turf/open/floor/carpet/green
	icon = 'icons/turf/floors.dmi'
	icon_state = "carpet_inn"

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
	damage_deflection = 8
	max_integrity = 1000

/turf/open/floor/plank/turf_destruction(damage_flag)
	. = ..()
	ScrapeAway(flags = CHANGETURF_INHERIT_AIR)

/turf/open/floor/plank/h
	icon_state = "plank2"

/turf/open/floor/tile/checker_green
	icon_state = "tile"
	color = "#94df5b"

/turf/open/floor/sandstone
	icon_state = "sandstone"
	footstep = FOOTSTEP_STONE
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY
	landsound = 'sound/foley/jumpland/grassland.wav'

/*	..................  Platforms   ................... */
/turf/open/floor/ruinedwood/platform
	name = "wood platform"
	desc = "A destructible platform to traverse gaps."
	damage_deflection = 6
	max_integrity = 600
	break_sound = 'sound/combat/hits/onwood/destroywalldoor.ogg'
	attacked_sound = list('sound/combat/hits/onwood/fence_hit1.ogg','sound/combat/hits/onwood/fence_hit2.ogg','sound/combat/hits/onwood/fence_hit3.ogg')

/turf/open/floor/twig/platform
	name = "twig platform"
	desc = "A destructible platform to traverse gaps."
	damage_deflection = 4
	max_integrity = 150
	break_sound = 'sound/combat/hits/onwood/destroywalldoor.ogg'
	attacked_sound = list('sound/combat/hits/onwood/fence_hit1.ogg','sound/combat/hits/onwood/fence_hit2.ogg','sound/combat/hits/onwood/fence_hit3.ogg')

/turf/open/floor/blocks/platform
	name = "stone platform"
	desc = "A destructible platform to traverse gaps."
	damage_deflection = 8
	max_integrity = 800
	break_sound = 'sound/combat/hits/onstone/stonedeath.ogg'
	attacked_sound = list('sound/combat/hits/onstone/wallhit.ogg', 'sound/combat/hits/onstone/wallhit2.ogg', 'sound/combat/hits/onstone/wallhit3.ogg')
