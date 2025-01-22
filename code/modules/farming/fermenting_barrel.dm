/obj/structure/fermenting_barrel
	name = "barrel"
	desc = ""
	icon = 'icons/roguetown/misc/structure.dmi'
	icon_state = "barrel1"
	density = TRUE
	opacity = FALSE
	anchored = FALSE
	w_class = WEIGHT_CLASS_BULKY
	max_integrity = 300
	drag_slowdown = 2
	metalizer_result = /obj/item/reagent_containers/glass/bucket/pot
	var/open = FALSE
	var/speed_multiplier = 1 //How fast it distills. Defaults to 100% (1.0). Lower is better.

/obj/structure/fermenting_barrel/Initialize()
	// Bluespace beakers, but without the portability or efficiency in circuits.
	create_reagents(900, DRAINABLE | AMOUNT_VISIBLE | REFILLABLE)
	if(icon_state == "barrel1")
		icon_state = "barrel[rand(1,3)]"
	. = ..()




/obj/structure/fermenting_barrel/Destroy()
	chem_splash(loc, 2, list(reagents))
	qdel(reagents)
	..()

/obj/structure/fermenting_barrel/examine(mob/user)
	. = ..()
//	. += "<span class='notice'>It is currently [open?"open, letting you pour liquids in.":"closed, letting you draw liquids."]</span>"

/obj/structure/fermenting_barrel/proc/makeWine(obj/item/reagent_containers/food/snacks/fruit)
	if(fruit.reagents)
		fruit.reagents.remove_reagent(/datum/reagent/consumable/nutriment, fruit.reagents.total_volume)
		fruit.reagents.trans_to(src, fruit.reagents.total_volume)
	if(fruit.distill_reagent)
		reagents.add_reagent(fruit.distill_reagent, fruit.distill_amt)
//		reagents.add_reagent(/datum/reagent/water, 1)
	qdel(fruit)
	playsound(src, "bubbles", 100, TRUE)

/obj/structure/fermenting_barrel/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/reagent_containers/food/snacks/produce))
		if(try_ferment(I, user))
			playsound(src, pick('sound/foley/touch1.ogg','sound/foley/touch2.ogg','sound/foley/touch3.ogg'), 170, TRUE)
			return TRUE
	if(istype(I, /obj/item/storage/roguebag) && I.contents.len)
		var/success
		for(var/obj/item/reagent_containers/food/snacks/produce/bagged_fruit in I.contents)
			if(try_ferment(bagged_fruit, user, TRUE))
				var/datum/component/storage/STR = I.GetComponent(/datum/component/storage)
				STR.remove_from_storage(bagged_fruit)
				success = TRUE
		if(success)
			playsound(src, pick('sound/foley/touch1.ogg','sound/foley/touch2.ogg','sound/foley/touch3.ogg'), 170, TRUE)
			to_chat(user, span_info("I dump the contents of [I] into [src]."))
			I.update_icon()
		else
			to_chat(user, span_warning("There's nothing in [I] that I can ferment."))
		return TRUE
	..()

/obj/structure/fermenting_barrel/proc/try_ferment(obj/item/reagent_containers/food/snacks/fruit, mob/user, batch_process)
	if(!fruit.can_distill)
		if(!batch_process)
			to_chat(user, span_warning("I can't ferment this into anything."))
		return FALSE
	else if(!user.transferItemToLoc(fruit,src))
		if(!batch_process)
			to_chat(user, span_warning("[fruit] is stuck to my hand!"))
		return FALSE
	if(!batch_process)
		to_chat(user, span_info("I place [fruit] into [src]."))
	addtimer(CALLBACK(src, PROC_REF(makeWine), fruit), rand(1 MINUTES, 3 MINUTES))
	return TRUE

// /obj/structure/fermenting_barrel/attack_right(mob/user)
// 	var/turf/T = get_turf(user)
// 	for(var/obj/item/reagent_containers/food/snacks/produce/fruit in get_turf(T))
// 		if(fruit.can_distill)
// 			if(move_after(user, 1 SECONDS, target = src))
// 				src.attackby(fruit, user)

//obj/structure/fermenting_barrel/attack_hand(mob/user)
//	open = !open
//	if(open)
//		ENABLE_BITFIELD(reagents.flags, DRAINABLE)
//		ENABLE_BITFIELD(reagents.flags, REFILLABLE)
//		to_chat(user, "<span class='notice'>I open [src].</span>")
//	else
//		DISABLE_BITFIELD(reagents.flags, DRAINABLE)
//		DISABLE_BITFIELD(reagents.flags, REFILLABLE)
//		to_chat(user, "<span class='notice'>I close [src].</span>")
//	update_icon()

/obj/structure/fermenting_barrel/update_icon()
	if(open)
		icon_state = "barrel_open"
	else
		icon_state = "barrel"
	if(broken)
		icon_state = "barrel_destroyed"

/datum/crafting_recipe/fermenting_barrel
	name = "Wooden Barrel"
	result = /obj/structure/fermenting_barrel
	reqs = list(/obj/item/grown/log = 5)
	time = 50
	category = CAT_NONE

/obj/structure/fermenting_barrel/random/water
	name = "water barrel"
	icon_state = "pbarrel1"
/obj/structure/fermenting_barrel/random/water/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/water, rand(0,900))

/obj/structure/fermenting_barrel/random/beer
	icon_state = "barrel_alt"
/obj/structure/fermenting_barrel/random/beer/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/consumable/ethanol/beer, rand(0,900))

/obj/structure/fermenting_barrel/water
	name = "water barrel"
	icon_state = "pbarrel1"
/obj/structure/fermenting_barrel/water/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/water,900)

/obj/structure/fermenting_barrel/beer/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/consumable/ethanol/beer,900)

/obj/item/roguebin/water/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/water,500)
	update_icon()


/obj/item/roguebin/water/gross/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/water/gross,500)
	update_icon()

/obj/item/roguebin/water/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/water,500)
	update_icon()

/obj/item/roguebin/water/gross/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/water/gross,500)
	update_icon()
