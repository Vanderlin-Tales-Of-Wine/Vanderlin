//N/A lamerd version of the headeater until Aberra actually gives the thumbs up for the real one

/obj/structure/roguemachine/headeater
	name = "head eating HAILER"
	desc = "seems like its here on the behalf of something else"
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "mail"
	density = FALSE
	blade_dulling = DULLING_BASH
	pixel_y = 32

/obj/structure/roguemachine/headeater/attackby(obj/item/natural/head/H, mob/user, params)
	. = ..()
	if(!istype(H, /obj/item/natural/head) || !istype(H, /obj/item/bodypart/head) || H.headprice <= 0)
		to_chat(user, span_danger("It seems uninterested by the [H]"))
		return

	to_chat(user, span_danger("[src] consumes the [H] and leaves spits out coins!"))
	budget2change(H.headprice, user)
	H.forceMove(loc)



