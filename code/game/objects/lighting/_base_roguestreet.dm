/obj/machinery/light/fueledstreet
	icon = 'icons/roguetown/misc/tallstructure.dmi'
	icon_state = "slamp1"
	base_state = "slamp"
	brightness = 10
	//nightshift_allowed = FALSE
	fueluse = 0
	bulb_colour = "#e4ff6c"
	bulb_power = 1
	max_integrity = 0
	pass_flags = LETPASSTHROW
	smeltresult = /obj/item/ingot/bronze

/obj/machinery/light/fueledstreet/midlamp
	icon = 'icons/roguetown/misc/64x64.dmi'
	icon_state = "midlamp1"
	base_state = "midlamp"
	pixel_x = -16
	density = TRUE

/obj/machinery/light/fueledstreet/proc/lights_out()
	on = FALSE
	set_light(0)
	update_icon()
	addtimer(CALLBACK(src, PROC_REF(lights_on)), 5 MINUTES)

/obj/machinery/light/fueledstreet/proc/lights_on()
	on = TRUE
	update()
	update_icon()

/obj/machinery/light/fueledstreet/update_icon()
	if(on)
		icon_state = "[base_state]1"
	else
		icon_state = "[base_state]0"

/obj/machinery/light/fueledstreet/update()
	. = ..()
	if(on)
		GLOB.fires_list |= src
	else
		GLOB.fires_list -= src

/obj/machinery/light/fueledstreet/Initialize()
	lights_on()
	GLOB.streetlamp_list += src
	update_icon()
	. = ..()

/obj/machinery/light/fueledstreet/update_icon()
	if(on)
		icon_state = "[base_state]1"
	else
		icon_state = "[base_state]0"
