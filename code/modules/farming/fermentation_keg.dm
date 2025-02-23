GLOBAL_LIST_EMPTY(custom_fermentation_recipes)

/datum/looping_sound/boiling
	mid_sounds = list('sound/foley/bubb (1).ogg' = 1,'sound/foley/bubb (2).ogg' = 1,'sound/foley/bubb (3).ogg' = 1,'sound/foley/bubb (4).ogg' = 1,'sound/foley/bubb (5).ogg' = 1)
	mid_length = 2 SECONDS
	volume = 25

/obj/structure/fermentation_keg
	name = "fermentation keg"
	desc = "A simple keg that is meant for making booze."

	icon = 'icons/obj/brewing.dmi'
	icon_state = "barrel_tapless"

	density = TRUE
	anchored = FALSE

	/// The sound of fermentation
	var/datum/looping_sound/boiling/soundloop
	/// The volume of the barrel sounds
	var/sound_volume = 25
	var/open_icon_state = "barrel_tapless_open"

	//After brewing we can sell or bottle, this is for the latter
	var/ready_to_bottle = FALSE
	var/brewing = FALSE

	///our currently needed crops
	var/list/recipe_crop_stocks
	///our currently selected recipe
	var/datum/brewing_recipe/selected_recipe
	///our made item which we clear once its no longer ready to bottle
	var/made_item

	///icon used for wrapping the keg. set to NULL for any intentionally unwrappable subtypes.
	var/delivery_icon = "deliverykeg"

	var/age_start_time = 0

	var/tapped = FALSE
	var/beer_left = 0

	var/selecting_recipe = FALSE




/obj/structure/fermentation_keg/Initialize()
	. = ..()
	create_reagents(900, OPENCONTAINER | NO_REACT | AMOUNT_VISIBLE | REFILLABLE) //on agv it should be 120u for water then rest can be other needed chemicals
	recipe_crop_stocks = list()

	soundloop = new(src, brewing)
	soundloop.volume = sound_volume

/obj/structure/fermentation_keg/update_overlays()
	. = ..()
	if(length(overlays))
		overlays.Cut()

	if(!reagents.total_volume)
		return
	if(icon_state != open_icon_state)
		return
	var/mutable_appearance/MA = mutable_appearance(icon, "filling")
	MA.color = mix_color_from_reagents(reagents)
	overlays += MA

/obj/structure/fermentation_keg/attack_hand(mob/user)
	if((user.used_intent == /datum/intent/grab) || user.cmode)
		return ..()
	if(ready_to_bottle)
		if(try_tapping(user))
			return

	if(!brewing && (!selected_recipe || ready_to_bottle))
		shopping_run(user)
		return

	if(try_n_brew(user))
		start_brew()
	..()

/obj/structure/fermentation_keg/attackby(obj/item/I, mob/user)
	if(istype(I, /obj/item/reagent_containers) && tapped && (user.used_intent == /datum/intent/fill))
		if(try_filling(user, I))
			return

	if(ready_to_bottle)
		if(selected_recipe.after_finish_attackby(user, I, src))
			create_items()
			return

	var/list/produce_list = list()

	if(istype(I, /obj/item/bottle_kit))
		var/obj/item/bottle_kit/kit = I
		bottle(kit.glass_colour)

	if(I.type in selected_recipe?.needed_items)
		produce_list += I

	if(istype(I, /obj/item/reagent_containers/food))
		produce_list += I

	for(var/obj/item/reagent_containers/food/G in produce_list)
		if(G.type in selected_recipe?.needed_crops)
			recipe_crop_stocks[G.type]++
			qdel(G)

	for(var/obj/item/item in produce_list)
		if(item.type in selected_recipe?.needed_items)
			var/amount = recipe_crop_stocks[item.type] || 0
			var/added_item = 1
			recipe_crop_stocks[item.type] = amount + added_item
			qdel(item)

	. = ..()
	update_overlays()

/obj/structure/fermentation_keg/examine(mob/user)
	. =..()
	if(ready_to_bottle)
		. += span_boldnotice("[made_item]")
		if(age_start_time)
			. += "Aged for [(world.time - age_start_time) * 0.1] Seconds.\n"

	else if(selected_recipe)
		var/message = "Currently making: [selected_recipe.name].\n"

		//time
		if(selected_recipe.brew_time)
			if(selected_recipe.brew_time >= 1 MINUTES)
				message += "Once set, will take [selected_recipe.brew_time / 600] Minutes.\n"
			else
				message += "Once set, will take [selected_recipe.brew_time / 10] Seconds.\n"

		//How many are brewed
		if(selected_recipe.brewed_amount)
			message += "Will produce [selected_recipe.brewed_amount] bottles when finished or [FLOOR((selected_recipe.brewed_amount * selected_recipe.per_brew_amount)/ 3 , 1)] oz.\n"

		if(selected_recipe.brewed_item && selected_recipe.brewed_item_count)
			var/name_to_use = selected_recipe.secondary_name
			if(!name_to_use)
				name_to_use = selected_recipe.name
			message += "Will produce [name_to_use] x [selected_recipe.brewed_item_count] when finished.\n"

		if(selected_recipe.helpful_hints)
			message += "[selected_recipe.helpful_hints].\n"

		/*
		if(istype(selected_recipe, /datum/brewing_recipe/custom_recipe))
			var/datum/brewing_recipe/custom_recipe/recipe = selected_recipe
			message += "Recipe Created By:[recipe.made_by]"
		. += message
		*/
		. += message

/obj/structure/fermentation_keg/proc/shopping_run(mob/user)
	if(brewing)
		return
	if(selecting_recipe)
		return
	selecting_recipe = TRUE
	var/list/options = list()
	for(var/path in subtypesof(/datum/brewing_recipe))
		var/datum/brewing_recipe/recipe = path
		var/prereq = initial(recipe.pre_reqs)
		if((!ready_to_bottle && prereq == null) || (selected_recipe?.reagent_to_brew == prereq && ready_to_bottle))
			options[initial(recipe.name)] = recipe


	for(var/datum/brewing_recipe/recipe in GLOB.custom_fermentation_recipes)
		var/prereq = recipe.pre_reqs
		if((!ready_to_bottle && prereq == null) || (selected_recipe?.reagent_to_brew == prereq && ready_to_bottle))
			options[recipe.name] = recipe

	if(options.len == 0)
		to_chat(user, "Their is no further brewing to be done, clear this barrel out or sell it.")
		return

	var/choice = input(user,"What brew do you want to make?", name) as anything in options

	if(!choice)
		return

	var/choice_to_spawn = options[choice]

	/*
	if(istype(choice_to_spawn, /datum/brewing_recipe/custom_recipe))
		selected_recipe = choice_to_spawn
	else
		selected_recipe = new choice_to_spawn
	*/
	selected_recipe = new choice_to_spawn

	//Second stage brewing gives no refunds! - This is intented design to help make it so folks dont quit halfway through and still get a rebate
	ready_to_bottle = FALSE
	sellprice = 25
	icon_state = open_icon_state
	update_overlays()
	selecting_recipe = FALSE

//Remove only chemicals
/obj/structure/fermentation_keg/proc/clear_keg_reagents()
	if(reagents)
		//consume consume consume consume
		reagents.clear_reagents()

//Remove and reset
/obj/structure/fermentation_keg/proc/clear_keg(force = FALSE)
	if(brewing)
		return FALSE

	if(!force && ready_to_bottle)
		return FALSE

	if(reagents)
		reagents.clear_reagents()

	ready_to_bottle = FALSE
	made_item = null
	icon_state = open_icon_state
	update_overlays()

	recipe_crop_stocks.Cut()
	age_start_time = 0

	sellprice = 25
	tapped = FALSE
	beer_left = 0

	if(force)
		selected_recipe = null

	return TRUE

/obj/structure/fermentation_keg/proc/start_brew()
	brewing = TRUE

	for(var/obj/item/reagent_containers/food/item as anything in selected_recipe.needed_crops)
		if(!(item in recipe_crop_stocks))
			return
		var/amount = recipe_crop_stocks[item] || 0
		recipe_crop_stocks[item] = amount - selected_recipe.needed_crops[item]

	for(var/obj/item/item as anything in selected_recipe.needed_items)
		if(!(item in recipe_crop_stocks))
			return
		var/amount = recipe_crop_stocks[item] || 0
		recipe_crop_stocks[item] = amount - selected_recipe.needed_items[item]

	clear_keg_reagents()

	soundloop.start()
	addtimer(CALLBACK(src, PROC_REF(end_brew)), selected_recipe.brew_time)
	icon_state = initial(icon_state)
	update_overlays()

/obj/structure/fermentation_keg/proc/end_brew()
	icon_state = "barrel_tapless_ready"
	update_overlays()
	soundloop.stop()
	ready_to_bottle = TRUE
	brewing = FALSE
	sellprice = selected_recipe.sell_value
	made_item = selected_recipe.name
	if(selected_recipe.ages)
		age_start_time = world.time

/obj/structure/fermentation_keg/proc/try_n_brew(mob/user)
	var/ready = TRUE
	if(!selected_recipe)
		if(user)
			to_chat(user, span_notice("You need to set a booze to brew!"))
		ready = FALSE

	if(brewing)
		if(user)
			to_chat(user, span_notice("This keg is already brewing a mix!"))
		ready = FALSE

	//Crops
	for(var/obj/item/reagent_containers/food/needed_crop as anything in selected_recipe.needed_crops)
		if(recipe_crop_stocks[needed_crop] < selected_recipe.needed_crops[needed_crop])
			if(user)
				to_chat(user, span_notice("This keg lacks [initial(needed_crop.name)]!"))
				ready = FALSE

	for(var/obj/item/needed_item as anything in selected_recipe.needed_items)
		if(recipe_crop_stocks[needed_item] < selected_recipe.needed_items[needed_item])
			if(user)
				to_chat(user, span_notice("This keg lacks [initial(needed_item.name)]!"))
				ready = FALSE

	for(var/datum/reagent/required_chem as anything in selected_recipe.needed_reagents)
		if(selected_recipe.needed_reagents[required_chem] > reagents.get_reagent_amount(required_chem))
			if(user)
				to_chat(user, span_notice("The keg's unable to brew well lacking [initial(required_chem.name)]!"))
				ready = FALSE

	return ready


/obj/structure/fermentation_keg/random/water
	name = "water barrel"

/obj/structure/fermentation_keg/random/water/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/water, rand(0,900))


/obj/structure/fermentation_keg/random/beer/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/consumable/ethanol/beer, rand(0,900))

/obj/structure/fermentation_keg/water
	name = "water barrel"

/obj/structure/fermentation_keg/water/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/water,900)

/obj/structure/fermentation_keg/beer/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/consumable/ethanol/beer,900)

/obj/structure/fermentation_keg/proc/create_items()
	if(!ready_to_bottle)
		return

	ready_to_bottle = FALSE
	made_item = null
	tapped = FALSE
	age_start_time = 0
	beer_left = 0
	brewing = FALSE
	sellprice = 25
	icon_state = open_icon_state
	update_overlays()

	if(selected_recipe.brewed_item)
		var/items_given
		for(items_given= 0, items_given < selected_recipe.brewed_item_count, items_given++)
			new selected_recipe.brewed_item(get_turf(src))
	selected_recipe = null


/obj/structure/fermentation_keg/proc/bottle(glass_colour)
	if(ready_to_bottle)

		ready_to_bottle = FALSE
		made_item = null
		tapped = FALSE
		age_start_time = 0
		beer_left = 0
		brewing = FALSE
		sellprice = 25
		icon_state = open_icon_state
		update_overlays()

		if(selected_recipe.reagent_to_brew)
			if(!glass_colour)
				glass_colour = "brew_bottle"

			var/bottlecaps
			for(bottlecaps=0, bottlecaps < selected_recipe.brewed_amount, bottlecaps++)
				var/obj/item/reagent_containers/glass/bottle/brewing_bottle/bottle_made = new /obj/item/reagent_containers/glass/bottle/brewing_bottle(get_turf(src))
				bottle_made.icon_state = "[glass_colour]"
				/*
				if(istype(selected_recipe, /datum/brewing_recipe/custom_recipe))
					var/datum/brewing_recipe/custom_recipe/recipe = selected_recipe
					bottle_made.name = recipe.bottle_name
					bottle_made.desc = recipe.bottle_desc
					bottle_made.glass_name = recipe.glass_name
					bottle_made.glass_desc = recipe.glass_desc
					bottle_made.reagents.add_reagent(selected_recipe.reagent_to_brew, selected_recipe.per_brew_amount, list("reagents" = recipe.reagent_data))
				else
					bottle_made.reagents.add_reagent(selected_recipe.reagent_to_brew, selected_recipe.per_brew_amount)
				*/
				var/datum/reagent/brewed_reagent = selected_recipe.reagent_to_brew
				if(selected_recipe.ages)
					var/time = world.time - age_start_time
					for(var/path in selected_recipe.age_times)
						if(time > selected_recipe.age_times[path])
							brewed_reagent = path
				bottle_made.reagents.add_reagent(brewed_reagent, selected_recipe.per_brew_amount)
		if(selected_recipe.brewed_item)
			var/items_given
			for(items_given= 0, items_given < selected_recipe.brewed_item_count, items_given++)
				new selected_recipe.brewed_item(get_turf(src))
		selected_recipe = null

/obj/structure/fermentation_keg/proc/try_tapping(mob/user)
	if(tapped)
		return
	visible_message("[user] starts tapping [src].", "You start tapping [src].")
	if(!do_after(user, 4 SECONDS, src))
		return
	tapped = TRUE
	icon_state = "barrel_tapped_ready"
	sellprice = 0
	beer_left = selected_recipe.brewed_amount * selected_recipe.per_brew_amount

/obj/structure/fermentation_keg/proc/try_filling(mob/user, obj/item/reagent_containers/container)
	if(!tapped)
		return
	visible_message("[user] starts pouring from [src].", "You start pouring from [src].")
	if(!do_after(user, 1 SECONDS, src))
		return
	var/beer_taken = min((container.reagents.maximum_volume - container.reagents.total_volume), beer_left)

	beer_left -= beer_taken

	var/datum/reagent/brewed_reagent = selected_recipe.reagent_to_brew
	if(selected_recipe.ages)
		var/time = world.time - age_start_time
		for(var/path in selected_recipe.age_times)
			if(time > selected_recipe.age_times[path])
				brewed_reagent = path
	container.reagents.add_reagent(brewed_reagent, beer_taken)

	if(beer_left <= 0)
		clear_keg()

/obj/structure/fermentation_keg/verb/reset_keg()
	set name = "Clear Keg (Completely Resets)"
	set category = "Object"
	set src in range(1)

	if(!isdead(usr))
		clear_keg(TRUE)
	else
		to_chat(usr, span_notice("Sadly this keg isnt brewing spirits!"))

/obj/item/reagent_containers/glass/bottle/brewing_bottle
	name = "bottle"
	desc = "A bottle with a cork."
	icon =  'icons/obj/bottle.dmi'
	icon_state = "brew_bottle"
	volume = 50

	var/glass_name
	var/glass_desc

/obj/item/reagent_containers/glass/bottle/brewing_bottle/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(target.type in (typesof(/obj/item/reagent_containers/glass) - typesof(/obj/item/reagent_containers/glass/bottle)))
		if(glass_name)
			target.name = glass_name
		if(glass_desc)
			target.desc = glass_desc
	if(reagents.total_volume <= 0)
		glass_desc = null
		glass_name = null
