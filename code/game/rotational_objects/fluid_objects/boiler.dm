/obj/structure/boiler
	name = "boiler"

	icon_state = "boiler"
	icon = 'icons/obj/rotation_machines.dmi'
	layer = 5
	accepts_water_input = TRUE

	var/fuel = 100

	var/stored_steam = 0
	var/maximum_steam = 1024
	var/obj/structure/water_pipe/input
	var/obj/structure/water_pipe/output


/obj/structure/boiler/Initialize()
	. = ..()
	var/turf/east_turf = get_step(src, EAST)
	var/turf/west_turf = get_step(src, WEST)

	input = locate(/obj/structure/water_pipe) in east_turf
	output = locate(/obj/structure/water_pipe) in west_turf

	START_PROCESSING(SSobj, src)

/obj/structure/boiler/return_rotation_chat(atom/movable/screen/movable/mouseover/mouseover)
	mouseover.maptext_height = 128

	return {"<span style='font-size:8pt;font-family:"Pterra";color:#808000;text-shadow:0 0 1px #fff, 0 0 2px #fff, 0 0 30px #e60073, 0 0 40px #e60073, 0 0 50px #e60073, 0 0 60px #e60073, 0 0 70px #e60073;' class='center maptext '>
			Input Pressure:[input ? input.water_pressure : "0"]
			Output Pressure:[stored_steam]
			Steam:[stored_steam ? round((stored_steam / maximum_steam) * 100, 1 ): "0"]%"}


/obj/structure/boiler/valid_water_connection(direction)
	if(direction == EAST || direction == WEST)
		return TRUE
	return FALSE

/obj/structure/boiler/process()
	if(input && fuel && length(input.providers))
		var/obj/structure/water_pipe/picked_provider = pick(input.providers)
		var/steam_left = maximum_steam - stored_steam
		var/taking_pressure = min(steam_left,input.water_pressure)
		if(taking_pressure)
			picked_provider?.taking_from?.use_water_pressure(taking_pressure * 0.5)
		stored_steam += taking_pressure

	if(!output)
		return
	output.make_provider(/datum/reagent/steam, stored_steam, src)

/datum/reagent/steam
	name = "Steam"
