/client
	var/datum/slapcraft_handbook/crafting_book

/client/New()
	. = ..()
	if(!crafting_book)
		crafting_book = new

/client/proc/show_crafting_book()
	crafting_book.show(mob)

/datum/slapcraft_handbook
	var/current_category = SLAP_CAT_CARPTENTRY
	var/current_subcategory = SLAP_SUBCAT_STRUCTURE
	var/current_recipe

/// Gets the description of the step. This can include a href link.
/datum/slapcraft_handbook/proc/print_step_description(datum/slapcraft_step/craft_step)
	if(!craft_step.recipe_link)
		return craft_step.desc
	// This step links to some recipe, linkify the description with a href
	. = craft_step.desc
	. = replacetext(., "%ENDLINK%", "</a>")
	. = replacetext(., "%LINK%", "<a href='?src=[REF(src)];preference=popup_recipe;recipe=[craft_step.recipe_link]'>")

/datum/slapcraft_handbook/proc/print_recipe(datum/slapcraft_recipe/recipe, in_handbook = FALSE, background_color = "#23273C")
	var/list/dat = list()
	var/recipe_type = recipe.type
	var/first_cell
	var/second_cell
	if(in_handbook)
		first_cell = "<a href='?src=[REF(src)];preference=set_recipe;recipe=[recipe_type]' [current_recipe == recipe_type ? "class='linkOn'" : ""]>[recipe.name]</a>"
		second_cell = "<a href='?src=[REF(src)];preference=popup_recipe;recipe=[recipe_type]'>Popup Recipe</a>"
	else
		first_cell = "[recipe.name]"
		second_cell = "<a href='?src=[REF(src)];preference=goto_recipe;recipe=[recipe_type]'>Goto Recipe</a>"
	dat += "<tr style='vertical-align:top; background-color: [background_color];'>"
	dat += "<td>[first_cell]</td><td>[second_cell]</td>"
	dat += "</tr>"
	if(!in_handbook || recipe_type == current_recipe)
		var/steps_string = ""
		var/list_string = ""
		var/first = TRUE
		var/step_count = 0
		for(var/step_type in recipe.steps)
			var/datum/slapcraft_step/step_datum = SLAPCRAFT_STEP(step_type)
			step_count++
			if(!first)
				steps_string += "<br>"
				list_string += "<br>"
			var/count_string
			switch(recipe.step_order)
				if(SLAP_ORDER_STEP_BY_STEP)
					count_string = step_count
				if(SLAP_ORDER_FIRST_AND_LAST)
					if(step_count == 1 || step_count == recipe.steps.len)
						count_string = step_count
					else
						count_string = "X"
				if(SLAP_ORDER_FIRST_THEN_FREEFORM)
					if(step_count == 1)
						count_string = step_count
					else
						count_string = "X"
			var/opt_string = step_datum.optional ? "(optional)" : ""
			steps_string += "[count_string]. [opt_string] [print_step_description(step_datum)]"
			list_string += "[step_datum.list_desc]"
			first = FALSE
		// If there's a recipe, add a row with it.
		if(recipe.desc)
			dat += "<tr><td>[recipe.desc]</td><td></td></tr>"
		dat += "<tr><td>[steps_string]</td><td>[list_string]</td></tr>"
	return dat

/datum/slapcraft_handbook/proc/show(mob/user)
	var/list/dat = list()

	for(var/category in GLOB.slapcraft_categorized_recipes)
		dat += "<a href='?src=[REF(src)];preference=set_category;tab=[category]' [category == current_category ? "class='linkOn'" : ""]>[category]</a> "
	dat += "<hr>"
	var/list/subcategory_list = GLOB.slapcraft_categorized_recipes[current_category]
	for(var/subcategory in subcategory_list)
		dat += "<a href='?src=[REF(src)];preference=set_subcategory;tab=[subcategory]' [subcategory == current_subcategory ? "class='linkOn'" : ""]>[current_subcategory]</a> "
	dat += "<hr>"

	dat += "<table align='center'; width='100%'; height='100%'; style='background-color:#13171C'><tr><td width='65%'></td><td width='35%'></td></tr>"
	var/even = FALSE
	var/list/recipe_list = subcategory_list[current_subcategory]
	for(var/datum/slapcraft_recipe/recipe as anything in recipe_list)
		var/background_cl = even ? "#17191C" : "#23273C"
		even = !even
		dat += print_recipe(recipe, TRUE, background_cl)

	dat += "</table>"

	var/datum/browser/noclose/popup = new(user, "slapcraft_handbook", "Slapcraft Handbook", 600, 800)
	popup.set_content(dat.Join())
	popup.open()
	return

/datum/slapcraft_handbook/Topic(href, href_list)
	if(..())
		return
	if(href_list["preference"])
		switch(href_list["preference"])
			if("set_category")
				current_category = href_list["tab"]
			if("set_subcategory")
				current_subcategory = href_list["tab"]
			if("set_recipe")
				current_recipe = text2path(href_list["recipe"])
			if("popup_recipe")
				var/recipe_type_to_pop = text2path(href_list["recipe"])
				popup_recipe(usr, recipe_type_to_pop)
				return
			if("goto_recipe")
				var/recipe_type = text2path(href_list["recipe"])
				var/datum/slapcraft_recipe/recipe = SLAPCRAFT_RECIPE(recipe_type)
				current_recipe = recipe_type
				current_category = recipe.category
				current_subcategory = recipe.subcategory

		show(usr)

/datum/slapcraft_handbook/proc/popup_recipe(mob/user, recipe_type)
	var/list/dat = list()

	dat += "<table align='center'; width='100%'; height='100%'; style='background-color:#13171C'><tr><td width='65%'></td><td width='35%'></td></tr>"
	var/datum/slapcraft_recipe/recipe = SLAPCRAFT_RECIPE(recipe_type)
	dat += print_recipe(recipe)
	dat += "</table>"

	var/datum/browser/noclose/popup = new(user, "[recipe_type]_popup", "[recipe.category] - [recipe.subcategory] - [recipe.name]", 500, 200)
	popup.set_content(dat.Join())
	popup.open()
	return
