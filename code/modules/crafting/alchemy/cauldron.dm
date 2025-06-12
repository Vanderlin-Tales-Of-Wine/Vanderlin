/obj/machinery/light/fueled/cauldron
	name = "cauldron"
	desc = "Bubble, Bubble, toil and trouble. A great iron cauldron for brewing potions from thaumaturgical essences."
	icon = 'icons/roguetown/misc/alchemy.dmi'
	icon_state = "cauldron1"
	base_state = "cauldron"
	density = TRUE
	opacity = FALSE
	anchored = TRUE
	max_integrity = 300
	var/list/essence_contents = list() // essence_type = amount
	var/max_essence_types = 6
	var/brewing = 0
	var/datum/weakref/lastuser
	fueluse = 20 MINUTES
	crossfire = FALSE

/obj/machinery/light/fueled/cauldron/Initialize()
	create_reagents(500, DRAINABLE | AMOUNT_VISIBLE | REFILLABLE)
	return ..()

/obj/machinery/light/fueled/cauldron/Destroy()
	chem_splash(loc, 2, list(reagents))
	playsound(loc, pick('sound/foley/water_land1.ogg','sound/foley/water_land2.ogg', 'sound/foley/water_land3.ogg'), 100, FALSE)
	return ..()

/obj/machinery/light/fueled/cauldron/update_icon()
	..()
	cut_overlays()
	if(essence_contents.len > 0 || reagents?.total_volume > 0)
		if(!brewing)
			var/mutable_appearance/filling = mutable_appearance('icons/roguetown/misc/alchemy.dmi', "cauldron_full")
			filling.color = calculate_mixture_color()
			add_overlay(filling)
		if(brewing > 0)
			var/mutable_appearance/filling = mutable_appearance('icons/roguetown/misc/alchemy.dmi', "cauldron_boiling")
			filling.color = calculate_mixture_color()
			add_overlay(filling)

/obj/machinery/light/fueled/cauldron/burn_out()
	brewing = 0
	return ..()

/obj/machinery/light/fueled/cauldron/proc/calculate_mixture_color()
	if(essence_contents.len == 0)
		return "#4A90E2" // Default water color

	var/total_weight = 0
	var/r = 0, g = 0, b = 0

	for(var/essence_type in essence_contents)
		var/datum/thaumaturgical_essence/essence = new essence_type
		var/amount = essence_contents[essence_type]
		var/weight = amount * (essence.tier + 1) // Higher tier essences have more color influence

		total_weight += weight
		var/color_val = hex2num(copytext(essence.color, 2, 4)) // R
		r += color_val * weight
		color_val = hex2num(copytext(essence.color, 4, 6)) // G
		g += color_val * weight
		color_val = hex2num(copytext(essence.color, 6, 8)) // B
		b += color_val * weight

		qdel(essence)

	if(total_weight == 0)
		return "#4A90E2"

	r = FLOOR(r / total_weight, 1)
	g = FLOOR(g / total_weight, 1)
	b = FLOOR(b / total_weight, 1)

	return rgb(r, g, b)

/obj/machinery/light/fueled/cauldron/attackby(obj/item/I, mob/user, params)
	if(!istype(I, /obj/item/essence_vial))
		return ..()
	var/obj/item/essence_vial/vial = I
	if(!vial.contained_essence || vial.essence_amount <= 0)
		to_chat(user, span_warning("The vial is empty."))
		return

	if(essence_contents.len >= max_essence_types)
		to_chat(user, span_warning("The cauldron cannot hold any more essence types."))
		return

	var/essence_type = vial.contained_essence.type
	if(essence_contents[essence_type])
		essence_contents[essence_type] += vial.essence_amount
	else
		essence_contents[essence_type] = vial.essence_amount

	to_chat(user, span_info("You pour the [vial.contained_essence.name] into the cauldron."))
	vial.contained_essence = null
	vial.essence_amount = 0
	vial.update_overlays()

	brewing = 0 // Reset brewing when new ingredients added
	lastuser = WEAKREF(user)
	update_icon()
	playsound(src, "bubbles", 100, TRUE)

/obj/machinery/light/fueled/cauldron/process()
	..()
	update_icon()
	if(on)
		if(essence_contents.len)
			if(brewing < 20)
				if(src.reagents.has_reagent(/datum/reagent/water, 30))
					brewing++
					if(prob(10))
						playsound(src, "bubbles", 100, FALSE)
			else if(brewing == 20)
				var/list/recipe_result = find_matching_recipe_with_batches()
				if(recipe_result)
					var/datum/alch_cauldron_recipe/found_recipe = recipe_result["recipe"]
					var/batch_count = recipe_result["batches"]

					// Clear essences (consume all used essences)
					essence_contents = list()

					// Remove water and add product
					if(reagents)
						var/in_cauldron = src.reagents.get_reagent_amount(/datum/reagent/water)
						src.reagents.remove_reagent(/datum/reagent/water, in_cauldron)

					// Scale output by batch count
					if(found_recipe.output_reagents.len)
						var/list/scaled_reagents = list()
						for(var/reagent in found_recipe.output_reagents)
							scaled_reagents[reagent] = found_recipe.output_reagents[reagent] * batch_count
						src.reagents.add_reagent_list(scaled_reagents)

					if(found_recipe.output_items.len)
						for(var/itempath in found_recipe.output_items)
							for(var/i = 1 to batch_count)
								new itempath(get_turf(src))

					if(batch_count > 1)
						src.visible_message(span_info("The cauldron finishes boiling [batch_count] batches with a strong [found_recipe.smells_like] smell."))
					else
						src.visible_message(span_info("The cauldron finishes boiling with a faint [found_recipe.smells_like] smell."))

					// XP and stats (scaled by batch count)
					if(lastuser)
						var/mob/living/L = lastuser.resolve()
						record_featured_stat(FEATURED_STATS_ALCHEMISTS, L)
						GLOB.vanderlin_round_stats[STATS_POTIONS_BREWED] += batch_count
						var/boon = L.get_learning_boon(/datum/skill/craft/alchemy)
						var/amt2raise = L.STAINT * 2 * batch_count // More XP for multiple batches
						L.adjust_experience(/datum/skill/craft/alchemy, amt2raise * boon, FALSE)

					playsound(src, "bubbles", 100, TRUE)
					playsound(src, 'sound/misc/smelter_fin.ogg', 30, FALSE)
					brewing = 21
				else
					brewing = 0
					essence_contents = list() // Clear failed recipe
					src.visible_message(span_info("The essences in the [src] fail to combine properly..."))
					playsound(src, 'sound/misc/smelter_fin.ogg', 30, FALSE)

/obj/machinery/light/fueled/cauldron/proc/find_matching_recipe_with_batches()
	// This searches through all recipes to find one that matches and calculates max batches possible
	for(var/recipe_path in subtypesof(/datum/alch_cauldron_recipe))
		var/datum/alch_cauldron_recipe/recipe = new recipe_path
		var/batch_count = calculate_max_batches(recipe)
		if(batch_count > 0)
			var/list/result = list("recipe" = recipe, "batches" = batch_count)
			return result
		qdel(recipe)
	return null

/obj/machinery/light/fueled/cauldron/proc/calculate_max_batches(datum/alch_cauldron_recipe/recipe)
	// Check if recipe matches at all first
	if(!recipe.matches_essences(essence_contents))
		return 0

	// Calculate how many complete batches we can make
	var/min_batches = 999 // Start high

	for(var/essence_type in recipe.required_essences)
		var/required_amount = recipe.required_essences[essence_type]
		var/available_amount = essence_contents[essence_type]

		if(!available_amount || available_amount < required_amount)
			return 0 // Can't make even one batch

		var/possible_batches = FLOOR(available_amount / required_amount, 1)
		min_batches = min(min_batches, possible_batches)

	return min_batches
