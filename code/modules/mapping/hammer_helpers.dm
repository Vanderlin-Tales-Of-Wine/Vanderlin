/obj/effect/landmark/hammer
	icon = 'icons/testing/source.dmi'
	icon_state = "error"
	invisibility = 101
	layer = 9999
	anchored = 1
	plane = ABOVE_LIGHTING_PLANE

/obj/effect/landmark/hammer/Initialize()
	. = ..()
	invisibility = 101
#ifdef TESTING
	invisibility = 0
#endif

// dev_text, it's only visible in game when "TESTING" is defined in _compile_options.dm
/obj/effect/landmark/hammer/dev_text
	icon = 'icons/testing/source.dmi'
	icon_state = "dev_text"
	name = "Put your<br>text here!"
	desc = "Assign the dev_text to the name var. <br> to linebreak if needed."

/obj/effect/landmark/hammer/dev_text/Initialize()
	. = ..()
#ifndef TESTING
	qdel(src)
#endif
	maptext = name
	maptext_width = 500
	maptext_x = 32
