/* * * * * * * * * * * **
 *						*
 *		 NeuFood		*	- Defined as edible food that can't be plated and ideally can be made in rough conditions, generally less nutritious
 *		 (Snacks)		*
 *						*
 * * * * * * * * * * * **/


/*	.............   Frysteak   ................ */
/obj/item/reagent_containers/food/snacks/rogue/meat/steak/fried
	eat_effect = null
	slices_num = 0
	name = "frysteak"
	desc = "A slab of beastflesh, fried to a perfect medium-rare"
	icon_state = "frysteak"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = MEATSLAB_NUTRITION)
	rotprocess = SHELFLIFE_DECENT
	tastes = list("warm steak" = 1)

/obj/item/reagent_containers/food/snacks/rogue/meat/steak/fried/attackby(obj/item/I, mob/user, params)
	var/obj/item/reagent_containers/peppermill/mill = I
	if (!isturf(src.loc) || \
		!(locate(/obj/structure/table) in src.loc) && \
		!(locate(/obj/structure/table/optable) in src.loc) && \
		!(locate(/obj/item/storage/bag/tray) in src.loc))
		to_chat(user, "<span class='warning'>I need to use a table.</span>")
		return FALSE
	if(user.mind)
		short_cooktime = (50 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*5))
		long_cooktime = (90 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*10))
	if(istype(mill))
		if(!mill.reagents.has_reagent(/datum/reagent/consumable/blackpepper, 1))
			to_chat(user, "There's not enough black pepper to make anything with.")
			return TRUE
		mill.icon_state = "peppermill_grind"
		to_chat(user, "You start rubbing the steak with black pepper.")
		playsound(get_turf(user), 'modular/Neu_Food/sound/peppermill.ogg', 100, TRUE, -1)
		if(do_after(user, long_cooktime, src))
			if(!mill.reagents.has_reagent(/datum/reagent/consumable/blackpepper, 1))
				to_chat(user, "There's not enough black pepper to make anything with.")
				return TRUE
			mill.reagents.remove_reagent(/datum/reagent/consumable/blackpepper, 1)
			new /obj/item/reagent_containers/food/snacks/rogue/peppersteak(loc)
			user.mind.adjust_experience(/datum/skill/craft/cooking, COMPLEX_COOKING_XPGAIN, FALSE)
			qdel(src)

	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/preserved/onion_fried))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
		to_chat(user, "<span class='notice'>Adding onions...</span>")
		if(do_after(user, short_cooktime, src))
			new /obj/item/reagent_containers/food/snacks/rogue/onionsteak(loc)
			user.mind.adjust_experience(/datum/skill/craft/cooking, SIMPLE_COOKING_XPGAIN, FALSE)
			qdel(I)
			qdel(src)

	else
		to_chat(user, "<span class='warning'>You need to put [src] on a table to knead in the spice.</span>")


/*	.............   Fried Cackleberry   ................ */
/obj/item/reagent_containers/food/snacks/rogue/friedegg
	trash = null
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	tastes = list("fried cackleberry" = 1)
	name = "fried cackleberry"
	desc = "A favorite dish among Astratans."
	icon_state = "friedegg"
	foodtype = MEAT
	warming = 5 MINUTES
	rotprocess = SHELFLIFE_DECENT
/obj/item/reagent_containers/food/snacks/rogue/friedegg/attackby(obj/item/I, mob/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(user.mind)
		short_cooktime = (50 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*5))
		long_cooktime = (90 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*10))
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/friedegg))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/gen_drop.ogg', 30, TRUE, -1)
			if(do_after(user, short_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/rogue/friedegg/two(loc)
				user.mind.adjust_experience(/datum/skill/craft/cooking, SIMPLE_COOKING_XPGAIN, FALSE)
				qdel(I)
				qdel(src)
	else
		return ..()


/*	.............   Twin fried cackleberries   ................ */
/obj/item/reagent_containers/food/snacks/rogue/friedegg/two
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_NUTRITIOUS)
	tastes = list("fried cackleberries" = 1)
	name = "fried cackleberries"
	desc = "Double the yolks, double the fun."
	icon_state = "seggs"
/obj/item/reagent_containers/food/snacks/rogue/friedegg/two/attackby(obj/item/I, mob/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(user.mind)
		short_cooktime = (50 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*5))
		long_cooktime = (90 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*10))
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/cheddarwedge))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/gen_drop.ogg', 30, TRUE, -1)
			if(do_after(user, long_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/rogue/friedegg/tiberian(loc)
				user.mind.adjust_experience(/datum/skill/craft/cooking, SIMPLE_COOKING_XPGAIN, FALSE)
				qdel(I)
				qdel(src)
	else
		return ..()


/*	.............   Frybird   ................ */
/obj/item/reagent_containers/food/snacks/rogue/meat/poultry/cutlet/fried
	eat_effect = null
	slices_num = 0
	name = "frybird"
	desc = "Poultry scorched to a perfect delicious crisp."
	icon_state = "frybird"
	fried_type = null
	bonus_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	rotprocess = SHELFLIFE_DECENT
/obj/item/reagent_containers/food/snacks/rogue/meat/poultry/cutlet/fried/attackby(obj/item/I, mob/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(user.mind)
		short_cooktime = (50 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*5))
		long_cooktime = (90 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*10))
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/preserved/potato_baked))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/gen_drop.ogg', 30, TRUE, -1)
			if(do_after(user, short_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/rogue/frybirdtato(loc)
				user.mind.adjust_experience(/datum/skill/craft/cooking, SIMPLE_COOKING_XPGAIN, FALSE)
				qdel(I)
				qdel(src)
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/preserved/potato_fried))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/gen_drop.ogg', 30, TRUE, -1)
			if(do_after(user, short_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/rogue/frybirdtato(loc)
				user.mind.adjust_experience(/datum/skill/craft/cooking, SIMPLE_COOKING_XPGAIN, FALSE)
				qdel(I)
				qdel(src)
	else
		return ..()


/*	.............   Crispy bacon   ................ */
/obj/item/reagent_containers/food/snacks/rogue/meat/bacon/fried
	eat_effect = null
	name = "fried bacon"
	desc = "A trufflepig's retirement plan."
	icon_state = "friedbacon"
	bonus_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	rotprocess = SHELFLIFE_DECENT


/obj/item/reagent_containers/food/snacks/rogue/truffles/Initialize()
	icon_state = pick("mushroom1_full","mushroom1_full","mushroom1_full")
	. = ..()

/obj/item/reagent_containers/food/snacks/rogue/toxicshrooms
	name = "truffles"

// for truffles + bacon meal
/obj/item/reagent_containers/food/snacks/rogue/truffles/cooked/attackby(obj/item/I, mob/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(user.mind)
		short_cooktime = (50 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*5))
		long_cooktime = (90 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*10))
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/meat/bacon/fried))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/gen_drop.ogg', 30, TRUE, -1)
			if(do_after(user, short_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/rogue/royaltruffles(loc)
				user.mind.adjust_experience(/datum/skill/craft/cooking, SIMPLE_COOKING_XPGAIN, FALSE)
				qdel(I)
				qdel(src)
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/toxicshrooms/cooked))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/gen_drop.ogg', 30, TRUE, -1)
			if(do_after(user, short_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/rogue/royaltruffles_poisoned(loc)
				user.mind.adjust_experience(/datum/skill/craft/cooking, SIMPLE_COOKING_XPGAIN, FALSE)
				qdel(I)
				qdel(src)
	else
		return ..()


/*	.............   Frything   ................ */
/obj/item/reagent_containers/food/snacks/rogue/meat/spider/fried
	name = "fried strange meat"
	desc = "Whatever it was, its roasted."
	icon_state = "friedspider"
	eat_effect = null
	bonus_reagents = list(/datum/reagent/consumable/nutriment = SNACK_POOR)
	rotprocess = SHELFLIFE_DECENT



/*---------------\
| Sausage snacks |
\---------------*/

/*	.............   Sausage & Wiener   ................ */
/obj/item/reagent_containers/food/snacks/rogue/meat/sausage/cooked
	eat_effect = null
	name = "sausage"
	desc = "Delicious flesh stuffed in a intestine casing."
	icon_state = "wiener"
	fried_type = null
	bonus_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	rotprocess = SHELFLIFE_EXTREME
/obj/item/reagent_containers/food/snacks/rogue/meat/sausage/cooked/attackby(obj/item/I, mob/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(user.mind)
		short_cooktime = (50 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*5))
		long_cooktime = (90 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*10))
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/preserved/cabbage_fried))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/gen_drop.ogg', 30, TRUE, -1)
			if(do_after(user, short_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/rogue/wienercabbage(loc)
				qdel(I)
				qdel(src)
	else
		return ..()

/obj/item/reagent_containers/food/snacks/rogue/meat/sausage/cooked/wiener // wiener meant to be made from beef or maybe mince + bacon, luxury sausage, not implemented yet
	name = "wiener"

/*	.............   Grenzelbun   ................ */
/obj/item/reagent_containers/food/snacks/rogue/bun_grenz
	list_reagents = list(/datum/reagent/consumable/nutriment = SAUSAGE_NUTRITION+SMALLDOUGH_NUTRITION)
	tastes = list("savory sausage" = 1, "bread" = 1)
	name = "grenzelbun"
	desc = "Originally an elven cuisine composed of mortal races flesh and bread, the classic wiener in a bun, now modified and staple food of Grenzelhoft cuisine."
	icon_state = "grenzbun"
	foodtype = GRAIN | MEAT
	warming = 5 MINUTES
	rotprocess = SHELFLIFE_LONG
	eat_effect = /datum/status_effect/buff/foodbuff
/obj/item/reagent_containers/food/snacks/rogue/bun_grenz/plated
	icon_state = "grenzbun_plated"
	item_state = "plate_food"
	lefthand_file = 'modular/Neu_Food/icons/food_lefthand.dmi'
	righthand_file = 'modular/Neu_Food/icons/food_righthand.dmi'
	experimental_inhand = FALSE
	w_class = WEIGHT_CLASS_BULKY
	bonus_reagents = list(/datum/reagent/consumable/nutriment = 2)
	trash = /obj/item/cooking/platter
	rotprocess = SHELFLIFE_EXTREME


/*---------------\
| Cooked veggies |
\---------------*/

/*	.............   Cooked cabbage   ................ */
/obj/item/reagent_containers/food/snacks/rogue/preserved/cabbage_fried
	name = "cooked cabbage"
	icon_state = "cabbage_fried"
	desc = "A peasant's delight."
	bitesize = 6
	list_reagents = list(/datum/reagent/consumable/nutriment = 6)
	tastes = list("warm cabbage" = 1)
	rotprocess = SHELFLIFE_LONG
/obj/item/reagent_containers/food/snacks/rogue/preserved/cabbage_fried/attackby(obj/item/I, mob/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(user.mind)
		short_cooktime = (50 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*5))
		long_cooktime = (90 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*10))
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/meat/sausage/cooked))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/gen_drop.ogg', 30, TRUE, -1)
			if(do_after(user, short_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/rogue/wienercabbage(loc)
				user.mind.adjust_experience(/datum/skill/craft/cooking, SIMPLE_COOKING_XPGAIN, FALSE)
				qdel(I)
				qdel(src)
	else
		return ..()


/*	.............   Baked potato   ................ */
/obj/item/reagent_containers/food/snacks/rogue/preserved/potato_baked
	name = "baked potatos"
	desc = "A dwarven favorite, as a meal or a game of hot potato."
	icon_state = "potato_baked"
	bitesize = 4
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	rotprocess = SHELFLIFE_LONG
/obj/item/reagent_containers/food/snacks/rogue/preserved/potato_baked/attackby(obj/item/I, mob/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(user.mind)
		short_cooktime = (50 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*5))
		long_cooktime = (90 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*10))
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/meat/sausage/cooked))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/gen_drop.ogg', 30, TRUE, -1)
			to_chat(user, "Preparing a serving of wiener and tatos...")
			if(do_after(user, short_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/rogue/wienerpotato(loc)
				user.mind.adjust_experience(/datum/skill/craft/cooking, SIMPLE_COOKING_XPGAIN, FALSE)
				qdel(I)
				qdel(src)
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/meat/poultry/cutlet/fried))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/gen_drop.ogg', 30, TRUE, -1)
			to_chat(user, "Preparing a serving of frybird and tatos...")
			if(do_after(user, short_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/rogue/frybirdtato(loc)
				user.mind.adjust_experience(/datum/skill/craft/cooking, SIMPLE_COOKING_XPGAIN, FALSE)
				qdel(I)
				qdel(src)
	else
		return ..()


/*	.............   Fried onions   ................ */
/obj/item/reagent_containers/food/snacks/rogue/preserved/onion_fried
	name = "fried onion"
	desc = "Seared onions roasted to a delicious set of rings."
	icon_state = "onion_fried"
	bitesize = 6
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	tastes = list("savoury morsel" = 1)
	rotprocess = SHELFLIFE_DECENT
/obj/item/reagent_containers/food/snacks/rogue/preserved/onion_fried/attackby(obj/item/I, mob/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(user.mind)
		short_cooktime = (50 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*5))
		long_cooktime = (90 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*10))
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/meat/sausage/cooked))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/gen_drop.ogg', 30, TRUE, -1)
			to_chat(user, "Preparing a serving of wiener and onions...")
			if(do_after(user, short_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/rogue/wieneronions(loc)
				user.mind.adjust_experience(/datum/skill/craft/cooking, SIMPLE_COOKING_XPGAIN, FALSE)
				qdel(I)
				qdel(src)
	else
		return ..()

/*	.............   Fried potato   ................ */
/obj/item/reagent_containers/food/snacks/rogue/preserved/potato_fried
	name = "fried potato"
	desc = "Potato bits, well roasted."
	icon_state = "potato_fried"
	bitesize = 3
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_DECENT)
	tastes = list("warm potato" = 1)
	rotprocess = SHELFLIFE_LONG
/obj/item/reagent_containers/food/snacks/rogue/preserved/potato_fried/attackby(obj/item/I, mob/user, params)
	var/found_table = locate(/obj/structure/table) in (loc)
	if(user.mind)
		short_cooktime = (50 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*5))
		long_cooktime = (90 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*10))
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/meat/sausage/cooked))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/gen_drop.ogg', 30, TRUE, -1)
			to_chat(user, "Preparing a serving of wiener and tatos...")
			if(do_after(user, short_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/rogue/wienerpotato(loc)
				user.mind.adjust_experience(/datum/skill/craft/cooking, SIMPLE_COOKING_XPGAIN, FALSE)
				qdel(I)
				qdel(src)
	if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/meat/poultry/cutlet/fried))
		if(isturf(loc)&& (found_table))
			playsound(get_turf(user), 'sound/foley/dropsound/gen_drop.ogg', 30, TRUE, -1)
			to_chat(user, "Preparing a serving of frybird and tatos...")
			if(do_after(user, short_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/rogue/frybirdtato(loc)
				user.mind.adjust_experience(/datum/skill/craft/cooking, SIMPLE_COOKING_XPGAIN, FALSE)
				qdel(I)
				qdel(src)
	else
		return ..()

