/obj/structure/handcart
	name = "cart"
	desc = "A wooden cart that will help you carry many things."
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "cart-empty"
	density = TRUE
	max_integrity = 600
	anchored = FALSE
	climbable = TRUE

	var/list/stuff_shit = list()

	var/current_capacity = 0
	var/maximum_capacity = 60 //arbitrary maximum amount of weight allowed in the cart before it says fuck off

	var/arbitrary_living_creature_weight = 10 // The arbitrary weight for any thing of a mob and living variety
	var/obj/item/gear/wood/upgrade = null
	facepull = FALSE
	throw_range = 1
	drag_slowdown = 0.8 // weeping and gnashing of teeth

/obj/structure/handcart/examine(mob/user)
	. = ..()
	if(upgrade)
		. += span_notice("This cart has \an [upgrade] installed.")

/obj/structure/handcart/Initialize(mapload)
	if(mapload)		// if closed, any item at the crate's loc is put in the contents
		addtimer(CALLBACK(src, PROC_REF(take_contents)), 0)
	. = ..()
	update_icon()

/obj/structure/handcart/container_resist(mob/living/user)
	var/atom/L = drop_location()
	for(var/atom/movable/AM in stuff_shit)
		if(AM == user)
			AM.forceMove(L)
			stuff_shit -= AM
			current_capacity = max(current_capacity-arbitrary_living_creature_weight, 0)
			update_icon()
			break

/obj/structure/handcart/dump_contents()
	var/atom/L = drop_location()
	for(var/atom/movable/AM in src)
		AM.forceMove(L)
	stuff_shit = list()
	current_capacity = 0

/obj/structure/handcart/Destroy()
	dump_contents()
	return ..()

/obj/structure/handcart/MouseDrop_T(atom/movable/O, mob/living/user)
	if(!istype(O) || !isturf(O.loc) || istype(O, /atom/movable/screen))
		return
	if(!istype(user) || user.incapacitated())
		return
	if(!Adjacent(user) || !user.Adjacent(O))
		return
	if(user == O) //try to climb into or onto it
		if(user.body_position == LYING_DOWN)
			if(!do_after(user, 2 SECONDS, src))
				return FALSE
			if(put_in(O))
				playsound(loc, 'sound/foley/cartadd.ogg', 100, FALSE, -1)
			return TRUE
		return ..()
	//only these intents should be able to move objects into handcarts
	if(user.used_intent.type == INTENT_HELP || user.used_intent.type == /datum/intent/grab/move)
		if(isliving(O))
			if(!do_after(user, 2 SECONDS, O))
				return FALSE
		if(put_in(O))
			playsound(loc, 'sound/foley/cartadd.ogg', 100, FALSE, -1)
		return TRUE

/obj/structure/handcart/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/gear/wood))
		var/obj/item/gear/wood/cog = I
		if(cog.cart_capacity <= maximum_capacity)
			to_chat(user, span_warning("[src] already has a better upgrade installed!"))
			return
		upgrade = I
		maximum_capacity = cog.cart_capacity
		qdel(cog)
		playsound(src, pick('sound/combat/hits/onwood/fence_hit1.ogg', 'sound/combat/hits/onwood/fence_hit2.ogg', 'sound/combat/hits/onwood/fence_hit3.ogg'), 100, FALSE)
		shake_camera(user, 1, 1)
		to_chat(user, span_notice("I upgrade [src] with [cog]."))
		update_icon()
		return
	if(!user.cmode)
		if(put_in(I, user))
			playsound(loc, 'sound/foley/cartadd.ogg', 100, FALSE, -1)
		return
	..()

/obj/structure/handcart/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(user.cmode)
		return
	var/turf/T = get_turf(user)
	if(isturf(T))
		user.changeNext_move(CLICK_CD_MELEE)
		var/fou

		//First, we do ores.
		if(put_in_ores_and_gems(T))
			fou = TRUE
		//Then, we try wood
		else if(put_in_wood(T))
			fou = TRUE
		// Then, everything else.
		else
			for(var/obj/item/I in T)
				//Only play the sound if success.
				if(put_in(I))
					fou = TRUE
		if(fou)
			playsound(loc, 'sound/foley/cartadd.ogg', 100, FALSE, -1)


/**
 * @brief This allows you to sieve through objects on a given turf and insert
 * them into the cart if they match the given type.
 *
 * @param user_turf: The turf of the mob that clicked on this cart. This is checked by attack_hand, so
 * no need for much paranoia here.
 * @param types: Must be a list of type paths. Individually enforced for each item in the list.
 * This proc will partially succeed even if some of the typepaths in the typelist are bogus.
 *
 * @return bool: Whether this proc has inserted at least one item.
 */
/obj/structure/handcart/proc/filtered_put(turf/user_turf, list/types)
	//Turf check should be handled by caller.
	var/have_inserted = FALSE

	//Nothing especially fancy here. We just check for one of the types to match
	// before letting the object be "put in".
	for(var/obj/item/I in user_turf)
		for(var/typepath in types)
			//Make sure it's actually a path...
			if(!ispath(typepath))
				continue
			//Check the type of the object and insert if match.
			if(istype(I, typepath))
				put_in(I)
				have_inserted = TRUE
	if(have_inserted)
		playsound(loc, 'sound/foley/cartadd.ogg', 100, FALSE, -1)

	return have_inserted

//Handles any object that's an ore or a gem (in the future, should change to raw gems if you add refinement steps)
/obj/structure/handcart/proc/put_in_ores_and_gems(turf/user_turf)
	return filtered_put(user_turf, list(/obj/item/ore, /obj/item/gem))

//Handles logs (big, small), sticks. Big logs may run afoul of the cart's weight limits.
/obj/structure/handcart/proc/put_in_wood(turf/user_turf)
	return filtered_put(user_turf, list(/obj/item/grown/log/tree))

/obj/structure/handcart/proc/put_in(atom/movable/O, mob/user)
	if(!insertion_allowed(O))
		return
	var/weight = 0
	if(isitem(O))
		var/obj/item/I = O
		if((current_capacity + I.w_class) > maximum_capacity)
			return FALSE
		weight = I.w_class
	if(isliving(O))
		if((current_capacity + arbitrary_living_creature_weight) > maximum_capacity)
			return FALSE
		weight = arbitrary_living_creature_weight
	if(user && !user.transferItemToLoc(O, src))
		return FALSE
	else
		O.forceMove(src)
	current_capacity += weight
	stuff_shit += O
	update_icon()
	return TRUE

/obj/structure/handcart/proc/take_contents()
	var/atom/L = drop_location()
	for(var/atom/movable/AM in L)
		if(AM != src && put_in(AM)) // limit reached
			break

/obj/structure/handcart/update_icon()
	. = ..()
	cut_overlays()
	switch(maximum_capacity)
		if(90 to 119)
			add_overlay("ov_upgrade")
		if(120 to INFINITY)
			add_overlay("ov_upgrade2")
	if(length(stuff_shit))
		icon_state = "cart-full"
	else
		icon_state = "cart-empty"

/obj/structure/handcart/attack_right(mob/user)
	. = ..()
	if(.)
		return
	user.changeNext_move(CLICK_CD_MELEE)
	if(length(stuff_shit))
		dump_contents()
		visible_message(span_info("[user] dumps out [src]!"))
		playsound(loc, 'sound/foley/cartdump.ogg', 100, FALSE, -1)
	update_icon()

/obj/structure/handcart/proc/insertion_allowed(atom/movable/AM)
	if(ismob(AM))
		if(!isliving(AM)) //let's not put ghosts or camera mobs inside closets...
			return FALSE
		var/mob/living/L = AM
		if(L.anchored || (L.buckled && L.buckled != src) || L.incorporeal_move || L.has_buckled_mobs())
			return FALSE
		if(L.mob_size > MOB_SIZE_TINY) // Tiny mobs are treated as items.
			if(L.density)
				return FALSE
		L.stop_pulling()
	else if(isobj(AM))
		if((AM.density) || AM.anchored || AM.has_buckled_mobs() || iseffect(AM))
			return FALSE
		else
			if(isitem(AM))
				var/obj/item/I = AM
				if(HAS_TRAIT(I, TRAIT_NODROP) || I.item_flags & ABSTRACT)
					return FALSE
	else // not a mob or object
		return FALSE

	return TRUE

/obj/structure/handcart/Move(atom/newloc, direct, glide_size_override)
	. = ..()
	if (. && pulledby && dir != pulledby.dir)
		setDir(pulledby.dir)
