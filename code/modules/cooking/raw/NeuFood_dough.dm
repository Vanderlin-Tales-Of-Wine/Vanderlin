/* * * * * * * * * * * **
 *						*
 *		 NeuFood		*	- Basically add water to powder, then more powder
 *		 (Snacks)		*
 *						*
 * * * * * * * * * * * **/


/*------\
| Dough |
\------*/

/*	.................   Dough   ................... */
/obj/item/reagent_containers/food/snacks/dough_base
	name = "unfinished dough"
	desc = "With a little more ambition, you will conquer."
	icon_state = "dough_base"
	w_class = WEIGHT_CLASS_NORMAL
	rotprocess = SHELFLIFE_LONG
/obj/item/reagent_containers/food/snacks/dough_base/attackby(obj/item/I, mob/living/user, params)
	. = ..()
	if(user.mind)
		short_cooktime = (50 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*8))
	var/found_table = locate(/obj/structure/table) in (loc)
	if(isturf(loc)&& (found_table))
		if(istype(I, /obj/item/reagent_containers/powder/flour))
			playsound(get_turf(user), 'sound/foley/kneading.ogg', 100, TRUE, -1)
			to_chat(user, span_notice("Kneading in more powder..."))
			if(do_after(user, short_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/dough(loc)
				qdel(I)
				qdel(src)
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
	else
		to_chat(user, span_warning("Put [src] on a table before working it!"))


/obj/item/reagent_containers/food/snacks/dough
	name = "dough"
	desc = "The triumph of all bakers."
	icon_state = "dough"
	slices_num = 2
	slice_batch = TRUE
	slice_path = /obj/item/reagent_containers/food/snacks/dough_slice
	cooked_type = /obj/item/reagent_containers/food/snacks/bread
	cooked_smell = /datum/pollutant/food/bread
	w_class = WEIGHT_CLASS_NORMAL
	rotprocess = SHELFLIFE_LONG
	slice_sound = TRUE
/obj/item/reagent_containers/food/snacks/dough/attackby(obj/item/I, mob/living/user, params)
	..()
	if(user.mind)
		short_cooktime = (50 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*7))
		long_cooktime = (90 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*14))
	var/found_table = locate(/obj/structure/table) in (loc)
	if(istype(I, /obj/item/reagent_containers/food/snacks/butterslice))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/kneading_alt.ogg', 90, TRUE, -1)
			to_chat(user, span_notice("Kneading butter into the dough..."))
			if(do_after(user,long_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/butterdough(loc)
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
				qdel(I)
				qdel(src)
		else
			to_chat(user, span_warning("Put [src] on a table before working it!"))
	if(istype(I, /obj/item/reagent_containers/food/snacks/raisins/poison))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/kneading.ogg', 100, TRUE, -1)
			to_chat(user, span_notice("Kneading the dough and adding raisins..."))
			if(do_after(user, short_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/raisindough_poison(loc)
				qdel(I)
				qdel(src)
		else
			to_chat(user, span_warning("Put [src] on a table before working it!"))
	else if(istype(I, /obj/item/reagent_containers/food/snacks/raisins))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/kneading.ogg', 100, TRUE, -1)
			to_chat(user, span_notice("Kneading the dough and adding raisins..."))
			if(do_after(user, short_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/raisindough(loc)
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
				qdel(I)
				qdel(src)
		else
			to_chat(user, span_warning("Put [src] on a table before working it!"))

/*	.................   Smalldough   ................... */
/obj/item/reagent_containers/food/snacks/dough_slice
	name = "smalldough"
	icon_state = "doughslice"
	slices_num = 0
	bitesize = 10
	cooked_type = /obj/item/reagent_containers/food/snacks/bun
	cooked_smell = /datum/pollutant/food/bun
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("dough" = 1)
/obj/item/reagent_containers/food/snacks/dough_slice/attackby(obj/item/I, mob/living/user, params)
	. = ..()
	if(user.mind)
		short_cooktime = (50 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*8))
	var/found_table = locate(/obj/structure/table) in (loc)
	if(istype(I, /obj/item/kitchen/rollingpin))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/rollingpin.ogg', 100, TRUE, -1)
			to_chat(user, span_notice("Rolling [src] into cracker dough."))
			if(do_after(user,long_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/foodbase/hardtack_raw(loc)
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
				qdel(src)
		else
			to_chat(user, span_warning("Put [src] on a table before working it!"))
		return TRUE
	if(isturf(loc)&& (found_table))
		if(istype(I, /obj/item/reagent_containers/food/snacks/cheese/gote))
			playsound(get_turf(user), 'sound/foley/kneading_alt.ogg', 90, TRUE, -1)
			to_chat(user, span_notice("Adding fresh gote cheese..."))
			if(do_after(user, short_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/foodbase/cheesebun_raw(loc)
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
				qdel(I)
				qdel(src)
		if(istype(I, /obj/item/reagent_containers/food/snacks/cheese_wedge))
			playsound(get_turf(user), 'sound/foley/kneading_alt.ogg', 90, TRUE, -1)
			to_chat(user, span_notice("Adding cheese..."))
			if(do_after(user, short_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/foodbase/cheesebun_raw(loc)
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
				qdel(I)
				qdel(src)
		if(istype(I, /obj/item/reagent_containers/food/snacks/dough_slice))
			playsound(get_turf(user), 'sound/foley/kneading.ogg', 100, TRUE, -1)
			to_chat(user, span_notice("Combining dough..."))
			if(do_after(user, short_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/dough(loc)
				qdel(I)
				qdel(src)
		else if(istype(I, /obj/item/reagent_containers/food/snacks/cheese))
			playsound(get_turf(user), 'sound/foley/kneading_alt.ogg', 90, TRUE, -1)
			to_chat(user, span_notice("Adding fresh cheese..."))
			if(do_after(user, short_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/foodbase/cheesebun_raw(loc)
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
				qdel(I)
				qdel(src)
	else
		to_chat(user, span_warning("Put [src] on a table before working it!"))


/*------------\
| Butterdough |
\------------*/

/*	.................   Butterdough   ................... */
/obj/item/reagent_containers/food/snacks/butterdough
	name = "butterdough"
	desc = "What is a triumph, to a legacy?"
	icon_state = "butterdough"
	slices_num = 2
	bitesize = 3
	slice_batch = TRUE
	slice_path = /obj/item/reagent_containers/food/snacks/butterdough_slice
	w_class = WEIGHT_CLASS_NORMAL
	slice_sound = TRUE
	rotprocess = SHELFLIFE_EXTREME
/obj/item/reagent_containers/food/snacks/butterdough/attackby(obj/item/I, mob/living/user, params)
	..()
	var/found_table = locate(/obj/structure/table) in (loc)
	if(user.mind)
		short_cooktime = (50 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*8))
		long_cooktime = (90 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*15))
	if(isturf(loc)&& (found_table))
		if(istype(I, /obj/item/reagent_containers/food/snacks/egg))
			if(user.mind.get_skill_level(/datum/skill/craft/cooking) <= 2) // cooks with less than 2 skill don´t know this recipe
				to_chat(user, span_warning("Cakes are not for the likes of you."))
				return
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			to_chat(user, span_notice("Working egg into the dough, shaping it into a cake..."))
			playsound(get_turf(user), 'sound/foley/eggbreak.ogg', 100, TRUE, -1)
			if(do_after(user,long_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/cake(loc)
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
				qdel(I)
				qdel(src)
	else
		to_chat(user, span_warning("Put [src] on a table before working it!"))

/*	.................   Butterdough piece   ................... */
/obj/item/reagent_containers/food/snacks/butterdough_slice
	name = "butterdough piece"
	desc = "A slice of pedigree, to create lines of history."
	icon_state = "butterdoughslice"
	slices_num = 0
	fried_type = /obj/item/reagent_containers/food/snacks/frybread
	cooked_type = /obj/item/reagent_containers/food/snacks/pastry
	cooked_smell = /datum/pollutant/food/pastry
	rotprocess = SHELFLIFE_EXTREME
	w_class = WEIGHT_CLASS_NORMAL
/obj/item/reagent_containers/food/snacks/butterdough_slice/attackby(obj/item/I, mob/living/user, params)
	..()
	if(user.mind)
		short_cooktime = (50 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*8))
	var/found_table = locate(/obj/structure/table) in (loc)
	if(isturf(loc)&& (found_table))
		if(istype(I, /obj/item/kitchen/rollingpin))
			playsound(get_turf(user), 'sound/foley/rollingpin.ogg', 100, TRUE, -1)
			to_chat(user, span_notice("Flattening [src]..."))
			if(do_after(user, short_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/piedough(loc)
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
				qdel(src)
		if(istype(I, /obj/item/reagent_containers/food/snacks/raisins/poison))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			to_chat(user, span_notice("Adding raisins to the dough..."))
			if(do_after(user, short_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/foodbase/biscuitpoison_raw(loc)
				qdel(I)
				qdel(src)
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
		if(I.get_sharpness())
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			to_chat(user, span_notice("Cutting the dough in strips and making a prezzel..."))
			if(do_after(user, short_cooktime, src))
				if(user.mind.get_skill_level(/datum/skill/craft/cooking) >= 2 || isdwarf(user))
					new /obj/item/reagent_containers/food/snacks/foodbase/prezzel_raw/good(loc)
				else
					new /obj/item/reagent_containers/food/snacks/foodbase/prezzel_raw(loc)
				qdel(src)
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
		if(istype(I, /obj/item/reagent_containers/food/snacks/sugar))
			if(user.mind.get_skill_level(/datum/skill/craft/cooking) <= 2) // cooks with less than 2 skill don´t know this recipe
				to_chat(user, span_warning("Scones are much too fancy for you."))
				return
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			to_chat(user, span_notice("Adding sugar to the dough..."))
			if(do_after(user, short_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/foodbase/scone_raw(loc)
				qdel(I)
				qdel(src)
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
		if(istype(I, /obj/item/reagent_containers/food/snacks/produce/apple) || istype(I, /obj/item/reagent_containers/food/snacks/apple_dried))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			to_chat(user, span_notice("Adding apple bits to the dough..."))
			if(do_after(user, short_cooktime, src))
				if(user.mind.get_skill_level(/datum/skill/craft/cooking) >= 2)
					new /obj/item/reagent_containers/food/snacks/foodbase/fritter_raw/good(loc)
				else
					new /obj/item/reagent_containers/food/snacks/foodbase/fritter_raw(loc)
				qdel(src)
				qdel(I)
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
		if(istype(I, /obj/item/reagent_containers/food/snacks/cooked/sausage_sticked))
			playsound(get_turf(user), 'sound/foley/kneading_alt.ogg', 90, TRUE, -1)
			to_chat(user, span_notice("Covering sausage with dough..."))
			if(do_after(user, short_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/foodbase/griddledog_raw(loc)
				qdel(I)
				qdel(src)

		if(istype(I, /obj/item/reagent_containers/food/snacks/egg))
			if(user.mind.get_skill_level(/datum/skill/craft/cooking) <= 1) // cooks with less than 1 skill don´t know this recipe
				to_chat(user, span_warning("Griddle cakes are not for the likes of you."))
				return
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			to_chat(user, span_notice("Working egg into the dough..."))
			playsound(get_turf(user), 'sound/foley/eggbreak.ogg', 100, TRUE, -1)
			if(do_after(user, short_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/foodbase/griddlecake_raw(loc)
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
				qdel(I)
				qdel(src)
		else if(istype(I, /obj/item/reagent_containers/food/snacks/raisins))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			to_chat(user, span_notice("Adding raisins to the dough..."))
			if(do_after(user, short_cooktime, src))
				if(user.mind.get_skill_level(/datum/skill/craft/cooking) >= 2)
					new /obj/item/reagent_containers/food/snacks/foodbase/biscuit_raw/good(loc)
				else
					new /obj/item/reagent_containers/food/snacks/foodbase/biscuit_raw(loc)
				qdel(I)
				qdel(src)
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
	else
		to_chat(user, span_warning("Put [src] on a table before working it!"))



/*	.................   Hardtack   ................... */
/obj/item/reagent_containers/food/snacks/foodbase/hardtack_raw
	name = "raw hardtack"
	desc = "Doughy, soft, unacceptable."
	icon_state = "raw_tack"
	cooked_type = /obj/item/reagent_containers/food/snacks/hardtack
	w_class = WEIGHT_CLASS_NORMAL
	eat_effect = null
	rotprocess = SHELFLIFE_LONG

/obj/item/reagent_containers/food/snacks/hardtack
	name = "hardtack"
	desc = "Very, very hard and dry."
	icon_state = "tack"
	base_icon_state = "tack"
	biting = TRUE
	bitesize = 6
	list_reagents = list(/datum/reagent/consumable/nutriment = DOUGH_NUTRITION)
	tastes = list("spelt" = 1)
	rotprocess = null
	faretype = FARE_POOR

/*	.................   Piedough   ................... */
/obj/item/reagent_containers/food/snacks/piedough
	name = "piedough"
	desc = "The beginning of greater things to come."
	icon_state = "piedough"
	dropshrink = 0.9
	cooked_type = /obj/item/reagent_containers/food/snacks/foodbase/piebottom
	cooked_smell = /datum/pollutant/food/pie_base
	w_class = WEIGHT_CLASS_NORMAL
	rotprocess = SHELFLIFE_LONG
/obj/item/reagent_containers/food/snacks/piedough/attackby(obj/item/I, mob/living/user, params)
	if(user.mind)
		short_cooktime = (50 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*8))
	if(istype(I, /obj/item/reagent_containers/food/snacks/truffles))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 50, TRUE, -1)
		to_chat(user, span_notice("Making a handpie..."))
		if(do_after(user, short_cooktime, src))
			var/obj/item/reagent_containers/food/snacks/foodbase/handpieraw/mushroom/handpie= new(get_turf(user))
			if(user.mind.get_skill_level(/datum/skill/craft/cooking) >= 2)
				handpie.cooked_type = /obj/item/reagent_containers/food/snacks/handpie/good
				handpie.fried_type = /obj/item/reagent_containers/food/snacks/handpie/good
			user.put_in_hands(handpie)
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
			qdel(I)
			qdel(src)
	if(istype(I, /obj/item/reagent_containers/food/snacks/meat/mince))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 50, TRUE, -1)
		to_chat(user, span_notice("Making a handpie..."))
		if(do_after(user, short_cooktime, src))
			var/obj/item/reagent_containers/food/snacks/foodbase/handpieraw/mince/handpie= new(get_turf(user))
			if(user.mind.get_skill_level(/datum/skill/craft/cooking) >= 2)
				handpie.cooked_type = /obj/item/reagent_containers/food/snacks/handpie/good
				handpie.fried_type = /obj/item/reagent_containers/food/snacks/handpie/good
			user.put_in_hands(handpie)
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
			qdel(I)
			qdel(src)
	if(istype(I, /obj/item/reagent_containers/food/snacks/produce/jacksberry/poison))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 50, TRUE, -1)
		to_chat(user, span_notice("Making a handpie..."))
		if(do_after(user, short_cooktime, src))
			var/obj/item/reagent_containers/food/snacks/foodbase/handpieraw/poison/handpie= new(get_turf(user))
			if(user.mind.get_skill_level(/datum/skill/craft/cooking) >= 2)
				handpie.cooked_type = /obj/item/reagent_containers/food/snacks/handpie/good
				handpie.fried_type = /obj/item/reagent_containers/food/snacks/handpie/good
			user.put_in_hands(handpie)
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
			qdel(I)
			qdel(src)
	if(istype(I, /obj/item/reagent_containers/food/snacks/produce/apple))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 50, TRUE, -1)
		to_chat(user, span_notice("Making a handpie..."))
		if(do_after(user, short_cooktime, src))
			var/obj/item/reagent_containers/food/snacks/foodbase/handpieraw/apple/handpie= new(get_turf(user))
			if(user.mind.get_skill_level(/datum/skill/craft/cooking) >= 2)
				handpie.cooked_type = /obj/item/reagent_containers/food/snacks/handpie/good
				handpie.fried_type = /obj/item/reagent_containers/food/snacks/handpie/good
			user.put_in_hands(handpie)
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
			qdel(I)
			qdel(src)
	if(istype(I, /obj/item/reagent_containers/food/snacks/cheese/gote))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 50, TRUE, -1)
		to_chat(user, span_notice("Making a handpie..."))
		if(do_after(user, short_cooktime, src))
			var/obj/item/reagent_containers/food/snacks/foodbase/handpieraw/cheese/handpie= new(get_turf(user))
			if(user.mind.get_skill_level(/datum/skill/craft/cooking) >= 2)
				handpie.cooked_type = /obj/item/reagent_containers/food/snacks/handpie/good
				handpie.fried_type = /obj/item/reagent_containers/food/snacks/handpie/good
			user.put_in_hands(handpie)
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
			qdel(I)
			qdel(src)
	if(istype(I, /obj/item/reagent_containers/food/snacks/cheese))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 50, TRUE, -1)
		to_chat(user, span_notice("Making a handpie..."))
		if(do_after(user, short_cooktime, src))
			var/obj/item/reagent_containers/food/snacks/foodbase/handpieraw/cheese/handpie= new(get_turf(user))
			if(user.mind.get_skill_level(/datum/skill/craft/cooking) >= 2)
				handpie.cooked_type = /obj/item/reagent_containers/food/snacks/handpie/good
				handpie.fried_type = /obj/item/reagent_containers/food/snacks/handpie/good
			user.put_in_hands(handpie)
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
			qdel(I)
			qdel(src)
	if(istype(I, /obj/item/reagent_containers/food/snacks/cheese_wedge))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 50, TRUE, -1)
		to_chat(user, span_notice("Making a handpie..."))
		if(do_after(user, short_cooktime, src))
			var/obj/item/reagent_containers/food/snacks/foodbase/handpieraw/cheese/handpie= new(get_turf(user))
			if(user.mind.get_skill_level(/datum/skill/craft/cooking) >= 2)
				handpie.cooked_type = /obj/item/reagent_containers/food/snacks/handpie/good
				handpie.fried_type = /obj/item/reagent_containers/food/snacks/handpie/good
			user.put_in_hands(handpie)
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
			qdel(I)
			qdel(src)
	else if(istype(I, /obj/item/reagent_containers/food/snacks/produce/jacksberry))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 50, TRUE, -1)
		to_chat(user, span_notice("Making a handpie..."))
		if(do_after(user, short_cooktime, src))
			var/obj/item/reagent_containers/food/snacks/foodbase/handpieraw/berry/handpie= new(get_turf(user))
			if(user.mind.get_skill_level(/datum/skill/craft/cooking) >= 2)
				handpie.cooked_type = /obj/item/reagent_containers/food/snacks/handpie/good
				handpie.fried_type = /obj/item/reagent_containers/food/snacks/handpie/good
			user.put_in_hands(handpie)
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
			qdel(I)
			qdel(src)
	else
		return ..()



/*----------------\
| Sliceable bread |
\----------------*/

/*	.................   Bread   ................... */
/obj/item/reagent_containers/food/snacks/bread
	name = "bread loaf"
	desc = "One of the staple foods of commoners. With the decline of magic, the loss of bread-duplication has led to mass famines around Psydonia."
	icon_state = "loaf"
	base_icon_state = "loaf"
	dropshrink = 0.8
	biting = TRUE
	bitesize = 5
	slices_num = 6
	slice_path = /obj/item/reagent_containers/food/snacks/breadslice
	list_reagents = list(/datum/reagent/consumable/nutriment = DOUGH_NUTRITION)
	drop_sound = 'sound/foley/dropsound/gen_drop.ogg'
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("bread" = 1)
	slice_batch = FALSE
	slice_sound = TRUE
	rotprocess = SHELFLIFE_LONG
	become_rot_type = /obj/item/reagent_containers/food/snacks/stale_bread

/obj/item/reagent_containers/food/snacks/bread/slice(obj/item/W, mob/user)
	. = ..()
	if(. && !QDELETED(src))
		bitecount++
		update_icon()

/obj/item/reagent_containers/food/snacks/bread/on_consume(mob/living/eater)
	..()
	if(slices_num)
		if(bitecount == 1)
			slices_num = 5
		if(bitecount == 2)
			slices_num = 4
		if(bitecount == 3)
			slices_num = 3
		if(bitecount == 4)
			slices_num = 2
		if(bitecount == 5)
			changefood(slice_path, eater)

/*	.................   Breadslice & Toast   ................... */
/obj/item/reagent_containers/food/snacks/breadslice
	name = "sliced bread"
	desc = "A bit of comfort to start your dae."
	icon_state = "loaf_slice"
	cooked_type = /obj/item/reagent_containers/food/snacks/breadslice/toast
	cooked_smell = /datum/pollutant/food/toast
	list_reagents = list(/datum/reagent/consumable/nutriment = BREADSLICE_NUTRITION)
	rotprocess = SHELFLIFE_LONG
	dropshrink = 0.8
	become_rot_type = /obj/item/reagent_containers/food/snacks/rotten/breadslice
	faretype = FARE_POOR

/obj/item/reagent_containers/food/snacks/breadslice/attackby(obj/item/I, mob/living/user, params)
	if(user.mind)
		short_cooktime = (50 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*8))
	if(modified)
		return TRUE
	if(istype(I, /obj/item/reagent_containers/food/snacks/meat/salami/slice))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 50, TRUE, -1)
		if(do_after(user, short_cooktime, src))
			name = "[name] & salumoi"
			desc = "[desc] A thick slice of salumoi has been added."
			add_overlay("salumoid")
			tastes = list("salumoi" = 1,"bread" = 1)
			bonus_reagents = list(/datum/reagent/consumable/nutriment = SNACK_POOR + 2)
			foodtype = GRAIN | MEAT
			modified = TRUE
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.2))
			qdel(I)
	if(istype(I, /obj/item/reagent_containers/food/snacks/cheddarslice))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 50, TRUE, -1)
		if(do_after(user, short_cooktime, src))
			name = "[name] & cheese"
			desc = "[desc] Fat cheese slices has been added."
			add_overlay("cheesed")
			tastes = list("cheese" = 1,"bread" = 1)
			bonus_reagents = list(/datum/reagent/consumable/nutriment = SNACK_POOR + 1)
			foodtype = GRAIN | DAIRY
			modified = TRUE
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.2))
			qdel(I)
	if(istype(I, /obj/item/reagent_containers/food/snacks/cooked/egg))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 50, TRUE, -1)
		if(do_after(user, short_cooktime, src))
			name = "[name] & egg"
			add_overlay("egged")
			tastes = list("bread" = 1,"egg" = 1)
			bonus_reagents = list(/datum/reagent/consumable/nutriment = EGG_NUTRITION + 2)
			foodtype = GRAIN | MEAT
			modified = TRUE
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.2))
			qdel(I)
	if(istype(I, /obj/item/reagent_containers/food/snacks/fat/salo/slice))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 50, TRUE, -1)
		if(do_after(user, short_cooktime, src))
			name = "[name] & salo"
			add_overlay("salod")
			tastes = list("bread" = 1,"salted fat" = 1)
			bonus_reagents = list(/datum/reagent/consumable/nutriment = SNACK_POOR + 2)
			foodtype = GRAIN | MEAT
			modified = TRUE
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.2))
			qdel(I)
	if(istype(I, /obj/item/reagent_containers/food/snacks/butterslice))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 50, TRUE, -1)
		if(do_after(user, short_cooktime, src))
			name = "buttered [name]"
			add_overlay("buttered")
			tastes = list("butter" = 1)
			bonus_reagents = list(/datum/reagent/consumable/nutriment = SNACK_POOR)
			foodtype = GRAIN | DAIRY
			modified = TRUE
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.2))
			qdel(I)
	if(istype(I, /obj/item/reagent_containers/food/snacks/meat/mince/beef/mett))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 50, TRUE, -1)
		if(do_after(user, short_cooktime, src))
			name = "[name] & mett"
			add_overlay("metted")
			tastes = list("bread" = 1,"spicy raw meat" = 1)
			bonus_reagents = list(/datum/reagent/consumable/nutriment = SNACK_POOR + 2)
			foodtype = GRAIN | MEAT | VEGETABLES
			modified = TRUE
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.2))
			qdel(I)
	return ..()

/obj/item/reagent_containers/food/snacks/breadslice/toast
	name = "toasted bread"
	icon_state = "toast"
	tastes = list("crispy bread" = 1)
	cooked_type = /obj/item/reagent_containers/food/snacks/badrecipe
	rotprocess = SHELFLIFE_EXTREME

/obj/item/reagent_containers/food/snacks/stale_bread
	name = "stale bread"
	desc = "Old. Is that mold? Not fit for slicing, just eating in sullen silence."
	icon_state = "loaf6"
	color = "#92908a"
	dropshrink = 0.8
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	drop_sound = 'sound/foley/dropsound/gen_drop.ogg'
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("stale bread" = 1)
	faretype = FARE_NEUTRAL

/obj/item/reagent_containers/food/snacks/stale_bread/raisin
	icon_state = "raisinbread6"
/obj/item/reagent_containers/food/snacks/stale_bread/raisin/poison
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/berrypoison = 12)

/*	.................   Raisin bread   ................... */
/obj/item/reagent_containers/food/snacks/raisindough
	name = "dough of raisins"
	icon_state = "dough_raisin"
	slices_num = 0
	cooked_type = /obj/item/reagent_containers/food/snacks/bread/raisin
	cooked_smell = /datum/pollutant/food/raisin_bread
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/reagent_containers/food/snacks/bread/raisin
	name = "raisin loaf"
	desc = "Bread with raisins has a sweet taste and is both filling and preserves well."
	icon_state = "raisinbread6"
	base_icon_state = "raisinbread"
	slice_path = /obj/item/reagent_containers/food/snacks/breadslice/raisin
	list_reagents = list(/datum/reagent/consumable/nutriment = DOUGH_NUTRITION+SNACK_DECENT)
	tastes = list("bread" = 1,"dried fruit" = 1)
	rotprocess = SHELFLIFE_EXTREME
	become_rot_type = /obj/item/reagent_containers/food/snacks/stale_bread/raisin
	faretype = FARE_NEUTRAL

/obj/item/reagent_containers/food/snacks/raisindough_poison
	name = "loaf of raisins"
	icon_state = "raisinbreaduncooked"
	slices_num = 0
	cooked_type = /obj/item/reagent_containers/food/snacks/bread/raisin/poison
	cooked_smell = /datum/pollutant/food/raisin_bread
	list_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/berrypoison = 12)
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/reagent_containers/food/snacks/bread/raisin/poison
	slice_path = /obj/item/reagent_containers/food/snacks/breadslice/raisin_poison
	list_reagents = list(/datum/reagent/consumable/nutriment = MEAL_AVERAGE, /datum/reagent/berrypoison = 6)
	tastes = list("bread" = 1,"bitter fruit" = 1)
	become_rot_type = /obj/item/reagent_containers/food/snacks/stale_bread/raisin/poison

/obj/item/reagent_containers/food/snacks/breadslice/raisin
	name = "raisinbread slice"
	icon_state = "raisinbread_slice"
	list_reagents = list(/datum/reagent/consumable/nutriment = BREADSLICE_NUTRITION+2)
	tastes = list("bread" = 1,"dried fruit" = 1)
	rotprocess = SHELFLIFE_EXTREME
	faretype = FARE_NEUTRAL

/obj/item/reagent_containers/food/snacks/breadslice/raisin_poison
	name = "raisin loaf slice"
	icon_state = "raisinbread_slice"
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_POOR, /datum/reagent/berrypoison = 4)
	cooked_type = /obj/item/reagent_containers/food/snacks/badrecipe
	tastes = list("bread" = 1,"dried fruit" = 1)
	rotprocess = SHELFLIFE_LONG


/*-----------\
| Bread buns |
\-----------*/

/*	.................   Bread bun   ................... */
/obj/item/reagent_containers/food/snacks/bun
	name = "bun"
	desc = "Portable, quaint and entirely consumable"
	icon_state = "bun"
	base_icon_state = "bun"
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	w_class = WEIGHT_CLASS_NORMAL
	biting = TRUE
	tastes = list("bread" = 1)
	rotprocess = SHELFLIFE_EXTREME
	faretype = FARE_POOR

/obj/item/reagent_containers/food/snacks/bun/attackby(obj/item/I, mob/living/user, params)
	if(user.mind)
		short_cooktime = (50 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*8))
	if(modified)
		return TRUE
	if(bitecount >0)
		to_chat(user, span_warning("Leftovers aren´t suitable for this."))
		return TRUE
	if(istype(I, /obj/item/reagent_containers/food/snacks/cooked/sausage))
		playsound(get_turf(user), 'sound/foley/dropsound/gen_drop.ogg', 30, TRUE, -1)
		if(do_after(user, short_cooktime, src))
			name = "grenzelbun"
			desc = "Originally an elven cuisine composed of mortal races flesh and bread, the classic wiener in a bun, now modified and staple food of Grenzelhoft cuisine."
			list_reagents = list(/datum/reagent/consumable/nutriment = SAUSAGE_NUTRITION+SMALLDOUGH_NUTRITION)
			tastes = list("savory sausage" = 1)
			icon_state = "grenzbun"
			base_icon_state = "grenzbun"
			faretype = FARE_NEUTRAL
			foodtype = GRAIN | MEAT
			modified = TRUE
			meal_properties()
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
			qdel(I)
	return ..()


/*	.................   Cheese bun   ................... */
/obj/item/reagent_containers/food/snacks/foodbase/cheesebun_raw
	name = "raw cheese bun"
	desc = "Portable, quaint and entirely consumable"
	icon_state = "cheesebun_raw"
	cooked_type = /obj/item/reagent_containers/food/snacks/cheesebun
	cooked_smell = /datum/pollutant/food/cheese_bun
	list_reagents = list(/datum/reagent/consumable/nutriment = 4)
	w_class = WEIGHT_CLASS_NORMAL
	foodtype = GRAIN | DAIRY

/obj/item/reagent_containers/food/snacks/cheesebun
	name = "cheese bun"
	desc = "A treat from the Grenzelhoft kitchen."
	icon_state = "cheesebun"
	base_icon_state = "cheesebun"
	list_reagents = list(/datum/reagent/consumable/nutriment = SMALLDOUGH_NUTRITION+CHEESE_NUTRITION)
	biting = TRUE
	tastes = list("crispy bread and cream cheese" = 1)
	foodtype = GRAIN | DAIRY
	w_class = WEIGHT_CLASS_NORMAL
	rotprocess = SHELFLIFE_DECENT
	faretype = FARE_FINE

/*---------\
| Pastries |
\---------*/

/obj/item/reagent_containers/food/snacks/frybread
	name = "frybread"
	desc = "Flatbread fried at high heat with butter to give it a crispy outside. Staple of the elven kitchen."
	icon_state = "frybread"
	base_icon_state = "frybread"
	biting = TRUE
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	tastes = list("crispy bread with a soft inside" = 1)
	rotprocess = null
	faretype = FARE_FINE


/*	.................   Pastry   ................... */
/obj/item/reagent_containers/food/snacks/pastry
	name = "pastry"
	desc = "Favored among children and sweetlovers."
	icon_state = "pastry"
	base_icon_state = "pastry"
	biting = TRUE
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	tastes = list("crispy butterdough" = 1)
	rotprocess = SHELFLIFE_EXTREME


/*	.................   Raisin Biscuit   ................... */
/obj/item/reagent_containers/food/snacks/foodbase/biscuit_raw
	name = "uncooked raisin biscuit"
	icon_state = "biscuit_raw"
	cooked_type = /obj/item/reagent_containers/food/snacks/biscuit
	cooked_smell = /datum/pollutant/food/biscuit
	eat_effect = null
	rotprocess = SHELFLIFE_EXTREME
/obj/item/reagent_containers/food/snacks/foodbase/biscuit_raw/good
	cooked_type = /obj/item/reagent_containers/food/snacks/biscuit/good

/obj/item/reagent_containers/food/snacks/biscuit
	name = "biscuit"
	desc = "A treat made for a wretched dog like you."
	icon_state = "biscuit"
	base_icon_state = "biscuit"
	biting = TRUE
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT+SNACK_POOR)
	tastes = list("crispy butterdough" = 1, "raisins" = 1)
	faretype = FARE_POOR

/obj/item/reagent_containers/food/snacks/biscuit/good
	eat_effect = /datum/status_effect/buff/foodbuff
/obj/item/reagent_containers/food/snacks/biscuit/good/New()
	. = ..()
	good_quality_descriptors()

/obj/item/reagent_containers/food/snacks/foodbase/biscuitpoison_raw
	name = "uncooked raisin biscuit"
	icon_state = "biscuit_raw"
	cooked_type = /obj/item/reagent_containers/food/snacks/biscuit_poison
	cooked_smell = /datum/pollutant/food/biscuit
	eat_effect = null
	rotprocess = SHELFLIFE_EXTREME

/obj/item/reagent_containers/food/snacks/biscuit_poison
	name = "biscuit"
	desc = "A treat made for a wretched dog like you."
	icon_state = "biscuit"
	base_icon_state = "biscuit"
	biting = TRUE
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT+SNACK_POOR, /datum/reagent/berrypoison = 4)
	tastes = list("crispy butterdough" = 1, "bitter raisins" = 1)


/*	.................   Prezzel   ................... */
/obj/item/reagent_containers/food/snacks/foodbase/prezzel_raw
	name = "uncooked prezzel"
	icon_state = "prezzel_raw"
	dropshrink = 0.8
	cooked_type = /obj/item/reagent_containers/food/snacks/prezzel
	cooked_smell = /datum/pollutant/food/prezzel
	eat_effect = null
	rotprocess = SHELFLIFE_LONG
/obj/item/reagent_containers/food/snacks/foodbase/prezzel_raw/good
	cooked_type = /obj/item/reagent_containers/food/snacks/prezzel/good

/obj/item/reagent_containers/food/snacks/prezzel
	name = "lacklustre prezzel"
	desc = "The next best thing since sliced bread, originally a dwarven pastry, now seeing mass appeal."
	icon_state = "prezzel"
	base_icon_state = "prezzel"
	dropshrink = 0.8
	biting = TRUE
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	tastes = list("crispy butterdough" = 1)
	faretype = FARE_FINE

/obj/item/reagent_containers/food/snacks/prezzel/good
	name = "prezzel"
	eat_effect = /datum/status_effect/buff/foodbuff
/obj/item/reagent_containers/food/snacks/prezzel/good/New()
	. = ..()
	good_quality_descriptors()

/*	.................   Apple Fritter   ................... */

/obj/item/reagent_containers/food/snacks/foodbase/fritter_raw
	name = "uncooked apple fritter"
	icon_state = "applefritterraw"
	dropshrink = 0.8
	cooked_type = /obj/item/reagent_containers/food/snacks/fritter
	fried_type = /obj/item/reagent_containers/food/snacks/fritter
	cooked_smell = /datum/pollutant/food/fritter
	eat_effect = null
	rotprocess = SHELFLIFE_LONG
/obj/item/reagent_containers/food/snacks/foodbase/fritter_raw/good
	cooked_type = /obj/item/reagent_containers/food/snacks/fritter/good

/obj/item/reagent_containers/food/snacks/fritter
	name = "apple fritter"
	desc = "Having deep origins in the culture of Vanderlin, the humble fritter is perhaps the most patriotic pastry out there, long may it reign!"
	icon_state = "applefritter"
	dropshrink = 0.8
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_CHUNKY)
	tastes = list("crispy butterdough" = 1, "sweet apple bits" = 1)
	faretype = FARE_FINE

/obj/item/reagent_containers/food/snacks/fritter/good
	name = "apple fritter"
	eat_effect = /datum/status_effect/buff/foodbuff
/obj/item/reagent_containers/food/snacks/fritter/good/New()
	. = ..()
	good_quality_descriptors()

/*------\
| Cakes |
\------*/

/*	.................   Cake   ................... */
/obj/item/reagent_containers/food/snacks/cake
	name = "cake base"
	desc = "With this sweet thing, you shall make them sing. With jacksberry filling a cheesecake can be made. More exotic cakes require different fruit fillings."
	icon_state = "cake"
	dropshrink = 0.8
	w_class = WEIGHT_CLASS_NORMAL
	foodtype = GRAIN | DAIRY
	rotprocess = SHELFLIFE_LONG
/obj/item/reagent_containers/food/snacks/cake/attackby(obj/item/I, mob/living/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(user.mind)
		long_cooktime = (90 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*15))

	if(istype(I, /obj/item/reagent_containers/food/snacks/produce/jacksberry/poison) || istype(I, /obj/item/reagent_containers/food/snacks/raisins/poison))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			to_chat(user, span_notice("Adding some juicy fruit filling..."))
			if(do_after(user,long_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/chescake_poison(loc)
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT))
				qdel(I)
				qdel(src)
		else
			to_chat(user, span_warning("Put [src] on a table before working it!"))
	if(istype(I, /obj/item/reagent_containers/food/snacks/produce/pear))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			to_chat(user, span_notice("Adding mouth-watering pear filling..."))
			if(do_after(user,long_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/zybcake(loc)
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT))
				qdel(I)
				qdel(src)
		else
			to_chat(user, span_warning("Put [src] on a table before working it!"))
	if(istype(I, /obj/item/reagent_containers/food/snacks/produce/jacksberry) || istype(I, /obj/item/reagent_containers/food/snacks/raisins) || istype(I, /obj/item/reagent_containers/food/snacks/produce/apple))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			to_chat(user, span_notice("Adding some juicy fruit filling..."))
			if(do_after(user,long_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/chescake(loc)
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT))
				qdel(I)
				qdel(src)
		else
			to_chat(user, span_warning("Put [src] on a table before working it!"))
	if(istype(I, /obj/item/reagent_containers/food/snacks/produce/plum) || istype(I, /obj/item/reagent_containers/food/snacks/plum_dried))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			to_chat(user, span_notice("Adding some fine plum filling..."))
			if(do_after(user,long_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/crimsoncake(loc)
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT))
				qdel(I)
				qdel(src)
		else
	if(istype(I, /obj/item/reagent_containers/food/snacks/produce/tangerine) || istype(I, /obj/item/reagent_containers/food/snacks/tangerine_dried))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			to_chat(user, span_notice("Adding some tangy tangerine filling..."))
			if(do_after(user,long_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/tangerinecake(loc)
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT))
				qdel(I)
				qdel(src)
		else
			to_chat(user, span_warning("Put [src] on a table before working it!"))
	else if(istype(I, /obj/item/reagent_containers/food/snacks/produce/strawberry) || istype(I, /obj/item/reagent_containers/food/snacks/strawberry_dried))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			to_chat(user, span_notice("Adding some sweet strawberry filling..."))
			if(do_after(user,long_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/strawbycake(loc)
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT))
				qdel(I)
				qdel(src)
		else
			to_chat(user, span_warning("Put [src] on a table before working it!"))
	else
		return ..()

/obj/item/reagent_containers/food/snacks/chescake
	name = "cheesecake base"
	desc = "With this sweet thing, you shall make them sing. Lacking fresh cheese glazing."
	icon_state = "cake_filled"
	dropshrink = 0.8
	w_class = WEIGHT_CLASS_NORMAL
	foodtype = GRAIN | DAIRY
	rotprocess = SHELFLIFE_LONG
/obj/item/reagent_containers/food/snacks/chescake/attackby(obj/item/I, mob/living/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(user.mind)
		long_cooktime = (90 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*15))
	if(istype(I, /obj/item/reagent_containers/food/snacks/cheese))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			to_chat(user, span_notice("Spreading fresh cheese on the cake..."))
			if(do_after(user,long_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/chescake_ready(loc)
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT))
				qdel(I)
				qdel(src)
		else
			to_chat(user, span_warning("Put [src] on a table before working it!"))
	else
		return ..()

/obj/item/reagent_containers/food/snacks/chescake_poison
	name = "cheesecake base"
	desc = "With this sweet thing, you shall make them sing. Lacking fresh cheese glazing."
	icon_state = "cake_filled"
	dropshrink = 0.8
	w_class = WEIGHT_CLASS_NORMAL
	foodtype = GRAIN | DAIRY
	rotprocess = SHELFLIFE_LONG
/obj/item/reagent_containers/food/snacks/chescake_poison/attackby(obj/item/I, mob/living/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(user.mind)
		long_cooktime = (90 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*15))
	if(istype(I, /obj/item/reagent_containers/food/snacks/cheese))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			to_chat(user, span_notice("Spreading fresh cheese on the cake..."))
			if(do_after(user,long_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/chescake_poison_ready(loc)
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT))
				qdel(I)
				qdel(src)
		else
			to_chat(user, span_warning("Put [src] on a table before working it!"))
	else
		return ..()

/obj/item/reagent_containers/food/snacks/zybcake
	name = "zybantu cake base"
	desc = "With this sweet thing, you shall make them sing. Lacking spider-honey glazing."
	icon_state = "cake_filled"
	dropshrink = 0.8
	w_class = WEIGHT_CLASS_NORMAL
	foodtype = GRAIN | DAIRY
	rotprocess = SHELFLIFE_LONG
/obj/item/reagent_containers/food/snacks/zybcake/attackby(obj/item/I, mob/living/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(user.mind)
		long_cooktime = (90 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*15))
	if(istype(I, /obj/item/reagent_containers/food/snacks/spiderhoney))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			to_chat(user, span_notice("Spreading spider-honey on the cake..."))
			if(do_after(user,long_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/zybcake_ready(loc)
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT))
				qdel(I)
				qdel(src)
		else
			to_chat(user, span_warning("Put [src] on a table before working it!"))
	else
		return ..()



// -------------- SPIDER-HONEY CAKE (Zybantu) -----------------
/obj/item/reagent_containers/food/snacks/zybcake_ready
	name = "unbaked zybantu cake"
	icon_state = "honeycakeuncook"
	dropshrink = 0.8
	slices_num = 0
	cooked_type = /obj/item/reagent_containers/food/snacks/zybcake_cooked
	cooked_smell = /datum/pollutant/food/honey_cake
	w_class = WEIGHT_CLASS_NORMAL
	rotprocess = SHELFLIFE_DECENT

/obj/item/reagent_containers/food/snacks/zybcake_cooked
	name = "zybantine cake"
	desc = "Cake glazed with honey, in the famous Zybantu fashion, a delicious sweet treat. Said to be very hard to poison, perhaps the honey counteracting such malicious concotions."
	icon_state = "honeycake"
	dropshrink = 0.8
	slices_num = 6
	slice_path = /obj/item/reagent_containers/food/snacks/zybcake_slice
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT*6)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("cake"=1, "pear" = 1, "delicious honeyfrosting"=1)
	slice_batch = TRUE
	slice_sound = TRUE
	rotprocess = SHELFLIFE_LONG
	eat_effect = /datum/status_effect/buff/foodbuff
	faretype = FARE_LAVISH

/obj/item/reagent_containers/food/snacks/zybcake_slice
	name = "zybantine cake slice"
	icon_state = "hcake_slice"
	base_icon_state = "hcake_slice"
	dropshrink = 0.8
	slices_num = 0
	bitesize = 2
	biting = TRUE
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	w_class = WEIGHT_CLASS_NORMAL
	foodtype = GRAIN | FRUIT | SUGAR
	tastes = list("cake"=1, "pear" = 1, "delicious honeyfrosting"=1)
	eat_effect = /datum/status_effect/buff/foodbuff
	rotprocess = SHELFLIFE_DECENT
	plateable = TRUE
	faretype = FARE_FINE

// -------------- CHEESECAKE -----------------
/obj/item/reagent_containers/food/snacks/chescake_ready
	name = "unbaked cake of cheese"
	icon_state = "cheesecakeuncook"
	dropshrink = 0.8
	slices_num = 0
	cooked_type = /obj/item/reagent_containers/food/snacks/cheesecake_cooked
	cooked_smell = /datum/pollutant/food/cheese_cake
	w_class = WEIGHT_CLASS_NORMAL
	rotprocess = SHELFLIFE_DECENT

/obj/item/reagent_containers/food/snacks/chescake_poison_ready
	name = "unbaked cake of cheese"
	icon_state = "cheesecakeuncook"
	dropshrink = 0.8
	slices_num = 0
	cooked_type = /obj/item/reagent_containers/food/snacks/cheesecake_poison_cooked
	cooked_smell = /datum/pollutant/food/cheese_cake
	w_class = WEIGHT_CLASS_NORMAL
	rotprocess = SHELFLIFE_DECENT

/obj/item/reagent_containers/food/snacks/cheesecake_cooked
	name = "cheesecake"
	desc = "Humenity's favored creation."
	icon_state = "cheesecake"
	dropshrink = 0.8
	slices_num = 6
	slice_path = /obj/item/reagent_containers/food/snacks/cheesecake_slice
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT*6)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("cake"=1, "jacksberry" = 1, "creamy cheese"=1)
	foodtype = GRAIN | DAIRY | SUGAR
	slice_batch = TRUE
	slice_sound = TRUE
	rotprocess = SHELFLIFE_LONG
	eat_effect = /datum/status_effect/buff/foodbuff
	faretype = FARE_FINE

/obj/item/reagent_containers/food/snacks/cheesecake_slice
	name = "cheesecake slice"
	icon_state = "cheesecake_slice"
	base_icon_state = "cheesecake_slice"
	dropshrink = 0.8
	slices_num = 0
	bitesize = 2
	biting = TRUE
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	tastes = list("cake"=1, "jacksberry" = 1, "creamy cheese"=1)
	w_class = WEIGHT_CLASS_NORMAL
	foodtype = GRAIN | DAIRY | SUGAR
	eat_effect = /datum/status_effect/buff/foodbuff
	rotprocess = SHELFLIFE_DECENT
	plateable = TRUE
	faretype = FARE_FINE

/obj/item/reagent_containers/food/snacks/cheesecake_poison_cooked
	name = "cheesecake"
	desc = "Humenity's favored creation."
	icon_state = "cheesecake"
	dropshrink = 0.8
	slices_num = 6
	slice_path = /obj/item/reagent_containers/food/snacks/cheesecake_poison_slice
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT*6, /datum/reagent/berrypoison = 24)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("cake"=1, "sour berry" = 1, "creamy cheese"=1)
	foodtype = GRAIN | DAIRY | SUGAR
	slice_batch = TRUE
	slice_sound = TRUE
	rotprocess = SHELFLIFE_LONG
	eat_effect = /datum/status_effect/buff/foodbuff
	bitesize = 6
	faretype = FARE_FINE

/obj/item/reagent_containers/food/snacks/cheesecake_poison_slice
	name = "cheesecake slice"
	icon_state = "cheesecake_slice"
	base_icon_state = "cheesecake_slice"
	dropshrink = 0.8
	slices_num = 0
	bitesize = 2
	biting = TRUE
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT, /datum/reagent/berrypoison = 6)
	tastes = list("cake"=1, "sour berry" = 1, "creamy cheese"=1)
	w_class = WEIGHT_CLASS_NORMAL
	foodtype = GRAIN | DAIRY | SUGAR
	rotprocess = SHELFLIFE_DECENT
	plateable = TRUE
	faretype = FARE_FINE

/*	.................   STRAWBERRY CAKE   ................... */

/obj/item/reagent_containers/food/snacks/strawbycake
	name = "strawberry cake base"
	desc = "With this sweet thing, you shall make them sing. Lacking sugar frosting."
	icon_state = "cake_filled"
	dropshrink = 0.8
	w_class = WEIGHT_CLASS_NORMAL
	rotprocess = SHELFLIFE_DECENT
/obj/item/reagent_containers/food/snacks/strawbycake/attackby(obj/item/I, mob/living/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(user.mind)
		long_cooktime = (90 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*15))
	if(istype(I, /obj/item/reagent_containers/food/snacks/sugar))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			to_chat(user, span_notice("Spreading sugar frosting on the cake..."))
			if(do_after(user,long_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/strawbycake_ready(loc)
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT))
				qdel(I)
				qdel(src)
		else
			to_chat(user, span_warning("Put [src] on a table before working it!"))
	else
		return ..()

/obj/item/reagent_containers/food/snacks/strawbycake_ready
	name = "unbaked strawberry cake"
	icon_state = "strawberrycakeuncooked"
	dropshrink = 0.8
	slices_num = 0
	cooked_type = /obj/item/reagent_containers/food/snacks/strawbycake_cooked
	cooked_smell = /datum/pollutant/food/strawberry_cake
	w_class = WEIGHT_CLASS_NORMAL
	rotprocess = SHELFLIFE_DECENT

/obj/item/reagent_containers/food/snacks/strawbycake_cooked
	name = "strawberry cake"
	desc = "Tradidtionally made with sugarbeet frosting, an elvish treat as old as time. Commonly served at elf weddings."
	icon_state = "strawberrycake"
	dropshrink = 0.8
	slices_num = 6
	slice_path = /obj/item/reagent_containers/food/snacks/strawbycake_slice
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT*6)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("cake"=1, "strawberry" = 1, "sugar"=1)
	foodtype = GRAIN | FRUIT | SUGAR
	slice_batch = TRUE
	slice_sound = TRUE
	rotprocess = SHELFLIFE_LONG
	eat_effect = /datum/status_effect/buff/foodbuff
	faretype = FARE_LAVISH

/obj/item/reagent_containers/food/snacks/strawbycake_slice
	name = "strawberry cake slice"
	icon_state = "strawberrycakeslice"
	dropshrink = 0.8
	slices_num = 0
	bitesize = 2
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	tastes = list("cake"=1, "strawberry" = 1, "sugar"=1)
	w_class = WEIGHT_CLASS_NORMAL
	foodtype = GRAIN | FRUIT | SUGAR
	rotprocess = SHELFLIFE_DECENT
	eat_effect = /datum/status_effect/buff/foodbuff
	faretype = FARE_FINE

/*	.................   CRIMSON PINE CAKE   ................... */

/obj/item/reagent_containers/food/snacks/crimsoncake
	name = "crimson pine cake base"
	desc = "With this sweet thing, you shall make them sing. Lacking chocolate bits."
	icon_state = "cake_filled"
	dropshrink = 0.8
	w_class = WEIGHT_CLASS_NORMAL
	rotprocess = SHELFLIFE_DECENT
/obj/item/reagent_containers/food/snacks/crimsoncake/attackby(obj/item/I, mob/living/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(user.mind)
		long_cooktime = (90 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*15))
	if(istype(I, /obj/item/reagent_containers/food/snacks/chocolate))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			to_chat(user, span_notice("Adding chocolate to the dough..."))
			if(do_after(user,long_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/crimsoncake_ready(loc)
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT))
				qdel(I)
				qdel(src)
		else
			to_chat(user, span_warning("Put [src] on a table before working it!"))
	else
		return ..()

/obj/item/reagent_containers/food/snacks/crimsoncake_ready
	name = "unbaked crimson pine cake"
	icon_state = "crimsonpinecakeraw"
	slices_num = 0
	cooked_type = /obj/item/reagent_containers/food/snacks/crimsoncake_cooked
	cooked_smell = /datum/pollutant/food/crimson_cake
	w_class = WEIGHT_CLASS_NORMAL
	rotprocess = SHELFLIFE_DECENT

/obj/item/reagent_containers/food/snacks/crimsoncake_cooked
	name = "crimson pine cake"
	desc = "A fusion of Crimson Elf and Grenzlehoftian cuisines, the cake originates from the Valorian Republics. Rumor has it that one of the many casus belli in the Republics was based upon a disagreement on the cakes exact recipe."
	icon_state = "crimsonpinecake"
	slices_num = 6
	slice_path = /obj/item/reagent_containers/food/snacks/crimsoncake_slice
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_NUTRITIOUS*6, /datum/reagent/consumable/ethanol/plum_wine = SNACK_DECENT*6)
	tastes = list("cake"=1, "chocolate" = 1, "plum"=1)
	foodtype = GRAIN | FRUIT | SUGAR
	slice_batch = TRUE
	slice_sound = TRUE
	rotprocess = SHELFLIFE_LONG
	eat_effect = /datum/status_effect/buff/foodbuff
	faretype = FARE_LAVISH

/obj/item/reagent_containers/food/snacks/crimsoncake_slice
	name = "crimson pine cake slice"
	icon_state = "crimsonpinecakeslice"
	dropshrink = 0.8
	slices_num = 0
	bitesize = 2
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_NUTRITIOUS, /datum/reagent/consumable/ethanol/plum_wine = SNACK_DECENT)
	tastes = list("cake"=1, "chocolate" = 1, "plum"=1)
	w_class = WEIGHT_CLASS_NORMAL
	foodtype = GRAIN | FRUIT | SUGAR
	rotprocess = SHELFLIFE_LONG
	eat_effect = /datum/status_effect/buff/foodbuff
	faretype = FARE_LAVISH

/*	.................   TANGERINE CAKE   ................... */

/obj/item/reagent_containers/food/snacks/tangerinecake
	name = "scarletharp cake base"
	desc = "With this sweet thing, you shall make them sing. Lacking sugar frosting."
	icon_state = "cake_filled"
	dropshrink = 0.8
	w_class = WEIGHT_CLASS_NORMAL
	rotprocess = SHELFLIFE_DECENT
/obj/item/reagent_containers/food/snacks/tangerinecake/attackby(obj/item/I, mob/living/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(user.mind)
		long_cooktime = (90 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*15))
	if(istype(I, /obj/item/reagent_containers/food/snacks/sugar))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			to_chat(user, span_notice("Spreading sugar frosting on the cake..."))
			if(do_after(user,long_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/tangerinecake_ready(loc)
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT))
				qdel(I)
				qdel(src)
		else
			to_chat(user, span_warning("Put [src] on a table before working it!"))
	else
		return ..()

/obj/item/reagent_containers/food/snacks/tangerinecake_ready
	name = "unbaked scarletharp cake"
	icon_state = "tangerinecakeraw"
	dropshrink = 0.9
	slices_num = 0
	cooked_type = /obj/item/reagent_containers/food/snacks/tangerinecake_cooked
	cooked_smell = /datum/pollutant/food/strawberry_cake
	w_class = WEIGHT_CLASS_NORMAL
	rotprocess = SHELFLIFE_DECENT

/obj/item/reagent_containers/food/snacks/tangerinecake_cooked
	name = "scarletharp cake"
	desc = "The Scarletharp cake, named not so aptly for its town of origin, is a twist on the traditional lunch cake substituting the dried fruit bits for a center filling of tangerine jam."
	icon_state = "tangerinecake"
	dropshrink = 0.9
	slices_num = 6
	slice_path = /obj/item/reagent_containers/food/snacks/tangerinecake_slice
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT*6)
	w_class = WEIGHT_CLASS_NORMAL
	tastes = list("cake"=1, "tangerine" = 1, "sugar"=1)
	foodtype = GRAIN | FRUIT | SUGAR
	slice_batch = TRUE
	slice_sound = TRUE
	rotprocess = SHELFLIFE_LONG
	eat_effect = /datum/status_effect/buff/foodbuff
	faretype = FARE_LAVISH

/obj/item/reagent_containers/food/snacks/tangerinecake_slice
	name = "scarletharp cake slice"
	icon_state = "tangerinecakeslice"
	dropshrink = 0.8
	slices_num = 0
	bitesize = 2
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	tastes = list("cake"=1, "tangerine" = 1, "sugar"=1)
	w_class = WEIGHT_CLASS_NORMAL
	foodtype = GRAIN | FRUIT | SUGAR
	rotprocess = SHELFLIFE_DECENT
	eat_effect = /datum/status_effect/buff/foodbuff
	faretype = FARE_FINE

/*-------\
| Scones |
\-------*/

/*	.................   Plain Scone   ................... */

/obj/item/reagent_containers/food/snacks/foodbase/scone_raw
	name = "unbaked scone"
	icon_state = "uncookedsconebase"
	cooked_type = /obj/item/reagent_containers/food/snacks/scone
	cooked_smell = /datum/pollutant/food/scone
	rotprocess = SHELFLIFE_EXTREME
	eat_effect = null
/obj/item/reagent_containers/food/snacks/foodbase/scone_raw/attackby(obj/item/I, mob/living/user, params)
	..()
	if(user.mind)
		short_cooktime = (50 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*8))
	var/found_table = locate(/obj/structure/table) in (loc)
	if(isturf(loc)&& (found_table))
		if(istype(I, /obj/item/reagent_containers/food/snacks/produce/tangerine) || istype(I, /obj/item/reagent_containers/food/snacks/tangerine_dried))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			to_chat(user, span_notice("Adding tangerine to the scone..."))
			if(do_after(user, short_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/foodbase/scone_raw_tangerine(loc)
				qdel(I)
				qdel(src)
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
		else if(istype(I, /obj/item/reagent_containers/food/snacks/produce/plum) || istype(I, /obj/item/reagent_containers/food/snacks/plum_dried))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			to_chat(user, span_notice("Adding plum to the scone..."))
			if(do_after(user, short_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/foodbase/scone_raw_plum(loc)
				qdel(I)
				qdel(src)
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
	else
		to_chat(user, span_warning("Put [src] on a table before working it!"))

/obj/item/reagent_containers/food/snacks/scone
	name = "plain scone"
	desc = "A delightfully fancy treat adored by the upper echelons of Kingsfield."
	icon_state = "cookedscone"
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT+SNACK_POOR)
	tastes = list("crumbly butterdough" = 1, "sweet" = 1)
	faretype = FARE_FINE
	eat_effect = /datum/status_effect/buff/foodbuff

/*	.................   Tangerine Scone   ................... */

/obj/item/reagent_containers/food/snacks/foodbase/scone_raw_tangerine
	name = "unbaked tangerine scone"
	icon_state = "uncookedtangerinescone"
	cooked_type = /obj/item/reagent_containers/food/snacks/scone_tangerine
	cooked_smell = /datum/pollutant/food/scone
	rotprocess = SHELFLIFE_EXTREME
	eat_effect = null

/obj/item/reagent_containers/food/snacks/scone_tangerine
	name = "tangerine scone"
	desc = "A delightfully fancy treat adored by the upper echelons of Kingsfield, complete with tangerine frosting."
	icon_state = "cookedtangerinescone"
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT+SNACK_POOR)
	tastes = list("crumbly butterdough" = 1, "sweet" = 1, "tangerine" = 1)
	faretype = FARE_FINE
	eat_effect = /datum/status_effect/buff/foodbuff

/*	.................   Plum Scone   ................... */

/obj/item/reagent_containers/food/snacks/foodbase/scone_raw_plum
	name = "unbaked plum scone"
	icon_state = "uncookedplumscone"
	cooked_type = /obj/item/reagent_containers/food/snacks/scone_plum
	cooked_smell = /datum/pollutant/food/scone
	rotprocess = SHELFLIFE_EXTREME
	eat_effect = null

/obj/item/reagent_containers/food/snacks/scone_plum
	name = "plum scone"
	desc = "A delightfully fancy treat adored by the upper echelons of Kingsfield, complete with plum filling."
	icon_state = "cookedplumscone"
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT+SNACK_POOR)
	tastes = list("crumbly butterdough" = 1, "sweet" = 1, "plum" = 1)
	faretype = FARE_FINE
	eat_effect = /datum/status_effect/buff/foodbuff

/*-------------\
| Griddlecakes |
\-------------*/

/*	.................   Plain Griddlecake   ................... */

/obj/item/reagent_containers/food/snacks/foodbase/griddlecake_raw
	name = "raw griddlecake"
	icon_state = "rawgriddlecake"
	fried_type = /obj/item/reagent_containers/food/snacks/griddlecake
	cooked_smell = /datum/pollutant/food/griddlecake
	rotprocess = SHELFLIFE_LONG
	eat_effect = null

/obj/item/reagent_containers/food/snacks/foodbase/griddlecake_raw/attackby(obj/item/I, mob/living/user, params)
	..()
	if(user.mind)
		short_cooktime = (50 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*8))
	var/found_table = locate(/obj/structure/table) in (loc)
	if(isturf(loc)&& (found_table))
		if(istype(I, /obj/item/reagent_containers/food/snacks/produce/lemon))
			playsound(get_turf(user), 'sound/foley/kneading.ogg', 100, TRUE, -1)
			to_chat(user, span_notice("Adding lemon to the griddlecake..."))
			if(do_after(user, short_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/foodbase/lemongriddlecake_raw(loc)
				qdel(I)
				qdel(src)
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
		if(istype(I, /obj/item/reagent_containers/food/snacks/produce/apple) || istype(I, /obj/item/reagent_containers/food/snacks/apple_dried))
			playsound(get_turf(user), 'sound/foley/kneading.ogg', 100, TRUE, -1)
			to_chat(user, span_notice("Adding apple to the griddlecake..."))
			if(do_after(user, short_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/foodbase/applegriddlecake_raw(loc)
				qdel(I)
				qdel(src)
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
		if(istype(I, /obj/item/reagent_containers/food/snacks/produce/jacksberry) || istype(I, /obj/item/reagent_containers/food/snacks/raisins))
			playsound(get_turf(user), 'sound/foley/kneading.ogg', 100, TRUE, -1)
			to_chat(user, span_notice("Adding jacksberry to the griddlecake..."))
			if(do_after(user, short_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/foodbase/berrygriddlecake_raw(loc)
				qdel(I)
				qdel(src)
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
		else if(istype(I, /obj/item/reagent_containers/food/snacks/produce/jacksberry/poison) || istype(I, /obj/item/reagent_containers/food/snacks/raisins/poison))
			playsound(get_turf(user), 'sound/foley/kneading.ogg', 100, TRUE, -1)
			to_chat(user, span_notice("Adding jacksberry to the griddlecake..."))
			if(do_after(user, short_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/foodbase/poisonberrygriddlecake_raw(loc)
				qdel(I)
				qdel(src)
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
	else
		to_chat(user, span_warning("Put [src] on a table before working it!"))

/obj/item/reagent_containers/food/snacks/griddlecake
	name = "griddlecake"
	desc = "Enjoyed by mercenaries throughout Psydonia, though despite its prevelance no one quite knows its origin."
	bitesize = 6
	icon_state = "griddlecake"
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT+SNACK_POOR)
	tastes = list("fluffy butterdough" = 1, "sweet" = 1)
	rotprocess = SHELFLIFE_LONG
	faretype = FARE_NEUTRAL

/*	.................   Lemon Griddlecake   ................... */

/obj/item/reagent_containers/food/snacks/foodbase/lemongriddlecake_raw
	name = "raw lemon griddlecake"
	icon_state = "rawgriddlecakelemon"
	fried_type = /obj/item/reagent_containers/food/snacks/griddlecake/lemon
	cooked_smell = /datum/pollutant/food/griddlecake
	rotprocess = SHELFLIFE_LONG
	eat_effect = null

/obj/item/reagent_containers/food/snacks/griddlecake/lemon
	name = "lemon griddlecake"
	desc = "Enjoyed by mercenaries throughout Psydonia, though despite its prevelance no one quite knows its origin."
	bitesize = 6
	icon_state = "griddlecakelemon"
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT+SNACK_POOR)
	tastes = list("fluffy butterdough" = 1, "sweet" = 1, "lemon" = 1)
	rotprocess = SHELFLIFE_LONG
	faretype = FARE_FINE
	eat_effect = /datum/status_effect/buff/foodbuff

/*	.................   Apple Griddlecake   ................... */

/obj/item/reagent_containers/food/snacks/foodbase/applegriddlecake_raw
	name = "raw apple griddlecake"
	icon_state = "rawgriddlecakeapple"
	fried_type = /obj/item/reagent_containers/food/snacks/griddlecake/apple
	cooked_smell = /datum/pollutant/food/griddlecake
	rotprocess = SHELFLIFE_LONG
	eat_effect = null

/obj/item/reagent_containers/food/snacks/griddlecake/apple
	name = "apple griddlecake"
	desc = "Enjoyed by mercenaries throughout Psydonia, though despite its prevelance no one quite knows its origin."
	bitesize = 6
	icon_state = "griddlecakeapple"
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT+SNACK_POOR)
	tastes = list("fluffy butterdough" = 1, "sweet" = 1, "apple" = 1)
	rotprocess = SHELFLIFE_LONG
	faretype = FARE_FINE
	eat_effect = /datum/status_effect/buff/foodbuff

/*	.................   Berry Griddlecake   ................... */

/obj/item/reagent_containers/food/snacks/foodbase/berrygriddlecake_raw
	name = "raw jacksberry griddlecake"
	icon_state = "rawgriddlecakeberry"
	fried_type = /obj/item/reagent_containers/food/snacks/griddlecake/berry
	cooked_smell = /datum/pollutant/food/griddlecake
	rotprocess = SHELFLIFE_LONG
	eat_effect = null

/obj/item/reagent_containers/food/snacks/griddlecake/berry
	name = "jacksberry griddlecake"
	desc = "Enjoyed by mercenaries throughout Psydonia, though despite its prevelance no one quite knows its origin."
	bitesize = 6
	icon_state = "griddlecakeberry"
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT+SNACK_POOR)
	tastes = list("fluffy butterdough" = 1, "sweet" = 1, "sweet berry" = 1)
	rotprocess = SHELFLIFE_LONG
	faretype = FARE_FINE
	eat_effect = /datum/status_effect/buff/foodbuff

/obj/item/reagent_containers/food/snacks/foodbase/poisonberrygriddlecake_raw
	name = "raw jacksberry griddlecake"
	icon_state = "rawgriddlecakeberry"
	fried_type = /obj/item/reagent_containers/food/snacks/griddlecake/berry_poison
	cooked_smell = /datum/pollutant/food/griddlecake
	rotprocess = SHELFLIFE_LONG
	eat_effect = null

/obj/item/reagent_containers/food/snacks/griddlecake/berry_poison
	name = "jacksberry griddlecake"
	desc = "Enjoyed by mercenaries throughout Psydonia, though despite its prevelance no one quite knows its origin."
	bitesize = 6
	icon_state = "griddlecakeberry"
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT+SNACK_POOR, /datum/reagent/berrypoison = 12)
	tastes = list("fluffy butterdough" = 1, "sweet" = 1, "bitter berry" = 1)
	rotprocess = SHELFLIFE_LONG
	faretype = FARE_NEUTRAL
	eat_effect = /datum/status_effect/buff/foodbuff

/*	.................   Griddlecake Condiments   ................... */

/obj/item/reagent_containers/food/snacks/griddlecake/attackby(obj/item/I, mob/living/user, params)
	if(user.mind)
		short_cooktime = (50 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*8))
	if(modified)
		return TRUE
	if(istype(I, /obj/item/reagent_containers/food/snacks/butterslice))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 50, TRUE, -1)
		if(do_after(user, short_cooktime, src))
			name = "buttered [name]"
			desc = "[desc] A melting pat of butter has been added."
			add_overlay("griddlebutter")
			tastes = list("butter" = 1)
			bonus_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT*2)
			modified = TRUE
			faretype = FARE_FINE
			eat_effect = /datum/status_effect/buff/foodbuff
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.2))
			qdel(I)
	if(istype(I, /obj/item/reagent_containers/food/snacks/spiderhoney))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 50, TRUE, -1)
		if(do_after(user, short_cooktime, src))
			name = "honey syruped [name]"
			desc = "[desc] A generous serving of honey has been poured on top."
			add_overlay("griddlehoney")
			tastes = list("honey" = 1)
			bonus_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT*2)
			modified = TRUE
			faretype = FARE_FINE
			eat_effect = /datum/status_effect/buff/foodbuff
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.2))
			qdel(I)
	else if(istype(I, /obj/item/reagent_containers/food/snacks/chocolate))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 50, TRUE, -1)
		if(do_after(user, short_cooktime, src))
			name = "chocolate drizzled [name]"
			desc = "[desc] Luxurious chocolate has been drizzled on top."
			add_overlay("griddlechocolate")
			tastes = list("chocolate" = 1)
			bonus_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT*3)
			modified = TRUE
			faretype = FARE_LAVISH
			eat_effect = /datum/status_effect/buff/foodbuff
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.2))
			qdel(I)
