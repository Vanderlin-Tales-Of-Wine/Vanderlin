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
/obj/item/reagent_containers/food/snacks/rogue/dough_base
	name = "unfinished dough"
	desc = "With a little more ambition, you will conquer."
	icon_state = "dough_base"
	w_class = WEIGHT_CLASS_NORMAL
	rotprocess = SHELFLIFE_LONG
/obj/item/reagent_containers/food/snacks/rogue/dough_base/attackby(obj/item/I, mob/living/user, params)
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
				new /obj/item/reagent_containers/food/snacks/rogue/butterdough(loc)
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
				qdel(I)
				qdel(src)
		else
			to_chat(user, span_warning("Put [src] on a table before working it!"))
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
	if(isturf(loc)&& (found_table))
		if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/cheese/gote))
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
		else if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/cheese))
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
/obj/item/reagent_containers/food/snacks/rogue/butterdough
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
/obj/item/reagent_containers/food/snacks/rogue/butterdough/attackby(obj/item/I, mob/living/user, params)
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
			to_chat(user, "<span class='notice'>Flattening [src]...</span>")
			if(do_after(user, short_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/piedough(loc)
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
				qdel(src)
		if(istype(I, /obj/item/reagent_containers/food/snacks/raisins/poison))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			to_chat(user, "<span class='notice'>Adding raisins to the dough...</span>")
			if(do_after(user, short_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/foodbase/biscuitpoison_raw(loc)
				qdel(I)
				qdel(src)
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
		if(I.get_sharpness())
			if(!isdwarf(user))
				to_chat(user, "<span class='warning'>You lack knowledge of dwarven pastries!</span>")
				return
			else
				playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
				to_chat(user, "<span class='notice'>Cutting the dough in strips and making a prezzel...</span>")
				if(do_after(user, short_cooktime, src))
					if(user.mind.get_skill_level(/datum/skill/craft/cooking) >= 2)
						new /obj/item/reagent_containers/food/snacks/foodbase/prezzel_raw/good(loc)
					else
						new /obj/item/reagent_containers/food/snacks/foodbase/prezzel_raw(loc)
					qdel(src)
					user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
		else if(istype(I, /obj/item/reagent_containers/food/snacks/raisins))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			to_chat(user, "<span class='notice'>Adding raisins to the dough...</span>")
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
		to_chat(user, "<span class='notice'>Making a handpie...</span>")
		if(do_after(user, short_cooktime, src))
			var/obj/item/reagent_containers/food/snacks/foodbase/handpieraw/mushroom/handpie= new(get_turf(user))
			if(user.mind.get_skill_level(/datum/skill/craft/cooking) >= 2)
				handpie.cooked_type = /obj/item/reagent_containers/food/snacks/handpie/good
				handpie.fried_type = /obj/item/reagent_containers/food/snacks/handpie/good
			user.put_in_hands(handpie)
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
			qdel(I)
			qdel(src)
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/meat/mince))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 50, TRUE, -1)
		to_chat(user, "<span class='notice'>Making a handpie...</span>")
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
		to_chat(user, "<span class='notice'>Making a handpie...</span>")
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
		to_chat(user, "<span class='notice'>Making a handpie...</span>")
		if(do_after(user, short_cooktime, src))
			var/obj/item/reagent_containers/food/snacks/foodbase/handpieraw/apple/handpie= new(get_turf(user))
			if(user.mind.get_skill_level(/datum/skill/craft/cooking) >= 2)
				handpie.cooked_type = /obj/item/reagent_containers/food/snacks/handpie/good
				handpie.fried_type = /obj/item/reagent_containers/food/snacks/handpie/good
			user.put_in_hands(handpie)
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
			qdel(I)
			qdel(src)
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/cheese/gote))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 50, TRUE, -1)
		to_chat(user, "<span class='notice'>Making a handpie...</span>")
		if(do_after(user, short_cooktime, src))
			var/obj/item/reagent_containers/food/snacks/foodbase/handpieraw/cheese/handpie= new(get_turf(user))
			if(user.mind.get_skill_level(/datum/skill/craft/cooking) >= 2)
				handpie.cooked_type = /obj/item/reagent_containers/food/snacks/handpie/good
				handpie.fried_type = /obj/item/reagent_containers/food/snacks/handpie/good
			user.put_in_hands(handpie)
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
			qdel(I)
			qdel(src)
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/cheese))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 50, TRUE, -1)
		to_chat(user, "<span class='notice'>Making a handpie...</span>")
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
		to_chat(user, "<span class='notice'>Making a handpie...</span>")
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
		to_chat(user, "<span class='notice'>Making a handpie...</span>")
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
	desc = "One of the staple foods of the world, with the decline of magic, the loss of bread-duplication has led to mass famines around Psydonia."
	icon_state = "loaf6"
	base_icon_state = "loaf"
	dropshrink = 0.8
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

/obj/item/reagent_containers/food/snacks/bread/update_icon()
	if(slices_num)
		icon_state = "[base_icon_state][slices_num]"
	else
		icon_state = "[base_icon_state]_slice"

/obj/item/reagent_containers/food/snacks/bread/On_Consume(mob/living/eater)
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
/obj/item/reagent_containers/food/snacks/breadslice/attackby(obj/item/I, mob/living/user, params)
	if(user.mind)
		short_cooktime = (50 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*8))
	if(modified)
		return TRUE
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/meat/salami/slice))
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
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/cheddarslice))
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
	desc = "The next best thing since sliced bread, naturally, made by a dwarf."
	icon_state = "prezzel"
	base_icon_state = "prezzel"
	dropshrink = 0.8
	biting = TRUE
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	tastes = list("crispy butterdough" = 1)
/obj/item/reagent_containers/food/snacks/prezzel/good
	name = "prezzel"
	eat_effect = /datum/status_effect/buff/foodbuff
/obj/item/reagent_containers/food/snacks/prezzel/good/New()
	. = ..()
	good_quality_descriptors()

/*------\
| Cakes |
\------*/

/*	.................   Cake   ................... */
/obj/item/reagent_containers/food/snacks/cake
	name = "cake base"
	desc = "With this sweet thing, you shall make them sing. With jacksberry filling a cheesecake can be made. A more exotic cake requires pear filling."
	icon_state = "cake"
	dropshrink = 0.8
	w_class = WEIGHT_CLASS_NORMAL
	foodtype = GRAIN | DAIRY
	rotprocess = SHELFLIFE_LONG
/obj/item/reagent_containers/food/snacks/cake/attackby(obj/item/I, mob/living/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(user.mind)
		long_cooktime = (90 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*15))
	if(istype(I, /obj/item/reagent_containers/food/snacks/produce/jacksberry/poison))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			to_chat(user, "<span class='notice'>Adding some juicy fruit filling...</span>")
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
			to_chat(user, "<span class='notice'>Adding mouth-watering pear filling...</span>")
			if(do_after(user,long_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/zybcake(loc)
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT))
				qdel(I)
				qdel(src)
		else
			to_chat(user, span_warning("Put [src] on a table before working it!"))
	else if(istype(I, /obj/item/reagent_containers/food/snacks/produce/jacksberry))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			to_chat(user, "<span class='notice'>Adding some juicy fruit filling...</span>")
			if(do_after(user,long_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/chescake(loc)
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
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/cheese))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			to_chat(user, "<span class='notice'>Spreading fresh cheese on the cake...</span>")
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
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/cheese))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			to_chat(user, "<span class='notice'>Spreading fresh cheese on the cake...</span>")
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
			to_chat(user, "<span class='notice'>Spreading spider-honey on the cake...</span>")
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

/obj/item/reagent_containers/food/snacks/cheesecake_poison_slice
	name = "cheesecake slice"
	icon_state = "cheesecake_slice"
	base_icon_state = "cheesecake_slice"
	dropshrink = 0.8
	slices_num = 0
	biting = TRUE
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT, /datum/reagent/berrypoison = 6)
	tastes = list("cake"=1, "sour berry" = 1, "creamy cheese"=1)
	w_class = WEIGHT_CLASS_NORMAL
	foodtype = GRAIN | DAIRY | SUGAR
	rotprocess = SHELFLIFE_DECENT
	plateable = TRUE

