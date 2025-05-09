/obj/item/customlock //custom lock unfinished
	name = "unfinished lock"
	desc = "A lock without its pins set. Endless possibilities..."
	icon = 'icons/roguetown/items/keys.dmi'
	icon_state = "lock"
	w_class = WEIGHT_CLASS_SMALL
	dropshrink = 0.75

/obj/item/customlock/examine()
	. = ..()
	if(get_access())
		. += span_info("It has been etched with [access2string()].")
		return
	. += span_info("Its pins can be set with a hammer or copied from an existing lock or key.")

/obj/item/customlock/proc/check_access(obj/item/I)
	var/access
	if(istype(I, /obj/item/key/custom))
		var/obj/item/key/custom/k = I
		if(k.access2add)
			access = k.access2add
		else
			access = k.get_access()
	else
		access = I.get_access()
	if(!access)
		return FALSE
	for(var/id as anything in lockids)
		if(id in access)
			return TRUE
	return FALSE

/obj/item/customlock/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/weapon/hammer))
		var/input = input(user, "What would you like to set the lock ID to?", "", 0) as num
		input = abs(input)
		if(!input)
			return
		to_chat(user, span_notice("You set the lock ID to [input]."))
		lockids = list("[input]")
		return
	if(!check_access(I))
		to_chat(user, span_warning("[I] jams in [src]!"))
		return
	to_chat(user, span_notice("[I] twists cleanly in [src]."))

/obj/item/customlock/attack_right(mob/user)
	var/held = user.get_active_held_item()
	if(istype(held, /obj/item/weapon/hammer))
		if(!length(lockids))
			to_chat(user, span_notice("[src] is not ready, its pins are not set!"))
			return
		var/obj/item/customlock/finished/F = new (get_turf(src))
		F.lockids = lockids
		to_chat(user, span_notice("You finish [F]."))
		qdel(src)
		return
	if(!copy_access(held))
		to_chat(user, span_warning("I cannot base the pins on [held]!"))
		return
	to_chat(user, span_notice("I set the pins based on [held]."))

//finished lock
/obj/item/customlock/finished
	name = "lock"
	desc = "A customized iron lock that is used by keys. A name can be etched in with a hammer."
	var/holdname = ""

/obj/item/customlock/finished/attackby(obj/item/I, mob/user, params)
	if(!istype(I, /obj/item/weapon/hammer))
		..()
	holdname = input(user, "What would you like to name this?", "", "") as text
	if(holdname)
		to_chat(user, span_notice("You label the [name] with [holdname]."))

/obj/item/customlock/finished/attack_right(mob/user)//does nothing. probably better ways to do this but whatever

/obj/item/customlock/finished/attack_obj(obj/O, mob/living/user)
	if(!O.can_add_lock)
		to_chat(user, span_notice("There is no place for a lock on [O]."))
		return
	if(O.lock)
		to_chat(user, span_notice("[O] already has a lock."))
		return
	if(holdname)
		O.name = holdname
	O.lock = new /datum/lock/key(O, lockids)
	to_chat(user, span_notice("I fit [src] to [O]."))
	qdel(src)
