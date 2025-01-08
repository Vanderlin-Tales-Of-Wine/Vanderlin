/obj/reflection
	vis_flags = VIS_INHERIT_ICON|VIS_INHERIT_ICON_STATE|VIS_INHERIT_DIR|VIS_INHERIT_LAYER|VIS_UNDERLAY
	appearance_flags = PIXEL_SCALE
	plane = REFLECTION_PLANE
	mouse_opacity = 0
	pixel_y = -44

/obj/reflection/New(loc,mob/owner)
	owner.vis_contents += src


/obj/item
	has_reflection = TRUE

/obj/structure
	has_reflection = TRUE

/obj/machinery
	has_reflection = TRUE

/obj/structure/kneestingers
	has_reflection = FALSE

/obj/structure/flora
	has_reflection = FALSE
