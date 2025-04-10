/proc/lockid_to_lockpick_difficulty(lockid)
	if(!lockid)
		return 5
	switch(lockid)
		if(ACCESS_VAULT)
			return 1
		if(ACCESS_LORD)
			return 1
		if(ACCESS_MANOR)
			return 2
		if(ACCESS_GUEST)
			return 2
		if(ACCESS_DUNGEON)
			return 2
		if(ACCESS_FOREST)
			return 2
		if(ACCESS_GARRISON)
			return 2
		if(ACCESS_FARM)
			return 4
		if(ACCESS_WAREHOUSE)
			return 3
		if(ACCESS_CAPTAIN)
			return 3
		if(ACCESS_MERCHANT)
			return 5
		if(ACCESS_INN)
			return 5
		if(ACCESS_SMITH)
			return 3
		if(ACCESS_BUTCHER)
			return 3
		if(ACCESS_MANOR_GATE)
			return 2
		if(ACCESS_PRIEST)
			return 2
		if(ACCESS_CHURCH)
			return 3
		if(ACCESS_TOWER)
			return 3
		if(ACCESS_MAGE)
			return 2
		if(ACCESS_ARTIFICER)
			return 4
		if(ACCESS_HAND)
			return 1
		if(ACCESS_STEWARD)
			return 2
		if(ACCESS_FELDSHER)
			return 3
		if("roomi")
			return 6
		if("roomii")
			return 6
		if("roomiii")
			return 6
		if("roomiv")
			return 6
		if("roomv")
			return 6
		if("roomvi")
			return 6
		if("medroomi")
			return 5
		if("medroomii")
			return 5
		if("medroomiii")
			return 5
		if("medroomiv")
			return 5
		if("medroomv")
			return 5
		if("medroomvi")
			return 5
		if("luxroomi")
			return 3
		if("luxroomi")
			return 3
		if("luxroomii")
			return 3
		if("luxroomiii")
			return 3
		if("luxroomiv")
			return 3
		if("luxroomv")
			return 3
		if("luxroomvi")
			return 3
		else
			return 5

/obj/structure/mineral_door
	name = "wooden door"
	desc = "A door that can open and close."
	icon = 'icons/roguetown/misc/doors.dmi'
	icon_state = "wcg"
	density = TRUE
	anchored = TRUE
	opacity = TRUE
	layer = OPEN_DOOR_LAYER
	resistance_flags = FLAMMABLE
	max_integrity = 1000
	integrity_failure = 0.5
	armor = list("blunt" = 10, "slash" = 10, "stab" = 10,  "piercing" = 0, "fire" = 0, "acid" = 0)
	damage_deflection = 10
	CanAtmosPass = ATMOS_PASS_DENSITY
	break_sound = 'sound/combat/hits/onwood/destroywalldoor.ogg'
	attacked_sound = list('sound/combat/hits/onwood/woodimpact (1).ogg', 'sound/combat/hits/onwood/woodimpact (2).ogg')

	/// Can people riding go through without falling off their mount
	var/ridethrough = FALSE
	var/door_opened = FALSE
	/// If we are switching states
	var/switching_states = FALSE
	/// Delay of auto closing, values 0 or below do not auto close.
	var/close_delay = 0
	/// How long should it take for the door to change states? Ideally matches the icon's animation length
	var/animate_time = 10
	var/open_sound = 'sound/foley/doors/creak.ogg'
	var/close_sound = 'sound/foley/doors/shut.ogg'

	/// If we are windowed, to avoid setting opacity
	var/windowed = FALSE
	/// Last bump time
	var/last_bump = null
	/// Can we be closed by bumping if open
	var/bump_closed = TRUE
	var/locked = FALSE
	var/keylock = TRUE
	var/lockid = null
	var/lock_sound = 'sound/foley/doors/woodlock.ogg'
	var/unlock_sound = 'sound/foley/doors/woodlock.ogg'
	/// If the masterky can open regardless
	var/rattle_sound = 'sound/foley/doors/lockrattle.ogg'
	var/masterkey = TRUE
	/// Initial value is STR requirement to kick, then var is used as how many kicks to force open
	var/kickthresh = 15
	/// Can we add a custom lock
	var/can_add_lock = TRUE
	/// Can we knock on the door
	var/can_knock = TRUE
	/// Are ghosts prevented from passing through
	var/ghostproof = FALSE

	var/repairable = TRUE
	var/repair_state = 0
	var/obj/item/repair_cost_first = /obj/item/grown/log/tree/small
	var/obj/item/repair_cost_second = /obj/item/grown/log/tree/small
	var/repair_skill = /datum/skill/craft/carpentry
	metalizer_result = /obj/structure/mineral_door/iron
	/// Handle bolting on right click
	var/has_bolt = FALSE
	/// Handle viewport toggle
	var/has_viewport = FALSE

/obj/structure/mineral_door/Initialize()
	. = ..()
	if(has_bolt && has_viewport)
		warning("[src] at [AREACOORD(src)] has both a deadbolt and a viewport, these will conflict as they both use attack_right.")
	if(has_bolt && keylock)
		warning("[src] at [AREACOORD(src)] has both a deadbolt and a keylock, while this will work it may produce intended behaviour.")
	set_init_layer()
	air_update_turf(TRUE)
	if(keylock)
		AddElement(/datum/element/lockpickable, list(/obj/item/lockpick), list(/obj/item/lockpick), lockid_to_lockpick_difficulty(lockid))

/obj/structure/mineral_door/update_icon()
	icon_state = "[initial(icon_state)][door_opened ? "open":""]"

/obj/structure/mineral_door/examine(mob/user)
	. = ..()
	if(has_viewport)
		. += span_notice("It has a built-in viewport.")
	if(has_bolt)
		. += span_notice("It's lock is a deadbolt.")
	if(keylock)
		. += span_notice("There is a keyhole below the handle.")
	if(!repairable)
		return
	if(!isobj(repair_cost_first) || !isobj(repair_cost_second))
		return
	if(obj_integrity < max_integrity)
		if(repair_state == 0)
			. += span_notice("A [repair_cost_first] can be used to repair it.")
		if(obj_broken || repair_state == 1)
			. += span_notice("An additional [repair_cost_second] is needed to finish repairs.")

/obj/structure/mineral_door/onkick(mob/user)
	if(switching_states)
		return
	if(door_opened)
		playsound(get_turf(src), pick(attacked_sound), 100)
		user.visible_message(span_warning("[user] kicks [src] shut!"), \
			span_notice("I kick [src] shut!"))
		force_closed()
		return
	if(!locked)
		playsound(get_turf(src), pick(attacked_sound), 100)
		user.visible_message(span_warning("[user] kicks [src] open!"), \
			span_notice("I kick [src] open!"))
		force_open()
		return
	if(isliving(user))
		var/mob/living/L = user
		if(L.STASTR < initial(kickthresh))
			playsound(get_turf(src), pick(attacked_sound), 100)
			user.visible_message(span_warning("[user] kicks [src]! It's not effective."), \
			span_notice("I kick [src]! It's not effective."))
			return
		if((prob(L.STASTR * 0.5) || kickthresh-- == 0))
			playsound(get_turf(src), pick(attacked_sound), 100)
			user.visible_message(span_warning("[user] kicks open [src]!"), \
				span_notice("I kick open [src]!"))
			locked = FALSE
			force_open()
			return
		playsound(get_turf(src), pick(attacked_sound), 100)
		user.visible_message(span_warning("[user] kicks [src]!"), \
			span_notice("I kick [src]!"))

/obj/structure/mineral_door/proc/force_open()
	switching_states = TRUE
	if(!windowed)
		set_opacity(FALSE)
	air_update_turf(TRUE)
	update_icon()
	density = FALSE
	door_opened = TRUE
	layer = OPEN_DOOR_LAYER
	switching_states = FALSE

	if(close_delay > 0)
		addtimer(CALLBACK(src, PROC_REF(Close)), close_delay)

/obj/structure/mineral_door/proc/force_closed()
	switching_states = TRUE
	if(!windowed)
		set_opacity(TRUE)
	air_update_turf(TRUE)
	update_icon()
	density = TRUE
	door_opened = FALSE
	layer = CLOSED_DOOR_LAYER
	switching_states = FALSE

/obj/structure/mineral_door/proc/set_init_layer()
	if(density)
		layer = CLOSED_DOOR_LAYER
	else
		layer = initial(layer)

/obj/structure/mineral_door/Move()
	. = ..()
	var/turf/T = loc
	move_update_air(T)

/obj/structure/mineral_door/attack_ghost(mob/dead/observer/user)	// lets ghosts click on windows to transport across
	if(!ghostproof)
		density = FALSE
		. = step(user, get_dir(user, loc))
		density = TRUE

/obj/structure/mineral_door/Bumped(atom/movable/AM)
	..()
	if(door_opened)
		return
	if(world.time < last_bump + 20)
		return
	last_bump = world.time
	if(ismob(AM))
		var/mob/user = AM
		if(HAS_TRAIT(user, TRAIT_BASHDOORS))
			if(locked)
				user.visible_message(span_warning("[user] bashes into [src]!"))
				take_damage(200, BRUTE, BCLASS_SMASH, TRUE)
			else
				playsound(src, 'sound/combat/hits/onwood/woodimpact (1).ogg', 100)
				force_open()
				user.visible_message(span_warning("[user] smashes through [src]!"))
			return
		if(HAS_TRAIT(user, TRAIT_ROTMAN))
			if(locked)
				user.visible_message(span_warning("The deadite bashes into [src]!"))
				take_damage(50, BRUTE, BCLASS_SMASH, TRUE)
			else
				playsound(src, 'sound/combat/hits/onwood/woodimpact (1).ogg', 90)
				force_open()
				user.visible_message(span_warning("The deadite smashes through [src]!"))
			return
		if(locked)
			door_rattle()
			return
		if(TryToSwitchState(AM))
			return
		if(bump_closed)
			if(isliving(AM))
				var/mob/living/M = AM
				var/delay = (close_delay > 0) ? close_delay : 25
				if(M.m_intent == MOVE_INTENT_SNEAK)
					addtimer(CALLBACK(src, PROC_REF(Close), TRUE), delay)
				else
					addtimer(CALLBACK(src, PROC_REF(Close), FALSE), delay)


/obj/structure/mineral_door/attack_paw(mob/user)
	return attack_hand(user)

/obj/structure/mineral_door/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(obj_broken || switching_states)
		return
	if(!locked)
		return TryToSwitchState(user)
	if(user.used_intent.type == /datum/intent/unarmed/claw)
		user.changeNext_move(CLICK_CD_MELEE)
		user.visible_message(span_warning("[user] claws at the door!"), \
			span_notice("I claw at [src]."))
		take_damage(40, BRUTE, BCLASS_CUT, TRUE)
		return
	if(isliving(user))
		var/mob/living/L = user
		if(L.m_intent == MOVE_INTENT_SNEAK)
			to_chat(user, span_warning("This door is locked."))
			return
	if(can_knock)
		playsound(src, 'sound/foley/doors/knocking.ogg', 100)
		user.visible_message(span_warning("[user] knocks on [src]."), \
			span_notice("I knock on [src]."))

/obj/structure/mineral_door/CanPass(atom/movable/mover, turf/target)
	if(istype(mover, /mob/camera))
		return TRUE
	if(istype(mover, /obj/effect/beam))
		return !opacity
	return !density

/obj/structure/mineral_door/proc/TryToSwitchState(atom/user)
	if(switching_states || !anchored)
		return FALSE
	if(!isliving(user))
		return FALSE
	var/mob/living/M = user
	if(!M.client)
		return FALSE
	if(!iscarbon(M))
		SwitchState()
		return FALSE
	var/mob/living/carbon/C = M
	if(!C.handcuffed)
		if(C.m_intent == MOVE_INTENT_SNEAK)
			SwitchState(TRUE)
		else
			SwitchState()
		return TRUE

/obj/structure/mineral_door/proc/SwitchState(silent = FALSE)
	if(door_opened)
		Close(silent)
		return
	Open(silent)

/obj/structure/mineral_door/proc/Open(silent = FALSE)
	switching_states = TRUE
	if(!silent)
		playsound(get_turf(src), open_sound, 90)
	if(!windowed)
		set_opacity(FALSE)
	flick("[initial(icon_state)]opening",src)
	sleep(animate_time)
	air_update_turf(TRUE)
	update_icon()
	density = FALSE
	door_opened = TRUE
	layer = OPEN_DOOR_LAYER
	switching_states = FALSE

	if(close_delay > 0)
		addtimer(CALLBACK(src, PROC_REF(Close), silent), close_delay)

/obj/structure/mineral_door/proc/Close(silent = FALSE)
	if(switching_states || !door_opened)
		return
	for(var/mob/living/L in get_turf(src))
		return
	switching_states = TRUE
	if(!silent)
		playsound(get_turf(src), close_sound, 90)
	if(!windowed)
		set_opacity(TRUE)
	flick("[initial(icon_state)]closing", src)
	sleep(animate_time)
	air_update_turf(TRUE)
	update_icon()
	density = TRUE
	door_opened = FALSE
	layer = initial(layer)
	switching_states = FALSE


/obj/structure/mineral_door/proc/door_rattle()
	playsound(src, rattle_sound, 100)
	var/oldx = pixel_x
	animate(src, pixel_x = oldx+1, time = 0.5)
	animate(pixel_x = oldx-1, time = 0.5)
	animate(pixel_x = oldx, time = 0.5)

/obj/structure/mineral_door/attackby(obj/item/I, mob/user)
	user.changeNext_move(CLICK_CD_FAST)
	if(keylock && (istype(I, /obj/item/key) || istype(I, /obj/item/storage/keyring)))
		if(!locked)
			to_chat(user, span_warning("It won't turn this way. Try turning to the right."))
			door_rattle()
			return
		trykeylock(I, user)
	if(repairable && (user.mind?.get_skill_level(repair_skill) > 0) && ((istype(I, repair_cost_first)) || (istype(I, repair_cost_second)))) // At least 1 skill level needed
		repairdoor(I,user)
		return
	return ..()

/obj/structure/mineral_door/attack_right(mob/user)
	user.changeNext_move(CLICK_CD_FAST)
	var/obj/item = user.get_active_held_item()
	if(keylock && (istype(item, /obj/item/key) || istype(item, /obj/item/storage/keyring)))
		if(locked)
			to_chat(user, span_warning("It won't turn this way. Try turning to the left."))
			door_rattle()
			return
		trykeylock(item, user)
		return
	if(has_bolt)
		if(get_dir(src, user) == dir)
			lock_toggle(user)
			return
		to_chat(user, span_notice("The bolt is on the other side."))
		return
	if(has_viewport)
		if(get_dir(src, user) == dir)
			viewport_toggle(user)
			return
		to_chat(user, span_notice("The viewport does not open from this side."))
		return
	return ..()

/obj/structure/mineral_door/proc/repairdoor(obj/item/I, mob/user)
	if(!obj_broken)
		if(obj_integrity < max_integrity)
			user.visible_message(span_notice("[user] starts repairing [src]."), span_notice("I start repairing [src]."))
			playsound(user, 'sound/misc/wood_saw.ogg', 100, TRUE)
			if(do_after(user, (30 SECONDS / user.mind.get_skill_level(repair_skill)), src))
				qdel(I)
				playsound(user, 'sound/misc/wood_saw.ogg', 100, TRUE)
				obj_integrity = clamp(obj_integrity + max_integrity * integrity_failure, 0, max_integrity)
				user.visible_message(span_notice("[user] finishes repairing [src]."), span_notice("I finished repairing [src]."))
			return
	switch(repair_state)
		if(0)
			if(!istype(I, repair_cost_first))
				return
			user.visible_message(span_notice("[user] starts repairing [src]."), span_notice("I start repairing [src]."))
			playsound(user, 'sound/misc/wood_saw.ogg', 100, TRUE)
			if(!do_after(user, (30 SECONDS / user.mind.get_skill_level(repair_skill)), src)) // 1 skill = 30 secs, 2 skill = 15 secs etc.
				return
			repair_state = 1
			qdel(I)
			playsound(user, 'sound/misc/wood_saw.ogg', 100, TRUE)
		if(1)
			if(!istype(I, repair_cost_second))
				return
			user.visible_message(span_notice("[user] starts repairing [src]."), span_notice("I start repairing [src]."))
			playsound(user, 'sound/misc/wood_saw.ogg', 100, TRUE)
			if(!do_after(user, (30 SECONDS / user.mind.get_skill_level(repair_skill)), src)) // 1 skill = 30 secs, 2 skill = 15 secs etc.
				return
			qdel(I)
			playsound(user, 'sound/misc/wood_saw.ogg', 100, TRUE)
			icon_state = "[initial(icon_state)]"
			density = initial(density)
			layer = initial(layer)
			if(!windowed)
				set_opacity(initial(opacity))
			obj_broken = FALSE
			obj_integrity = max_integrity
			repair_state = 0
			user.visible_message(span_notice("[user] finishes repairing [src]."), span_notice("I finished repairing [src]."))

/obj/structure/mineral_door/proc/trykeylock(obj/item/I, mob/user)
	if(door_opened || switching_states)
		return
	if(!keylock)
		return
	user.changeNext_move(CLICK_CD_MELEE)
	if(istype(I, /obj/item/storage/keyring))
		var/obj/item/storage/keyring/R = I
		if(!length(R.contents))
			to_chat(user, span_info("You have no keys."))
			return
		for(var/obj/item/key/K as anything in shuffle(R.contents.Copy()))
			var/combat = user.cmode
			if(combat && !do_after(user, 1 SECONDS, src))
				door_rattle()
				break
			if(K.lockid == lockid)
				lock_toggle(user)
				break
			if(combat)
				door_rattle()
		return
	var/obj/item/key/K = I
	if(K.lockid != lockid)
		door_rattle()
		return
	lock_toggle(user)

/obj/structure/mineral_door/proc/lock_toggle(mob/user)
	if(switching_states || door_opened)
		return
	if(locked)
		user.visible_message(span_warning("[user] unlocks [src]."), \
			span_notice("I unlock [src]."))
		playsound(src, unlock_sound, 100)
		locked = FALSE
		return
	user.visible_message(span_warning("[user] locks [src]."), \
		span_notice("I lock [src]."))
	playsound(src, lock_sound, 100)
	locked = TRUE

/obj/structure/mineral_door/proc/viewport_toggle(mob/user)
	if(switching_states || door_opened)
		return
	if(!windowed)
		to_chat(user, span_info("I slide the viewport open."))
		windowed = TRUE
		playsound(src, 'sound/foley/doors/windowup.ogg', 100)
		return
	to_chat(user, span_info("I slide the viewport closed."))
	windowed = FALSE
	playsound(src, 'sound/foley/doors/windowup.ogg', 100)

/obj/structure/mineral_door/setAnchored(anchorvalue) //called in default_unfasten_wrench() chain
	. = ..()
	set_opacity(anchored ? !door_opened : FALSE)
	air_update_turf(TRUE)

/obj/structure/mineral_door/obj_break(damage_flag, mapload)
	. = ..()
	if(!obj_broken)
		icon_state = "[initial(icon_state)]br"
		density = FALSE
		set_opacity(FALSE)

/obj/structure/mineral_door/OnCrafted(dirin, user)
	. = ..()
	keylock = FALSE

/obj/structure/mineral_door/green
	icon_state = "wcg"

/obj/structure/mineral_door/red
	icon_state = "wcr"

/obj/structure/mineral_door/violet
	icon_state = "wcv"

/obj/structure/mineral_door/fancy
	icon_state = "fancy_wood"

/obj/structure/mineral_door/window
	icon_state = "woodwindow"
	opacity = FALSE
	windowed = TRUE

/obj/structure/mineral_door/viewport
	icon_state = "donjondir"
	max_integrity = 2000
	has_viewport = TRUE
	lock_sound = 'sound/foley/doors/lockmetal.ogg'
	unlock_sound = 'sound/foley/doors/lockmetal.ogg'
	rattle_sound = 'sound/foley/doors/lockrattlemetal.ogg'
	attacked_sound = list("sound/combat/hits/onmetal/metalimpact (1).ogg", "sound/combat/hits/onmetal/metalimpact (2).ogg")
	repair_cost_second = /obj/item/ingot/iron
	metalizer_result = null

/obj/structure/mineral_door/viewport/Initialize()
	. = ..()
	icon_state = "donjon"

/obj/structure/mineral_door/swing
	name = "swing door"
	desc = "A door that swings."
	icon_state = "swing"
	ridethrough = TRUE
	windowed = TRUE
	opacity = FALSE
	keylock = FALSE
	metalizer_result = /obj/structure/mineral_door/iron/bars
	close_delay = 1 SECONDS
	animate_time = 4

/obj/structure/mineral_door/weak
	icon_state = "wood"
	max_integrity = 500
	kickthresh = 10
	open_sound = 'sound/foley/doors/shittyopen.ogg'
	close_sound = 'sound/foley/doors/shittyclose.ogg'
	metalizer_result = null

/obj/structure/mineral_door/weak/bolt
	icon_state = "woodir"
	has_bolt = TRUE
	keylock = FALSE

/obj/structure/mineral_door/weak/bolt/Initialize()
	. = ..()
	icon_state = "wood"

/obj/structure/mineral_door/weak/bolt/shutter
	name = "serving hatch"
	desc = "Can be locked from the inside."
	icon_state = "serving"
	max_integrity = 250
	open_sound = 'sound/foley/blindsopen.ogg'
	close_sound = 'sound/foley/blindsclose.ogg'
	dir = NORTH
	locked = TRUE
	animate_time = 21

/obj/structure/mineral_door/iron
	name = "iron door"
	icon_state = "donjon"
	armor = list("blunt" = 15, "slash" = 30, "stab" = 30,  "piercing" = 0, "fire" = 50, "acid" = 50)
	max_integrity = 2000
	damage_deflection = 15
	resistance_flags = FIRE_PROOF
	blade_dulling = DULLING_BASH
	open_sound = 'sound/foley/doors/ironopen.ogg'
	close_sound = 'sound/foley/doors/ironclose.ogg'
	lock_sound = 'sound/foley/doors/lockmetal.ogg'
	unlock_sound = 'sound/foley/doors/lockmetal.ogg'
	rattle_sound = 'sound/foley/doors/lockrattlemetal.ogg'
	attacked_sound = list("sound/combat/hits/onmetal/metalimpact (1).ogg", "sound/combat/hits/onmetal/metalimpact (2).ogg")
	repair_cost_first = /obj/item/ingot/iron
	repair_cost_second = /obj/item/ingot/iron
	repair_skill = /datum/skill/craft/blacksmithing
	metalizer_result = null

/obj/structure/mineral_door/iron/bars
	icon_state = "bars"
	max_integrity = 1000
	blade_dulling = DULLING_BASHCHOP
	windowed = TRUE
	opacity = FALSE
	ridethrough = TRUE
	bump_closed = FALSE
	animate_time = 6

/obj/structure/mineral_door/iron/bars/cell
	name = "cell door"
	kickthresh = 20

/obj/structure/mineral_door/wood/fire_act(added, maxstacks)
	testing("added [added]")
	if(!added)
		return FALSE
	if(added < 10)
		return FALSE
	..()

/obj/structure/mineral_door/stone
	name = "stone door"
	icon_state = "stone"
	armor = list("blunt" = 15, "slash" = 30, "stab" = 30,  "piercing" = 0, "fire" = 50, "acid" = 50)
	open_sound = 'sound/foley/doors/stoneopen.ogg'
	close_sound = 'sound/foley/doors/stoneclose.ogg'
	repair_cost_first = /obj/item/natural/stone
	repair_cost_second = /obj/item/natural/stone
	repair_skill = /datum/skill/craft/masonry
	smeltresult = null
	metalizer_result = null

