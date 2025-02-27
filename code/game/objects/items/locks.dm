

//custom lock unfinished
/obj/item/customlock
	name = "unfinished lock"
	desc = "A lock without its pins set. Endless possibilities..."
	icon = 'icons/roguetown/items/keys.dmi'
	icon_state = "lock"
	w_class = WEIGHT_CLASS_SMALL
	dropshrink = 0.75
	var/lockhash = 0

/obj/item/customlock/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/weapon/hammer))
		var/input = input(user, "What would you like to set the lock ID to?", "", 0) as num
		input = abs(input)
		if(!input)
			return
		to_chat(user, span_notice("You set the lock ID to [input]."))
		lockhash = 10000 + input //same deal as the customkey
	else if(istype(I, /obj/item/key))
		var/obj/item/key/ID = I
		if(ID.lockhash == src.lockhash)
			to_chat(user, span_notice("[I] twists cleanly in [src]."))
		else
			to_chat(user, span_warning("[I] jams in [src]."))
	else if(istype(I, /obj/item/key_custom_blank))
		var/obj/item/key_custom_blank/ID = I
		if(ID.lockhash == src.lockhash)
			to_chat(user, span_notice("[I] twists cleanly in [src].")) //this makes no sense since the teeth aren't formed yet but i want people to be able to check whether the locks theyre making actually fit
		else
			to_chat(user, span_warning("[I] jams in [src]."))

/obj/item/customlock/attack_right(mob/user)
	if(istype(user.get_active_held_item(), /obj/item/key))//i need to figure out how to avoid these massive if/then trees, this sucks
		var/obj/item/key/held = user.get_active_held_item()
		src.lockhash = held.lockhash
		to_chat(user, span_notice("You align the lock's internals to [held].")) //locks for non-custom keys
	else if(istype(user.get_active_held_item(), /obj/item/key_custom_blank))
		var/obj/item/key_custom_blank/held = user.get_active_held_item()
		src.lockhash = held.lockhash
		to_chat(user, span_notice("You align the lock's internals to [held]."))
	else if(istype(user.get_active_held_item(), /obj/item/weapon/hammer) && src.lockhash != 0)
		var/obj/item/customlock/finished/F = new (get_turf(src))
		F.lockhash = src.lockhash
		to_chat(user, span_notice("You finish [F]."))
		qdel(src)

//finished lock
/obj/item/customlock/finished
	name = "lock"
	desc = "A customized iron lock that is used by keys."
	var/holdname = ""

/obj/item/customlock/finished/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/weapon/hammer))
		src.holdname = input(user, "What would you like to name this?", "", "") as text
		if(holdname)
			to_chat(user, span_notice("You label the [name] with [holdname]."))
	else
		..()

/obj/item/customlock/finished/attack_right(mob/user)//does nothing. probably better ways to do this but whatever

/obj/item/customlock/finished/attack_obj(obj/structure/K, mob/living/user)
	if(istype(K, /obj/structure/closet))
		var/obj/structure/closet/KE = K
		if(KE.keylock == TRUE)
			to_chat(user, span_warning("[K] already has a lock."))
		else
			KE.keylock = TRUE
			KE.lockhash = src.lockhash
			if(src.holdname)
				KE.name = (src.holdname + " " + KE.name)
			to_chat(user, span_notice("You add [src] to [K]."))
			qdel(src)
	if(istype(K, /obj/structure/mineral_door))
		var/obj/structure/mineral_door/KE = K
		if(KE.can_add_lock)
			if(KE.keylock == TRUE)
				to_chat(user, span_warning("[K] already has a lock."))
			else
				KE.keylock = TRUE
				KE.lockhash = src.lockhash
				if(src.holdname)
					KE.name = src.holdname
				to_chat(user, span_notice("You add [src] to [K]."))
				qdel(src)
		else
			to_chat(user, span_warning("A lock can't be added to [K]."))
