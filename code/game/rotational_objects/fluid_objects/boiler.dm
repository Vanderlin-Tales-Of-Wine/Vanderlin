/obj/structure/boiler
	name = "boiler"

	icon_state = "boiler"
	icon = 'icons/obj/rotation_machines.dmi'
	layer = 5
	accepts_water_input = TRUE

	var/fuel = 100

	var/stored_steam = 0
	var/maximum_steam = 1024


/obj/structure/boiler/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/structure/boiler/Destroy()
	STOP_PROCESSING(SSobj, src)
	if(output)
		output.remove_provider(/datum/reagent/steam, stored_steam)
	. = ..()

/obj/structure/boiler/setup_water()
	var/turf/east_turf = get_step(src, turn(dir, 90))
	var/turf/west_turf = get_step(src, turn(dir, -90))

	input = locate(/obj/structure/water_pipe) in east_turf
	output = locate(/obj/structure/water_pipe) in west_turf

/obj/structure/boiler/return_rotation_chat(atom/movable/screen/movable/mouseover/mouseover)
	mouseover.maptext_height = 128

	return {"<span style='font-size:8pt;font-family:"Pterra";color:#808000;text-shadow:0 0 1px #fff, 0 0 2px #fff, 0 0 30px #e60073, 0 0 40px #e60073, 0 0 50px #e60073, 0 0 60px #e60073, 0 0 70px #e60073;' class='center maptext '>
			Input Pressure:[input ? input.water_pressure : "0"]
			Output Pressure:[stored_steam]
			Steam:[stored_steam ? round((stored_steam / maximum_steam) * 100, 1 ): "0"]%"}

// Assume boiler is facing south (dir = SOUTH). Input is coming in from the right (direction = WEST) and output is to the left (direction = EAST)
/obj/structure/boiler/valid_water_connection(direction, obj/structure/water_pipe/pipe)
	if(direction == turn(dir, -90))
		input = pipe
		return TRUE
	if(direction == turn(dir, 90))
		output = pipe
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

/obj/structure/boiler/use_water_pressure(pressure)
	stored_steam -= pressure
	if(!output)
		return
	output.make_provider(/datum/reagent/steam, stored_steam, src)

/datum/reagent/steam
	name = "Steam"
