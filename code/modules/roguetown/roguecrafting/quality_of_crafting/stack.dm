/obj/item/stack
	name = "stack"
	icon = 'icons/roguetown/items/ore.dmi'
	icon_state = "stackcop2"
	desc = "You shouldn't be seeing this."
	possible_item_intents = list(/datum/intent/use)
	anchored = TRUE
	w_class = WEIGHT_CLASS_NORMAL
	var/amount = 2
	var/maxamount = 10
	var/stacktype = /obj/item/ingot/copper
	var/iconstatename = "stackcop"
	var/stackname
	var/items_per_increase = 1
	var/base_width = 32
	var/base_height = 32

/obj/item/stack/Initialize()
	. = ..()
	var/obj/item/I = stacktype
	sellprice = amount * (I.sellprice)
	update_stack()

/obj/item/ingot/attackby(obj/item/W, mob/living/user)
	if(istype(W, /obj/item/stack))
		if(item_flags & IN_STORAGE)
			to_chat(user, span_warning("It's hard to find [W] in my bag."))
			return
		var/obj/item/stack/B = W
		if(istype(src, B.stacktype))
			if(B.amount < B.maxamount)
				B.amount++
				B.update_stack()
				to_chat(user, span_notice("You add [src] to [W]."))
				qdel(src)
			else
				to_chat(user, span_warning("There's not enough space in [W]."))
			return
	else
		return ..()

/obj/item/ingot/pre_attack_right(atom/A, mob/living/user, params)
	if(istype(A, /obj/item/ingot))
		if(item_flags & IN_STORAGE)
			to_chat(user, span_warning("It's hard to find [src] in my bag."))
			return
		var/obj/item/ingot/B = A
		if(stacktype && stacktype == B.stacktype)
			if(!user.temporarilyRemoveItemFromInventory(src))
				return TRUE
			var/obj/item/stack/N = new stacktype(loc)
			to_chat(user, span_notice("You place the [N.stackname] into a stack."))
			qdel(B)
			qdel(src)
			user.dropItemToGround(N)
			return TRUE
	return ..()


/obj/item/stack/attackby(obj/item/W, mob/living/user)
	if(amount <= 0) //how did you manage to do this
		qdel(src)
		return
	if(istype(W, /obj/item/stack))
		var/obj/item/stack/B = W
		if(src.stacktype == B.stacktype)
			if(src.amount + B.amount > maxamount)
				amount = (src.amount + B.amount) - maxamount
				B.amount = maxamount
				B.update_stack()
				to_chat(user, span_warning("There's not enough space in [B]."))
				if(amount == 1)
					var/obj/H = new stacktype(src.loc)
					user.put_in_hands(H)
					qdel(src)
				else
					update_stack()
			else
				to_chat(user, span_notice("You add [src] to [B]."))
				B.amount += amount
				B.update_stack()
				qdel(src)
	else if(istype(W, stacktype))
		if(item_flags & IN_STORAGE)
			return
		if(src.amount < src.maxamount)
			to_chat(user, span_notice("You add [W] to [src]."))
			src.amount++
			update_stack()
			qdel(W)
		else
			to_chat(user, span_warning("There's not enough space in [src]."))
	else
		return ..()

/obj/item/stack/attack_right(mob/user)
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
	update_stack()

/obj/item/stack/examine(mob/user)
	. = ..()
	. += span_notice("There are [amount] [stackname] in this stack.")

/obj/item/stack/pre_attack_right(atom/A, mob/living/user, params)
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
		if(!istype(item, stacktype) && !istype(item, /obj/item/stack))
			continue
		if(!do_after(user, 5, TRUE, src))
			break
		if(item.loc != turflocation)
			continue
		if(istype(item, stacktype))
			amount++
			qdel(item)
		else if(istype(item, /obj/item/stack))
			var/obj/item/stack/B = item
			if(B.stacktype == stacktype)
				if(amount + B.amount > maxamount)
					B.amount = (amount + B.amount) - maxamount
					amount = maxamount
					if(B.amount == 1)
						new B.stacktype(B.loc)
						qdel(B)
					else
						B.update_stack()
				else
					amount += B.amount
					qdel(B)
		update_stack()
	return TRUE

/obj/item/stack/proc/update_stack()
	icon_state = "[iconstatename][amount]"
	var/increases = FLOOR(amount / items_per_increase, 1)
	var/height = FALSE
	var/obj/item/I = stacktype
	sellprice = amount * (I.sellprice)
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

/obj/item/stack/gold
	name = "gold ingot stack"
	desc = "A glimmering pile of gold ingots."
	stacktype = /obj/item/ingot/gold
	iconstatename = "stackgold"
	stackname = "gold ingots"
	icon_state = "stackgold2"

/obj/item/stack/iron
	name = "iron ingot stack"
	desc = "A neat pile of iron ingots."
	stacktype = /obj/item/ingot/iron
	iconstatename = "stackiron"
	stackname = "iron ingots"
	icon_state = "stackiron2"


/obj/item/stack/copper
	name = "copper ingot stack"
	desc = "A neat pile of copper ingots."
	stacktype = /obj/item/ingot/copper
	iconstatename = "stackcop"
	stackname = "copper ingots"
	icon_state = "stackcop2"

/obj/item/stack/tin
	name = "tin ingot stack"
	desc = "A neat pile of tin ingots."
	stacktype = /obj/item/ingot/tin
	iconstatename = "stacktin"
	stackname = "tin ingots"
	icon_state = "stacktin2"

/obj/item/stack/bronze
	name = "bronze ingot stack"
	desc = "A neat pile of bronze ingots."
	stacktype = /obj/item/ingot/bronze
	iconstatename = "stackbronze"
	stackname = "bronze ingots"
	icon_state = "stackbronze2"

/obj/item/stack/silver
	name = "silver ingot stack"
	desc = "A shiny pile of silver ingots."
	stacktype = /obj/item/ingot/silver
	iconstatename = "stacksilv"
	stackname = "silver ingots"
	icon_state = "stacksilv2"

/obj/item/stack/steel
	name = "steel ingot stack"
	desc = "A neat pile of steel ingots begging to be turned into weaponry."
	stacktype = /obj/item/ingot/steel
	iconstatename = "stacksteel"
	stackname = "steel ingots"
	icon_state = "stacksteel2"

/obj/item/stack/blacksteel
	name = "blacksteel ingot stack"
	desc = "A neat pile of blacksteel ingots. An armoursmith's dream."
	stacktype = /obj/item/ingot/blacksteel
	iconstatename = "stackblacksteel"
	stackname = "blacksteel ingots"
	icon_state = "stackblacksteel2"


