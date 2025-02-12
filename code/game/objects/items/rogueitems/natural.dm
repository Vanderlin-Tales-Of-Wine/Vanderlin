
/obj/item/natural
	icon = 'icons/roguetown/items/natural.dmi'
	desc = ""
	w_class = WEIGHT_CLASS_TINY

	grid_width = 32
	grid_height = 32
	var/bundletype = null
	var/quality = SMELTERY_LEVEL_NORMAL // To not ruin blacksmith recipes

/obj/item/natural/attackby(obj/item/W, mob/living/user)
	if(istype(W, /obj/item/natural/bundle))
		if(item_flags & IN_STORAGE)
			to_chat(user, span_warning("It's hard to find [W] in my bag."))
			return
		var/obj/item/natural/bundle/B = W
		if(istype(src, B.stacktype))
			if(B.amount < B.maxamount)
				B.amount++
				B.update_bundle()
				to_chat(user, span_notice("You add [src] to [W]."))
				qdel(src)
			else
				to_chat(user, span_warning("There's not enough space in [W]."))
			return
	else
		return ..()

/obj/item/natural/pre_attack_right(atom/A, mob/living/user, params)
	if(istype(A, /obj/item/natural))
		if(item_flags & IN_STORAGE)
			to_chat(user, span_warning("It's hard to find [src] in my bag."))
			return
		var/obj/item/natural/B = A
		if(bundletype && bundletype == B.bundletype)
			if(!user.temporarilyRemoveItemFromInventory(src))
				return TRUE
			var/obj/item/natural/bundle/N = new bundletype(loc)
			to_chat(user, span_notice("You collect the [N.stackname] into a bundle."))
			qdel(B)
			qdel(src)
			user.put_in_active_hand(N)
			return TRUE
	return ..()

/obj/item/natural/bundle
	name = "bundle"
	desc = "You shouldn't be seeing this."
	possible_item_intents = list(/datum/intent/use)
	force = 0
	throwforce = 0
	firefuel = 5 MINUTES
	resistance_flags = FLAMMABLE
	var/firemod = 5 MINUTES
	var/amount = 2
	var/maxamount = 10
	var/icon1 = "fibersroll1"
	var/icon1step = 3
	var/icon2 = "fibersroll2"
	var/icon2step = 6
	var/icon3 = null
	var/stacktype = /obj/item/natural/fibers/
	var/stackname = "fibers"
	var/items_per_increase = 5

	var/base_width = 32
	var/base_height = 32

/obj/item/natural/bundle/attackby(obj/item/W, mob/living/user)
	if(amount <= 0) //how did you manage to do this
		qdel(src)
		return
	if(istype(W, /obj/item/natural/bundle))
		var/obj/item/natural/bundle/B = W
		if(src.stacktype == B.stacktype)
			if(src.amount + B.amount > maxamount)
				amount = (src.amount + B.amount) - maxamount
				B.amount = maxamount
				B.update_bundle()
				to_chat(user, span_warning("There's not enough space in [B]."))
				if(amount == 1)
					var/obj/H = new stacktype(src.loc)
					user.put_in_hands(H)
					qdel(src)
				else
					update_bundle()
			else
				to_chat(user, span_notice("You add [src] to [B]."))
				B.amount += amount
				B.update_bundle()
				qdel(src)
	else if(istype(W, stacktype))
		if(item_flags & IN_STORAGE)
			return
		if(src.amount < src.maxamount)
			to_chat(user, span_notice("You add [W] to [src]."))
			src.amount++
			update_bundle()
			qdel(W)
		else
			to_chat(user, span_warning("There's not enough space in [src]."))
	else
		return ..()

/obj/item/natural/bundle/attack_right(mob/user)
	if(item_flags & IN_STORAGE)
		return
	if(amount <= 0) //how did you manage to do this
		qdel(src)
		return
	var/mob/living/carbon/human/H = user
	switch(amount)
		if(2)
			if(!user.temporarilyRemoveItemFromInventory(src))
				return
			var/obj/F = new stacktype(src.loc)
			var/obj/I = new stacktype(src.loc)
			H.put_in_hands(F)
			H.put_in_hands(I)
			qdel(src)
			return
		if(1)
			if(!user.temporarilyRemoveItemFromInventory(src))
				return
			var/obj/F = new stacktype(src.loc)
			H.put_in_hands(F)
			qdel(src)
			return
		else
			amount -= 1
			var/obj/F = new stacktype(src.loc)
			H.put_in_hands(F)
			to_chat(user, span_notice("You remove \a [F] from [src]."))
	update_bundle()

/obj/item/natural/bundle/examine(mob/user)
	. = ..()
	. += span_notice("There are [amount] [stackname] in this bundle.")

/obj/item/natural/bundle/pre_attack_right(atom/A, mob/living/user, params)
	if(amount <= 0) //how did you manage to do this
		qdel(src)
		return
	if(ismob(A))
		return ..()
	user.changeNext_move(CLICK_CD_MELEE)
	if(amount >= maxamount)
		to_chat(user, span_warning("There's not enough space in [src]."))
		return TRUE
	user.visible_message("[user] begins to gather all the [stackname] in front of them.", "I begin gathering all the [stackname] in front of me...")
	var/turf/turflocation = get_turf(A)
	for(var/obj/item/item in turflocation)
		if(amount >= maxamount)
			break
		if(!istype(item, stacktype) && !istype(item, /obj/item/natural/bundle))
			continue
		if(!do_after(user, 5 DECISECONDS, src))
			break
		if(item.loc != turflocation)
			continue
		if(istype(item, stacktype))
			amount++
			qdel(item)
		else if(istype(item, /obj/item/natural/bundle))
			var/obj/item/natural/bundle/B = item
			if(B.stacktype == stacktype)
				if(amount + B.amount > maxamount)
					B.amount = (amount + B.amount) - maxamount
					amount = maxamount
					if(B.amount == 1)
						new B.stacktype(B.loc)
						qdel(B)
					else
						B.update_bundle()
				else
					amount += B.amount
					qdel(B)
		update_bundle()
	return TRUE

/obj/item/natural/bundle/proc/update_bundle()
	if(firefuel != 0)
		firefuel = firemod * amount
	if((amount <= icon1step) && (icon1 != null))
		icon_state = icon1
	else if((icon1step < amount <= icon2step) && (icon2 != null))
		icon_state = icon2
	else
		if(icon3 != null)
			icon_state = icon3
	var/increases = FLOOR(amount / items_per_increase, 1)

	var/height = FALSE
	grid_height = base_height
	grid_width = base_width
	for(var/i = 1 to increases)
		if(height)
			height = FALSE
			grid_height += 32
		else
			height = TRUE
			grid_width += 32
	if(item_flags & IN_STORAGE)
		var/obj/item/location = loc
		var/datum/component/storage/storage = location.GetComponent(/datum/component/storage)

		storage.update_item(src)
		storage.orient2hud()
