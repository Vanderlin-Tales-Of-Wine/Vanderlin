
/obj/item/natural
	icon = 'icons/roguetown/items/natural.dmi'
	lefthand_file = 'icons/mob/inhands/misc/food_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/food_righthand.dmi'
	desc = ""
	w_class = WEIGHT_CLASS_TINY
	var/bundletype = null
	var/quality = SMELTERY_LEVEL_NORMAL // To not ruin blacksmith recipes

/obj/item/natural/attackby(obj/item/W, mob/living/user)
	if(istype(W, /obj/item/natural/bundle))
		var/obj/item/natural/bundle/B = W
		if(istype(src, B.stacktype))
			if(B.amount < B.maxamount)
				B.amount++
				B.update_bundle()
				user.visible_message("[user] adds [src] to [W].")
				qdel(src)
			else
				to_chat(user, "There's not enough space in [W].")
			return
	else
		return ..()

/obj/item/natural/attack_right(mob/user)
	var/obj/item/W = user.get_active_held_item()
	if(istype(W, /obj/item/natural))
		var/obj/item/natural/B = W
		if(B.bundletype == src.bundletype && src.bundletype != null)
			var/obj/item/natural/bundle/N = new bundletype(src.loc)
			user.put_in_hands(N)
			to_chat(user, "You tie the [N.stackname] into a bundle.")
			qdel(B)
			qdel(src)
		else
			return ..()
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

/obj/item/natural/bundle/attackby(obj/item/W, mob/living/user)
	if(istype(W, /obj/item/natural/bundle))
		var/obj/item/natural/bundle/B = W
		if(src.stacktype == B.stacktype)
			if(src.amount + B.amount > maxamount)
				B.amount = (src.amount + B.amount) - maxamount
				src.amount = maxamount
				src.update_bundle()
				B.update_bundle()
				to_chat(user, "There's not enough space in [src].")
				if(B.amount == 1)
					var/obj/H = new stacktype(src.loc)
					user.put_in_hands(H)
					qdel(B)
			else
				to_chat(user, "You add the [W] to the [src].")
				src.amount += B.amount
				update_bundle()
				qdel(B)
	else if(istype(W, stacktype))
		if(src.amount < src.maxamount)
			to_chat(user, "You add the [W] to the [src].")
			src.amount++
			qdel(W)
		else
			to_chat(user, "There's not enough space in [src].")
	else
		return ..()

/obj/item/natural/bundle/attack_right(mob/user)
	var/mob/living/carbon/human/H = user
	switch(amount)
		if(2)
			var/obj/F = new stacktype(src.loc)
			var/obj/I = new stacktype(src.loc)
			H.put_in_hands(F)
			H.put_in_hands(I)
			qdel(src)
			return
		else
			amount -= 1
			var/obj/F = new stacktype(src.loc)
			H.put_in_hands(F)
			user.visible_message("[user] removes [F] from [src]")
	update_bundle()

/obj/item/natural/bundle/examine(mob/user)
	. = ..()
	to_chat(user, "<span class='notice'>There are [amount] [stackname] in this bundle.</span>")

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
