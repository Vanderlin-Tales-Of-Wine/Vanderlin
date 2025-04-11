/turf/closed/wall/mineral/stone
	name = "stone wall"
	desc = "A wall of smooth, unyielding stone."
	icon = 'icons/turf/walls/stone_wall.dmi'
	icon_state = "stone"
	blade_dulling = DULLING_BASH
	max_integrity = 1200
	sheet_type = /obj/item/natural/stone
	break_sound = 'sound/combat/hits/onstone/stonedeath.ogg'
	attacked_sound = list('sound/combat/hits/onstone/wallhit.ogg', 'sound/combat/hits/onstone/wallhit2.ogg', 'sound/combat/hits/onstone/wallhit3.ogg')
	smoothing_flags = SMOOTH_CORNERS
	smoothing_groups = list(SMOOTH_GROUP_CLOSED, SMOOTH_GROUP_WALLS_STONE)
	canSmoothWith = list(SMOOTH_GROUP_WALLS_STONE)
	above_floor = /turf/open/floor/blocks
	baseturfs = list(/turf/open/floor/blocks)
	neighborlay = "dirtedge"
	climbdiff = 1
	damage_deflection = 10
	hardness = 3

/turf/closed/wall/mineral/stone/window
	name = "stone murder hole"
	desc = "A wall of stone with convenient small indents on it, perfect to let loose arrows against invaders."
	icon_state = "stonewindow"
	opacity = FALSE
	max_integrity = 800
	explosion_block = 2

/turf/closed/wall/mineral/stone/window/CanPass(atom/movable/mover, turf/target)
	if(istype(mover) && ((mover.pass_flags & PASSTABLE) || (mover.pass_flags & PASSGRILLE)) )
		return 1
	return ..()

/turf/closed/wall/mineral/stone/window/Initialize()
	. = ..()
	icon_state = "stone"
	var/mutable_appearance/M = mutable_appearance(icon, "stonehole", layer = ABOVE_NORMAL_TURF_LAYER)
	add_overlay(M)

/turf/closed/wall/mineral/stone/moss
	icon = 'icons/turf/walls/mossy_stone.dmi'
	climbdiff = 4

/turf/closed/wall/mineral/stone/window/moss
	icon = 'icons/turf/walls/mossy_stone.dmi'
	icon_state = "stonewindow"
	climbdiff = 4

/turf/closed/wall/mineral/stone/moss/blue
	icon = 'icons/turf/walls/mossy_stone_blue.dmi'

/turf/closed/wall/mineral/stone/window/moss/blue
	icon = 'icons/turf/walls/mossy_stone_blue.dmi'

/turf/closed/wall/mineral/stone/moss/red
	icon = 'icons/turf/walls/mossy_stone_red.dmi'

/turf/closed/wall/mineral/stone/window/moss/red
	icon = 'icons/turf/walls/mossy_stone_red.dmi'

/turf/closed/wall/mineral/craftstone
	name = "craftstone wall"
	desc = "A durable wall made from specially crafted stone."
	icon = 'icons/turf/walls/craftstone.dmi'
	icon_state = "box"
	blade_dulling = DULLING_BASH
	max_integrity = 2200
	sheet_type = /obj/item/natural/stone
	break_sound = 'sound/combat/hits/onstone/stonedeath.ogg'
	attacked_sound = list('sound/combat/hits/onstone/wallhit.ogg', 'sound/combat/hits/onstone/wallhit2.ogg', 'sound/combat/hits/onstone/wallhit3.ogg')
	smoothing_flags = SMOOTH_CORNERS
	smoothing_groups = list(SMOOTH_GROUP_CLOSED, SMOOTH_GROUP_WALLS_STONE_CRAFT)
	canSmoothWith = list(SMOOTH_GROUP_WALLS_STONE_CRAFT)
	above_floor = /turf/open/floor/blocks
	baseturfs = list(/turf/open/floor/blocks)
	neighborlay = "dirtedge"
	climbdiff = 1
	damage_deflection = 10

/turf/closed/wall/mineral/stonebrick
	name = "brick wall"
	desc = "Several rows of bricks form this wall."
	icon = 'icons/turf/walls/stonebrick.dmi'
	icon_state = "stonebrick"

	wallclimb = FALSE
	blade_dulling = DULLING_BASH
	max_integrity = 1500
	sheet_type = /obj/item/natural/stone
	break_sound = 'sound/combat/hits/onstone/stonedeath.ogg'
	attacked_sound = list('sound/combat/hits/onstone/wallhit.ogg', 'sound/combat/hits/onstone/wallhit2.ogg', 'sound/combat/hits/onstone/wallhit3.ogg')
	smoothing_flags = SMOOTH_CORNERS
	smoothing_groups = list(SMOOTH_GROUP_CLOSED, SMOOTH_GROUP_WALLS_STONE_BRICK)
	canSmoothWith = list(SMOOTH_GROUP_WALLS_STONE_BRICK)
	above_floor = /turf/open/floor/blocks
	baseturfs = list(/turf/open/floor/blocks)
	neighborlay = "dirtedge"
	climbdiff = 4
	damage_deflection = 20
	hardness = 2

/*	..................   Red brick Walls   ................... */
/turf/closed/wall/mineral/stonebrick/reddish
	color = "#e0b7af"

/turf/closed/wall/mineral/decostone/fluffstone/reddish
	color = "#fbc5bc"

/turf/closed/wall/mineral/decostone/cand/reddish
	color = "#fbd2cb"

/obj/structure/stairs/stone/reddish
	color = "#ffddd7"


/turf/closed/wall/mineral/wood
	name = "wooden wall"
	desc = "A rough-hewn wall of wood."
	icon = 'icons/turf/walls/roguewood.dmi'
	icon_state = "wood"
	blade_dulling = DULLING_BASHCHOP
	max_integrity = 1100
	break_sound = 'sound/combat/hits/onwood/destroywalldoor.ogg'
	attacked_sound = list('sound/combat/hits/onwood/woodimpact (1).ogg','sound/combat/hits/onwood/woodimpact (2).ogg')
	smoothing_flags = SMOOTH_CORNERS
	smoothing_groups = list(SMOOTH_GROUP_CLOSED, SMOOTH_GROUP_WALLS_WOOD)
	canSmoothWith = list(SMOOTH_GROUP_WALLS_WOOD)
	neighborlay = "dirtedge"
	above_floor = /turf/open/floor/ruinedwood
	baseturfs = list(/turf/open/floor/ruinedwood)
	climbdiff = 3
	explosion_block = 4
	hardness = 7

	burn_power = 20
	spread_chance = 4

/turf/closed/wall/mineral/wood/window
	name = "wooden window"
	desc = "A window with a rough-hewn wooden frame."
	icon_state = "woodwindow"
	opacity = FALSE
	max_integrity = 550

/turf/closed/wall/mineral/wood/window/CanPass(atom/movable/mover, turf/target)
	if(istype(mover) && ((mover.pass_flags & PASSTABLE) || (mover.pass_flags & PASSGRILLE)) )
		return 1
	return ..()

/turf/closed/wall/mineral/wood/window/Initialize()
	. = ..()
	var/mutable_appearance/M = mutable_appearance(icon, "woodhole", layer = ABOVE_NORMAL_TURF_LAYER)
	add_overlay(M)

/turf/closed/wall/mineral/tent
	name = "tent"
	desc = "Made from durable fabric and wooden branches."
	icon = 'icons/turf/roguewall.dmi'
	icon_state = "tent"
	smoothing_flags = NONE
	blade_dulling = DULLING_BASHCHOP
	max_integrity = 300
	break_sound = 'sound/combat/hits/onwood/destroywalldoor.ogg'
	attacked_sound = list('sound/combat/hits/onwood/woodimpact (1).ogg','sound/combat/hits/onwood/woodimpact (2).ogg')
	above_floor = /turf/open/floor/twig
	baseturfs = list(/turf/open/floor/twig)
	neighborlay = "dirtedge"
	climbdiff = 1
	explosion_block = 0
	hardness = 70

	burn_power = 20
	spread_chance = 9


/turf/closed/wall/mineral/tent/OnCrafted(dirin, mob/user)
	dir = dirin
	return ..()

/turf/closed/wall/mineral/wooddark
	name = "dark wood wall"
	desc = "Made from durable, somewhat darker wood."
	icon = 'icons/turf/roguewall.dmi'
	icon_state = "corner"
	smoothing_flags = NONE
	blade_dulling = DULLING_BASHCHOP
	max_integrity = 1500
	break_sound = 'sound/combat/hits/onwood/destroywalldoor.ogg'
	attacked_sound = list('sound/combat/hits/onwood/woodimpact (1).ogg','sound/combat/hits/onwood/woodimpact (2).ogg')
//	sheet_type = /obj/item/grown/log/tree/lumber
	above_floor = /turf/open/floor/ruinedwood
	baseturfs = list(/turf/open/floor/ruinedwood)
	neighborlay = "dirtedge"
	climbdiff = 3
	explosion_block = 4
	hardness = 7
	burn_power = 20
	spread_chance = 4

/turf/closed/wall/mineral/wooddark/OnCrafted(dirin, mob/user)
	if(dirin == NORTH || dirin == SOUTH)
		icon_state = "vertwooddark"
	else
		icon_state = "horizwooddark"
	. = ..()

/turf/closed/wall/mineral/wooddark/horizontal
	icon_state = "horizwooddark"

/turf/closed/wall/mineral/wooddark/vertical
	icon_state = "vertwooddark"

/turf/closed/wall/mineral/wooddark/end
	icon_state = "endwooddark"

/turf/closed/wall/mineral/wooddark/slitted
	icon_state = "slittedwooddark"

/turf/closed/wall/mineral/wooddark/window
	name = "dark wood window"
	icon_state = "subwindow"
	opacity = FALSE
	explosion_block = 1

/turf/closed/wall/mineral/wooddark/window/OnCrafted(dirin, mob/user)
	SHOULD_CALL_PARENT(FALSE)
	add_abstract_elastic_data(ELASCAT_CRAFTING, "[name]", 1)
	return

/turf/closed/wall/mineral/wooddark/window/CanPass(atom/movable/mover, turf/target)
	if(istype(mover) && ((mover.pass_flags & PASSTABLE) || (mover.pass_flags & PASSGRILLE)) )
		return 1
	return ..()

/turf/closed/wall/mineral/roofwall
	name = "wall"
	icon = 'icons/turf/roguewall.dmi'
	icon_state = ""
	smoothing_flags = NONE
	blade_dulling = DULLING_BASHCHOP
	max_integrity = 1100
	break_sound = 'sound/combat/hits/onwood/destroywalldoor.ogg'
	attacked_sound = list('sound/combat/hits/onwood/woodimpact (1).ogg','sound/combat/hits/onwood/woodimpact (2).ogg')
	above_floor = /turf/open/floor/rooftop
	baseturfs = list(/turf/open/floor/ruinedwood)
	neighborlay = "dirtedge"
	climbdiff = 3
	hardness = 7

	burn_power = 20
	spread_chance = 2


/turf/closed/wall/mineral/roofwall/center
	icon_state = "roofTurf_I"

/turf/closed/wall/mineral/roofwall/middle
	icon_state = "roofTurf_M"

/turf/closed/wall/mineral/roofwall/outercorner
	icon_state = "roofTurf_OC"

/turf/closed/wall/mineral/roofwall/innercorner
	icon_state = "roofTurf_IC"

/turf/closed/wall/mineral/decowood
	name = "daub wall"
	desc = "A wattle and daub wall."
	icon = 'icons/turf/roguewall.dmi'
	icon_state = "decowood"
	smoothing_flags = NONE
	blade_dulling = DULLING_BASHCHOP
	max_integrity = 1100
	break_sound = 'sound/combat/hits/onwood/destroywalldoor.ogg'
	attacked_sound = list('sound/combat/hits/onwood/woodimpact (1).ogg','sound/combat/hits/onwood/woodimpact (2).ogg')
//	sheet_type = /obj/item/grown/log/tree/lumber
	above_floor = /turf/open/floor/ruinedwood
	baseturfs = list(/turf/open/floor/ruinedwood)
	neighborlay = "dirtedge"
	climbdiff = 3
	explosion_block = 4
	hardness = 7

	burn_power = 20
	spread_chance = 4

/turf/closed/wall/mineral/decowood/Initialize()
	. = ..()
	dir = pick(GLOB.cardinals)

/turf/closed/wall/mineral/decowood/vert
	icon_state = "decowood-vert"

/turf/closed/wall/mineral/decostone
	name = "decorated stone wall"
	desc = "The mason did an excellent job etching details into this wall."
	icon = 'icons/turf/roguewall.dmi'
	icon_state = "decostone-b"
	smoothing_flags = SMOOTH_CORNERS
	wallclimb = FALSE
	blade_dulling = DULLING_BASH
	max_integrity = 2200
	sheet_type = /obj/item/natural/stone
	break_sound = 'sound/combat/hits/onstone/stonedeath.ogg'
	attacked_sound = list('sound/combat/hits/onstone/wallhit.ogg', 'sound/combat/hits/onstone/wallhit2.ogg', 'sound/combat/hits/onstone/wallhit3.ogg')
	above_floor = /turf/open/floor/blocks
	baseturfs = list(/turf/open/floor/blocks)
	neighborlay = "dirtedge"
	climbdiff = 1
	hardness = 2

/turf/closed/wall/mineral/decostone/long
	icon_state = "decostone-l"

/obj/structure/thronething
	name = "stone wall"
	icon = 'icons/turf/roguewall.dmi'
	max_integrity = 0
	opacity = 0
	icon_state = "decostone-l"

/turf/closed/wall/mineral/decostone/center
	icon_state = "decostone-c"

/turf/closed/wall/mineral/decostone/end
	icon_state = "decostone-e"

/turf/closed/wall/mineral/decostone/cand
	icon_state = "decostone-cand"

/turf/closed/wall/mineral/decostone/fluffstone
	icon_state = "fluffstone"

//green moss
/turf/closed/wall/mineral/decostone/moss
	icon_state = "decostone-b-green"

/turf/closed/wall/mineral/decostone/moss/long
	icon_state = "decostone-l-green"

/turf/closed/wall/mineral/decostone/moss/end
	icon_state = "decostone-e-green"

/turf/closed/wall/mineral/decostone/moss/cand
	icon_state = "decostone-cand-green"

//blue moss
/turf/closed/wall/mineral/decostone/moss/blue
	icon_state = "decostone-b-blue"

/turf/closed/wall/mineral/decostone/moss/blue/long
	icon_state = "decostone-l-blue"

/turf/closed/wall/mineral/decostone/moss/blue/end
	icon_state = "decostone-e-blue"

/turf/closed/wall/mineral/decostone/moss/blue/cand
	icon_state = "decostone-cand-blue"

//red moss
/turf/closed/wall/mineral/decostone/moss/red
	icon_state = "decostone-b-red"

/turf/closed/wall/mineral/decostone/moss/red/long
	icon_state = "decostone-l-red"

/turf/closed/wall/mineral/decostone/moss/red/end
	icon_state = "decostone-e-red"

/turf/closed/wall/mineral/decostone/moss/red/cand
	icon_state = "decostone-cand-red"

/turf/closed/dungeon_void
	name = "thick dungeon shroud"
	icon = 'icons/turf/roguewall.dmi'
	icon_state = "shroud1"

/turf/closed/wall/mineral/pipe
	name = "metal wall"
	icon = 'icons/turf/pipewall.dmi'
	icon_state = "iron_box"
	blade_dulling = DULLING_BASH
	max_integrity = 10000
	sheet_type = null
	break_sound = 'sound/combat/hits/onmetal/sheet (1).ogg'
	attacked_sound = list('sound/combat/hits/onmetal/attackpipewall (1).ogg','sound/combat/hits/onmetal/attackpipewall (2).ogg')
	// smoothing_flags = SMOOTH_CORNERS
	// smoothing_groups = list(SMOOTH_GROUP_CLOSED, SMOOTH_GROUP_WALLS_PIPE)
	// canSmoothWith = list(SMOOTH_GROUP_WALLS_PIPE)
	smoothing_flags = NONE
	smoothing_groups = null
	canSmoothWith = null
	above_floor = /turf/open/floor/concrete
	baseturfs = list(/turf/open/floor/concrete)
	climbdiff = 1
	damage_deflection = 20
	hardness = 10

/turf/closed/wall/mineral/underbrick
	name = "erebus stone wall"
	desc = "The toils of hard-working shades."
	icon = 'icons/turf/underbrick.dmi'
	icon_state = "box"
	smoothing_flags = SMOOTH_CORNERS
	wallclimb = FALSE
	blade_dulling = DULLING_BASH
	max_integrity = 99999
	sheet_type = null
	break_sound = 'sound/combat/hits/onstone/stonedeath.ogg'
	attacked_sound = list('sound/combat/hits/onstone/wallhit.ogg', 'sound/combat/hits/onstone/wallhit2.ogg', 'sound/combat/hits/onstone/wallhit3.ogg')
	above_floor = /turf/open/floor/church
	baseturfs = list(/turf/open/floor/church)
	neighborlay = "dirtedge"
	climbdiff = 6

//NO. BAD SKELETONS
/turf/closed/wall/mineral/underbrick/TerraformTurf(path, new_baseturf, flags, defer_change = FALSE, ignore_air = FALSE)
	return

/turf/closed/wall/mineral/underbrick/acid_act(acidpwr, acid_volume, acid_id)
	return 0

/turf/closed/wall/mineral/underbrick/Melt()
	to_be_destroyed = FALSE
	return src
