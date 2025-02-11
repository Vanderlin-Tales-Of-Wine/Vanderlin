/* Tables and Racks
 * Contains:
 *		Tables
 *		Glass Tables
 *		Wooden Tables
 *		Reinforced Tables
 *		Racks
 *		Rack Parts
 */

/*
 * Tables
 */

/obj/structure/table
	name = "table"
	desc = ""
	icon = 'icons/obj/smooth_structures/table.dmi'
	icon_state = "table"
	density = TRUE
	anchored = TRUE
	layer = TABLE_LAYER
	climbable = TRUE
	pass_flags = LETPASSTHROW //You can throw objects over this, despite it's density.")
	var/frame
	var/framestack
	var/buildstack
	var/busy = FALSE
	var/buildstackamount = 1
	var/framestackamount = 2
	var/deconstruction_ready = 1
	max_integrity = 100
	integrity_failure = 0.33
	smooth = SMOOTH_TRUE
	canSmoothWith = list(/obj/structure/table)
	destroy_sound = 'sound/combat/hits/onwood/destroyfurniture.ogg'
	attacked_sound = list('sound/combat/hits/onwood/woodimpact (1).ogg','sound/combat/hits/onwood/woodimpact (2).ogg')
	blade_dulling = DULLING_BASHCHOP

/obj/structure/table/update_icon()
	if(smooth)
		queue_smooth(src)
		queue_smooth_neighbors(src)

/obj/structure/table/narsie_act()
	var/atom/A = loc
	qdel(src)
	new /obj/structure/table/wood(A)

/obj/structure/table/attack_paw(mob/user)
	return attack_hand(user)

/obj/structure/table/attack_hand(mob/living/user)
	if(Adjacent(user) && user.pulling)
		if(isliving(user.pulling))
			var/mob/living/pushed_mob = user.pulling
			if(pushed_mob.buckled)
				to_chat(user, "<span class='warning'>[pushed_mob] is on [pushed_mob.buckled]!</span>")
				return
			if(user.used_intent.type == INTENT_GRAB)
				if(user.grab_state < GRAB_AGGRESSIVE)
					to_chat(user, "<span class='warning'>I need a better grip to do that!</span>")
					return
				if(user.grab_state >= GRAB_NECK)
					tableheadsmash(user, pushed_mob)
				else
					tablepush(user, pushed_mob)
			if(user.used_intent.type == INTENT_HELP)
				pushed_mob.visible_message("<span class='notice'>[user] begins to place [pushed_mob] onto [src]...</span>", \
									"<span class='danger'>[user] begins to place [pushed_mob] onto [src]...</span>")
				if(do_after(user, 3.5 SECONDS, pushed_mob))
					tableplace(user, pushed_mob)
				else
					return
			user.stop_pulling()
		else if(user.pulling.pass_flags & PASSTABLE)
			user.Move_Pulled(src)
			if (user.pulling.loc == loc)
				user.visible_message("<span class='notice'>[user] places [user.pulling] onto [src].</span>",
					"<span class='notice'>I place [user.pulling] onto [src].</span>")
				user.stop_pulling()
	return ..()

/obj/structure/table/proc/after_added_effects(obj/item/item, mob/user)

/obj/structure/table/CanPass(atom/movable/mover, turf/target)
	if(istype(mover) && (mover.pass_flags & PASSTABLE))
		return 1
	if(mover.throwing)
		return 1
	if(locate(/obj/structure/table) in get_turf(mover))
		return 1
	else
		return !density

/obj/structure/table/CanAStarPass(ID, dir, caller)
	. = !density
	if(ismovableatom(caller))
		var/atom/movable/mover = caller
		. = . || (mover.pass_flags & PASSTABLE)

/obj/structure/table/proc/tableplace(mob/living/user, mob/living/pushed_mob)
	pushed_mob.forceMove(loc)
	pushed_mob.set_resting(TRUE, TRUE)
	pushed_mob.visible_message("<span class='notice'>[user] places [pushed_mob] onto [src].</span>", \
								"<span class='notice'>[user] places [pushed_mob] onto [src].</span>")
	log_combat(user, pushed_mob, "places", null, "onto [src]")

/obj/structure/table/proc/tablepush(mob/living/user, mob/living/pushed_mob)
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		to_chat(user, "<span class='danger'>Throwing [pushed_mob] onto the table might hurt them!</span>")
		return
	var/added_passtable = FALSE
	if(!(pushed_mob.pass_flags & PASSTABLE))
		added_passtable = TRUE
		pushed_mob.pass_flags |= PASSTABLE
	pushed_mob.Move(src.loc)
	if(added_passtable)
		pushed_mob.pass_flags &= ~PASSTABLE
	if(pushed_mob.loc != loc) //Something prevented the tabling
		return
	pushed_mob.Knockdown(30)
	pushed_mob.apply_damage(10, BRUTE)
	pushed_mob.apply_damage(40, STAMINA)
	if(user.mind?.martial_art.smashes_tables && user.mind?.martial_art.can_use(user))
		deconstruct(FALSE)
	playsound(pushed_mob, "sound/effects/tableslam.ogg", 90, TRUE)
	pushed_mob.visible_message("<span class='danger'>[user] slams [pushed_mob] onto \the [src]!</span>", \
								"<span class='danger'>[user] slams you onto \the [src]!</span>")
	log_combat(user, pushed_mob, "tabled", null, "onto [src]")

/obj/structure/table/proc/tableheadsmash(mob/living/user, mob/living/pushed_mob)
	pushed_mob.Knockdown(30)
	pushed_mob.apply_damage(40, BRUTE, BODY_ZONE_HEAD)
	pushed_mob.apply_damage(60, STAMINA)
	take_damage(50)
	if(user.mind?.martial_art.smashes_tables && user.mind?.martial_art.can_use(user))
		deconstruct(FALSE)
	playsound(pushed_mob, "sound/effects/tableheadsmash.ogg", 90, TRUE)
	pushed_mob.visible_message("<span class='danger'>[user] smashes [pushed_mob]'s head against \the [src]!</span>",
								"<span class='danger'>[user] smashes your head against \the [src]</span>")
	log_combat(user, pushed_mob, "head slammed", null, "against [src]")
	SEND_SIGNAL(pushed_mob, COMSIG_ADD_MOOD_EVENT, "table", /datum/mood_event/table_headsmash)

/obj/structure/table/attackby(obj/item/I, mob/user, params)
	if(!(flags_1 & NODECONSTRUCT_1))
		if(I.tool_behaviour == TOOL_SCREWDRIVER && deconstruction_ready)
			to_chat(user, "<span class='notice'>I start disassembling [src]...</span>")
			if(I.use_tool(src, user, 20, volume=50))
				deconstruct(TRUE)
			return

		if(I.tool_behaviour == TOOL_WRENCH && deconstruction_ready)
			to_chat(user, "<span class='notice'>I start deconstructing [src]...</span>")
			if(I.use_tool(src, user, 40, volume=50))
				playsound(src.loc, 'sound/blank.ogg', 50, TRUE)
				deconstruct(TRUE, 1)
			return

	if(istype(I, /obj/item/plate/tray))
		var/obj/item/plate/tray/T = I
		if(T.contents.len > 0) // If the tray isn't empty
			for(var/obj/item/scattered_item as anything in T.contents)
				scattered_item.forceMove(drop_location())
			user.visible_message(span_notice("[user] empties [I] on [src]."))
			return
		// If the tray IS empty, continue on (tray will be placed on the table like other items)

	if(!user.cmode)
		if(!(I.item_flags & ABSTRACT))
			if(user.transferItemToLoc(I, drop_location(), silent = FALSE))
				var/list/click_params = params2list(params)
				//Center the icon where the user clicked.
				if(!click_params || !click_params["icon-x"] || !click_params["icon-y"])
					return
				//Clamp it so that the icon never moves more than 16 pixels in either direction (thus leaving the table turf)
				I.pixel_x = initial(I.pixel_x) + CLAMP(text2num(click_params["icon-x"]) - 16, -(world.icon_size/2), world.icon_size/2)
				I.pixel_y = initial(I.pixel_y) + CLAMP(text2num(click_params["icon-y"]) - 16, -(world.icon_size/2), world.icon_size/2)
				after_added_effects(I, user)
				if(istype(I, /obj/item/rogue/instrument)) // SURPRISE SURPRISE, YET ANOTHER EXPLOIT PREVENTION.
					var/obj/item/rogue/instrument/P = I
					if(P.playing)
						P.playing = FALSE
						P.soundloop.stop()
						for(var/mob/living/carbon/L in viewers(7))
							var/mob/living/carbon/buffed = L
							if(buffed.mind?.has_antag_datum(/datum/antagonist))
								if(buffed.mind?.isactuallygood())
									for(var/datum/status_effect/bardicbuff/b in L.status_effects)
										buffed.remove_status_effect(b)
										return TRUE
								else
									return TRUE
							else
								for(var/datum/status_effect/bardicbuff/b in L.status_effects)
									buffed.remove_status_effect(b)
									return TRUE
				return TRUE

	return ..()

/obj/structure/table/ongive(mob/user, params)
	var/obj/item/I = user.get_active_held_item()
	if(I)
		if(!(I.item_flags & ABSTRACT))
			if(user.transferItemToLoc(I, drop_location(), silent = FALSE))
				var/list/click_params = params2list(params)
				//Center the icon where the user clicked.
				if(!click_params || !click_params["icon-x"] || !click_params["icon-y"])
					return
				//Clamp it so that the icon never moves more than 16 pixels in either direction (thus leaving the table turf)
				I.pixel_x = initial(I.pixel_x) + CLAMP(text2num(click_params["icon-x"]) - 16, -(world.icon_size/2), world.icon_size/2)
				I.pixel_y = initial(I.pixel_y) + CLAMP(text2num(click_params["icon-y"]) - 16, -(world.icon_size/2), world.icon_size/2)
				return 1

/obj/structure/table/deconstruct(disassembled = TRUE, wrench_disassembly = 0)
	if(disassembled)
		if(!(flags_1 & NODECONSTRUCT_1))
			var/turf/T = get_turf(src)
			if(buildstack)
				new buildstack(T, buildstackamount)
			if(!wrench_disassembly)
				new frame(T)
			else
				new framestack(T, framestackamount)
	qdel(src)

/*
 * Wooden tables
 */


/obj/structure/table/wood
	name = "wooden table"
	desc = ""
	icon = 'icons/roguetown/misc/tables.dmi'
	icon_state = "tablewood"
	resistance_flags = FLAMMABLE
	max_integrity = 70
	smooth = 0
	debris = list(/obj/item/grown/log/tree/small = 1)
	climb_offset = 10

/obj/structure/table/wood/bar
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	flags_1 = NODECONSTRUCT_1
	max_integrity = 1000

/obj/structure/table/wood/crafted/Initialize()
	. = ..()
	icon_state = "tablewood1"

/obj/structure/table/wood/narsie_act(total_override = TRUE)
	if(!total_override)
		..()

/obj/structure/table/wood
	name = "wooden table"
	desc = ""
	icon = 'icons/roguetown/misc/tables.dmi'
	icon_state = "tablewood"
	resistance_flags = FLAMMABLE
	max_integrity = 70
	smooth = 0
	debris = list(/obj/item/grown/log/tree/small = 1)
	climb_offset = 10

/obj/structure/table/church
	name = "stone table"
	desc = ""
	icon = 'icons/roguetown/misc/tables.dmi'
	icon_state = "churchtable"
	max_integrity = 300
	smooth = 0
	climb_offset = 10
	debris = list(/obj/item/natural/stone = 1)

/obj/structure/table/church/m
	icon = 'icons/roguetown/misc/tables.dmi'
	icon_state = "churchtable_mid"

/obj/structure/table/stone_small
	name = "stone table"
	desc = ""
	icon = 'icons/roguetown/misc/tables.dmi'
	icon_state = "stonetable_small"
	max_integrity = 300
	smooth = 0
	climb_offset = 10
	debris = list(/obj/item/natural/stone = 1)

/obj/structure/table/vtable
	name = "ancient wooden table"
	desc = ""
	icon = 'icons/roguetown/misc/tables.dmi'
	icon_state = "vtable"
	max_integrity = 300
	smooth = 0
	climb_offset = 10
	debris = list(/obj/item/grown/log/tree/small = 1)

/obj/structure/table/vtable/v2
	icon = 'icons/roguetown/misc/tables.dmi'
	icon_state = "vtable2"
	debris = list(/obj/item/grown/log/tree/small = 1)

/obj/structure/table/wood/counter
	name = "counter"
	icon_state = "longtable_mid"

/obj/structure/table/wood/counter/end
	icon_state = "longtable"

/obj/structure/table/wood/plain
	icon_state = "tablewood1"

/obj/structure/table/wood/plain/alt
	icon_state = "tablewood2"

/obj/structure/table/wood/plain/alto
	icon_state = "tablewood3"

/obj/structure/table/wood/reinforced
	name = "reinforced table"
	icon_state = "tablewood"

/obj/structure/table/wood/reinforced_alt
	icon_state = "tablewood_alt2"

/obj/structure/table/wood/large
	icon_state = "largetable_mid"

/obj/structure/table/wood/large/corner
	icon_state = "largetable"

/obj/structure/table/wood/large_alt
	icon_state = "largetable_mid_alt"

/obj/structure/table/wood/large/corner_alt
	icon_state = "largetable_alt"

/obj/structure/table/wood/large_blue
	icon_state = "largetable_mid_alt2"

/obj/structure/table/wood/large/corner_blue
	icon_state = "largetable_alt2"

/obj/structure/table/wood/fine
	name = "wooden table"
	desc = ""
	icon = 'icons/roguetown/misc/tables.dmi'
	icon_state = "tablefine"
	resistance_flags = FLAMMABLE
	max_integrity = 40
	smooth = 0
	debris = list(/obj/item/grown/log/tree/small = 2)
	climb_offset = 10

/obj/structure/table/wood/nice
	name = "wooden table"
	desc = ""
	icon = 'icons/roguetown/misc/tables.dmi'
	icon_state = "tablefine2"

/obj/structure/table/wood/poker //No specialties, Just a mapping object.
	name = "gambling table"
	desc = ""
	icon = 'icons/obj/smooth_structures/poker_table.dmi'
	icon_state = "poker_table"

/obj/structure/table/wood/poker/narsie_act()
	..(FALSE)

/obj/structure/table/wood/fancy
	name = "fancy table"
	desc = ""
	icon = 'icons/obj/structures.dmi'
	icon_state = "fancy_table"
	canSmoothWith = list(/obj/structure/table/wood/fancy,
		/obj/structure/table/wood/fancy/black,
		/obj/structure/table/wood/fancy/blue,
		/obj/structure/table/wood/fancy/cyan,
		/obj/structure/table/wood/fancy/green,
		/obj/structure/table/wood/fancy/orange,
		/obj/structure/table/wood/fancy/purple,
		/obj/structure/table/wood/fancy/red,
		/obj/structure/table/wood/fancy/royalblack,
		/obj/structure/table/wood/fancy/royalblue)
	var/smooth_icon = 'icons/obj/smooth_structures/fancy_table.dmi' // see Initialize()

/obj/structure/table/wood/fancy/Initialize()
	. = ..()
	// Needs to be set dynamically because table smooth sprites are 32x34,
	// which the editor treats as a two-tile-tall object. The sprites are that
	// size so that the north/south corners look nice - examine the detail on
	// the sprites in the editor to see why.
	icon = smooth_icon

/obj/structure/table/wood/fancy/black
	icon_state = "fancy_table_black"
	smooth_icon = 'icons/obj/smooth_structures/fancy_table_black.dmi'

/obj/structure/table/wood/fancy/blue
	icon_state = "fancy_table_blue"
	smooth_icon = 'icons/obj/smooth_structures/fancy_table_blue.dmi'

/obj/structure/table/wood/fancy/cyan
	icon_state = "fancy_table_cyan"
	smooth_icon = 'icons/obj/smooth_structures/fancy_table_cyan.dmi'

/obj/structure/table/wood/fancy/green
	icon_state = "fancy_table_green"
	smooth_icon = 'icons/obj/smooth_structures/fancy_table_green.dmi'

/obj/structure/table/wood/fancy/orange
	icon_state = "fancy_table_orange"
	smooth_icon = 'icons/obj/smooth_structures/fancy_table_orange.dmi'

/obj/structure/table/wood/fancy/purple
	icon_state = "fancy_table_purple"
	smooth_icon = 'icons/obj/smooth_structures/fancy_table_purple.dmi'

/obj/structure/table/wood/fancy/red
	icon_state = "fancy_table_red"
	smooth_icon = 'icons/obj/smooth_structures/fancy_table_red.dmi'

/obj/structure/table/wood/fancy/royalblack
	icon_state = "fancy_table_royalblack"
	smooth_icon = 'icons/obj/smooth_structures/fancy_table_royalblack.dmi'

/obj/structure/table/wood/fancy/royalblue
	icon_state = "fancy_table_royalblue"
	smooth_icon = 'icons/obj/smooth_structures/fancy_table_royalblue.dmi'

/*	..................   More tables   ................... */
/obj/structure/table/wood/reinf_long
	icon_state = "tablewood_reinf"

/obj/structure/table/wood/plain_alt
	icon_state = "tablewood_plain"

/obj/structure/table/wood/large_new
	icon_state = "alt_largetable_mid"
/obj/structure/table/wood/large/corner_new
	icon_state = "alt_largetable"

/obj/structure/table/wood/reinforced_alter
	icon_state = "tablewood_alt"

/obj/structure/table/wood/nice/decorated
	icon_state = "tablefine_alt"

/obj/structure/table/wood/nice/decorated_alt
	icon_state = "tablefine_alt2"

/*
 * Racks
 */

/obj/structure/rack
	name = "rack"
	desc = ""
	icon = 'icons/obj/objects.dmi'
	icon_state = "rack"
	layer = TABLE_LAYER
	density = TRUE
	anchored = TRUE
	pass_flags = LETPASSTHROW //You can throw objects over this, despite it's density.
	max_integrity = 40
	destroy_sound = 'sound/combat/hits/onwood/destroyfurniture.ogg'
	attacked_sound = list('sound/combat/hits/onwood/woodimpact (1).ogg','sound/combat/hits/onwood/woodimpact (2).ogg')
	blade_dulling = DULLING_BASHCHOP

/obj/structure/rack/examine(mob/user)
	. = ..()
// += "<span class='notice'>It's held together by a couple of <b>bolts</b>.</span>"

/obj/structure/rack/CanPass(atom/movable/mover, turf/target)
	if(src.density == 0) //Because broken racks -Agouri |TODO: SPRITE!|
		return 1
	if(istype(mover) && (mover.pass_flags & PASSTABLE))
		return 1
	else
		return 0

/obj/structure/rack/CanAStarPass(ID, dir, caller)
	. = !density
	if(ismovableatom(caller))
		var/atom/movable/mover = caller
		. = . || (mover.pass_flags & PASSTABLE)

/obj/structure/rack/MouseDrop_T(obj/O, mob/user)
	. = ..()
	if ((!( istype(O, /obj/item) ) || user.get_active_held_item() != O))
		return
	if(!user.dropItemToGround(O))
		return
	if(O.loc != src.loc)
		step(O, get_dir(O, src))

/obj/structure/rack/attackby(obj/item/W, mob/user, params)
	. = ..()
	if (W.tool_behaviour == TOOL_WRENCH && !(flags_1&NODECONSTRUCT_1) && user.used_intent.type != INTENT_HELP)
		W.play_tool_sound(src)
		deconstruct(TRUE)
		return

	if(!user.cmode)
		if(!(W.item_flags & ABSTRACT))
			if(user.transferItemToLoc(W, drop_location(), silent = FALSE))
				var/list/click_params = params2list(params)
				//Center the icon where the user clicked.
				if(!click_params || !click_params["icon-x"] || !click_params["icon-y"])
					return
				//Clamp it so that the icon never moves more than 16 pixels in either direction (thus leaving the table turf)
				W.pixel_x = initial(W.pixel_x) + CLAMP(text2num(click_params["icon-x"]) - 16, -(world.icon_size/2), world.icon_size/2)
				W.pixel_y = initial(W.pixel_y) + CLAMP(text2num(click_params["icon-y"]) - 16, -(world.icon_size/2), world.icon_size/2)
				return 1

/obj/structure/rack/attack_paw(mob/living/user)
	attack_hand(user)



/obj/structure/rack/rogue
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "rack"
	climbable = TRUE
	climb_offset = 10

/obj/structure/rack/rogue/deconstruct(disassembled = TRUE)
	qdel(src)

/obj/structure/rack/rogue/underworld
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "rack_underworld"
	climbable = TRUE
	climb_offset = 10

/obj/structure/rack/rogue/shelf
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "shelf"
	climbable = FALSE
	dir = SOUTH
	pixel_y = 32

/obj/structure/rack/rogue/shelf/big
	icon_state = "shelf_big"
	climbable = FALSE
	dir = SOUTH
	pixel_y = 16

/obj/structure/rack/rogue/shelf/biggest
	icon_state = "shelf_biggest"
	pixel_y = 0

/obj/structure/rack/rogue/shelf/notdense // makes the wall mounted one less weird in a way, got downside of offset when loaded again tho
	density = FALSE
	pixel_y = 24

// Necessary to avoid a critical bug with disappearing weapons.
/obj/structure/rack/rogue/attackby(obj/item/W, mob/user, params)
	if(!user.cmode)
		if(!(W.item_flags & ABSTRACT))
			if(user.transferItemToLoc(W, drop_location(), silent = FALSE))
				var/list/click_params = params2list(params)
				if(!click_params || !click_params["icon-x"] || !click_params["icon-y"])
					return
				W.pixel_x = initial(W.pixel_x) + CLAMP(text2num(click_params["icon-x"]) - 16, -(world.icon_size/2), world.icon_size/2)
				W.pixel_y = initial(W.pixel_y) + CLAMP(text2num(click_params["icon-y"]) - 16, -(world.icon_size/2), world.icon_size/2)
				return 1
	else
		. = ..()


/obj/structure/table/optable
	name = "operating table"
	desc = ""
	icon = 'icons/obj/surgery.dmi'
	icon_state = "optable"
	smooth = SMOOTH_FALSE
	can_buckle = 1
	buckle_lying = -1
	buckle_requires_restraints = 1
	var/mob/living/carbon/human/patient = null

/obj/structure/table/optable/Initialize()
	. = ..()

/obj/structure/table/optable/tablepush(mob/living/user, mob/living/pushed_mob)
	pushed_mob.forceMove(loc)
	pushed_mob.set_resting(TRUE, TRUE)
	visible_message("<span class='notice'>[user] has laid [pushed_mob] on [src].</span>")
	check_patient()

/obj/structure/table/optable/proc/check_patient()
	var/mob/living/carbon/human/M = locate(/mob/living/carbon/human, loc)
	if(M)
		if(M.resting)
			patient = M
			return TRUE
	else
		patient = null
		return FALSE
