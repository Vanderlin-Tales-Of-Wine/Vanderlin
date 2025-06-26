/obj/structure/throne
	name = "throne"
	desc = "A big throne, to hold the Lord's giant personality. Say 'help' with the crown on your head if you are confused."
	icon = 'icons/roguetown/misc/96x96.dmi'
	icon_state = "throne"
	density = FALSE
	can_buckle = 1
	pixel_x = -32
	max_integrity = 999999
	buckle_lying = FALSE
	obj_flags = NONE
	uses_lord_coloring = LORD_PRIMARY | LORD_SECONDARY

/obj/structure/throne/post_buckle_mob(mob/living/M)
	..()
	density = TRUE
	M.set_mob_offsets("bed_buckle", _w = 0, _z = 8)

/obj/structure/throne/post_unbuckle_mob(mob/living/M)
	. = ..()
	density = FALSE
	M.reset_offsets("bed_buckle")

/obj/structure/throne/statues	// alt version with more statue but covers side tables less.
	icon = 'icons/roguetown/misc/throne_alt.dmi'
