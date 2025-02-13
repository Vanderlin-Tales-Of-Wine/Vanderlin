/** # Snacks

Items in the "Snacks" subcategory are food items that people actually eat. The key points are that they are created
already filled with reagents and are destroyed when empty. Additionally, they make a "munching" noise when eaten.

Notes by Darem: Food in the "snacks" subtype can hold a maximum of 50 units. Generally speaking, you don't want to go over 40
total for the item because you want to leave space for extra condiments. If you want effect besides healing, add a reagent for
it. Try to stick to existing reagents when possible (so if you want a stronger healing effect, just use omnizine). On use
effect (such as the old officer eating a donut code) requires a unique reagent (unless you can figure out a better way).

The nutriment reagent and bitesize variable replace the old heal_amt and amount variables. Each unit of nutriment is equal to
2 of the old heal_amt variable. Bitesize is the rate at which the reagents are consumed. So if you have 6 nutriment and a
bitesize of 2, then it'll take 3 bites to eat. Unlike the old system, the contained reagents are evenly spread among all
the bites. No more contained reagents = no more bites.

Here is an example of the new formatting for anyone who wants to add more food items.
```
/obj/item/reagent_containers/food/snacks/xenoburger			//Identification path for the object.
	name = "Xenoburger"													//Name that displays in the UI.
	desc = ""						//Duh
	icon_state = "xburger"												//Refers to an icon in food.dmi
/obj/item/reagent_containers/food/snacks/xenoburger/Initialize()		//Don't mess with this. | nO I WILL MESS WITH THIS
	. = ..()														//Same here.
	reagents.add_reagent(/datum/reagent/xenomicrobes, 10)						//This is what is in the food item. you may copy/paste
	reagents.add_reagent(/datum/reagent/consumable/nutriment, 2)							//this line of code for all the contents.
	bitesize = 3													//This is the amount each bite consumes.
```

All foods are distributed among various categories. Use common sense.
*/
/obj/item/reagent_containers/food/snacks
	name = "snack"
	desc = ""
	icon = 'icons/roguetown/items/food.dmi'
	icon_state = null
	lefthand_file = 'icons/roguetown/onmob/lefthand.dmi'
	righthand_file = 'icons/roguetown/onmob/righthand.dmi'

	obj_flags = UNIQUE_RENAME
	grind_results = list() //To let them be ground up to transfer their reagents
	possible_item_intents = list(/datum/intent/food)
	foodtype = GRAIN
	list_reagents = list(/datum/reagent/consumable/nutriment = 1)
	w_class = WEIGHT_CLASS_SMALL
	var/bitesize = 3 // how many times you need to bite to consume it fully
	var/bitecount = 0
	var/trash = null
	var/slice_path    // for sliceable food. path of the item resulting from the slicing
	var/slice_bclass = BCLASS_CUT
	var/slices_num
	var/slice_batch = TRUE
	var/eatverb
	var/dried_type = null
	var/dry = 0
	var/dunkable = FALSE // for dunkable food, make true
	var/dunk_amount = 10 // how much reagent is transferred per dunk
	var/cooked_type = null  //for overn cooking
	var/fried_type = null	//instead of becoming
	var/filling_color = "#FFFFFF" //color to use when added to custom food.
	var/custom_food_type = null  //for food customizing. path of the custom food to create
	var/junkiness = 0  //for junk food. used to lower human satiety.
	var/list/bonus_reagents //the amount of reagents (usually nutriment and vitamin) added to crafted/cooked snacks, on top of the ingredients reagents.
	var/customfoodfilling = 1 // whether it can be used as filling in custom food
	var/list/tastes  // for example list("crisps" = 2, "salt" = 1)

	var/cooking = 0
	var/cooktime = 25 SECONDS
	var/burning = 0
	var/burntime = 5 MINUTES
	var/warming		//if greater than 0, have a brief period where the food buff applies while its still hot. On 2025-02-05 testing didn´t show it did anything. ROGTODO.

	var/cooked_color = "#91665c"
	var/burned_color = "#302d2d"

	var/ingredient_size = 1
	var/eat_effect
	var/rotprocess = FALSE
	var/become_rot_type = null

	var/mill_result = null

	var/fertamount = 50

	drop_sound = 'sound/foley/dropsound/food_drop.ogg'
	smeltresult = /obj/item/ash
	//Placeholder for effect that trigger on eating that aren't tied to reagents.

	var/chopping_sound = FALSE // does it play a choppy sound when batch sliced?
	var/slice_sound = FALSE // does it play the slice sound when sliced?
	var/can_distill = FALSE //If FALSE, this object cannot be distilled into an alcohol.
	var/distill_reagent //If NULL and this object can be distilled, it uses a generic fruit_wine reagent and adjusts its variables.
	var/distill_amt = 12

	var/cooked_smell

	var/list/sizemod = null
	var/list/raritymod = null

	var/plateable = FALSE //if it can be plated or not
	var/foodbuff_skillcheck // is the cook good enough to add buff?
	var/modified = FALSE // for tracking if food has been changed
	var/quality = 1  // used to track foodbuffs and such. Somewhat basic, could be combined with the foodbuff system directly perhaps

	var/plating_alt_icon // for food items not sprited in a way that fits the plating underlay, you can instead have a alt sprite specifically for its plated version.
	var/plated_iconstate // used in afterattack to switch the above on or off
	var/base_icon_state // used for procs manipulating icons when sliced and the like
	var/biting // if TRUE changes the icon state to the bitecount, for stuff like handpies. Will break unless you also set a base_icon_state

/datum/intent/food
	name = "feed"
	noaa = TRUE
	icon_state = "infeed"
	rmb_ranged = TRUE
	no_attack = TRUE

/datum/intent/food/rmb_ranged(atom/target, mob/user)
	if(ismob(target))
		var/mob/M = target
		var/list/targetl = list(target)
		user.visible_message("<span class='green'>[user] beckons [M] with [masteritem].</span>", "<span class='green'>I beckon [M] with [masteritem].</span>", ignored_mobs = targetl)
		if(M.client)
			if(M.can_see_cone(user))
				to_chat(M, "<span class='green'>[user] beckons me with [masteritem].</span>")
		M.food_tempted(masteritem, user)
	return

/obj/item/reagent_containers/food/snacks/fire_act(added, maxstacks)
	burning(1 MINUTES)

/obj/item/reagent_containers/food/snacks/Initialize()
	if(rotprocess)
		SSticker.OnRoundstart(CALLBACK(src, PROC_REF(begin_rotting)))
	if(cooked_type || fried_type)
		cooktime = 30 SECONDS
	..()

/obj/item/reagent_containers/food/snacks/proc/begin_rotting()
	START_PROCESSING(SSobj, src)

/obj/item/reagent_containers/food/snacks/process()
	..()
	if(rotprocess)
		var/obj/structure/closet/crate/chest/chest = locate(/obj/structure/closet/crate/chest) in get_turf(src)
		var/obj/structure/roguemachine/vendor = locate(/obj/structure/roguemachine/vendor) in get_turf(src)
		if(!chest && !vendor)
			var/obj/structure/table/located = locate(/obj/structure/table) in loc
			if(located)
				warming -= 5
			else
				warming -= 20 //ssobj processing has a wait of 20
			if(warming < (-1*rotprocess))
				if(become_rotten())
					STOP_PROCESSING(SSobj, src)

/obj/item/reagent_containers/food/snacks/can_craft_with()
	if(eat_effect == /datum/status_effect/debuff/rotfood)
		return FALSE
	return ..()

/obj/item/reagent_containers/food/snacks/proc/become_rotten()
	if(become_rot_type)
		if(ismob(loc))
			return FALSE
		else
			var/obj/item/reagent_containers/NU = new become_rot_type(loc)
			var/atom/movable/location = loc
			NU.reagents.clear_reagents()
			reagents.trans_to(NU.reagents, reagents.maximum_volume)
			qdel(src)
			if(!location || !SEND_SIGNAL(location, COMSIG_TRY_STORAGE_INSERT, NU, null, TRUE, TRUE))
				NU.forceMove(get_turf(NU.loc))
			return TRUE
	else
		color = "#6c6897"
		var/mutable_appearance/rotflies = mutable_appearance('icons/roguetown/mob/rotten.dmi', "rotten")
		add_overlay(rotflies)
		name = "rotten [initial(name)]"
		eat_effect = /datum/status_effect/debuff/rotfood
		slices_num = 0
		slice_path = null
		cooktime = 0
		modified = TRUE
		return TRUE


/obj/item/proc/cooking(input as num)
	return

/obj/item/reagent_containers/food/snacks/cooking(input as num, atom/A)
	if(!input)
		return
	if(cooktime)
		if(cooking < cooktime)
			cooking = cooking + input
			if(cooking >= cooktime)
				return heating_act(A)
			warming = 5 MINUTES
			return
	burning(input)

/obj/item/reagent_containers/food/snacks/heating_act(atom/A)
	if(istype(A,/obj/machinery/light/rogue/oven))
		var/obj/item/result
		if(cooked_type)
			result = new cooked_type(A)
			if(cooked_smell)
				result.AddComponent(/datum/component/temporary_pollution_emission, cooked_smell, 20, 5 MINUTES)
		else
			result = new /obj/item/reagent_containers/food/snacks/badrecipe(A)
		initialize_cooked_food(result, 1)
		return result
	if(istype(A,/obj/machinery/light/rogue/hearth) || istype(A,/obj/machinery/light/rogue/firebowl) || istype(A,/obj/machinery/light/rogue/campfire))
		var/obj/item/result
		if(fried_type)
			result = new fried_type(A)
			if(cooked_smell)
				result.AddComponent(/datum/component/temporary_pollution_emission, cooked_smell, 20, 5 MINUTES)
		else
			result = new /obj/item/reagent_containers/food/snacks/badrecipe(A)
		initialize_cooked_food(result, 1)
		return result
	var/obj/item/result = new /obj/item/reagent_containers/food/snacks/badrecipe(A)
	initialize_cooked_food(result, 1)
	return result

/obj/item/proc/burning(input as num)
	return

/obj/item/reagent_containers/food/snacks/burning(input as num) //used for pans without oil, skips the cooking stage
	if(!input)
		return
	warming = 5 MINUTES
	if(burntime)
		burning = burning + input
		if(eat_effect != /datum/status_effect/debuff/burnedfood)
			if(burning >= burntime)
				color = burned_color
				name = "burned [name]"
				slice_path = null
				eat_effect = /datum/status_effect/debuff/burnedfood
		if(burning > (burntime * 2))
			burn()

/obj/item/reagent_containers/food/snacks/add_initial_reagents()
	create_reagents(volume)
	if(tastes && tastes.len)
		if(list_reagents)
			for(var/rid in list_reagents)
				var/amount = list_reagents[rid]
				if(rid == /datum/reagent/consumable/nutriment || rid == /datum/reagent/consumable/nutriment/vitamin)
					reagents.add_reagent(rid, amount, tastes.Copy())
				else
					reagents.add_reagent(rid, amount)
	else
		..()

/obj/item/reagent_containers/food/snacks/proc/On_Consume(mob/living/eater)
	if(!eater)
		return

	if(eat_effect)
		if(islist(eat_effect))
			for(var/effect in eat_effect)
				eater.apply_status_effect(effect)
		else
			eater.apply_status_effect(eat_effect)
	eater.taste(reagents)

	if(!reagents.total_volume)
		var/mob/living/location = loc
		var/obj/item/trash_item = generate_trash(location)
		qdel(src)
		if(istype(location))
			location.put_in_hands(trash_item)

/obj/item/reagent_containers/food/snacks/attack_self(mob/user)
	return

/obj/item/reagent_containers/food/snacks/attack(mob/living/M, mob/living/user, def_zone)
	if(user.used_intent.type != /datum/intent/food)
		return ..()
	if(!eatverb)
		eatverb = pick("bite","chew","nibble","gnaw","gobble","chomp")
	if(iscarbon(M))
		if(!canconsume(M, user))
			return FALSE

		var/fullness = M.nutrition + 10
		for(var/datum/reagent/consumable/C in M.reagents.reagent_list) //we add the nutrition value of what we're currently digesting
			fullness += C.nutriment_factor * C.volume / C.metabolization_rate

		if(M == user)								//If you're eating it myself.
/*			if(junkiness && M.satiety < -150 && M.nutrition > NUTRITION_LEVEL_STARVING + 50 && !HAS_TRAIT(user, TRAIT_VORACIOUS))
				to_chat(M, "<span class='warning'>I don't feel like eating any more junk food at the moment!</span>")
				return FALSE
			else if(fullness <= 50)
				user.visible_message("<span class='notice'>[user] hungrily [eatverb]s \the [src], gobbling it down!</span>", "<span class='notice'>I hungrily [eatverb] \the [src], gobbling it down!</span>")
			else if(fullness > 50 && fullness < 150)
				user.visible_message("<span class='notice'>[user] hungrily [eatverb]s \the [src].</span>", "<span class='notice'>I hungrily [eatverb] \the [src].</span>")
			else if(fullness > 150 && fullness < 500)
				user.visible_message("<span class='notice'>[user] [eatverb]s \the [src].</span>", "<span class='notice'>I [eatverb] \the [src].</span>")
			else if(fullness > 500 && fullness < 600)
				user.visible_message("<span class='notice'>[user] unwillingly [eatverb]s a bit of \the [src].</span>", "<span class='notice'>I unwillingly [eatverb] a bit of \the [src].</span>")
			else if(fullness > (600 * (1 + M.overeatduration / 2000)))	// The more you eat - the more you can eat
				user.visible_message("<span class='warning'>[user] cannot force any more of \the [src] to go down [user.p_their()] throat!</span>", "<span class='warning'>I cannot force any more of \the [src] to go down your throat!</span>")
				return FALSE
			if(HAS_TRAIT(M, TRAIT_VORACIOUS))
				M.changeNext_move(CLICK_CD_MELEE * 0.5)*/
			switch(M.nutrition)
				if(NUTRITION_LEVEL_FAT to INFINITY)
					user.visible_message("<span class='notice'>[user] forces [M.p_them()]self to eat \the [src].</span>", "<span class='notice'>I force myself to eat \the [src].</span>")
				if(NUTRITION_LEVEL_STARVING to NUTRITION_LEVEL_FAT)
					user.visible_message("<span class='notice'>[user] [eatverb]s \the [src].</span>", "<span class='notice'>I [eatverb] \the [src].</span>")
				if(0 to NUTRITION_LEVEL_STARVING)
					user.visible_message("<span class='notice'>[user] hungrily [eatverb]s \the [src], gobbling it down!</span>", "<span class='notice'>I hungrily [eatverb] \the [src], gobbling it down!</span>")
					M.changeNext_move(CLICK_CD_MELEE * 0.5)
/*			if(M.energy <= 50)
				user.visible_message("<span class='notice'>[user] hungrily [eatverb]s \the [src], gobbling it down!</span>", "<span class='notice'>I hungrily [eatverb] \the [src], gobbling it down!</span>")
			else if(M.energy > 50 && M.energy < 500)
				user.visible_message("<span class='notice'>[user] hungrily [eatverb]s \the [src].</span>", "<span class='notice'>I hungrily [eatverb] \the [src].</span>")
			else if(M.energy > 500 && M.energy < 1000)
				user.visible_message("<span class='notice'>[user] [eatverb]s \the [src].</span>", "<span class='notice'>I [eatverb] \the [src].</span>")
			if(HAS_TRAIT(M, TRAIT_VORACIOUS))
			M.changeNext_move(CLICK_CD_MELEE * 0.5) nom nom nom*/
		else
			if(!isbrain(M))		//If you're feeding it to someone else.
//				if(fullness <= (600 * (1 + M.overeatduration / 1000)))
				if(M.nutrition in NUTRITION_LEVEL_FAT to INFINITY)
					M.visible_message("<span class='warning'>[user] cannot force any more of [src] down [M]'s throat!</span>", \
										"<span class='warning'>[user] cannot force any more of [src] down your throat!</span>")
					return FALSE
				else
					M.visible_message("<span class='danger'>[user] tries to feed [M] [src].</span>", \
										"<span class='danger'>[user] tries to feed me [src].</span>")
				if(iscarbon(M))
					var/mob/living/carbon/C = M
					var/obj/item/bodypart/CH = C.get_bodypart(BODY_ZONE_HEAD)
					if(C.cmode)
						if(!CH.grabbedby)
							to_chat(user, "<span class='info'>[C.p_they(TRUE)] steals [C.p_their()] face from it.</span>")
							return FALSE
				if(!do_after(user, 3 SECONDS, M))
					return
				log_combat(user, M, "fed", reagents.log_list())
//				M.visible_message("<span class='danger'>[user] forces [M] to eat [src]!</span>", "<span class='danger'>[user] forces you to eat [src]!</span>")
			else
				to_chat(user, "<span class='warning'>[M] doesn't seem to have a mouth!</span>")
				return

		if(reagents)								//Handle ingestion of the reagent.
			if(M.satiety > -200)
				M.satiety -= junkiness
			playsound(M.loc,'sound/misc/eat.ogg', rand(30,60), TRUE)
			if(reagents.total_volume)
				SEND_SIGNAL(src, COMSIG_FOOD_EATEN, M, user)
				var/fraction = min(bitesize / reagents.total_volume, 1)
				var/amt2take = reagents.total_volume / (bitesize - bitecount)
				if((bitecount >= bitesize) || (bitesize == 1))
					amt2take = reagents.total_volume
				reagents.trans_to(M, amt2take, transfered_by = user, method = INGEST)
				bitecount++
				On_Consume(M)
				checkLiked(fraction, M)
				if(bitecount >= bitesize)
					qdel(src)
				return TRUE
		playsound(M.loc,'sound/misc/eat.ogg', rand(30,60), TRUE)
		qdel(src)
		return FALSE

	return 0

/obj/item/reagent_containers/food/snacks/examine(mob/user)
	. = ..()
	if(!in_container)
		switch (bitecount)
			if (0)
				return
			if(1)
				. += "[src] was bitten by someone!"
			if(2,3)
				. += "[src] was bitten [bitecount] times!"
			else
				. += "[src] was bitten multiple times!"


/obj/item/reagent_containers/food/snacks/attackby(obj/item/W, mob/user, params)
	. = ..()
	if(istype(W, /obj/item/storage))
		..() // -> item/attackby()
		return 0

	if(W.get_sharpness() && W.wlength == WLENGTH_SHORT)
		if((slices_num <= 0 || !slices_num) || !slice_path) //is the food sliceable?
			return FALSE
		if(slice_bclass == BCLASS_CHOP)
			user.visible_message("<span class='notice'>[user] chops [src]!</span>")
			slice(W, user)
			return TRUE
		if(slice_bclass == BCLASS_CUT)
			user.visible_message("<span class='notice'>[user] slices [src]!</span>")
			slice(W, user)
			return TRUE
		else if(slice(W, user))
			return TRUE

	if(user.mind)
		if(foodbuff_skillcheck)		// cooks with less than 3 skill don´t add bonus buff
			if(user.mind.get_skill_level(/datum/skill/craft/cooking) <= 1) // cooks with 0 skill make shitty meals when trying to be fancy
				tastes = list("blandness" = 1)
				quality = 0
				switch(rand(1,4))
					if(1)
						name = "unappealing [name]"
						desc = "It is made without love or care."
					if(2)
						name = "sloppy [name]"
						desc = "It barely looks like food."
					if(3)
						name = "failed [name]"
						desc = "It is a disgrace to cooking."
					if(4)
						name = "woeful [name]"
						desc = "Cooking that might cause a divorce."
			if(user.mind.get_skill_level(/datum/skill/craft/cooking) >= 2)
				eat_effect = /datum/status_effect/buff/foodbuff
				quality = 2
			if(user.mind.get_skill_level(/datum/skill/craft/cooking) >= 4)
				quality = 3
				switch(rand(1,5))
					if(1)
						name = "masterful [name]"
						desc = "[desc] It looks perfect."
					if(2)
						name = "exquisite [name]"
						desc = "[desc] It smells like heaven."
					if(3)
						name = "perfected [name]"
						desc = "[desc] It is a triumph of cooking."
					if(4)
						name = "gourmet [name]"
						desc = "[desc] It is fit for royalty."
					if(5)
						name = "delicious [name]"
						desc = "[desc] It is a masterwork."

//Called when you finish tablecrafting a snack.
/obj/item/reagent_containers/food/snacks/CheckParts(list/parts_list, datum/crafting_recipe/food/R)
	..()
//	reagents.clear_reagents()
	for(var/obj/item/reagent_containers/RC in contents)
		RC.reagents.trans_to(reagents, RC.reagents.maximum_volume)
	if(istype(R))
		contents_loop:
			for(var/A in contents)
				for(var/B in R.real_parts)
					if(istype(A, B))
						continue contents_loop
				qdel(A)
	SSblackbox.record_feedback("tally", "food_made", 1, type)

	if(bonus_reagents && bonus_reagents.len)
		for(var/r_id in bonus_reagents)
			var/amount = bonus_reagents[r_id]
			if(r_id == /datum/reagent/consumable/nutriment || r_id == /datum/reagent/consumable/nutriment/vitamin)
				reagents.add_reagent(r_id, amount, tastes)
			else
				reagents.add_reagent(r_id, amount)

/obj/item/reagent_containers/food/snacks/proc/slice(obj/item/W, mob/user)
	if((slices_num <= 0 || !slices_num) || !slice_path) //is the food sliceable?
		return FALSE

	if ( \
			!isturf(src.loc) || \
			(!(locate(/obj/structure/table) in src.loc) && \
			!(locate(/obj/structure/table/optable) in src.loc) && \
			!(locate(/obj/item/plate) in src.loc)) \
		)
		to_chat(user, "<span class='warning'>I need to use a table.</span>")
		return FALSE

	if(slice_sound)
		playsound(get_turf(user), 'sound/foley/slicing.ogg', 60, TRUE, -1) // added some choppy sound
	if(chopping_sound)
		playsound(get_turf(user), 'sound/foley/chopping_block.ogg', 60, TRUE, -1) // added some choppy sound
	if(slice_batch)
		if(!do_after(user, 3 SECONDS, src))
			return FALSE
		var/reagents_per_slice = reagents.total_volume/slices_num
		for(var/i in 1 to slices_num)
			var/obj/item/reagent_containers/food/snacks/slice = new slice_path(loc)
			slice.filling_color = filling_color
			initialize_slice(slice, reagents_per_slice)
		qdel(src)
	else
		var/reagents_per_slice = reagents.total_volume/slices_num
		var/obj/item/reagent_containers/food/snacks/slice = new slice_path(loc)
		slice.filling_color = filling_color
		initialize_slice(slice, reagents_per_slice)
		slices_num--
		if(slices_num == 1)
			slice = new slice_path(loc)
			slice.filling_color = filling_color
			initialize_slice(slice, reagents_per_slice)
			qdel(src)
			return TRUE
		if(slices_num <= 0)
			qdel(src)
			return TRUE
		update_icon()
	return TRUE

/obj/item/reagent_containers/food/snacks/proc/initialize_slice(obj/item/reagent_containers/food/snacks/slice, reagents_per_slice)
	slice.create_reagents(slice.volume)
	reagents.trans_to(slice,reagents_per_slice)
	slice.filling_color = filling_color
	slice.update_snack_overlays(src)
//	if(name != initial(name))
//		slice.name = "slice of [name]"
//	if(desc != initial(desc))
//		slice.desc = ""
//	if(foodtype != initial(foodtype))
//		slice.foodtype = foodtype //if something happens that overrode our food type, make sure the slice carries that over

/obj/item/reagent_containers/food/snacks/proc/generate_trash(atom/location)
	if(trash)
		if(ispath(trash, /obj/item))
			. = new trash(location)
			trash = null
			return
		else if(isitem(trash))
			var/obj/item/trash_item = trash
			trash_item.forceMove(location)
			. = trash
			trash = null
			return

/obj/item/reagent_containers/food/snacks/proc/update_snack_overlays(obj/item/reagent_containers/food/snacks/S)
	cut_overlays()
	var/mutable_appearance/filling = mutable_appearance(icon, "[initial(icon_state)]_filling")
	filling.color = filling_color

	add_overlay(filling)

// initialize_cooked_food() is called when microwaving the food
/obj/item/reagent_containers/food/snacks/proc/initialize_cooked_food(obj/item/reagent_containers/food/snacks/S, cooking_efficiency = 1)
	if(reagents)
		reagents.trans_to(S, reagents.total_volume)
	if(S.bonus_reagents && S.bonus_reagents.len)
		for(var/r_id in S.bonus_reagents)
			var/amount = S.bonus_reagents[r_id] * cooking_efficiency
			if(r_id == /datum/reagent/consumable/nutriment || r_id == /datum/reagent/consumable/nutriment/vitamin)
				S.reagents.add_reagent(r_id, amount)
			else
				S.reagents.add_reagent(r_id, amount)
	S.filling_color = filling_color
	S.update_snack_overlays(src)

/obj/item/reagent_containers/food/snacks/proc/changefood(path, mob/living/eater)
	if(!path || !eater)
		return
	var/turf/T = get_turf(eater)
	if(eater.dropItemToGround(src))
		qdel(src)
	var/obj/item/I = new path(T)
	eater.put_in_active_hand(I)

/obj/item/reagent_containers/food/snacks/Destroy()
	STOP_PROCESSING(SSobj, src)
	if(contents)
		for(var/atom/movable/something in contents)
			something.forceMove(drop_location())
	return ..()

/obj/item/reagent_containers/food/snacks/attack_animal(mob/M)
	if(isanimal(M))
		if(iscat(M))
			var/mob/living/L = M
			if(bitecount == 0 || prob(50))
				M.emote("me", 1, "nibbles away at \the [src]")
			bitecount++
			L.taste(reagents) // why should carbons get all the fun?
			if(bitecount >= 5)
				var/sattisfaction_text = pick("burps from enjoyment", "meows for more", "looks at the area where \the [src] was")
				if(sattisfaction_text)
					M.emote("me", 1, "[sattisfaction_text]")
				qdel(src)

/obj/item/reagent_containers/food/snacks/afterattack(obj/item/reagent_containers/M, mob/user, proximity)
	. = ..()
	if(!dunkable || !proximity)
		return
	if(istype(M, /obj/item/reagent_containers/glass))	//you can dunk dunkable snacks into beakers or drinks
		if(!M.is_drainable())
			to_chat(user, "<span class='warning'>[M] is unable to be dunked in!</span>")
			return
		if(M.reagents.trans_to(src, dunk_amount, transfered_by = user))	//if reagents were transfered, show the message
			to_chat(user, "<span class='notice'>I dunk \the [src] into \the [M].</span>")
			return
		if(!M.reagents.total_volume)
			to_chat(user, "<span class='warning'>[M] is empty!</span>")
		else
			to_chat(user, "<span class='warning'>[src] is full!</span>")

// //////////////////////////////////////////////Store////////////////////////////////////////
/// All the food items that can store an item inside itself, like bread or cake.
/obj/item/reagent_containers/food/snacks/store
	w_class = WEIGHT_CLASS_NORMAL
	var/stored_item = 0

/obj/item/reagent_containers/food/snacks/store/attackby(obj/item/W, mob/living/user, params)
	..()
	if(W.w_class <= WEIGHT_CLASS_SMALL & !istype(W, /obj/item/reagent_containers/food/snacks)) //can't slip snacks inside, they're used for custom foods.
		if(W.get_sharpness())
			return 0
		if(stored_item)
			return 0
		if(!iscarbon(user))
			return 0
		if(contents.len >= 20)
			to_chat(user, "<span class='warning'>[src] is full.</span>")
			return 0
		to_chat(user, "<span class='notice'>I slip [W] inside [src].</span>")
		user.transferItemToLoc(W, src)
		add_fingerprint(user)
		contents += W
		stored_item = 1
		return 1 // no afterattack here

/obj/item/reagent_containers/food/snacks/MouseDrop(atom/over)
	var/turf/T = get_turf(src)
	var/obj/structure/table/TB = locate(/obj/structure/table) in T
	if(TB)
		TB.MouseDrop(over)
	else
		return ..()

/obj/item/reagent_containers/food/snacks/On_Consume(mob/living/eater)
	..()
	if(biting)
		icon_state = "[base_icon_state][bitecount]"


/obj/item/reagent_containers/food/snacks/badrecipe
	name = "burned mess"
	desc = ""
	icon_state = "badrecipe"
	list_reagents = list(/datum/reagent/toxin/bad_food = 30)
	filling_color = "#8B4513"
	foodtype = GROSS
	burntime = 0
	cooktime = 0


// Proc to handle visuals from plating
/obj/item/reagent_containers/food/snacks/proc/plated()
	icon = 'icons/roguetown/items/food.dmi'
	item_state = "plate_food"
	experimental_inhand = FALSE
	inhand_x_dimension = 32
	inhand_y_dimension = 32
	drop_sound = 'sound/foley/dropsound/wooden_drop.ogg'
	if(plating_alt_icon)
		icon_state = plated_iconstate

// Proc for important vars when reaching meal level
/obj/item/reagent_containers/food/snacks/proc/meal_properties()
	plateable = TRUE
	modified = TRUE
	foodbuff_skillcheck = TRUE
	rotprocess = SHELFLIFE_DECENT
	bitesize = 5

// A way to insert quality naming when the procs dont fire
/obj/item/reagent_containers/food/snacks/proc/good_quality_descriptors()
	switch(rand(1,4))
		if(1)
			name = "good [name]"
		if(2)
			name = "fine [name]"
		if(3)
			name = "appealing [name]"
		if(4)
			name = "nice [name]"
	filling_color = filling_color
	update_snack_overlays(src)



