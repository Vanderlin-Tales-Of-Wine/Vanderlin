#define PILLORY_HEAD_OFFSET      2 // How much we need to move the player to center their head

/obj/structure/pillory
	name = "pillory"
	desc = "To keep the criminals locked!"
	icon_state = "pillory_single"
	icon = 'icons/obj/pillory.dmi'
	can_buckle = TRUE
	max_buckled_mobs = 1
	buckle_lying = 0
	buckle_prevents_pull = TRUE
	anchored = TRUE
	density = TRUE
	layer = ABOVE_ALL_MOB_LAYER
	plane = GAME_PLANE_UPPER
	keylock = TRUE
	locked = FALSE
	lockids = list(ACCESS_GARRISON, ACCESS_DUNGEON, ACCESS_AT_ARMS)
	var/latched = FALSE
	var/base_icon = "pillory_single"

/obj/structure/pillory/double
	icon_state = "pillory_double"
	base_icon = "pillory_double"

/obj/structure/pillory/reinforced
	icon_state = "pillory_reinforced"
	base_icon = "pillory_reinforced"

/obj/structure/pillory/Initialize()
	LAZYINITLIST(buckled_mobs)
	. = ..()

/obj/structure/pillory/OnCrafted(dirin, mob/user)
	. = ..()
	keylock = FALSE
	can_add_lock = TRUE
	lockids = null

/obj/structure/pillory/examine(mob/user)
	. = ..()
	. += span_info("It is [latched ? "latched" : "unlatched"].")
	if(keylock)
		. += span_info("It is [locked ? "locked" : "unlocked"].")

/obj/structure/pillory/attack_right(mob/living/user)
	. = ..()
	if(!length(buckled_mobs))
		to_chat(user, span_warning("What's the point of latching it with nobody inside?"))
		return
	if(user in buckled_mobs)
		to_chat(user, span_warning("I can't reach the latch!"))
		return
	togglelatch(user)

/obj/structure/pillory/attackby(obj/item/I, mob/user, params)
	if(user in buckled_mobs)
		to_chat(user, span_warning("I can't reach the lock!"))
		return
	if(!latched)
		to_chat(user, span_warning("\The [src] is not latched shut!"))
		return
	if(!I.has_access())
		return ..()
	if(!keylock || !has_access())
		to_chat(user, span_warning("\the [src] has no lock!"))
		return
	if(check_access(I))
		togglelock(user)
		return
	to_chat(user, span_warning("I lack the key for \the [src]."))
	playsound(get_turf(src), 'sound/foley/doors/lockrattle.ogg', 100)

/obj/structure/pillory/proc/togglelatch(mob/living/user, silent)
	user.changeNext_move(CLICK_CD_MELEE)
	if(locked)
		to_chat(user, span_info("\The [src] is locked."))
		return
	latched = !latched
	user.visible_message( \
		span_warning("[user] [latched ? "latches" : "unlatches"] \the [src]."), \
		span_notice("I [latched ? "latch" : "unlatch"] \the [src]"))
	playsound(get_turf(src), 'sound/foley/doors/lock.ogg', 100)

/obj/structure/pillory/proc/togglelock(mob/living/user, silent)
	user.changeNext_move(CLICK_CD_MELEE)
	if (!latched)
		to_chat(user, span_info("\The [src] is not latched shut."))
		return
	locked = !locked
	user.visible_message( \
		span_warning("[user] [locked ? "locks" : "unlocks"] \the [src]."), \
		span_notice("I [locked ? "lock" : "unlock"] \the [src]"))
	playsound(get_turf(src), 'sound/foley/doors/lock.ogg', 100)

/obj/structure/pillory/buckle_mob(mob/living/M, force = FALSE, check_loc = TRUE)
	if (!anchored)
		return FALSE

	if(locked)
		to_chat(usr, span_warning("Unlock it first!"))
		return FALSE

	if (!istype(M, /mob/living/carbon/human))
		to_chat(usr, span_warning("It doesn't look like [M.p_they()] can fit into this properly!"))
		return FALSE // Can't hold non-humanoids

	if(iscarbon(M))
		var/mob/living/carbon/carbon = M
		if(carbon.handcuffed)
			return ..(carbon, force, FALSE)

	for(var/obj/item/grabbing/G in M.grabbedby)
		if(G.grab_state == GRAB_AGGRESSIVE)
			return ..(M, force, FALSE)

	to_chat(usr, span_warning("I must grab them more forcefully to put them in [src]."))
	return FALSE

/obj/structure/pillory/post_buckle_mob(mob/living/M)
	if (!istype(M, /mob/living/carbon/human))
		return

	var/mob/living/carbon/human/H = M

	if (H.dna)
		if (H.dna.species)
			var/datum/species/S = H.dna.species

			if (istype(S))
				//H.cut_overlays()
				H.update_body_parts_head_only()
				density = FALSE
				switch(H.dna.species.name)
					if ("Dwarf","Goblin")
						H.set_mob_offsets("bed_buckle", _x = 0, _y = PILLORY_HEAD_OFFSET)
				icon_state = "[base_icon]-over"
				update_icon()
			else
				unbuckle_all_mobs()
		else
			unbuckle_all_mobs()
	else
		unbuckle_all_mobs()

	..()

/obj/structure/pillory/post_unbuckle_mob(mob/living/M)
	M.regenerate_icons()
	M.reset_offsets("bed_buckle")
	icon_state = "[base_icon]"
	update_icon()
	..()

/obj/structure/pillory/user_unbuckle_mob(mob/living/buckled_mob, mob/living/user)
	if(latched)
		if(isliving(user) && user.STASTR >= 18)
			if(do_after(user, 2.5 SECONDS))
				user.visible_message(span_warning("[user] breaks [src] open!"))
				locked = FALSE
				latched = FALSE
				return ..()
		else
			to_chat(usr, span_warning("Unlatch it first!"))
			return FALSE
	else
		density = TRUE
		return ..()
	density = TRUE
	return ..()

#undef PILLORY_HEAD_OFFSET
