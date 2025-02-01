#define CTYPE_GOLD "g"
#define CTYPE_SILV "s"
#define CTYPE_COPP "c"
#define MAX_COIN_STACK_SIZE 20

/obj/item/roguecoin
	name = ""
	desc = ""
	icon = 'icons/roguetown/items/valuable.dmi'
	icon_state = ""
	lefthand_file = 'icons/mob/inhands/misc/food_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/food_righthand.dmi'
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_MOUTH
	dropshrink = 0.2
	drop_sound = 'sound/foley/coinphy (1).ogg'
	sellprice = 0
	static_price = TRUE
	simpleton_price = TRUE
	var/flip_cd
	var/heads_tails = TRUE
	var/last_merged_heads_tails = TRUE
	var/base_type //used for compares
	var/quantity = 1
	var/plural_name
	var/rigged_outcome = 0 //1 for heads, 2 for tails

/obj/item/roguecoin/Initialize(mapload, coin_amount)
	. = ..()
	if(coin_amount >= 1)
		set_quantity(floor(coin_amount))

/obj/item/roguecoin/getonmobprop(tag)
	. = ..()
	if(tag != "gen")
		return
	return list("shrink" = 0.10, "sx" = -6, "sy" = 6, "nx" = 6, "ny" = 7, "wx" = 0, "wy" = 5, "ex" = -1, "ey" = 7, "northabove" = 0, "southabove" = 1, "eastabove" = 1, "westabove" = 0, "nturn" = -50, "sturn" = 40, "wturn" = 50, "eturn" = -50, "nflip" = 0, "sflip" = 8, "wflip" = 8, "eflip" = 0)

/obj/item/roguecoin/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	playsound(loc, 'sound/foley/coins1.ogg', 100, TRUE, -2)
	scatter(get_turf(src))
	..()

/obj/item/roguecoin/pickup(mob/user)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_MATTHIOS_CURSE))
		var/mob/living/carbon/human/H = user
		to_chat(H, span_warning("The idea repulses me!"))
		H.cursed_freak_out()
		H.Paralyze(20)
		return

/obj/item/roguecoin/proc/scatter(turf/T)
	pixel_x = rand(-8, 8)
	pixel_y = rand(-5, 5)
	if(isturf(T) && quantity > 1)
		for(var/i in 2 to quantity) // exclude the first coin
			var/spawned_type = type
			if(base_type)
				switch(base_type)
					if(CTYPE_GOLD)
						spawned_type = /obj/item/roguecoin/gold
					if(CTYPE_SILV)
						spawned_type = /obj/item/roguecoin/silver
					else
						spawned_type = /obj/item/roguecoin/copper

			var/obj/item/roguecoin/new_coin = new spawned_type
			new_coin.forceMove(T)
			new_coin.set_quantity(1) // prevent exploits with coin piles
			new_coin.pixel_x = rand(-8, 8)
			new_coin.pixel_y = rand(-5, 5)

	set_quantity(1)

/obj/item/roguecoin/get_real_price()
	return sellprice * quantity

/obj/item/roguecoin/proc/set_quantity(new_quantity)
	quantity = new_quantity
	update_icon()
	update_transform()

/obj/item/roguecoin/examine(mob/user)
	. = ..()
	if(quantity > 1)
		. += "<span class='info'>\Roman [quantity] coins.</span>"

/obj/item/roguecoin/proc/merge(obj/item/roguecoin/G, mob/user)
	if(!G)
		return
	if(G.base_type != base_type)
		return
	if(user)
		if(user.get_inactive_held_item() != G && !isturf(G.loc) && user.get_active_held_item() != G)
			return

	var/amt_to_merge = min(G.quantity, MAX_COIN_STACK_SIZE - quantity)
	if(amt_to_merge <= 0)
		return
	set_quantity(quantity + amt_to_merge)
	last_merged_heads_tails = G.heads_tails

	G.set_quantity(G.quantity - amt_to_merge)
	rigged_outcome = 0
	G.rigged_outcome = 0
	if(G.quantity <= 0)
		qdel(G)
	playsound(loc, 'sound/foley/coins1.ogg', 100, TRUE, -2)

/obj/item/roguecoin/attack_right(mob/user)
	if(user.get_active_held_item())
		return ..()
	if(quantity == 1)
		if(HAS_TRAIT(user, TRAIT_BLACKLEG))
			var/outcome = alert(user, "What will you rig the next coin flip to?","XYLIX","Heads","Tails","Play fair")
			if(QDELETED(src) || !user.is_holding(src))
				return
			switch(outcome)
				if("Heads")
					rigged_outcome = 1
				if("Tails")
					rigged_outcome = 2
				if("Play fair")
					rigged_outcome = 0
		return
	user.put_in_active_hand(new type(user.loc, 1))
	set_quantity(quantity - 1)

/obj/item/roguecoin/attack_hand(mob/user)
	if(user.get_inactive_held_item() == src && quantity > 1)
		var/amt_text = " (1 to [quantity])"
		if(quantity == 1)
			amt_text = ""
		var/amount = input(user, "How many [plural_name] to split?[amt_text]", null, round(quantity/2, 1)) as null|num
		if(QDELETED(src) || !user.is_holding(src))
			return
		amount = clamp(amount, 0, quantity)
		amount = round(amount, 1) // no taking non-integer coins
		if(!amount)
			return
		if(amount >= quantity)
			return ..()
		var/obj/item/roguecoin/new_coins = new type()
		new_coins.set_quantity(amount)
		new_coins.heads_tails = last_merged_heads_tails
		set_quantity(quantity - amount)

		user.put_in_hands(new_coins)
		playsound(loc, 'sound/foley/coins1.ogg', 100, TRUE, -2)
		return
	..()


/obj/item/roguecoin/attack_self(mob/living/user)
	if(quantity > 1 || !base_type)
		return
	if(world.time < flip_cd + 30)
		return
	flip_cd = world.time
	playsound(user, 'sound/foley/coinphy (1).ogg', 100, FALSE)
	var/flip_outcome = rigged_outcome ? rigged_outcome : prob(50)
	switch(flip_outcome)
		if(1)
			user.visible_message("<span class='info'>[user] flips the coin. Heads!</span>")
			heads_tails = TRUE
		if(0,2)
			user.visible_message("<span class='info'>[user] flips the coin. Tails!</span>")
			heads_tails = FALSE
	rigged_outcome = 0
	update_icon()

/obj/item/roguecoin/update_icon()
	..()
	if(quantity > 1)
		drop_sound = 'sound/foley/coins1.ogg'
	else
		drop_sound = 'sound/foley/coinphy (1).ogg'

	if(quantity == 1)
		name = initial(name)
		desc = initial(desc)
		icon_state = "[base_type][heads_tails]"
		dropshrink = 0.2
		return

	name = plural_name
	desc = ""
	dropshrink = 1
	switch(quantity)
		if(2)
			dropshrink = 0.2 // this is just like the single coin, gotta shrink it
			icon_state = "[base_type]m"
			if(heads_tails == last_merged_heads_tails)
				icon_state = "[base_type][heads_tails]1"
		if(3)
			icon_state = "[base_type]2"
		if(4 to 5)
			icon_state = "[base_type]3"
		if(6 to 10)
			icon_state = "[base_type]5"
		if(11 to 15)
			icon_state = "[base_type]10"
		if(16 to INFINITY)
			icon_state = "[base_type]15"


/obj/item/roguecoin/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/roguecoin))
		var/obj/item/roguecoin/G = I
		if(item_flags & IN_STORAGE)
			merge(G, user)
		else
			G.merge(src, user)
		return
	return ..()

//GOLD
/obj/item/roguecoin/gold
	name = "zenar"
	desc = "A gold coin bearing the symbol of the Taurus and the pre-kingdom psycross. These were in the best condition of the provincial gold mints, the rest were melted down."
	icon_state = "g1"
	sellprice = 10
	base_type = CTYPE_GOLD
	plural_name = "zenarii"


// SILVER
/obj/item/roguecoin/silver
	name = "ziliqua"
	desc = "An ancient silver coin still in use due to their remarkable ability to last the ages."
	icon_state = "s1"
	sellprice = 5
	base_type = CTYPE_SILV
	plural_name = "ziliquae"

// COPPER
/obj/item/roguecoin/copper
	name = "zenny"
	desc = "A brand-new bronze coin minted by the capital in an effort to be rid of the financial use of silver."
	icon_state = "c1"
	sellprice = 1
	base_type = CTYPE_COPP
	plural_name = "zennies"

/obj/item/roguecoin/copper/pile/Initialize(mapload, coin_amount)
	. = ..()
	if(!coin_amount)
		set_quantity(rand(4,19))

/obj/item/roguecoin/silver/pile/Initialize(mapload, coin_amount)
	. = ..()
	if(!coin_amount)
		set_quantity(rand(4,19))

/obj/item/roguecoin/gold/pile/Initialize(mapload, coin_amount)
	. = ..()
	if(!coin_amount)
		set_quantity(rand(4,19))

#undef CTYPE_GOLD
#undef CTYPE_SILV
#undef CTYPE_COPP
#undef MAX_COIN_STACK_SIZE
