/* * * * * * * * * * * **
 *						*
 *		 NeuFood		*	- Defined as edible food that can be plated and usually needs rare tools or ingridients. Typically based on a snack but not necessarily
 *		 (Meals)		*
 *						*
 * * * * * * * * * * * **/


/*---------------\
| Chicken meals |
\---------------*/

/*	.................   Chicken roast   ................... */
/obj/item/reagent_containers/food/snacks/rogue/meat/poultry/baked
	desc = "A plump bird, roasted to a perfect temperature and bears a crispy skin."
	eat_effect = null
	slices_num = 0
	name = "roast bird"
	icon_state = "roast"
	tastes = list("tasty birdmeat" = 1)
	bitesize = 6
	cooked_type = null
	slice_path = null
	list_reagents = list(/datum/reagent/consumable/nutriment = COOKED_MEAT_NUTRITION+COOKED_MEAT_NUTRITION+1)
	rotprocess = SHELFLIFE_LONG
	plateable = TRUE
	foodbuff_skillcheck = TRUE
/obj/item/reagent_containers/food/snacks/rogue/meat/poultry/baked/attackby(obj/item/I, mob/living/user, params)
	var/obj/item/reagent_containers/peppermill/mill = I
	if(modified)
		return TRUE
	else if(istype(mill))
		if(!mill.reagents.has_reagent(/datum/reagent/consumable/blackpepper, 1))
			to_chat(user, "There's not enough black pepper to make anything with.")
			return TRUE
		mill.icon_state = "peppermill_grind"
		to_chat(user, "You start rubbing the bird roast with black pepper.")
		playsound(get_turf(user), 'modular/Neu_Food/sound/peppermill.ogg', 100, TRUE, -1)
		if(do_after(user,3 SECONDS, target = src))
			if(!mill.reagents.has_reagent(/datum/reagent/consumable/blackpepper, 1))
				to_chat(user, "There's not enough black pepper to make anything with.")
				return TRUE
			mill.reagents.remove_reagent(/datum/reagent/consumable/blackpepper, 1)
			name = "spiced [name]"
			desc = "A plump bird, roasted to perfection, spiced to taste divine."
			var/mutable_appearance/spice = mutable_appearance('modular/Neu_Food/icons/food.dmi', "roast_spice")
			overlays += spice
			tastes = list("spicy birdmeat" = 2)
			modified = TRUE
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
	return ..()

