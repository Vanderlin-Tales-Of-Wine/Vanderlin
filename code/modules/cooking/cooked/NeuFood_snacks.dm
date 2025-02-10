/* * * * * * * * * * * **
 *						*
 *		 NeuFood		*	- Defined as edible food that can't be plated and ideally can be made in rough conditions, generally less nutritious
 *		 (Snacks)		*
 *						*
 * * * * * * * * * * * **/


/*	.............   Frysteak   ................ */
/obj/item/reagent_containers/food/snacks/cooked/frysteak
	name = "frysteak"
	desc = "A slab of beastflesh, fried to a perfect medium-rare"
	icon_state = "frysteak"
	base_icon_state = "frysteak"
	biting = TRUE
	eat_effect = null
	tastes = list("warm steak" = 1)
	list_reagents = list(/datum/reagent/consumable/nutriment = COOKED_MEAT_NUTRITION)
	slices_num = 0
	rotprocess = SHELFLIFE_DECENT
	plateable = TRUE
/obj/item/reagent_containers/food/snacks/cooked/frysteak/attackby(obj/item/I, mob/living/user, params)
	if(user.mind)
		short_cooktime = (50 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*8))
	if(modified)
		return TRUE
	if(bitecount >0)
		to_chat(user, span_warning("Leftovers aren´t suitable for this."))
		return TRUE
	var/obj/item/reagent_containers/peppermill/mill = I
	if(istype(mill) && (!modified))
		if(!mill.reagents.has_reagent(/datum/reagent/consumable/blackpepper, 1))
			to_chat(user, "There's not enough black pepper to make anything with.")
			return TRUE
		mill.icon_state = "peppermill_grind"
		to_chat(user, "You start rubbing the steak with black pepper.")
		playsound(get_turf(user), 'sound/foley/peppermill.ogg', 100, TRUE, -1)
		if(do_after(user, 3 SECONDS, src))
			if(!mill.reagents.has_reagent(/datum/reagent/consumable/blackpepper, 1))
				to_chat(user, "There's not enough black pepper to make anything with.")
				return TRUE
			mill.reagents.remove_reagent(/datum/reagent/consumable/blackpepper, 1)
			name = "peppersteak"
			desc = "Roasted flesh flanked with a generous coating of ground pepper for intense flavor."
			var/mutable_appearance/spice = mutable_appearance('icons/roguetown/items/food.dmi', "frysteak_spice")
			overlays += spice
			tastes = list("spicy red meat" = 2)
			meal_properties()
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))

	if(istype(I, /obj/item/reagent_containers/food/snacks/onion_fried) && (!modified))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
		to_chat(user, "<span class='notice'>Adding onions...</span>")
		if(do_after(user, short_cooktime, src))
			tastes = list("roasted meat" = 1, "caramelized onions" = 1)
			name = "[name] and onions"
			desc = "[desc] Garnished with tender fried onion, juices made into a simple sauce."
			icon_state = "onionsteak"
			base_icon_state = "onionsteak"
			list_reagents = list(/datum/reagent/consumable/nutriment = COOKED_MEAT_NUTRITION+FRYVEGGIE_NUTRITION+1)
			meal_properties()
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
			qdel(I)

	if(istype(I, /obj/item/reagent_containers/food/snacks/potato) && (!modified))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
		to_chat(user, "<span class='notice'>Adding potato...</span>")
		if(do_after(user, short_cooktime, src))
			tastes = list("roasted meat" = 2, "potato" = 1)
			name = "[name] and potato"
			desc = "[desc] Served with potatos, this will nourish even a starving volf."
			icon_state = "potatosteak"
			base_icon_state = "potatosteak"
			list_reagents = list(/datum/reagent/consumable/nutriment = COOKED_MEAT_NUTRITION+FRYVEGGIE_NUTRITION+3)
			meal_properties()
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
			qdel(I)

	return ..()


/*	.............   Fried egg   ................ */
/obj/item/reagent_containers/food/snacks/cooked/egg
	list_reagents = list(/datum/reagent/consumable/nutriment = EGG_NUTRITION)
	tastes = list("fried egg" = 1)
	name = "fried egg"
	desc = "A staple of Astratan midsummer festival eating."
	icon_state = "friedegg"
	base_icon_state = "friedegg"
	biting = TRUE

/obj/item/reagent_containers/food/snacks/cooked/egg/attackby(obj/item/I, mob/living/user, params)
	if(user.mind)
		short_cooktime = (50 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*8))
	if(modified)
		return TRUE
	if(bitecount >0)
		to_chat(user, span_warning("Leftovers aren´t suitable for this."))
		return TRUE
	if(istype(I, /obj/item/reagent_containers/food/snacks/cooked/egg) && (!modified))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
		if(do_after(user, short_cooktime, src))
			name = "[name] twins"
			desc = "[desc] There are two of them."
			icon_state = "seggs"
			base_icon_state = "seggs"
			list_reagents = list(/datum/reagent/consumable/nutriment = EGG_NUTRITION+EGG_NUTRITION)
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
			qdel(I)
	if(istype(I, /obj/item/reagent_containers/food/snacks/cheese_wedge) && (!modified))	// cheese to make it a proper meal thus unlocking plating and using the food buff check
		if(icon_state == "seggs")
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			if(do_after(user, short_cooktime, src))
				name = "valorian omelette"
				desc = "Fried cackleberries on a bed of half-melted cheese, a dish from distant lands."
				list_reagents = list(/datum/reagent/consumable/nutriment = EGG_NUTRITION+EGG_NUTRITION+CHEESE_NUTRITION+1)
				tastes = list("fried cackleberries" = 1, "cheese" = 1)
				icon_state = "omelette"
				base_icon_state = "omelette"
				meal_properties()
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
				qdel(I)
	return ..()


/*	.............   Frybird   ................ */
/obj/item/reagent_containers/food/snacks/cooked/frybird
	name = "frybird"
	desc = "Poultry scorched to a perfect delicious crisp."
	icon_state = "frybird"
	base_icon_state = "frybird"
	biting = TRUE
/obj/item/reagent_containers/food/snacks/cooked/frybird/attackby(obj/item/I, mob/living/user, params)
	if(user.mind)
		short_cooktime = (50 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*8))
	if(modified)
		return TRUE
	if(istype(I, /obj/item/reagent_containers/food/snacks/potato) && (!modified))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
		if(do_after(user, short_cooktime, src))
			name = "[name] and tatos"
			desc = "[desc] Some warm tatos accompany it."
			icon_state = "frybirdtato"
			base_icon_state = "frybirdtato"
			tastes = list("frybird" = 1, "warm tato" = 1)
			list_reagents = list(/datum/reagent/consumable/nutriment = COOKED_MEAT_NUTRITION+FRYVEGGIE_NUTRITION+2)
			meal_properties()
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
			qdel(I)
	return ..()

/*	.............   Han   ................ */
/obj/item/reagent_containers/food/snacks/cooked/ham
	name = "ham"
	desc = "A trufflepig's retirement plan."
	icon_state = "ham"
	base_icon_state = "ham"
	biting = TRUE
	filling_color = "#8a0000"
	become_rot_type = /obj/item/reagent_containers/food/snacks/rotten/bacon
	list_reagents = list(/datum/reagent/consumable/nutriment = COOKED_MEAT_NUTRITION+1)
/obj/item/reagent_containers/food/snacks/cooked/ham/attackby(obj/item/I, mob/living/user, params)
	if(user.mind)
		short_cooktime = (50 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*8))
	if(modified)
		return TRUE
	if(bitecount >0)
		to_chat(user, span_warning("Leftovers aren´t suitable for this."))
		return TRUE
	if(istype(I, /obj/item/reagent_containers/food/snacks/cooked/truffle) && (!modified))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
		if(do_after(user, short_cooktime, src))
			name = "royal truffles"
			desc = "The height of decadence, a precious truffle pig, turned into a amusing meal, served on a bed of its beloved golden truffles."
			icon_state = "royaltruffles"
			base_icon_state = "royaltruffles"
			list_reagents = list(/datum/reagent/consumable/nutriment = COOKED_MEAT_NUTRITION+COOKED_MEAT_NUTRITION+2)
			tastes = list("salted ham" = 1, "divine truffles" = 1)
			meal_properties()
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
			qdel(I)
	if(istype(I, /obj/item/reagent_containers/food/snacks/cooked/truffle_toxic) && (!modified))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
		if(do_after(user, short_cooktime, src))
			name = "royal truffles"
			desc = "The height of decadence, a precious truffle pig, turned into a amusing meal, served on a bed of its beloved golden truffles."
			icon_state = "royaltruffles"
			base_icon_state = "royaltruffles"
			list_reagents = list(/datum/reagent/consumable/nutriment = COOKED_MEAT_NUTRITION, /datum/reagent/berrypoison = 10)
			tastes = list("salted ham" = 1, "divine truffles" = 1)
			meal_properties()
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
			qdel(I)
	return ..()


/*	.............   Frything   ................ */
/obj/item/reagent_containers/food/snacks/cooked/strange
	name = "fried strange meat"
	desc = "Whatever it was, its roasted."
	icon_state = "fried_strange"
	base_icon_state = "fried_strange"
	list_reagents = list(/datum/reagent/consumable/nutriment = RAWMEAT_NUTRITION) // raw meat nutrition but without getting sick
	plateable = TRUE
	biting = TRUE

/*---------------\
| Sausage snacks |
\---------------*/

/*	.............   Sausage & Wiener   ................ */
/obj/item/reagent_containers/food/snacks/cooked/sausage
	name = "sausage"
	desc = "Delicious flesh stuffed in a intestine casing."
	icon_state = "wiener"
	base_icon_state = "wiener"
	list_reagents = list(/datum/reagent/consumable/nutriment = SAUSAGE_NUTRITION)
	tastes = list("savory sausage" = 2)
	rotprocess = SHELFLIFE_EXTREME
	biting = TRUE
/obj/item/reagent_containers/food/snacks/cooked/sausage/attackby(obj/item/I, mob/living/user, params)
	if(user.mind)
		short_cooktime = (50 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*8))
	if(modified)
		return TRUE
	if(bitecount >0)
		to_chat(user, span_warning("Leftovers aren´t suitable for this."))
		return TRUE
	if(istype(I, /obj/item/reagent_containers/food/snacks/cabbage_fried) && (!modified))
		playsound(src, 'sound/foley/dropsound/gen_drop.ogg', 30, TRUE)
		if(do_after(user, short_cooktime, src))
			name = "wiener on cabbage"
			desc = "A rich and heavy meal, perfect ration for a soldier on the march."
			list_reagents = list(/datum/reagent/consumable/nutriment = SAUSAGE_NUTRITION+FRYVEGGIE_NUTRITION+1)
			tastes = list("cabbage" = 1)
			icon_state = "wienercabbage"
			base_icon_state = "wienercabbage"
			foodtype = VEGETABLES | MEAT
			meal_properties()
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
			qdel(I)
	if(istype(I, /obj/item/reagent_containers/food/snacks/potato) && (!modified))
		playsound(get_turf(user), 'sound/foley/dropsound/gen_drop.ogg', 30, TRUE, -1)
		if(do_after(user, short_cooktime, src))
			name = "wiener on tato"
			desc = "Stout and nourishing."
			list_reagents = list(/datum/reagent/consumable/nutriment = SAUSAGE_NUTRITION+FRYVEGGIE_NUTRITION+2)
			tastes = list("fried potato" = 1)
			icon_state = "wienerpotato"
			base_icon_state = "wienerpotato"
			foodtype = VEGETABLES | MEAT
			meal_properties()
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
			qdel(I)
	if(istype(I, /obj/item/reagent_containers/food/snacks/onion_fried) && (!modified))
		playsound(get_turf(user), 'sound/foley/dropsound/gen_drop.ogg', 30, TRUE, -1)
		if(do_after(user, short_cooktime, src))
			name = "wiener and onions"
			desc = "Stout and flavourful."
			icon_state = "wieneronion"
			base_icon_state = "wieneronion"
			list_reagents = list(/datum/reagent/consumable/nutriment = SAUSAGE_NUTRITION+FRYVEGGIE_NUTRITION+1)
			tastes = list("fried onions" = 1)
			foodtype = VEGETABLES | MEAT
			meal_properties()
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
			qdel(I)
	if(istype(I, /obj/item/reagent_containers/food/snacks/bun) && (!modified))
		playsound(get_turf(user), 'sound/foley/dropsound/gen_drop.ogg', 30, TRUE, -1)
		if(do_after(user, short_cooktime, src))
			name = "grenzelbun"
			desc = "Originally an elven cuisine composed of mortal races flesh and bread, the classic wiener in a bun, now modified and staple food of Grenzelhoft cuisine."
			list_reagents = list(/datum/reagent/consumable/nutriment = SAUSAGE_NUTRITION+SMALLDOUGH_NUTRITION)
			tastes = list("bread" = 1)
			icon_state = "grenzbun"
			base_icon_state = "grenzbun"
			foodtype = GRAIN | MEAT
			meal_properties()
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
			qdel(I)

	return ..()

/obj/item/reagent_containers/food/snacks/cooked/sausage/wiener // wiener meant to be made from beef or maybe mince + bacon, luxury sausage, not implemented yet
	name = "wiener"



/*---------------\
| Cooked veggies |
\---------------*/

/*	.............   Cooked cabbage   ................ */
/obj/item/reagent_containers/food/snacks/cabbage_fried
	name = "cooked cabbage"
	desc = "A peasant's delight."
	icon_state = "cabbage_fried"
	base_icon_state = "cabbage_fried"
	biting = TRUE
	list_reagents = list(/datum/reagent/consumable/nutriment = FRYVEGGIE_NUTRITION)
	tastes = list("warm cabbage" = 1)
	rotprocess = SHELFLIFE_LONG
/obj/item/reagent_containers/food/snacks/cabbage_fried/attackby(obj/item/I, mob/living/user, params)
	if(user.mind)
		short_cooktime = (50 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*8))
	if(modified)
		return TRUE
	if(bitecount >0)
		to_chat(user, span_warning("Leftovers aren´t suitable for this."))
		return TRUE
	if(istype(I, /obj/item/reagent_containers/food/snacks/cooked/sausage) && (!modified))
		if(do_after(user, short_cooktime, src))
			name = "wiener on cabbage"
			desc = "A rich and heavy meal, perfect ration for a soldier on the march."
			list_reagents = list(/datum/reagent/consumable/nutriment = SAUSAGE_NUTRITION+FRYVEGGIE_NUTRITION+1)
			tastes = list("savory sausage" = 2, "cabbage" = 1)
			icon_state = "wienercabbage"
			base_icon_state = "wienercabbage"
			foodtype = VEGETABLES | MEAT
			meal_properties()
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
			qdel(I)
	return ..()


/*	.............   Baked potato   ................ */
/obj/item/reagent_containers/food/snacks/potato/baked
	name = "baked potatos"
	desc = "A dwarven favorite, as a meal or a game of hot potato."
	icon_state = "potato_baked"
	base_icon_state = "potato_baked"
	bitesize = 3
	biting = TRUE
	list_reagents = list(/datum/reagent/consumable/nutriment = FRYVEGGIE_NUTRITION)
	rotprocess = SHELFLIFE_LONG
/obj/item/reagent_containers/food/snacks/potato/baked/attackby(obj/item/I, mob/living/user, params)
	if(user.mind)
		short_cooktime = (50 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*8))
	if(modified)
		return TRUE
	if(bitecount >0)
		to_chat(user, span_warning("Leftovers aren´t suitable for this."))
		return TRUE
	if(istype(I, /obj/item/reagent_containers/food/snacks/cooked/sausage) && (!modified))
		playsound(get_turf(user), 'sound/foley/dropsound/gen_drop.ogg', 30, TRUE, -1)
		if(do_after(user, short_cooktime, src))
			name = "wiener on tato"
			desc = "Stout and nourishing."
			list_reagents = list(/datum/reagent/consumable/nutriment = SAUSAGE_NUTRITION+FRYVEGGIE_NUTRITION+2)
			tastes = list("savory sausage" = 1, "potato" = 1)
			icon_state = "wienerpotato"
			base_icon_state = "wienerpotato"
			foodtype = VEGETABLES | MEAT
			meal_properties()
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
			qdel(I)
	if(istype(I, /obj/item/reagent_containers/food/snacks/cooked/frybird) && (!modified))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
		if(do_after(user, short_cooktime, src))
			name = "[name] and tatos"
			desc = "[desc] Some warm tatos accompany it."
			icon_state = "frybirdtato"
			base_icon_state = "frybirdtato"
			tastes = list("frybird" = 1, "warm tato" = 1)
			list_reagents = list(/datum/reagent/consumable/nutriment = COOKED_MEAT_NUTRITION+FRYVEGGIE_NUTRITION+2)
			meal_properties()
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
			qdel(I)
	return ..()


/*	.............   Fried onions   ................ */
/obj/item/reagent_containers/food/snacks/onion_fried
	name = "fried onion"
	desc = "Seared onions roasted to a delicious set of rings."
	icon_state = "onion_fried"
	base_icon_state = "onion_fried"
	biting = TRUE
	list_reagents = list(/datum/reagent/consumable/nutriment = FRYVEGGIE_NUTRITION)
	tastes = list("savoury morsel" = 1)
	rotprocess = SHELFLIFE_LONG
/obj/item/reagent_containers/food/snacks/onion_fried/attackby(obj/item/I, mob/living/user, params)
	if(user.mind)
		short_cooktime = (50 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*8))
	if(modified)
		return TRUE
	if(bitecount >0)
		to_chat(user, span_warning("Leftovers aren´t suitable for this."))
		return TRUE
	if(istype(I, /obj/item/reagent_containers/food/snacks/cooked/sausage) && (!modified))
		if(do_after(user, short_cooktime, src))
			name = "wiener and onions"
			desc = "Stout and flavourful."
			icon_state = "wieneronion"
			base_icon_state = "wieneronion"
			list_reagents = list(/datum/reagent/consumable/nutriment = SAUSAGE_NUTRITION+FRYVEGGIE_NUTRITION+1)
			tastes = list("savory sausage" = 1, "fried onions" = 1)
			foodtype = VEGETABLES | MEAT
			meal_properties()
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
			qdel(I)
	return ..()

/*	.............   Fried potato   ................ */
/obj/item/reagent_containers/food/snacks/potato/fried
	name = "fried potato"
	desc = "Potato bits, well roasted."
	icon_state = "potato_fried"
	base_icon_state = "potato_fried"
	bitesize = 3
	biting = TRUE
	list_reagents = list(/datum/reagent/consumable/nutriment = FRYVEGGIE_NUTRITION)
	tastes = list("warm potato" = 1)
	rotprocess = SHELFLIFE_EXTREME

/obj/item/reagent_containers/food/snacks/potato/fried/attackby(obj/item/I, mob/living/user, params)
	if(user.mind)
		short_cooktime = (50 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*8))
	if(modified)
		return TRUE
	if(bitecount >0)
		to_chat(user, span_warning("Leftovers aren´t suitable for this."))
		return TRUE
	if(istype(I, /obj/item/reagent_containers/food/snacks/cooked/sausage) && (!modified))
		playsound(get_turf(user), 'sound/foley/dropsound/gen_drop.ogg', 30, TRUE, -1)
		if(do_after(user, short_cooktime, src))
			name = "wiener on tato"
			desc = "Stout and nourishing."
			list_reagents = list(/datum/reagent/consumable/nutriment = SAUSAGE_NUTRITION+FRYVEGGIE_NUTRITION+2)
			tastes = list("savory sausage" = 1)
			icon_state = "wienerpotato"
			base_icon_state = "wienerpotato"
			foodtype = VEGETABLES | MEAT
			meal_properties()
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
			qdel(I)
	if(istype(I, /obj/item/reagent_containers/food/snacks/cooked/frybird) && (!modified))
		playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
		if(do_after(user, short_cooktime, src))
			name = "[name] and tatos"
			desc = "[desc] Some warm tatos accompany it."
			icon_state = "frybirdtato"
			base_icon_state = "frybirdtato"
			tastes = list("frybird" = 1)
			list_reagents = list(/datum/reagent/consumable/nutriment = COOKED_MEAT_NUTRITION+FRYVEGGIE_NUTRITION+2)
			meal_properties()
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
			qdel(I)
	return ..()


/*---------------\
| Chicken meals |
\---------------*/

/*	.................   Chicken roast   ................... */
/obj/item/reagent_containers/food/snacks/cooked/roastchicken
	name = "roast bird"
	desc = "A plump bird, roasted to a perfect temperature and bears a crispy skin."
	icon_state = "roast"
	base_icon_state = "roast"
	tastes = list("tasty birdmeat" = 1)
	bitesize = 5
	biting = TRUE
	list_reagents = list(/datum/reagent/consumable/nutriment = COOKED_MEAT_NUTRITION+COOKED_MEAT_NUTRITION+1)
	rotprocess = SHELFLIFE_LONG
	plateable = TRUE
	foodbuff_skillcheck = TRUE
/obj/item/reagent_containers/food/snacks/cooked/roastchicken/attackby(obj/item/I, mob/living/user, params)
	var/obj/item/reagent_containers/peppermill/mill = I
	if(user.mind)
		short_cooktime = (50 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*8))
	if(modified)
		return TRUE
	if(bitecount >0)
		to_chat(user, span_warning("Leftovers aren´t suitable for this."))
		return TRUE
	else if(istype(mill))
		if(!mill.reagents.has_reagent(/datum/reagent/consumable/blackpepper, 1))
			to_chat(user, "There's not enough black pepper to make anything with.")
			return TRUE
		mill.icon_state = "peppermill_grind"
		to_chat(user, "You start rubbing the bird roast with black pepper.")
		playsound(get_turf(user), 'sound/foley/peppermill.ogg', 100, TRUE, -1)
		if(do_after(user,3 SECONDS, src))
			if(!mill.reagents.has_reagent(/datum/reagent/consumable/blackpepper, 1))
				to_chat(user, "There's not enough black pepper to make anything with.")
				return TRUE
			mill.reagents.remove_reagent(/datum/reagent/consumable/blackpepper, 1)
			name = "spiced [name]"
			desc = "A plump bird, roasted to perfection, spiced to taste divine."
			var/mutable_appearance/spice = mutable_appearance('icons/roguetown/items/food.dmi', "roast_spice")
			overlays += spice
			tastes = list("spicy birdmeat" = 2)
			modified = TRUE
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
	return ..()
