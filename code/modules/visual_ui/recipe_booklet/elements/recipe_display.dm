/obj/abstract/visual_ui_element/current_recipe
	icon = 'icons/visual_ui/booklet.dmi'
	icon_state = "recipe_header"
	layer = VISUAL_UI_STEP_BACK

	maptext_width = 128
	maptext_x = 180
	maptext_y = 150

/obj/abstract/visual_ui_element/recipe_info_break
	icon = 'icons/visual_ui/booklet.dmi'
	icon_state = "recipe_info_break"
	layer = VISUAL_UI_STEP_BACK

	maptext_width = 128
	maptext_x = 180
	maptext_y = 150


/obj/abstract/visual_ui_element/recipe_info_one_liner
	icon = 'icons/visual_ui/booklet.dmi'
	icon_state = "recipe-requirement-line"
	layer = VISUAL_UI_STEP_BACK

	maptext_width = 128
	maptext_x = 180
	maptext_y = 30


/obj/abstract/visual_ui_element/hoverable/scroll_handle/recipe
	icon = 'icons/visual_ui/booklet.dmi'
	icon_state = "scroll-handle-recipe"

/obj/abstract/visual_ui_element/scroll_track/recipe
	icon = 'icons/visual_ui/booklet.dmi'
	icon_state = "recipe-scroll-track"

/obj/abstract/visual_ui_element/scrollable/selected_recipe
	icon = 'icons/visual_ui/booklet.dmi'
	icon_state = "recipe-scroll-area"
	scroll_handle = /obj/abstract/visual_ui_element/hoverable/scroll_handle/recipe
	scroll_track = /obj/abstract/visual_ui_element/scroll_track/recipe
	mask_icon_state = "scroll_mask-recipe"

	const_offset = 0
	scroll_step = 8

	visible_width = 94
	visible_height = 92


	var/recipe_selection


/obj/abstract/visual_ui_element/scrollable/selected_recipe/proc/unbuild_recipe()
	var/mob/current = parent.get_user()
	for(var/obj/abstract/visual_ui_element/element as anything in container_elements)
		element.scrollable_parent = null
		container_elements -= element
		parent.elements -= element
		current.client.screen -= element
		qdel(element)

	scroll_position = 0
	update_element_positions()
	update_scroll_handle()

/obj/abstract/visual_ui_element/scrollable/selected_recipe/proc/build_recipe()
	if(length(container_elements))
		unbuild_recipe()
	if(!recipe_selection)
		return
	var/mob/current = parent.get_user()
	var/datum/repeatable_crafting_recipe/recipe = new recipe_selection
	var/length = 1
	var/obj/abstract/visual_ui_element/recipe_info_break/requirements_start = new /obj/abstract/visual_ui_element/recipe_info_break(null, parent)
	requirements_start.offset_x = offset_x
	requirements_start.offset_y = offset_y + (18 * (length-1))
	requirements_start.update_ui_screen_loc()
	parent.elements += requirements_start
	current.client.screen |= requirements_start
	register_element(requirements_start)
	length++

	for(var/atom/path as anything in recipe.requirements)
		var/obj/abstract/visual_ui_element/recipe_info_one_liner/requirement = new /obj/abstract/visual_ui_element/recipe_info_one_liner(null, parent)
		requirement.offset_x = offset_x
		requirement.offset_y = offset_y + (18 * (length-1))
		requirement.update_ui_screen_loc()
		parent.elements += requirement
		current.client.screen |= requirement
		register_element(requirement)
		length++
		requirement.maptext = {"<span style='font-size:8pt;font-family:"Pixelify Sans";color:[hover_color]' class='center maptext '>[recipe.requirements[path]] x [initial(path.name)]</span>"}

	for(var/datum/reagent/path as anything in recipe.reagent_requirements)
		var/obj/abstract/visual_ui_element/recipe_info_one_liner/requirement = new /obj/abstract/visual_ui_element/recipe_info_one_liner(null, parent)
		requirement.offset_x = offset_x
		requirement.offset_y = offset_y + (18 * (length-1))
		requirement.update_ui_screen_loc()
		parent.elements += requirement
		current.client.screen |= requirement
		register_element(requirement)
		length++
		requirement.maptext = {"<span style='font-size:8pt;font-family:"Pixelify Sans";color:[hover_color]' class='center maptext '>[CEILING(recipe.reagent_requirements[path] / 3, 1)] Oz of [initial(path.name)]</span>"}

	var/obj/abstract/visual_ui_element/recipe_info_break/requirements_end = new /obj/abstract/visual_ui_element/recipe_info_break(null, parent)
	requirements_end.offset_x = offset_x
	requirements_end.offset_y = offset_y + (18 * (length-1))
	requirements_start.update_ui_screen_loc()
	parent.elements += requirements_end
	current.client.screen |= requirements_end
	register_element(requirements_end)
	length++
