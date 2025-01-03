/mob/living/proc/try_repeatable_craft(obj/item/attacked_item, obj/item/attacked_object)
	var/list/recipes = list()
	for(var/path in GLOB.repeatable_crafting_recipes)
		if(!istype(attacked_object, path))
			continue
		recipes |= GLOB.repeatable_crafting_recipes[path]

	var/list/passed_recipes = list()

	for(var/datum/repeatable_crafting_recipe/recipe in recipes)
		if(!recipe.check_start(attacked_item, attacked_object, src))
			continue
		passed_recipes |= recipe

	if(!length(passed_recipes))
		return FALSE

	if(length(passed_recipes) == 1)
		var/datum/repeatable_crafting_recipe/recipe = passed_recipes[1]
		recipe.start_recipe(attacked_item, attacked_object, src)

	else
		var/datum/repeatable_crafting_recipe/recipe = input(src, "Choose a recipe to craft", "Recipes") as null|anything in passed_recipes
		recipe.start_recipe(attacked_item, attacked_object, src)
	return TRUE
