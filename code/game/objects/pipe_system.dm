/obj/structure/water_pipe
	name = "water pipe"
	desc = ""
	icon_state = "base"
	icon = 'icons/roguetown/misc/pipes.dmi'
	density = FALSE
	layer = TABLE_LAYER
	plane = GAME_PLANE
	damage_deflection = 5
	blade_dulling = DULLING_BASHCHOP
	attacked_sound = list('sound/combat/hits/onmetal/grille (1).ogg', 'sound/combat/hits/onmetal/grille (2).ogg', 'sound/combat/hits/onmetal/grille (3).ogg')
	smeltresult = /obj/item/ingot/bronze

	var/water_pressure
	var/datum/reagent/carrying_reagent
	var/list/connected = list("2" = 0, "1" = 0, "8" = 0, "4" = 0)
	//this is a list of pipes that are connected to something giving a reagent
	var/list/providers = list()
	///this is just a list we can access for the sake of checking, this is basically just a number getting random addition every check to keep unique
	var/check_id = 0
	var/obj/structure/taking_from

/obj/structure/water_pipe/Initialize()
	. = ..()
	for(var/direction in GLOB.cardinals)
		var/turf/cardinal_turf = get_step(src, direction)
		for(var/obj/structure/water_pipe/pipe in cardinal_turf)
			if(!istype(pipe))
				return
			set_connection(get_dir(src, pipe))
			pipe.set_connection(get_dir(pipe, src))
			pipe.update_overlays()
			if(pipe.check_id && !check_id)
				check_id = pipe.check_id

		for(var/obj/structure/structure in cardinal_turf)
			if(!structure.accepts_water_input)
				continue
			if(!structure.valid_water_connection(direction))
				continue
			set_connection(get_dir(src, structure))

	update_overlays()
	START_PROCESSING(SSobj, src)

/obj/structure/water_pipe/Destroy()
	var/turf/old_turf = get_turf(src)
	. = ..()
	var/list/directional_pipes = list()
	for(var/direction in GLOB.cardinals)
		var/turf/cardinal_turf = get_step(old_turf, direction)
		for(var/obj/structure/water_pipe/pipe in cardinal_turf)
			if(!istype(pipe))
				continue
			pipe.unset_connection(get_dir(pipe, src))
			pipe.update_overlays()
			directional_pipes |= pipe

	var/list/orphaned_pipes = directional_pipes
	var/list/last_connected_pipes = list()
	for(var/obj/structure/water_pipe/provider in providers)
		var/list/connected_pipes = provider.build_connected(last_connected_pipes)
		last_connected_pipes = connected_pipes
		for(var/obj/structure/water_pipe/pipe in orphaned_pipes)
			if(pipe in connected_pipes)
				orphaned_pipes -= pipe
				if(!length(orphaned_pipes))
					return

	check_id++
	for(var/obj/structure/water_pipe/pipe in orphaned_pipes)
		pipe.propagate_change(check_id, null, 0, null, null)
		pipe.providers = list()
/obj/structure/water_pipe/return_rotation_chat(atom/movable/screen/movable/mouseover/mouseover)
	mouseover.maptext_height = 96
	return {"<span style='font-size:8pt;font-family:"Pterra";color:#808000;text-shadow:0 0 1px #fff, 0 0 2px #fff, 0 0 30px #e60073, 0 0 40px #e60073, 0 0 50px #e60073, 0 0 60px #e60073, 0 0 70px #e60073;' class='center maptext '>
			Pressure:[water_pressure]
			Fluid:[carrying_reagent ? initial(carrying_reagent.name) : "Nothing"]</span>"}

/obj/structure/water_pipe/proc/make_provider(datum/reagent/reagent, pressure, obj/structure/giver)
	check_id++
	taking_from = giver
	propagate_change(check_id, reagent, pressure, src)

/obj/structure/water_pipe/proc/remove_provider(datum/reagent/reagent, pressure)
	check_id++
	taking_from = null
	propagate_change(check_id, reagent, pressure, null, src)

/obj/structure/water_pipe/proc/use_pressure(pressure)
	taking_from?.use_water_pressure(pressure)

/obj/structure/water_pipe/proc/build_connected(list/last_checked)
	if(src in last_checked)
		return last_checked

	check_id++
	return check_adjacency(list(src), check_id)


/obj/structure/water_pipe/proc/check_adjacency(list/checked, id)
	check_id = id
	checked |= src
	for(var/direction in GLOB.cardinals)
		var/turf/cardinal_turf = get_step(src, direction)
		for(var/obj/structure/water_pipe/pipe in cardinal_turf)
			if(!istype(pipe))
				continue
			if(pipe.check_id == id)
				continue
			checked |= pipe.check_adjacency(checked, id)
	return checked

/obj/structure/water_pipe/proc/propagate_change(change_id, datum/reagent/id, pressure, obj/structure/water_pipe/added_provider, obj/structure/water_pipe/removed_provider)
	sleep(0.1 SECONDS)
	water_pressure = pressure
	carrying_reagent = id
	check_id = change_id
	if(added_provider)
		if(length(providers))
			for(var/obj/structure/water_pipe/pipe in providers)
				if(pipe.carrying_reagent != id)
					visible_message("[src] bursts from the clashing pipe streams!")
					qdel(src)
					return
		providers |= added_provider
	if(removed_provider)
		providers -= removed_provider

	for(var/direction in GLOB.cardinals)
		var/turf/cardinal_turf = get_step(src, direction)
		for(var/obj/structure/water_pipe/pipe in cardinal_turf)
			if(!istype(pipe))
				continue
			if((pipe.carrying_reagent == id && pipe.water_pressure == pressure) || pipe.check_id == change_id)
				continue
			pipe.propagate_change(change_id, id, max(0, pressure - 1), added_provider, removed_provider)


/obj/structure/water_pipe/proc/set_connection(dir)
	connected["[dir]"] = 1
	update_overlays()

/obj/structure/water_pipe/proc/unset_connection(dir)
	connected["[dir]"] = 0
	update_overlays()

/obj/structure/water_pipe/update_overlays()
	. = ..()
	var/new_overlay = ""
	for(var/i in connected)
		if(connected[i])
			new_overlay += i
	icon_state = "[new_overlay]"
	if(!new_overlay)
		icon_state = "base"

	manipulate_possible_steam_creaks()

/obj/structure/water_pipe/proc/manipulate_possible_steam_creaks()
	var/obj/particle_emitter/emitter
	if(prob(25))
		emitter = locate(/obj/particle_emitter) in particle_emitters
		if(!emitter)
			emitter = MakeParticleEmitter(/particles/smoke/cig/big)
	else
		for(var/obj/particle_emitter/stored in particle_emitters)
			RemoveEmitter(stored)
		return

	switch(icon_state)
		if("base", "84", "4", "8", "18", "28")
			emitter.pixel_x = rand(-8, -6)
			emitter.pixel_y = rand(3, 6)
		if("14", "18", "21", "2", "1")
			emitter.pixel_y = rand(14, 16)
			emitter.pixel_x = rand(3, 9)
		if("24")
			for(var/obj/particle_emitter/stored in particle_emitters)
				RemoveEmitter(stored)
