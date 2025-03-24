/obj/item/customlock //custom lock unfinished
	name = "unfinished lock"
	desc = "A lock without its pins set. Endless possibilities..."
	icon = 'icons/roguetown/items/keys.dmi'
	icon_state = "lock"
	w_class = WEIGHT_CLASS_SMALL
	dropshrink = 0.75

/obj/item/customlock/examine()
	. += ..()
	if(src.get_access())
		. += span_info("It has been etched with [src.access2string()].")
		return
	. += span_info("Its pins can be set with a hammer or copied from an existing lock or key.")

/obj/item/customlock/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/weapon/hammer))
		var/input = input(user, "What would you like to set the lock ID to?", "", 0) as num
		input = abs(input)
		if(!input)
			return
		to_chat(user, span_notice("You set the lock ID to [input]."))
		src.lockids = list("[input]")
		return
	if(!src.check_access(I))
		to_chat(user, span_warning("[I] jams in [src]!"))
		return
	to_chat(user, span_notice("[I] twists cleanly in [src]."))

/obj/item/customlock/attack_right(mob/user)
	var/held = user.get_active_held_item()
	if(istype(held, /obj/item/weapon/hammer))
		if(!length(src.lockids))
			to_chat(user, span_notice("[src] is not ready, its pins are not set!"))
			return
		var/obj/item/customlock/finished/F = new (get_turf(src))
		F.lockids = src.lockids
		to_chat(user, span_notice("You finish [F]."))
		qdel(src)
		return
	if(!src.copy_access(held))
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
	src.holdname = input(user, "What would you like to name this?", "", "") as text
	if(holdname)
		to_chat(user, span_notice("You label the [name] with [holdname]."))

/obj/item/customlock/finished/attack_right(mob/user)//does nothing. probably better ways to do this but whatever

/obj/item/customlock/finished/attack_obj(obj/O, mob/living/user)
	if(!O.can_add_lock)
		to_chat(user, span_warning("A lock can't be added to [O]."))
		return
	if(O.keylock)
		to_chat(user, span_warning("[O] already has a lock."))
		return
	if(src.holdname)
		O.name = src.holdname
	O.copy_access(src)
	to_chat(user, span_notice("You fit [src] to [O]."))
	qdel(src)
