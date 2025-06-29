/obj/structure/fake_machine/camera
	name = "face"
	desc = ""
	icon = 'icons/roguetown/misc/machines.dmi'
	icon_state = "camera-mid"
	density = FALSE
	blade_dulling = DULLING_BASH
	layer = ABOVE_MOB_LAYER
	max_integrity = 0
	var/number = 1
	SET_BASE_PIXEL(0, 10)

/obj/structure/fake_machine/camera/right
	icon_state = "camera-r"
	SET_BASE_PIXEL(5, 5)

/obj/structure/fake_machine/camera/left
	icon_state = "camera-l"
	SET_BASE_PIXEL(-5, 5)

/obj/structure/fake_machine/camera/obj_break(damage_flag, silent)
	..()
	set_light(0)
	icon_state = "camera-br"
	SSroguemachine.cameras -= src

/obj/structure/fake_machine/camera/Initialize()
	. = ..()
	set_light(1, 1, 1, l_color =  "#ff0d0d")
	SSroguemachine.cameras += src
	number = length(SSroguemachine.cameras)
	name = "face #[number]"

/obj/structure/fake_machine/camera/Destroy()
	set_light(0)
	SSroguemachine.cameras -= src
	. = ..()
