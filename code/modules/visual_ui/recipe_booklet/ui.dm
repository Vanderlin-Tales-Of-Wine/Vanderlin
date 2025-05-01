/datum/visual_ui/recipe_booklet
	uniqueID = "recipe_book"
	element_types_to_spawn = list(
		/obj/abstract/visual_ui_element/book_background,
		/obj/abstract/visual_ui_element/hoverable/book_close,
		/obj/abstract/visual_ui_element/scrollable/recipe_group,
		/obj/abstract/visual_ui_element/hoverable/movable/move_book,
		/obj/abstract/visual_ui_element/scrollable/selected_recipe,
		/obj/abstract/visual_ui_element/current_recipe,
		)
	display_with_parent = TRUE
	x = "LEFT"
	y = "BOTTOM"
