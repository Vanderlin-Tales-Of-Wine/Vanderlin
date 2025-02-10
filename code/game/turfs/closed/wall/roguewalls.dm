/turf/closed/wall/mineral/rogue
	canSmoothWith = null
	desc = ""
	smooth = SMOOTH_FALSE
	var/smooth_icon = null
	smooth_diag = FALSE
	sheet_type = null
	baseturfs = list(/turf/open/floor/rogue/dirt/road)
	wallclimb = TRUE
	explosion_block = 10
	damage_deflection = 0
	icon = 'icons/turf/roguewall.dmi'

/turf/closed/wall/mineral/rogue/examine()
	. += ..()
	if(max_integrity)
		var/healthpercent = (turf_integrity/max_integrity) * 100
		switch(healthpercent)
			if(50 to 99)
				. += "It looks slightly damaged."
			if(25 to 50)
				. += "It appears heavily damaged."
			if(1 to 25)
				. +=  "<span class='warning'>It's falling apart!</span>"

/turf/closed/wall/mineral/rogue/Initialize()
	if(smooth_icon)
		icon = smooth_icon
	. = ..()


/turf/closed/wall/mineral/rogue/stone
	name = "stone wall"
	desc = "A wall of smooth, unyielding stone."
	icon = 'icons/turf/walls/stone_wall.dmi'
	icon_state = "stone"
	smooth = SMOOTH_MORE
	blade_dulling = DULLING_BASH
	max_integrity = 1200
	sheet_type = /obj/item/natural/stone
	break_sound = 'sound/combat/hits/onstone/stonedeath.ogg'
	attacked_sound = list('sound/combat/hits/onstone/wallhit.ogg', 'sound/combat/hits/onstone/wallhit2.ogg', 'sound/combat/hits/onstone/wallhit3.ogg')
	canSmoothWith = list(/turf/closed/wall/mineral/rogue/stone)
	above_floor = /turf/open/floor/rogue/blocks
	baseturfs = list(/turf/open/floor/rogue/blocks)
	neighborlay = "dirtedge"
	climbdiff = 1
	damage_deflection = 10
	hardness = 3

/turf/closed/wall/mineral/rogue/stone/window
	name = "stone murder hole"
	desc = "A wall of stone with convenient small indents on it, perfect to let loose arrows against invaders."
	opacity = FALSE
	max_integrity = 800
	explosion_block = 2

/turf/closed/wall/mineral/rogue/stone/window/CanPass(atom/movable/mover, turf/target)
	if(istype(mover) && ((mover.pass_flags & PASSTABLE) || (mover.pass_flags & PASSGRILLE)) )
		return 1
	return ..()

/turf/closed/wall/mineral/rogue/stone/window/Initialize()
	. = ..()
	icon_state = "stone"
	var/mutable_appearance/M = mutable_appearance(icon, "stonehole", layer = ABOVE_NORMAL_TURF_LAYER)
	add_overlay(M)

/turf/closed/wall/mineral/rogue/stone/moss
	icon = 'icons/turf/walls/mossy_stone.dmi'
	climbdiff = 4

/turf/closed/wall/mineral/rogue/stone/window/moss
	icon = 'icons/turf/walls/mossy_stone.dmi'
	climbdiff = 4

/turf/closed/wall/mineral/rogue/craftstone
	name = "craftstone wall"
	desc = "A durable wall made from specially crafted stone."
	icon = 'icons/turf/walls/craftstone.dmi'
	icon_state = "box"
	smooth = SMOOTH_MORE
	blade_dulling = DULLING_BASH
	max_integrity = 2200
	sheet_type = /obj/item/natural/stone
	break_sound = 'sound/combat/hits/onstone/stonedeath.ogg'
	attacked_sound = list('sound/combat/hits/onstone/wallhit.ogg', 'sound/combat/hits/onstone/wallhit2.ogg', 'sound/combat/hits/onstone/wallhit3.ogg')
	canSmoothWith = list(/turf/closed/wall/mineral/rogue/craftstone)
	above_floor = /turf/open/floor/rogue/blocks
	baseturfs = list(/turf/open/floor/rogue/blocks)
	neighborlay = "dirtedge"
	climbdiff = 1
	damage_deflection = 10


/turf/closed/wall/mineral/rogue/stonebrick
	name = "brick wall"
	desc = "Several rows of bricks form this wall."
	icon = 'icons/turf/walls/stonebrick.dmi'
	icon_state = "stonebrick"
	smooth = SMOOTH_MORE
	wallclimb = FALSE
	blade_dulling = DULLING_BASH
	max_integrity = 1500
	sheet_type = /obj/item/natural/stone
	break_sound = 'sound/combat/hits/onstone/stonedeath.ogg'
	attacked_sound = list('sound/combat/hits/onstone/wallhit.ogg', 'sound/combat/hits/onstone/wallhit2.ogg', 'sound/combat/hits/onstone/wallhit3.ogg')
	canSmoothWith = list(/turf/closed/wall/mineral/rogue/stonebrick, /turf/closed/wall/mineral/rogue/wooddark)
	above_floor = /turf/open/floor/rogue/blocks
	baseturfs = list(/turf/open/floor/rogue/blocks)
	neighborlay = "dirtedge"
	climbdiff = 4
	damage_deflection = 20
	hardness = 2

/*	..................   Red brick Walls   ................... */
/turf/closed/wall/mineral/rogue/stonebrick/reddish
	color = "#e0b7af"

/turf/closed/wall/mineral/rogue/decostone/fluffstone/reddish
	color = "#fbc5bc"

/turf/closed/wall/mineral/rogue/decostone/cand/reddish
	color = "#fbd2cb"

/obj/structure/stairs/stone/reddish
	color = "#ffddd7"


/turf/closed/wall/mineral/rogue/wood
	name = "wooden wall"
	desc = "A rough-hewn wall of wood."
	icon = 'icons/turf/walls/roguewood.dmi'
	icon_state = "wood"
	smooth = SMOOTH_MORE
	blade_dulling = DULLING_BASHCHOP
	max_integrity = 1100
	break_sound = 'sound/combat/hits/onwood/destroywalldoor.ogg'
	attacked_sound = list('sound/combat/hits/onwood/woodimpact (1).ogg','sound/combat/hits/onwood/woodimpact (2).ogg')
	canSmoothWith = list(/turf/closed/wall/mineral/rogue/wood, /obj/structure/roguewindow, /obj/structure/roguetent, /turf/closed/wall/mineral/rogue/wooddark)
//	sheet_type = /obj/item/grown/log/tree/lumber
	above_floor = /turf/open/floor/rogue/ruinedwood
	baseturfs = list(/turf/open/floor/rogue/ruinedwood)
	neighborlay = "dirtedge"
	climbdiff = 3
	explosion_block = 4
	hardness = 7

/turf/closed/wall/mineral/rogue/wood/window
	name = "wooden window"
	desc = "A window with a rough-hewn wooden frame."
	opacity = FALSE
	max_integrity = 550

/turf/closed/wall/mineral/rogue/wood/window/CanPass(atom/movable/mover, turf/target)
	if(istype(mover) && ((mover.pass_flags & PASSTABLE) || (mover.pass_flags & PASSGRILLE)) )
		return 1
	return ..()

/turf/closed/wall/mineral/rogue/wood/window/Initialize()
	. = ..()
	var/mutable_appearance/M = mutable_appearance(icon, "woodhole", layer = ABOVE_NORMAL_TURF_LAYER)
	add_overlay(M)

/turf/closed/wall/mineral/rogue/tent
	name = "tent"
	desc = "Made from durable fabric and wooden branches."
	icon = 'icons/turf/roguewall.dmi'
	icon_state = "tent"
	smooth = SMOOTH_FALSE
	blade_dulling = DULLING_BASHCHOP
	max_integrity = 300
	break_sound = 'sound/combat/hits/onwood/destroywalldoor.ogg'
	attacked_sound = list('sound/combat/hits/onwood/woodimpact (1).ogg','sound/combat/hits/onwood/woodimpact (2).ogg')
//	canSmoothWith = list(/turf/closed/wall/mineral/rogue/wood, /obj/structure/roguewindow, /turf/closed/wall/mineral/rogue/wooddark)
//	sheet_type = /obj/item/grown/log/tree/lumber
	above_floor = /turf/open/floor/rogue/twig
	baseturfs = list(/turf/open/floor/rogue/twig)
	neighborlay = "dirtedge"
	climbdiff = 1
	explosion_block = 0
	hardness = 70


/turf/closed/wall/mineral/rogue/tent/OnCrafted(dirin)
	dir = dirin
	return ..()

/turf/closed/wall/mineral/rogue/wooddark
	name = "dark wood wall"
	desc = "Made from durable, somewhat darker wood."
	icon = 'icons/turf/roguewall.dmi'
	icon_state = "corner"
	smooth = SMOOTH_FALSE
	blade_dulling = DULLING_BASHCHOP
	max_integrity = 1500
	break_sound = 'sound/combat/hits/onwood/destroywalldoor.ogg'
	attacked_sound = list('sound/combat/hits/onwood/woodimpact (1).ogg','sound/combat/hits/onwood/woodimpact (2).ogg')
//	sheet_type = /obj/item/grown/log/tree/lumber
	above_floor = /turf/open/floor/rogue/ruinedwood
	baseturfs = list(/turf/open/floor/rogue/ruinedwood)
	neighborlay = "dirtedge"
	climbdiff = 3
	explosion_block = 4
	hardness = 7

/turf/closed/wall/mineral/rogue/wooddark/OnCrafted(dirin)
	if(dirin == NORTH || dirin == SOUTH)
		icon_state = "vertwooddark"
	else
		icon_state = "horizwooddark"
	. = ..()

/turf/closed/wall/mineral/rogue/wooddark/horizontal
	icon_state = "horizwooddark"

/turf/closed/wall/mineral/rogue/wooddark/vertical
	icon_state = "vertwooddark"

/turf/closed/wall/mineral/rogue/wooddark/end
	icon_state = "endwooddark"

/turf/closed/wall/mineral/rogue/wooddark/slitted
	icon_state = "slittedwooddark"

/turf/closed/wall/mineral/rogue/wooddark/window
	name = "dark wood window"
	icon_state = "subwindow"
	opacity = FALSE
	explosion_block = 1

/turf/closed/wall/mineral/rogue/wooddark/window/OnCrafted(dirin)
	return

/turf/closed/wall/mineral/rogue/wooddark/window/CanPass(atom/movable/mover, turf/target)
	if(istype(mover) && ((mover.pass_flags & PASSTABLE) || (mover.pass_flags & PASSGRILLE)) )
		return 1
	return ..()

/turf/closed/wall/mineral/rogue/roofwall
	name = "wall"
	icon = 'icons/turf/roguewall.dmi'
	icon_state = ""
	smooth = SMOOTH_FALSE
	blade_dulling = DULLING_BASHCHOP
	max_integrity = 1100
	break_sound = 'sound/combat/hits/onwood/destroywalldoor.ogg'
	attacked_sound = list('sound/combat/hits/onwood/woodimpact (1).ogg','sound/combat/hits/onwood/woodimpact (2).ogg')
	above_floor = /turf/open/floor/rogue/rooftop
	baseturfs = list(/turf/open/floor/rogue/ruinedwood)
	neighborlay = "dirtedge"
	climbdiff = 3
	hardness = 7

/turf/closed/wall/mineral/rogue/roofwall/center
	icon_state = "roofTurf_I"

/turf/closed/wall/mineral/rogue/roofwall/middle
	icon_state = "roofTurf_M"

/turf/closed/wall/mineral/rogue/roofwall/outercorner
	icon_state = "roofTurf_OC"

/turf/closed/wall/mineral/rogue/roofwall/innercorner
	icon_state = "roofTurf_IC"

/turf/closed/wall/mineral/rogue/decowood
	name = "daub wall"
	desc = "A wattle and daub wall."
	icon = 'icons/turf/roguewall.dmi'
	icon_state = "decowood"
	smooth = SMOOTH_FALSE
	blade_dulling = DULLING_BASHCHOP
	max_integrity = 1100
	break_sound = 'sound/combat/hits/onwood/destroywalldoor.ogg'
	attacked_sound = list('sound/combat/hits/onwood/woodimpact (1).ogg','sound/combat/hits/onwood/woodimpact (2).ogg')
//	sheet_type = /obj/item/grown/log/tree/lumber
	above_floor = /turf/open/floor/rogue/ruinedwood
	baseturfs = list(/turf/open/floor/rogue/ruinedwood)
	neighborlay = "dirtedge"
	climbdiff = 3
	explosion_block = 4
	hardness = 7

/turf/closed/wall/mineral/rogue/decowood/Initialize()
	. = ..()
	dir = pick(GLOB.cardinals)

/turf/closed/wall/mineral/rogue/decowood/vert
	icon_state = "decowood-vert"

/turf/closed/wall/mineral/rogue/decostone
	name = "decorated stone wall"
	desc = "The mason did an excellent job etching details into this wall."
	icon = 'icons/turf/roguewall.dmi'
	icon_state = "decostone-b"
	smooth = SMOOTH_MORE
	wallclimb = FALSE
	blade_dulling = DULLING_BASH
	max_integrity = 2200
	sheet_type = /obj/item/natural/stone
	break_sound = 'sound/combat/hits/onstone/stonedeath.ogg'
	attacked_sound = list('sound/combat/hits/onstone/wallhit.ogg', 'sound/combat/hits/onstone/wallhit2.ogg', 'sound/combat/hits/onstone/wallhit3.ogg')
	above_floor = /turf/open/floor/rogue/blocks
	baseturfs = list(/turf/open/floor/rogue/blocks)
	neighborlay = "dirtedge"
	climbdiff = 1
	hardness = 2

/turf/closed/wall/mineral/rogue/decostone/long
	icon_state = "decostone-l"

/obj/structure/thronething
	name = "stone wall"
	icon = 'icons/turf/roguewall.dmi'
	max_integrity = 0
	opacity = 0
	icon_state = "decostone-l"

/turf/closed/wall/mineral/rogue/decostone/center
	icon_state = "decostone-c"

/turf/closed/wall/mineral/rogue/decostone/end
	icon_state = "decostone-e"

/turf/closed/wall/mineral/rogue/decostone/cand
	icon_state = "decostone-cand"

/turf/closed/wall/mineral/rogue/decostone/fluffstone
	icon_state = "fluffstone"




/turf/closed/wall/shroud //vines
	name = "thick treetop"
	desc = "All the birds flew away before I could see one!"
	icon = 'icons/turf/roguewall.dmi'
	icon_state = "shroud1"
	var/smooth_icon = 'icons/turf/smoothrocks.dmi'
	smooth = SMOOTH_MORE|SMOOTH_BORDER
	canSmoothWith = null
	baseturfs = /turf/open/floor/rogue/shroud
	blade_dulling = DULLING_CUT
	opacity = 1
	density = TRUE
	max_integrity = 200
//	layer = EDGED_TURF_LAYER /ROGTODO make these have borders and smooth
	sheet_type = null
	attacked_sound = list('sound/combat/hits/onvine/vinehit.ogg')
	debris = list(/obj/item/grown/log/tree/stick = 1, /obj/item/natural/thorn = 2, /obj/item/natural/fibers = 1)
	climbdiff = 0
	above_floor = /turf/open/floor/rogue/shroud
	explosion_block = 0
	hardness = 90
	var/res = 0
	var/res_replenish

/turf/closed/wall/shroud/attack_right(mob/user)
	if(isliving(user))
		var/mob/living/L = user
		user.changeNext_move(CLICK_CD_MELEE)
		playsound(src, "plantcross", 80, FALSE, -1)
		if(do_after(L, rand(5 DECISECONDS, 1 SECONDS), src))
			if(!res && world.time > res_replenish)
				res = rand(1,3)
			if(res && prob(50))
				res--
				if(res <= 0)
					res_replenish = world.time + 8 MINUTES
				var/obj/item/B = new /obj/item/grown/log/tree/stick(user.loc)
				user.put_in_hands(B)
				user.visible_message("<span class='notice'>[user] finds [B] in [src].</span>")
				return
			user.visible_message("<span class='warning'>[user] searches through [src].</span>")
			if(!res)
				to_chat(user, "<span class='warning'>Picked clean... I should try later.</span>")
	..()

/turf/closed/wall/shroud/Initialize()
	. = ..()
	icon_state = "shroud[pick(1,2)]"
	dir = pick(GLOB.cardinals)
	res = rand(1,3)
	var/turf/open/transparent/openspace/target = get_step_multiz(src, UP)
	if(istype(target))
		target.ChangeTurf(/turf/open/floor/rogue/dirt/road)

/turf/closed/wall/mineral/rogue/pipe
	name = "metal wall"
	icon = 'icons/turf/pipewall.dmi'
	icon_state = "iron_box"
	smooth = SMOOTH_MORE
	blade_dulling = DULLING_BASH
	max_integrity = 10000
	sheet_type = null
	break_sound = 'sound/combat/hits/onmetal/sheet (1).ogg'
	attacked_sound = list('sound/combat/hits/onmetal/attackpipewall (1).ogg','sound/combat/hits/onmetal/attackpipewall (2).ogg')
	canSmoothWith = list(/turf/closed/wall/mineral/rogue/pipe)
	above_floor = /turf/open/floor/rogue/concrete
	baseturfs = list(/turf/open/floor/rogue/concrete)
	climbdiff = 1
	damage_deflection = 20
	hardness = 10

/turf/closed/wall/mineral/rogue/underbrick
	name = "erebus stone wall"
	desc = "The toils of hard-working shades."
	icon = 'icons/turf/underbrick.dmi'
	icon_state = "box"
	smooth = SMOOTH_MORE
	wallclimb = FALSE
	blade_dulling = DULLING_BASH
	max_integrity = 99999
	sheet_type = null
	break_sound = 'sound/combat/hits/onstone/stonedeath.ogg'
	attacked_sound = list('sound/combat/hits/onstone/wallhit.ogg', 'sound/combat/hits/onstone/wallhit2.ogg', 'sound/combat/hits/onstone/wallhit3.ogg')
	above_floor = /turf/open/floor/rogue/church
	baseturfs = list(/turf/open/floor/rogue/church)
	neighborlay = "dirtedge"
	climbdiff = 6

//NO. BAD SKELETONS
/turf/closed/wall/mineral/rogue/underbrick/TerraformTurf(path, new_baseturf, flags, defer_change = FALSE, ignore_air = FALSE)
	return

/turf/closed/wall/mineral/rogue/underbrick/acid_act(acidpwr, acid_volume, acid_id)
	return 0

/turf/closed/wall/mineral/rogue/underbrick/Melt()
	to_be_destroyed = FALSE
	return src
