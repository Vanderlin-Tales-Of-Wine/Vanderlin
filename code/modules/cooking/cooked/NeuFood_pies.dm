/* * * * * * * * * * * **
 *						*
 *		 NeuFood		*
 *		 (Pies)		 	*
 *						*
 * * * * * * * * * * * **/



/*	........   Pie making   ................ */
/obj/item/reagent_containers/food/snacks/foodbase/piebottom
	name = "pie bottom"
	desc = "The foundation of the fantastical."
	icon_state = "piebottom"
	w_class = WEIGHT_CLASS_NORMAL
	eat_effect = /datum/status_effect/debuff/uncookedfood
	dropshrink = 0.9


/*--------------\
| Pie templates |
\--------------*/

/obj/item/reagent_containers/food/snacks/pie
	name = "pie"
	desc = ""
	color = "#e7e2df"
	dropshrink = 0.8
	var/stunning = FALSE

/obj/item/reagent_containers/food/snacks/pie/cooked
	icon_state = "pie"
	list_reagents = list(/datum/reagent/consumable/nutriment = MEAL_FILLING)
	slice_path = /obj/item/reagent_containers/food/snacks/pieslice
	slices_num = 5
	slice_batch = TRUE
	eat_effect = null
	foodtype = GRAIN | DAIRY
	chopping_sound = TRUE
	dropshrink = 0.8

/obj/item/reagent_containers/food/snacks/pie/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(!.) //if we're not being caught
		splat(hit_atom)

/obj/item/reagent_containers/food/snacks/pie/proc/splat(atom/movable/hit_atom)
	if(isliving(loc)) //someone caught us!
		return
	var/turf/T = get_turf(hit_atom)
	new/obj/effect/decal/cleanable/food/pie_smudge(T)
	if(reagents && reagents.total_volume)
		reagents.reaction(hit_atom, TOUCH)
	if(isliving(hit_atom))
		var/mob/living/L = hit_atom
		if(stunning)
			L.Paralyze(20) //splat!
		L.adjust_blurriness(1)
		L.visible_message("<span class='warning'>[L] is hit by [src]!</span>", "<span class='danger'>I'm hit by [src]!</span>")
	qdel(src)

/obj/item/reagent_containers/food/snacks/pie/CheckParts(list/parts_list)
	..()
	for(var/obj/item/reagent_containers/food/snacks/M in parts_list)
		filling_color = M.filling_color
		update_snack_overlays(M)
		color = M.filling_color
		if(M.reagents)
			M.reagents.remove_reagent(/datum/reagent/consumable/nutriment, M.reagents.total_volume)
			M.reagents.trans_to(src, M.reagents.total_volume)
		qdel(M)

/obj/item/reagent_containers/food/snacks/pieslice
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	tastes = list("pie" = 1)
	name = "pie slice"
	desc = ""
	icon_state = "slice"
	dropshrink = 0.9
	filling_color = "#FFFFFF"
	foodtype = GRAIN | DAIRY
	color = "#e7e2df"
	rotprocess = SHELFLIFE_LONG

/obj/item/reagent_containers/food/snacks/pieslice/good
	eat_effect = /datum/status_effect/buff/foodbuff
/obj/item/reagent_containers/food/snacks/pieslice/good/pot
	filling_color = "#9d8c3b"
/obj/item/reagent_containers/food/snacks/pieslice/good/fish
	filling_color = "#bb5a93"
/obj/item/reagent_containers/food/snacks/pieslice/good/meat
	filling_color = "#b44f44"
/obj/item/reagent_containers/food/snacks/pieslice/good/berry
	filling_color = "#394da5"
/obj/item/reagent_containers/food/snacks/pieslice/good/apple
	filling_color = "#eca48c"

// -------------- MEAT PIE -----------------
/obj/item/reagent_containers/food/snacks/pie/cooked/meat // bae item
	name = "meat pie"
	desc = ""
	foodtype = GRAIN | DAIRY | MEAT
	list_reagents = list(/datum/reagent/consumable/nutriment = MEATPIE_NUTRITION)

/obj/item/reagent_containers/food/snacks/pie/cooked/meat/meat
	icon_state = "meatpie"
	tastes = list("meat and butterdough" = 1)
	filling_color = "#b44f44"
/obj/item/reagent_containers/food/snacks/pie/cooked/meat/meat/good
	eat_effect = /datum/status_effect/buff/foodbuff
	slice_path = /obj/item/reagent_containers/food/snacks/pieslice/good/meat
	tastes = list("succulent meat and crispy butterdough" = 1)
/obj/item/reagent_containers/food/snacks/pie/cooked/meat/meat/good/New()
	. = ..()
	good_quality_descriptors()

// -------------- FISH PIE -----------------
/obj/item/reagent_containers/food/snacks/pie/cooked/meat/fish
	name = "fish pie"
	icon_state = "fishpie"
	tastes = list("baked fish and butterdough" = 1)
	filling_color = "#bb5a93"

/obj/item/reagent_containers/food/snacks/pie/cooked/meat/fish/good
	eat_effect = /datum/status_effect/buff/foodbuff
	slice_path = /obj/item/reagent_containers/food/snacks/pieslice/good/fish
	tastes = list("baked fish and crispy butterdough" = 1)
/obj/item/reagent_containers/food/snacks/pie/cooked/meat/fish/good/New()
	. = ..()
	good_quality_descriptors()

// -------------- POT PIE -----------------
/obj/item/reagent_containers/food/snacks/pie/cooked/pot
	name = "pot pie"
	desc = ""
	slices_num = 6
	list_reagents = list(/datum/reagent/consumable/nutriment = MEATPIE_NUTRITION)
	tastes = list("mysterious filling and butterdough" = 1)
	filling_color = "#9d8c3b"
	foodtype = GRAIN | DAIRY | MEAT

/obj/item/reagent_containers/food/snacks/pie/cooked/pot/good
	eat_effect = /datum/status_effect/buff/foodbuff
	slice_path = /obj/item/reagent_containers/food/snacks/pieslice/good/pot
	tastes = list("succulent filling and crispy butterdough" = 1)
/obj/item/reagent_containers/food/snacks/pie/cooked/meat/pot/good/New()
	. = ..()
	good_quality_descriptors()

// -------------- BERRY PIE -----------------
/obj/item/reagent_containers/food/snacks/pie/cooked/berry
	name = "berry pie"
	desc = ""
	list_reagents = list(/datum/reagent/consumable/nutriment = FRUITPIE_NUTRITION)
	slices_num = 4
	tastes = list("butterdough" = 1, "berries" = 1)
	filling_color = "#394da5"

/obj/item/reagent_containers/food/snacks/pie/cooked/berry/good
	eat_effect = /datum/status_effect/buff/foodbuff
	slice_path = /obj/item/reagent_containers/food/snacks/pieslice/good/berry
	tastes = list("crispy butterdough" = 1, "sweet berries" = 1)
/obj/item/reagent_containers/food/snacks/pie/cooked/berry/good/New()
	. = ..()
	good_quality_descriptors()

// -------------- POISON PIE -----------------
/obj/item/reagent_containers/food/snacks/pie/cooked/poison
	name = "berry pie"
	slices_num = 4
	list_reagents = list(/datum/reagent/consumable/nutriment = FRUITPIE_NUTRITION, /datum/reagent/berrypoison = 12)
	tastes = list("crispy butterdough" = 1, "bitter berries" =1)
	filling_color = "#394da5"

// -------------- APPLE PIE -----------------
/obj/item/reagent_containers/food/snacks/pie/cooked/apple
	name = "apple pie"
	desc = ""
	slices_num = 4
	list_reagents = list(/datum/reagent/consumable/nutriment = FRUITPIE_NUTRITION)
	tastes = list("apples and butterdough" = 1)
/obj/item/reagent_containers/food/snacks/pie/cooked/apple/good
	eat_effect = /datum/status_effect/buff/foodbuff
	slice_path = /obj/item/reagent_containers/food/snacks/pieslice/good/apple
	tastes = list("baked apples and crispy butterdough" = 1)
/obj/item/reagent_containers/food/snacks/pie/cooked/apple/good/New()
	. = ..()
	good_quality_descriptors()

/*--------\
| Handpie |
\--------*/		// dwarven pie on the go, good shelflife until bitten, made from pie dough and mince, truffles or jacksberries

/obj/item/reagent_containers/food/snacks/foodbase/handpieraw
	name = "raw handpie"
	desc = "The dwarven take on pies, called pierogi in their dialect. A fistfull of food to stand the test of time."
	icon_state = "handpie_raw"
	cooked_type = /obj/item/reagent_containers/food/snacks/handpie
	fried_type = /obj/item/reagent_containers/food/snacks/handpie
	cooked_smell = /datum/pollutant/food/pie_base
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	w_class = WEIGHT_CLASS_NORMAL
	dropshrink = 0.8

/obj/item/reagent_containers/food/snacks/foodbase/handpieraw/mushroom
	w_class = WEIGHT_CLASS_NORMAL
	foodtype = GRAIN | VEGETABLES
	tastes = list("delicious truffles" = 1)

/obj/item/reagent_containers/food/snacks/foodbase/handpieraw/mince
	w_class = WEIGHT_CLASS_NORMAL
	foodtype = GRAIN | MEAT
	tastes = list("succulent meat" = 1)

/obj/item/reagent_containers/food/snacks/foodbase/handpieraw/cheese
	w_class = WEIGHT_CLASS_NORMAL
	foodtype = GRAIN | DAIRY
	tastes = list("hot cheese" = 1)

/obj/item/reagent_containers/food/snacks/foodbase/handpieraw/apple
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_POOR)
	w_class = WEIGHT_CLASS_NORMAL
	foodtype = GRAIN | FRUIT
	tastes = list("sweet apple" = 1)

/obj/item/reagent_containers/food/snacks/foodbase/handpieraw/berry
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_POOR)
	w_class = WEIGHT_CLASS_NORMAL
	foodtype = GRAIN | FRUIT
	tastes = list("sweet berry" = 1)

/obj/item/reagent_containers/food/snacks/foodbase/handpieraw/poison
	list_reagents = list(/datum/reagent/berrypoison = 5)
	w_class = WEIGHT_CLASS_NORMAL
	foodtype = GRAIN | FRUIT
	tastes = list("bitter berry" = 1)

/obj/item/reagent_containers/food/snacks/handpie
	name = "handpie"
	desc = "The dwarven take on pies, called pierogi in their dialect. A fistfull of food to stand the test of time. This is pretty dry."
	icon_state = "handpie"
	bitesize = 4
	bonus_reagents = list(/datum/reagent/consumable/nutriment = BUTTERDOUGHSLICE_NUTRITION)
	tastes = list("dry dough" = 1)
	dropshrink = 0.8

/obj/item/reagent_containers/food/snacks/handpie/good
	desc = "The dwarven take on pies, called pierogi in their dialect. A fistfull of food to stand the test of time."
	eat_effect = /datum/status_effect/buff/foodbuff
	bitesize = 4
	tastes = list("crispy dough" = 1)
/obj/item/reagent_containers/food/snacks/handpie/good/New()
	. = ..()
	good_quality_descriptors()

/obj/item/reagent_containers/food/snacks/handpie/On_Consume(mob/living/eater)
	..()
	icon_state = "handpie[bitecount]"
	if(bitecount == 1)
		rotprocess = SHELFLIFE_DECENT
		addtimer(CALLBACK(src, PROC_REF(begin_rotting)), 20, TIMER_CLIENT_TIME) //
