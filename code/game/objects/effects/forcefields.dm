/obj/effect/forcefield
	desc = ""
	name = "FORCEWALL"
	icon_state = "m_shield"
	anchored = TRUE
	opacity = 0
	density = TRUE
	CanAtmosPass = ATMOS_PASS_DENSITY
	var/timeleft = 300 //Set to 0 for permanent forcefields (ugh)

/obj/effect/forcefield/Initialize()
	. = ..()
	if(timeleft)
		QDEL_IN(src, timeleft)

///////////Mimewalls///////////

/obj/effect/forcefield/mime
	icon_state = "nothing"
	name = "invisible wall"
	desc = ""
	alpha = 0

/obj/effect/forcefield/mime/advanced
	name = "invisible blockade"
	desc = ""
	timeleft = 600
