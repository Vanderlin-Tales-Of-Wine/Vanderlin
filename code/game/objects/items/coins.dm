#define CTYPE_GOLD "g"
#define CTYPE_SILV "s"
#define CTYPE_COPP "c"
#define MAX_COIN_STACK_SIZE 20

/obj/item/coin
	name = ""
	desc = ""
	icon = 'icons/roguetown/items/valuable.dmi'
	icon_state = ""
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

/obj/item/coin/Initialize(mapload, coin_amount)
	. = ..()
	if(coin_amount >= 1)
		set_quantity(floor(coin_amount))
		setup_denomination()

/obj/item/coin/proc/setup_denomination()
	return

/obj/item/coin/getonmobprop(tag)
	. = ..()
	if(tag != "gen")
		return
	return list("shrink" = 0.10, "sx" = -6, "sy" = 6, "nx" = 6, "ny" = 7, "wx" = 0, "wy" = 5, "ex" = -1, "ey" = 7, "northabove" = 0, "southabove" = 1, "eastabove" = 1, "westabove" = 0, "nturn" = -50, "sturn" = 40, "wturn" = 50, "eturn" = -50, "nflip" = 0, "sflip" = 8, "wflip" = 8, "eflip" = 0)

/obj/item/coin/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	playsound(loc, 'sound/foley/coins1.ogg', 100, TRUE, -2)
	scatter(get_turf(src))
	..()

/obj/item/coin/pickup(mob/user)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_MATTHIOS_CURSE))
		var/mob/living/carbon/human/H = user
		to_chat(H, span_warning("The idea repulses me!"))
		H.cursed_freak_out()
		H.Paralyze(20)
		return

/obj/item/coin/proc/scatter(turf/T)
	pixel_x = rand(-8, 8)
	pixel_y = rand(-5, 5)
	if(isturf(T) && quantity > 1)
		for(var/i in 2 to quantity) // exclude the first coin
			var/spawned_type = type
			if(base_type)
				switch(base_type)
					if(CTYPE_GOLD)
						spawned_type = /obj/item/coin/gold
					if(CTYPE_SILV)
						spawned_type = /obj/item/coin/silver
					else
						spawned_type = /obj/item/coin/copper

			var/obj/item/coin/new_coin = new spawned_type
			new_coin.forceMove(T)
			new_coin.set_quantity(1) // prevent exploits with coin piles
			new_coin.pixel_x = rand(-8, 8)
			new_coin.pixel_y = rand(-5, 5)

	set_quantity(1)

/obj/item/coin/get_real_price()
	return sellprice * quantity

/obj/item/coin/proc/set_quantity(new_quantity)
	quantity = new_quantity
	update_icon()
	update_transform()

/obj/item/coin/examine(mob/user)
	. = ..()
	var/denomination = quantity == 1 ? name : plural_name
	var/exact_value = get_real_price()
	var/mathematics_skill = user.mind?.get_skill_level(/datum/skill/labor/mathematics) || 0
	var/is_skilled = mathematics_skill >= 3
	var/intelligence = user.mind?.current.STAINT
	if(intelligence < 9)
		mathematics_skill = max(mathematics_skill - 1, 0)
	if(quantity > 1)
		if(is_skilled)
			. += span_info("Exactly [quantity] [denomination] ([exact_value] mammon)")
		else
			// Create estimation with skill-based inaccuracy
			var/fuzzy_quantity = quantity
			var/value_error = 0
			var/uncertainty_phrases = list("maybe","you think","roughly","perhaps","around","probably")
			// Apply counting inaccuracy
			switch(mathematics_skill)
				if(0) // WHAT IS MATH!?
					user.visible_message(span_notice("You see [user] clumsily start counting the coins"), span_notice("You clumsily start counting the coins..."))
					do_after(user, CLAMP((1 SECONDS * quantity), 1 SECONDS, 8 SECONDS))
					fuzzy_quantity = CLAMP(quantity + rand(-3,3), 1, 20)
					value_error = rand(-25,25) //Upper and lower % error
				if(1) // Weak skill
					user.visible_message(span_notice("You see [user] start counting the coins"), span_notice("You start counting the coins..."))
					do_after(user, CLAMP((1 SECONDS * quantity), 1 SECONDS, 4 SECONDS))
					fuzzy_quantity = CLAMP(quantity + rand(-1,1), 1, 20)
					value_error = rand(-10,10) //Upper and lower % error
				if(2) // Average skill
					user.visible_message(span_notice("You see [user] count the coins"), span_notice("You start counting the coins..."))
					do_after(user, CLAMP((1 SECONDS * quantity), 1 SECONDS, 2 SECONDS))
				else
					user.visible_message(span_notice("You see [user] swiftly tally the coins with practiced ease."), span_notice("You quickly count the coins with precision."))
			// Calculate approximate value with compounding error
			var/estimated_value = round((exact_value * (100 + value_error)) / 100)
			estimated_value = CLAMP(estimated_value, 1, 200) // Keep within max stack size possible (20*10)
			var/description = "[quantity_to_words(fuzzy_quantity)] [denomination]"
			var/value_text = "~[estimated_value] mammon"
			//Add the flavor phrases for oblivious people
			if(mathematics_skill == 0)
				value_text = "[pick(uncertainty_phrases)] [value_text]"
				if(prob(30))
					value_text += "?"
			. += span_info("[description] ([value_text])")
	else
		. += span_info("One [name] ([sellprice] mammon)")

/obj/item/coin/proc/quantity_to_words(amount)
	switch(amount)
		if(1 to 4) return "A few"
		if(5 to 9) return "Several"
		if(10 to 14) return "A dozen or so"
		if(15 to 19) return "A large number of"
		if(20) return "A full stack of"
		else return "Some"

/obj/item/coin/proc/merge(obj/item/coin/G, mob/user)
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

/obj/item/coin/attack_right(mob/user)
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

/obj/item/coin/attack_hand(mob/user)
	if(user.get_inactive_held_item() == src && quantity > 1)
		var/intended = input(user, "How many [plural_name] to split?", null, 1) as null|num
		if(QDELETED(src) || !user.is_holding(src))
			return
		// Initial processing
		intended = clamp(intended, 0, quantity)
		intended = round(intended, 1)
		if(!intended)
			return
		if(intended >= quantity)
			return ..()

		// Apply counting errors
		var/actual = intended
		var/mathematics_skill = user.mind?.get_skill_level(/datum/skill/labor/mathematics) || 0
		var/intelligence = user.mind?.current.STAINT
		if(intelligence < 9)
			mathematics_skill = max(mathematics_skill - 1, 0)

		// Calculate error based on skill
		switch(mathematics_skill)
			if(0) // Unskilled: Large error
				actual += rand(-3,3)
			if(1) // Weak: Small error
				actual += rand(-1,1)
		actual = clamp(actual, 1, quantity - 1)
		if(actual >= quantity)
			return
		var/obj/item/coin/new_coins = new type()
		new_coins.set_quantity(actual)
		new_coins.heads_tails = last_merged_heads_tails
		set_quantity(quantity - actual)
		user.put_in_hands(new_coins)
		playsound(loc, 'sound/foley/coins1.ogg', 100, TRUE, -2)
		return
	..()


/obj/item/coin/attack_self(mob/living/user)
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

/obj/item/coin/update_icon()
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


/obj/item/coin/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/coin))
		var/obj/item/coin/G = I
		if(item_flags & IN_STORAGE)
			merge(G, user)
		else
			G.merge(src, user)
		return
	return ..()

//GOLD
/obj/item/coin/gold
	name = "zenar"
	desc = "A gold coin bearing the symbol of the Taurus and the pre-kingdom psycross. These were in the best condition of the provincial gold mints, the rest were melted down. It's valued at 10 mammon per coin."
	icon_state = "g1"
	sellprice = 10
	base_type = CTYPE_GOLD
	plural_name = "zenarii"


// SILVER
/obj/item/coin/silver
	name = "ziliqua"
	desc = "An ancient silver coin still in use due to their remarkable ability to last the ages. It's valued at 5 mammon per coin."
	icon_state = "s1"
	sellprice = 5
	base_type = CTYPE_SILV
	plural_name = "ziliquae"

// COPPER
/obj/item/coin/copper
	name = "zenny"
	desc = "A brand-new bronze coin minted by the capital in an effort to be rid of the financial use of silver. It's valued at 1 mammon per coin."
	icon_state = "c1"
	sellprice = 1
	base_type = CTYPE_COPP
	plural_name = "zennies"

/obj/item/coin/copper/pile/Initialize(mapload, coin_amount)
	. = ..()
	if(!coin_amount)
		set_quantity(rand(4,19))

/obj/item/coin/silver/pile/Initialize(mapload, coin_amount)
	. = ..()
	if(!coin_amount)
		set_quantity(rand(4,19))

/obj/item/coin/gold/pile/Initialize(mapload, coin_amount)
	. = ..()
	if(!coin_amount)
		set_quantity(rand(4,19))

#undef CTYPE_GOLD
#undef CTYPE_SILV
#undef CTYPE_COPP
#undef MAX_COIN_STACK_SIZE
