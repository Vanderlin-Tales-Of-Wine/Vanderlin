/*
	calling display_ui("Hello World") on a mob with a client and a mind gives them a panel with a green button that sends "Hello World!" to their chat, and a red button that hides the UI.
*/
////////////////////////////////////////////////////////////////////
//																  //
//						   HELLO WORLD							  //
//																  //
////////////////////////////////////////////////////////////////////
/datum/visual_ui/test_hello_world_parent
	uniqueID = "Hello World"
	element_types_to_spawn = list(
		/obj/abstract/visual_ui_element/test_back,
		)
	sub_uis_to_spawn = list(
		/datum/visual_ui/test_hello_world,
		)
	x = "LEFT"
	y = "BOTTOM"
	display_with_parent = TRUE

//------------------------------------------------------------
/obj/abstract/visual_ui_element/test_back
	icon = 'icons/visual_ui/480x480.dmi'
	icon_state = "test_background"
	layer = FULLSCREEN_LAYER
	plane = FULLSCREEN_PLANE
	blend_mode = BLEND_ADD
	mouse_opacity = 0
////////////////////////////////////////////////////////////////////
//																  //
//						   HELLO WORLD CHILD					  //
//																  //
////////////////////////////////////////////////////////////////////
/datum/visual_ui/test_hello_world
	uniqueID = "Hello World Panel"
	element_types_to_spawn = list(
		/obj/abstract/visual_ui_element/test_window,
		/obj/abstract/visual_ui_element/hoverable/test_close,
		/obj/abstract/visual_ui_element/hoverable/test_hello,
		/obj/abstract/visual_ui_element/hoverable/movable/test_move,
		)
	display_with_parent = TRUE
//------------------------------------------------------------
/obj/abstract/visual_ui_element/test_window
	icon = 'icons/visual_ui/192x192.dmi'
	icon_state = "test_192x128"
	layer = VISUAL_UI_BACK
	offset_x = -80
	offset_y = -80
	alpha = 180
	mouse_opacity = 1
//------------------------------------------------------------
/obj/abstract/visual_ui_element/hoverable/test_close
	icon = 'icons/visual_ui/32x32.dmi'
	icon_state = "close"
	layer = VISUAL_UI_BUTTON
	offset_x = 80
	offset_y = 16
	mouse_opacity = 1
/obj/abstract/visual_ui_element/hoverable/test_close/appear()
	..()
	mouse_opacity = 1
	icon_state = "close"
	flick("close-spawn", src)

/obj/abstract/visual_ui_element/hoverable/test_close/hide()
	mouse_opacity = 0
	icon_state = "blank"
	flick("close-click", src)
	spawn(10)
		..()

/obj/abstract/visual_ui_element/hoverable/test_close/Click()
	var/datum/visual_ui/ancestor = parent.get_ancestor()
	ancestor.hide()
//------------------------------------------------------------
/obj/abstract/visual_ui_element/hoverable/test_hello
	icon = 'icons/visual_ui/32x32.dmi'
	icon_state = "hello"
	layer = VISUAL_UI_BUTTON
	offset_y = -16
	mouse_opacity = 1

/obj/abstract/visual_ui_element/hoverable/test_hello/Click()
	flick("hello-click", src)
	to_chat(get_user(), "Hello World!")
//------------------------------------------------------------


/obj/abstract/visual_ui_element/hoverable/movable/test_move
	icon = 'icons/visual_ui/32x32.dmi'
	icon_state = "move"
	layer = VISUAL_UI_BUTTON
	offset_x = -80
	offset_y = 16
	mouse_opacity = 1

	move_whole_ui = TRUE
