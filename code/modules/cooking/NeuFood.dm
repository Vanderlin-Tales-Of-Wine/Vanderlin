/* * * * * * * * * * * **
 *						*	-Cooking based on slapcrafting
 *		 NeuFood		*	-Uses defines to track nutrition
 *	Made by NPC1314		*	-Meant to replace menu crafting completely for foods
 *						*
 * * * * * * * * * * * **/


/*---------------\
| Food templates |
\---------------*/

/obj/item/reagent_containers/food/snacks/foodbase // root item for uncooked food thats disgusting when raw
	list_reagents = list(/datum/reagent/consumable/nutriment = SNACK_POOR)
	eat_effect = /datum/status_effect/debuff/uncookedfood
	do_random_pixel_offset = FALSE // disables the random placement on creation for this object

/obj/effect/decal/cleanable/food/mess // decal applied when throwing minced meat for example
	name = "mess"
	desc = ""
	color = "#ab9d9d"
	icon_state = "tomato_floor1"
	random_icon_states = list("tomato_floor1", "tomato_floor2", "tomato_floor3")

/obj/effect/decal/cleanable/food/mess/soup
	color = "#496538"
	alpha = 200

/obj/effect/decal/cleanable/food/mess/rotting
	color = "#708364"
	alpha = 220
/obj/effect/decal/cleanable/food/mess/rotting/Initialize()
	var/mutable_appearance/rotflies = mutable_appearance('icons/roguetown/mob/rotten.dmi', "rotten")
	add_overlay(rotflies)
	. = ..()


/*-------------\
| Rotting food |
\-------------*/	// needed so you can prevent cooking combos with rotted food and add gross effects etc. Food not combinable/processable don't need this type. Its clunkly, should be replaced with some sort of check in the procs ROGTODO

/obj/item/reagent_containers/food/snacks/rotten
	name = "rotten food"
	color = "#6c6897"
	eat_effect = /datum/status_effect/debuff/rotfood
/obj/item/reagent_containers/food/snacks/rotten/Initialize()
	var/mutable_appearance/rotflies = mutable_appearance('icons/roguetown/mob/rotten.dmi', "rotten")
	add_overlay(rotflies)
	. = ..()

/obj/item/reagent_containers/food/snacks/rotten/meat
	name = "rotten meat"
	icon_state = "meat"
/obj/item/reagent_containers/food/snacks/rotten/bacon
	name = "rotten meat"
	icon_state = "pigflesh"
/obj/item/reagent_containers/food/snacks/rotten/sausage
	icon_state = "raw_wiener"
/obj/item/reagent_containers/food/snacks/rotten/poultry
	icon_state = "poultry"
/obj/item/reagent_containers/food/snacks/rotten/chickenleg
	icon_state = "chickencutlet"
/obj/item/reagent_containers/food/snacks/rotten/breadslice
	name = "moldy bread"
	icon_state = "loaf_slice"
/obj/item/reagent_containers/food/snacks/rotten/egg
	name = "rotted egg"
	icon_state = "egg2"
/obj/item/reagent_containers/food/snacks/rotten/egg/throw_impact(atom/hit_atom, datum/thrownthing/thrownthing)
	if(!..()) //was it caught by a mob?
		var/turf/T = get_turf(hit_atom)
		var/obj/O = new /obj/effect/decal/cleanable/food/egg_smudge(T)
		O.pixel_x = rand(-8,8)
		O.pixel_y = rand(-8,8)
		O.color = "#9794be"
		qdel(src)
/obj/item/reagent_containers/food/snacks/rotten/mince
	name = "rotten meat"
	icon_state = "meatmince"
/obj/item/reagent_containers/food/snacks/rotten/mince/throw_impact(atom/hit_atom, datum/thrownthing/thrownthing)
	new /obj/effect/decal/cleanable/food/mess/rotting/get_turf(src)
	playsound(get_turf(src), 'sound/foley/meatslap.ogg', 100, TRUE, -1)
	..()
	qdel(src)



/*--------------\
| Kitchen tools |
\--------------*/

/obj/item/kitchen
	icon = 'icons/roguetown/items/cooking.dmi'
	lefthand_file = 'icons/roguetown/onmob/lefthand.dmi'
	righthand_file = 'icons/roguetown/onmob/righthand.dmi'
	force = 0
	w_class = WEIGHT_CLASS_TINY
	var/base_item

/obj/item/kitchen/spoon
	name = "wooden spoon"
	desc = "Traditional utensil for shoveling soup into your mouth, or to churn butter with."
	icon_state = "spoon"

/obj/item/kitchen/spoon/iron
	name = "iron spoon"
	icon_state = "spoon_iron"

/obj/item/kitchen/fork
	name = "wooden fork"
	desc = "Traditional utensil for stabbing your food in order to shove it into your mouth."
	icon_state = "fork"

/obj/item/kitchen/fork/iron
	name = "iron fork"
	icon_state = "fork_iron"

/obj/item/kitchen/platter
	name = "platter"
	desc = "Made from wood."
	icon_state = "platter"
	dropshrink = 0.9
	resistance_flags = NONE
	drop_sound = 'sound/foley/dropsound/wooden_drop.ogg'
	experimental_inhand = FALSE
	w_class = WEIGHT_CLASS_NORMAL
	base_item = /obj/item/kitchen/platter

/obj/item/kitchen/platter/clay
	desc = "Made from fired clay."
	icon_state = "platter_clay"
	drop_sound = 'sound/foley/dropsound/brick_drop.ogg'
	resistance_flags = FIRE_PROOF
	base_item = /obj/item/kitchen/platter/clay
/obj/item/kitchen/platter/clay/throw_impact(atom/hit_atom, datum/thrownthing/thrownthing)
	new /obj/effect/decal/cleanable/shreds/clay(get_turf(src))
	playsound(get_turf(src), 'sound/foley/break_clay.ogg', 90, TRUE)
	..()
	qdel(src)

/obj/item/kitchen/platter/copper
	desc = "Made from thin metal."
	icon_state = "platter_copper"
	resistance_flags = FIRE_PROOF
	drop_sound = 'sound/foley/dropsound/armor_drop.ogg'
	base_item = /obj/item/kitchen/platter/copper

/obj/item/reagent_containers/glass/bowl
	name = "bowl"
	desc = "It is the empty space that makes the bowl useful."
	icon = 'icons/roguetown/items/cooking.dmi'
	lefthand_file = 'icons/roguetown/onmob/lefthand.dmi'
	righthand_file = 'icons/roguetown/onmob/righthand.dmi'
	icon_state = "bowl"
	force = 5
	throwforce = 5
	reagent_flags = OPENCONTAINER
	amount_per_transfer_from_this = 6
	possible_transfer_amounts = list(6)
	dropshrink = 0.8
	w_class = WEIGHT_CLASS_SMALL
	volume = 24
	obj_flags = CAN_BE_HIT
	sellprice = 1
	drinksounds = list('sound/items/drink_cup (1).ogg','sound/items/drink_cup (2).ogg','sound/items/drink_cup (3).ogg','sound/items/drink_cup (4).ogg','sound/items/drink_cup (5).ogg')
	fillsounds = list('sound/items/fillcup.ogg')
	metalizer_result = /obj/item/roguecoin/copper
	var/in_use // so you can't spam eating with spoon

/obj/item/reagent_containers/glass/bowl/iron
	icon_state = "bowl_iron"
	drop_sound = 'sound/foley/dropsound/armor_drop.ogg'
/obj/item/reagent_containers/glass/bowl/clay
	desc = "Made from fired clay."
	icon_state = "bowl_clay"
	drop_sound = 'sound/foley/dropsound/brick_drop.ogg'
/obj/item/reagent_containers/glass/bowl/clay/throw_impact(atom/hit_atom, datum/thrownthing/thrownthing)
	new /obj/effect/decal/cleanable/shreds/clay(get_turf(src))
	playsound(get_turf(src), 'sound/foley/break_clay.ogg', 90, TRUE)
	..()
	qdel(src)

/obj/item/reagent_containers/glass/bowl/update_icon()
	cut_overlays()
	var/mutable_appearance/steam = mutable_appearance(icon, "steam")
	if(reagents)
		if(reagents.total_volume > 0)
			if(reagents.total_volume < 1)
				icon_state = "bowl"
				underlays.Cut()
			if(reagents.total_volume <= 10)
				var/mutable_appearance/filling = mutable_appearance(icon, "bowl_low")
				filling.color = mix_color_from_reagents(reagents.reagent_list)
				add_overlay(filling)
		if(reagents.total_volume > 10)
			if(reagents.total_volume <= 20)
				var/mutable_appearance/filling = mutable_appearance(icon, "bowl_half")
				filling.color = mix_color_from_reagents(reagents.reagent_list)
				add_overlay(filling)
		if(reagents.total_volume > 20)
			if(reagents.has_reagent(/datum/reagent/consumable/soup/oatmeal, 10))
				var/mutable_appearance/filling = mutable_appearance(icon, "bowl_oatmeal")
				filling.color = mix_color_from_reagents(reagents.reagent_list)
				add_overlay(filling)
			if(reagents.has_reagent(/datum/reagent/consumable/soup/veggie/cabbage, 17) || reagents.has_reagent(/datum/reagent/consumable/soup/veggie/onion, 17) || reagents.has_reagent(/datum/reagent/consumable/soup/veggie/onion, 17))
				var/mutable_appearance/filling = mutable_appearance(icon, "bowl_full")
				filling.color = mix_color_from_reagents(reagents.reagent_list)
				underlays += steam
				add_overlay(filling)
			if(reagents.has_reagent(/datum/reagent/consumable/soup/stew/chicken, 17) || reagents.has_reagent(/datum/reagent/consumable/soup/stew/meat, 17) || reagents.has_reagent(/datum/reagent/consumable/soup/stew/fish, 17))
				var/mutable_appearance/filling = mutable_appearance(icon, "bowl_stew")
				filling.color = mix_color_from_reagents(reagents.reagent_list)
				underlays += steam
				add_overlay(filling)
			else
				var/mutable_appearance/filling = mutable_appearance(icon, "bowl_full")
				filling.color = mix_color_from_reagents(reagents.reagent_list)
				add_overlay(filling)
		else
			underlays.Cut()
	else
		icon_state = "bowl"
		underlays.Cut()

/obj/item/reagent_containers/glass/bowl/on_reagent_change(changetype)
	..()
	update_icon()

/obj/item/reagent_containers/glass/bowl/attackby(obj/item/I, mob/user, params) // lets you eat with a spoon from a bowl
	if(istype(I, /obj/item/kitchen/spoon))
		if(reagents.total_volume > 0)
			beingeaten()
			playsound(src,'sound/misc/eat.ogg', rand(30,60), TRUE)
			visible_message("<span class='info'>[user] eats from [src].</span>")
			if(do_after(user,1 SECONDS, src))
				addtimer(CALLBACK(reagents, TYPE_PROC_REF(/datum/reagents, trans_to), user, min(amount_per_transfer_from_this,5), TRUE, TRUE, FALSE, user, FALSE, INGEST), 5)
		return TRUE

/obj/item/reagent_containers/glass/bowl/attack(mob/M, mob/user, obj/target)
	testing("a1")
	if(istype(M))
		if(user.used_intent.type == INTENT_GENERIC)
			return ..()

		else

			if(!spillable)
				return

			if(!reagents || !reagents.total_volume)
				to_chat(user, "<span class='warning'>[src] is empty!</span>")
				return
			if(user.used_intent.type == INTENT_SPLASH)
				var/R
				M.visible_message("<span class='danger'>[user] splashes the contents of [src] onto [M]!</span>", \
								"<span class='danger'>[user] splashes the contents of [src] onto you!</span>")
				if(reagents)
					for(var/datum/reagent/A in reagents.reagent_list)
						R += "[A] ([num2text(A.volume)]),"

				if(isturf(target) && reagents.reagent_list.len && thrownby)
					log_combat(thrownby, target, "splashed (thrown) [english_list(reagents.reagent_list)]")
					message_admins("[ADMIN_LOOKUPFLW(thrownby)] splashed (thrown) [english_list(reagents.reagent_list)] on [target] at [ADMIN_VERBOSEJMP(target)].")
				reagents.reaction(M, TOUCH)
				log_combat(user, M, "splashed", R)
				reagents.clear_reagents()
				return
			else if(user.used_intent.type == INTENT_POUR)
				if(!canconsume(M, user))
					return
				if(M != user)
					M.visible_message("<span class='danger'>[user] attempts to feed [M] something.</span>", \
								"<span class='danger'>[user] attempts to feed you something.</span>")
					if(!reagents || !reagents.total_volume)
						return // The drink might be empty after the delay, such as by spam-feeding
					M.visible_message("<span class='danger'>[user] feeds [M] something.</span>", \
								"<span class='danger'>[user] feeds you something.</span>")
					log_combat(user, M, "fed", reagents.log_list())
				else
					to_chat(user, "<span class='notice'>I swallow a gulp of [src].</span>")
				if(reagents.total_volume > 0)
					beingeaten()
					playsound(M.loc,pick(drinksounds), 100, TRUE)
					visible_message("<span class='info'>[user] eats from [src].</span>")
					if(do_after(user,1 SECONDS, src))
						addtimer(CALLBACK(reagents, TYPE_PROC_REF(/datum/reagents, trans_to), user, min(amount_per_transfer_from_this,5), TRUE, TRUE, FALSE, user, FALSE, INGEST), 5)
				return

/obj/item/reagent_containers/glass/bowl/throw_impact(atom/hit_atom, datum/thrownthing/thrownthing)
	if(reagents.total_volume > 5)
		new /obj/effect/decal/cleanable/food/mess/soup(get_turf(src))
	..()

/obj/item/reagent_containers/glass/bowl/proc/beingeaten()
	in_use = TRUE
	sleep(10)
	in_use = FALSE

/obj/item/reagent_containers/peppermill // new with some animated art
	name = "pepper mill"
	icon = 'icons/roguetown/items/cooking.dmi'
	icon_state = "peppermill"
	layer = CLOSED_BLASTDOOR_LAYER // obj layer + a little, small obj layering above convenient
	drop_sound = 'sound/foley/dropsound/gen_drop.ogg'
	list_reagents = list(/datum/reagent/consumable/blackpepper = 5)
	reagent_flags = TRANSPARENT





/*-------------\
| Pot reagents |
\-------------*/	// These are for the pot, if more vegetables are added and need to be integrated into the pot brewing you need to add them here

/datum/reagent/consumable/soup // so you get hydrated without the flavor system messing it up. Works like water with less hydration
	var/hydration = 5
/datum/reagent/consumable/soup/on_mob_life(mob/living/carbon/M)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(!HAS_TRAIT(H, TRAIT_NOHUNGER))
			H.adjust_hydration(hydration)
		if(M.blood_volume < BLOOD_VOLUME_NORMAL)
			M.blood_volume = min(M.blood_volume+6, BLOOD_VOLUME_NORMAL)
	..()

/datum/reagent/consumable/soup/oatmeal
	name = "oatmeal"
	description = "Fitting for a peasant."
	reagent_state = LIQUID
	color = "#c38553"
	nutriment_factor = 10
	metabolization_rate = 0.5 // half as fast as normal, last twice as long
	taste_description = "oatmeal"
	taste_mult = 3
	hydration = 2

/datum/reagent/consumable/soup/veggie
	name = "vegetable soup"
	description = ""
	reagent_state = LIQUID
	nutriment_factor = 7
	taste_mult = 4
	hydration = 8

/datum/reagent/consumable/soup/veggie/potato
	color = "#869256"
	taste_description = "potato broth"

/datum/reagent/consumable/soup/veggie/onion
	color = "#a6b457"
	taste_description = "boiled onions"

/datum/reagent/consumable/soup/veggie/cabbage
	color = "#859e56"
	taste_description = "watery cabbage"

/datum/reagent/consumable/soup/veggie/turnip
	color = "#becf9d"
	taste_description = "boiled turnip"

/datum/reagent/consumable/soup/egg
	color = "#dedbaf"
	taste_description = "egg soup"
	nutriment_factor = 12

/datum/reagent/consumable/soup/cheese // A thicker soup, almost on the level of old oatmeal. But less hydration than other soups
	name = "cheese soup"
	description = "A thick cheese soup. Creamy and comforting."
	color = "#c4be70"
	reagent_state = LIQUID
	nutriment_factor = 12
	taste_description = "creamy cheese"
	taste_mult = 4
	hydration = 4

/datum/reagent/consumable/soup/stew // can all be made with mince ie half meat so has to stay nutrient poor
	name = "thick stew"
	description = "All manners of edible bits went into this."
	reagent_state = LIQUID
	nutriment_factor = 11
	taste_mult = 4

/datum/reagent/consumable/soup/stew/chicken
	color = "#baa21c"
	taste_description = "chicken"

/datum/reagent/consumable/soup/stew/meat
	color = "#80432a"
	taste_description = "meat stew"

/datum/reagent/consumable/soup/stew/meat_meagre
	color = "#80432a"
	taste_description = "meagre meat stew"

/datum/reagent/consumable/soup/stew/fish
	color = "#c7816e"
	taste_description = "fish stew"

/datum/reagent/consumable/soup/stew/truffle
	color = "#5f4a0e"
	taste_description = "rich truffles"

/datum/reagent/water/spicy // filler, not important
	taste_description = "something spicy"
	color = "#ea9f9fc6"

/datum/reagent/consumable/soup/stew/gross // barely edible, but beggars eat it without issue, even getting a little relief
	name = "beggars stew"
	color = "#3b4537"
	nutriment_factor = 8
	taste_description = "something gross"
	metabolization_rate = 0.3
/datum/reagent/consumable/soup/stew/gross/on_mob_life(mob/living/carbon/M)
	if(M.mind.assigned_role == "Beggar") // beggars gets revitalized, a little
		M.adjustBruteLoss(-0.1)
		M.adjustFireLoss(-0.1)
		M.adjust_energy(2)
		return
	if(HAS_TRAIT(M, TRAIT_NASTY_EATER ))
		return
	else
		if(prob(8))
			switch(pick(1,4))
				if (1)
					to_chat(M, "<span class='danger'>I feel bile rising...</span>")
				if (2)
					to_chat(M, "<span class='danger'>I feel nauseous...</span>")
				if (2)
					to_chat(M, "<span class='danger'>My breath smells terrible...</span>")
				if (2)
					to_chat(M, "<span class='danger'>My stomach churns...</span>")
		if(prob(8))
			M.emote("gag")
			M.add_nausea(9)
	..()
	. = TRUE

/datum/reagent/yuck/cursed_soup	// toxic sludge, though its edible for NASTY_EATERS like orcs, healing them slightly
	name = "cursed soup"
	description = "Vile smell."
	color = "#5b2b44"
	taste_description = "something truly vile"
	metabolization_rate = 0.2
/datum/reagent/yuck/cursed_soup/on_mob_life(mob/living/carbon/M)
	if(HAS_TRAIT(M, TRAIT_NASTY_EATER ))
		if(M.blood_volume < BLOOD_VOLUME_NORMAL)
			M.blood_volume = min(M.blood_volume+2, BLOOD_VOLUME_MAXIMUM)
		M.adjustBruteLoss(-0.2, 0)
		M.adjustFireLoss(-0.2, 0)
		M.adjust_energy(5)
		return
	else
		if(prob(12))
			M.emote("gag")
			M.add_nausea(9)
			if(isdwarf(M))
				M.adjustToxLoss(2)
			else
				M.adjustToxLoss(5)
	..()
	. = TRUE



/*--------------\
| Powder & Salt |
\--------------*/

// -------------- POWDER (flour) -----------------
/obj/item/reagent_containers/powder/flour
	name = "powder"
	desc = "With this ambition, we build an empire."
	icon_state = "flour"
	list_reagents = list(/datum/reagent/floure = 1)
	volume = 1
	sellprice = 0
	var/water_added
/obj/item/reagent_containers/powder/flour/throw_impact(atom/hit_atom, datum/thrownthing/thrownthing)
	new /obj/effect/decal/cleanable/food/flour(get_turf(src))
	..()
	qdel(src)
/obj/item/reagent_containers/powder/flour/attackby(obj/item/I, mob/living/user, params)
	..()
	var/found_table = locate(/obj/structure/table) in (loc)
	var/obj/item/reagent_containers/glass/R = I
	if(user.mind)
		short_cooktime = (50 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*7))
	if(isturf(loc)&& (found_table))
		if(istype(I, /obj/item/reagent_containers/food/snacks/rogue/dough_base))
			playsound(get_turf(user), 'sound/foley/kneading.ogg', 100, TRUE, -1)
			to_chat(user, span_notice("Kneading in more powder..."))
			if(do_after(user, short_cooktime, src))
				new /obj/item/reagent_containers/food/snacks/dough(loc)
				qdel(I)
				qdel(src)
				user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
		if(!istype(R) || (water_added))
			return ..()
		if(!R.reagents.has_reagent(/datum/reagent/water, 10))
			to_chat(user, "<span class='notice'>Needs more water to work it.</span>")
			return TRUE
		to_chat(user, "<span class='notice'>Adding water, now its time to knead it...</span>")
		playsound(get_turf(user), 'sound/foley/splishy.ogg', 100, TRUE, -1)
		if(do_after(user,15, src))
			name = "wet powder"
			desc = "Destined for greatness, at your hands."
			R.reagents.remove_reagent(/datum/reagent/water, 10)
			water_added = TRUE
			color = "#d9d0cb"
	else
		to_chat(user, span_warning("Put [src] on a table before working it!"))

/obj/item/reagent_containers/powder/flour/attack_hand(mob/living/user)
	if(water_added)
		short_cooktime = (40 - ((user.mind.get_skill_level(/datum/skill/craft/cooking))*5))
		playsound(get_turf(user), 'sound/foley/kneading_alt.ogg', 90, TRUE, -1)
		if(do_after(user, short_cooktime, src))
			var/obj/item/reagent_containers/food/snacks/rogue/dough_base/newdough= new(get_turf(user))
			user.put_in_hands(newdough)
			user.mind.add_sleep_experience(/datum/skill/craft/cooking, (user.STAINT*0.5))
			qdel(src)
	else
		..()



// -------------- SALT -----------------
/obj/item/reagent_containers/powder/salt
	name = "salt"
	desc = ""
	gender = PLURAL
	icon_state = "salt"
	list_reagents = list(/datum/reagent/floure = 1)
	volume = 1
	sellprice = 0

/obj/item/reagent_containers/powder/salt/throw_impact(atom/hit_atom, datum/thrownthing/thrownthing)
	new /obj/effect/decal/cleanable/food/flour(get_turf(src))
	..()
	qdel(src)



/*------------------\
| Meals on platters |
\------------------*/

/*	..................   Food platter   ................... */
/obj/item/kitchen/platter/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/reagent_containers/food/snacks))
		var/obj/item/reagent_containers/food/snacks/S = I
		if (S.plateable == TRUE)
			playsound(get_turf(user), 'sound/foley/dropsound/food_drop.ogg', 40, TRUE, -1)
			if(do_after(user, 1 SECONDS, src))
				S.plated()
				S.trash = base_item
				S.plateable = FALSE
				S.rotprocess =  SHELFLIFE_LONG
				S.w_class = WEIGHT_CLASS_NORMAL
				S.dropshrink = 0.9
				S.bonus_reagents = list(/datum/reagent/consumable/nutriment = 2)
				var/mutable_appearance/platter = mutable_appearance(icon, icon_state)
				S.underlays += platter
				qdel(src)
		else
			to_chat(user, span_warning("[S] cannot be plated."))
	else
		return ..()



/* * * * * * * * * * * **
 *						*
 *	 Food Rot Timers	*	- Just lists as it stands on 2024-08-24
 *						*
 * * * * * * * * * * * **/

/*	.................   Never spoils   ................... *//*

* Hardtack
* Toast
* Salted fish
* Frybread
* Unbitten handpies
* Biscuit
* Prezzel
* Cheese wheel/wedges
* Salo
* Copiette
* Salumoi
* Uncut pie
* Raw potato, onion
* Uncut raisin bread

/*	.................   Extreme shelflife   ................... */

* Raw cabbage
* Uncut bread loaf
* Most plated dishes

/*	.................   Long shelflife   ................... */

* Uncut cake
* Dough
* Pastry
* Bun
* Most cooked veggies
* Cooked sausage
* Pie slice
* Bread slice

/*	.................   Decent shelflife   ................... */

* Fresh cheese
* Mixed dishes with meats
* Fried meats & eggs

/*	.................   Short shelflife   ................... */

* Raw meat
* Berries

/*	.................   Tiny shelflife   ................... */

* Minced meat

*/
