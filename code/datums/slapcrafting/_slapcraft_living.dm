/// Have a living mob attempt to do a slapcraft. The mob is using the second item on the first item.
/mob/living/proc/try_slapcraft(obj/item/first_item, obj/item/second_item)
	// You cannot craft with items in storage, you must be holding them in hand
	// or they must be on the floor
	if(!isitem(first_item))
		return list()
	if((first_item.item_flags | second_item.item_flags) & IN_STORAGE)
		return list()

	// We need to find a recipe where the first item corresponds to the first step
	// ..and the second item corresponds to the second step
	var/list/available_recipes = slapcraft_recipes_for_type(first_item.type)
	if(!available_recipes)
		return list()

	var/list/recipes = list()
	for(var/datum/slapcraft_recipe/recipe in available_recipes)
		//Always start from step one.
		var/datum/slapcraft_step/step_one = SLAPCRAFT_STEP(recipe.steps[1])
		if(!step_one.perform_check(src, first_item, null))
			continue

		// Get next suitable step that is available after the first one would be performed.
		var/list/pretend_list = list()
		pretend_list[step_one.type] = TRUE

		var/datum/slapcraft_step/next_step = recipe.next_suitable_step(src, second_item, pretend_list, check_type_only = TRUE)
		if(!next_step)
			continue
		if(!next_step.perform_check(src, second_item, null, check_type_only = TRUE))
			continue

		recipes += recipe

	if(!length(recipes))
		return list()

	return recipes
