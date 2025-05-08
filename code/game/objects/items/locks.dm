/obj/item/customlock //custom lock unfinished
	name = "unfinished lock"
	desc = "A lock without its pins set. Endless possibilities..."
	icon = 'icons/roguetown/items/keys.dmi'
	icon_state = "lock"
	w_class = WEIGHT_CLASS_SMALL
	dropshrink = 0.75
	var/lockid = null

/obj/item/customlock/examine()
	. += ..()
	if(src.lockid)
		. += span_info("It has been etched with [src.lockid].")
		return
	. += span_info("Its pins can be set with a hammer or copied from an existing lock or key.")

/obj/item/customlock/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/weapon/hammer))
		var/input = input(user, "What would you like to set the lock ID to?", "", 0) as num
		input = abs(input)
		if(!input)
			return
		to_chat(user, span_notice("You set the lock ID to [input]."))
		lockid = "[input]"
		return
	if(istype(I, /obj/item/key))
		var/obj/item/key/K = I
		if(istype(K, /obj/item/key/custom) && !K.lockid)
			var/obj/item/key/custom/CK = I
			if(CK.idtoset == src.lockid)
				to_chat(user, span_notice("[I] twists cleanly in [src].")) //this makes no sense since the teeth aren't formed yet but i want people to be able to check whether the locks theyre making actually fi
				return
			to_chat(user, span_warning("[I] jams in [src]!"))
			return
		if(K.lockid == src.lockid)
			to_chat(user, span_notice("[I] twists cleanly in [src]."))
			return
		to_chat(user, span_warning("[I] jams in [src]!"))

/obj/item/customlock/attack_right(mob/user)
	var/held = user.get_active_held_item()
	if(istype(held, /obj/item/key))//i need to figure out how to avoid these massive if/then trees, this sucks
		var/obj/item/key/K = held
		if(istype(K, /obj/item/key/custom) && !K.lockid)
			var/obj/item/key/custom/CK = held
			if(!CK.idtoset)
				to_chat(user, span_warning("[held] has no teeth!"))
				return
			src.lockid = CK.idtoset
			to_chat(user, span_notice("You align the lock's internals to [held]."))
			return
		if(!K.lockid)
			to_chat(user, span_warning("[held] has no teeth!"))
			return
		src.lockid = K.lockid
		to_chat(user, span_notice("You align the lock's internals to [held].")) //locks for non-custom keys
		return
	if(istype(held, /obj/item/weapon/hammer))
		if(!src.lockid)
			to_chat(user, span_notice("[src] is not ready, its pins are not set!"))
			return
		var/obj/item/customlock/finished/F = new (get_turf(src))
		F.lockid = src.lockid
		to_chat(user, span_notice("You finish [F]."))
		qdel(src)

//finished lock
/obj/item/customlock/finished
	name = "lock"
	desc = "A customized iron lock that is used by keys. A name can be etched in with a hammer."
	var/holdname = ""

/obj/item/customlock/finished/attackby(obj/item/I, mob/user, params)
	if(!istype(I, /obj/item/weapon/hammer))
		..()
	src.holdname = input(user, "What would you like to name this?", "", "") as text
	if(holdname)
		to_chat(user, span_notice("You label the [name] with [holdname]."))

/obj/item/customlock/finished/attack_right(mob/user)//does nothing. probably better ways to do this but whatever

/obj/item/customlock/finished/attack_obj(obj/structure/S, mob/living/user)
	if(istype(S, /obj/structure/closet))
		var/obj/structure/closet/closet = S
		if(closet.keylock == TRUE)
			to_chat(user, span_warning("[S] already has a lock."))
			return
		closet.keylock = TRUE
		closet.lockid = src.lockid
		if(src.holdname)
			closet.name = (src.holdname + " " + closet.name)
		to_chat(user, span_notice("You add [src] to [S]."))
		qdel(src)
		return
	if(istype(S, /obj/structure/door))
		var/obj/structure/door/door = S
		if(!door.can_add_lock)
			to_chat(user, span_warning("A lock can't be added to [S]."))
		if(door.keylock == TRUE)
			to_chat(user, span_warning("[S] already has a lock."))
			return
		door.keylock = TRUE
		door.lockid = src.lockid
		if(src.holdname)
			door.name = src.holdname
		to_chat(user, span_notice("You add [src] to [door]."))
		qdel(src)

