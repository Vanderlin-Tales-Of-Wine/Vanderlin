/datum/container_craft/cooking/drugs
	abstract_type = /datum/container_craft/cooking/drugs

/datum/container_craft/cooking/arcyne
	abstract_type = /datum/container_craft/cooking/arcyne

/datum/container_craft/cooking
	abstract_type = /datum/container_craft/cooking
	category = "Soups"
	crafting_time = 5 SECONDS
	reagent_requirements = list(
		/datum/reagent/water = 33
	)
	craft_verb = "cooking for "
	required_container = /obj/item/reagent_containers/glass/bucket/pot
	var/datum/reagent/created_reagent

	var/water_conversion = 1
	var/datum/pollutant/finished_smell
	///the amount we pollute
	var/pollute_amount = 600
	///our required_baking temperature
	var/required_chem_temp = 374
	///what we add for optionals ie chunks of
	var/wording_choice = "chunks of"

/datum/container_craft/cooking/try_craft(obj/item/crafter, list/pathed_items, mob/initiator, datum/callback/on_craft_start, datum/callback/on_craft_failed)
	if(crafter.reagents.chem_temp < required_chem_temp)
		return FALSE
	. = ..()

/datum/container_craft/cooking/check_failure(obj/item/crafter, mob/user)
	if(crafter.reagents.chem_temp < required_chem_temp)
		return TRUE
	return FALSE

/datum/container_craft/cooking/get_real_time(atom/host, mob/user, estimated_multiplier)
	var/real_cooking_time = crafting_time * estimated_multiplier
	if(user.mind)
		real_cooking_time /= 1 + (user.get_skill_level(/datum/skill/craft/cooking) * 0.5)
		real_cooking_time = round(real_cooking_time)
	return real_cooking_time

/datum/container_craft/cooking/create_item(obj/item/crafter, mob/initiator, list/found_optional_requirements, list/found_optional_wildcards, list/found_optional_reagents)
	var/turf/pot_turf = get_turf(crafter)
	var/datum/reagent/first =  reagent_requirements[1]
	var/reagent_amount =  reagent_requirements[first]
	for(var/j = 1 to output_amount)
		crafter.reagents.add_reagent(created_reagent, reagent_amount * water_conversion)
		after_craft(null, crafter, initiator, found_optional_requirements, found_optional_wildcards, found_optional_reagents)
		if(finished_smell)
			pot_turf.pollute_turf(finished_smell, pollute_amount)
	playsound(pot_turf, "bubbles", 30, TRUE)



/datum/container_craft/cooking/after_craft(atom/created_output, obj/item/crafter, mob/initiator, list/found_optional_requirements, list/found_optional_wildcards, list/found_optional_reagents, list/removing_items)
	. = ..()
	var/datum/reagent/found_product = crafter.reagents.get_reagent(created_reagent)

	if(!length(found_optional_wildcards))
		return

	var/extra_string = " with [wording_choice] "
	var/first_ingredient = TRUE

	var/list/all_used_ingredients = list()

	for(var/wildcard_type in found_optional_wildcards)
		var/list/items = found_optional_wildcards[wildcard_type]
		for(var/obj/item/ingredient in items)
			all_used_ingredients += ingredient

	for(var/obj/item/ingredient in all_used_ingredients)
		if(first_ingredient)
			extra_string += ingredient.name
			first_ingredient = FALSE
		else
			extra_string += " and [ingredient.name]"

	found_product.name += extra_string

/datum/container_craft/cooking/extra_html()
	var/html
	var/datum/reagent/first =  reagent_requirements[1]
	var/result_amount = reagent_requirements[first]
	if(water_conversion > 0)
		result_amount = CEILING((result_amount * water_conversion) / 3, 1)
	html += "[result_amount] oz of [initial(created_reagent.name)]<br>"

	return html
