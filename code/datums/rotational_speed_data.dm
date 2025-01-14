/obj/structure
	var/rotation_structure = FALSE
	var/rotations_per_minute
	var/stress_use
	var/stress_generation
	var/rotation_direction
	var/cog_size = COG_SMALL
	var/stress_generator = FALSE
	var/last_stress_added = 0
	var/accepts_water_input = FALSE

	var/datum/rotation_network/rotation_network

/obj/structure/Initialize()
	. = ..()
	if(rotation_structure)
		return INITIALIZE_HINT_LATELOAD

/obj/structure/Destroy()
	if(rotation_network)
		var/datum/rotation_network/old_network = rotation_network
		rotation_network.remove_connection(src)
		old_network.reassess_group(src)
	. = ..()
/obj/structure/return_rotation_chat(atom/movable/screen/movable/mouseover/mouseover)
	mouseover.maptext_height = 96
	return {"<span style='font-size:8pt;font-family:"Pterra";color:#e6b120;text-shadow:0 0 1px #fff, 0 0 2px #fff, 0 0 30px #e60073, 0 0 40px #e60073, 0 0 50px #e60073, 0 0 60px #e60073, 0 0 70px #e60073;' class='center maptext '>
			RPM:[rotations_per_minute ? rotations_per_minute : "0"]
			[rotation_network.overstressed ? "Overstressed" : "Stress:[round(((rotation_network?.used_stress / max(1, rotation_network?.total_stress)) * 100), 1)]%"]</span>"}

/obj/structure/LateInitialize()
	. = ..()
	if(rotation_structure)
		find_rotation_network()

/obj/structure/proc/update_animation_effect()
	return

/obj/structure/proc/find_rotation_network()
	var/turf/step_forward = get_step(src, dir)
	for(var/obj/structure/structure in step_forward.contents)
		if(structure.rotation_network)
			if(rotation_network)
				if(!structure.try_network_merge(src))
					rotation_break()
			else
				if(!structure.try_connect(src))
					rotation_break()

	var/turf/step_back = get_step(src, GLOB.reverse_dir[dir])
	for(var/obj/structure/structure in step_back.contents)
		if(structure.rotation_network)
			if(rotation_network)
				if(!structure.try_network_merge(src))
					rotation_break()
			else
				if(!structure.try_connect(src))
					rotation_break()

	if(!rotation_network)
		rotation_network = new
		rotation_network.add_connection(src)

/obj/structure/proc/set_rotational_direction_and_speed(direction, speed)
	set_rotations_per_minute(speed)
	rotation_direction = direction
	find_and_propagate(first = TRUE)
	rotation_network.check_stress()
	rotation_network.update_animation_effect()

/obj/structure/proc/set_rotational_speed(speed)
	set_rotations_per_minute(speed)
	find_and_propagate(first = TRUE)
	rotation_network.check_stress()
	rotation_network.update_animation_effect()

/obj/structure/proc/set_stress_generation(amount)
	rotation_network.total_stress -= stress_generation
	rotation_network.total_stress += amount
	stress_generation = amount
	rotation_network.check_stress()

/obj/structure/proc/set_stress_use(amount)
	rotation_network.used_stress -= last_stress_added
	rotation_network.used_stress += amount
	last_stress_added = amount
	stress_use = amount
	rotation_network.check_stress()

/obj/structure/proc/try_connect(obj/structure/connector)
	if(can_connect(connector))
		rotation_network.add_connection(connector)
		pass_rotation_data(connector)
		return TRUE
	return FALSE

/obj/structure/proc/can_connect(obj/structure/connector)
	if(connector.rotation_direction && connector.rotation_direction != rotation_direction)
		if(connector.rotations_per_minute && rotations_per_minute)
			return FALSE
	return TRUE

/obj/structure/proc/try_network_merge(obj/structure/connector)
	if(!can_connect(connector))
		return FALSE
	rotation_network.total_stress += connector.rotation_network.total_stress
	rotation_network.used_stress += connector.rotation_network.used_stress
	for(var/obj/structure/child in connector.rotation_network.connected)
		connector.rotation_network.remove_connection(child)
		rotation_network.add_connection(child)
	propagate_rotation_change(connector)
	return TRUE

/obj/structure/proc/propagate_rotation_change(obj/structure/connector, list/checked, first = FALSE)
	if(!length(checked))
		checked = list()
	checked |= src

	if(connector.stress_generation && connector.rotation_direction != rotation_direction)
		rotation_break()
		return
	connector.rotation_direction = rotation_direction
	if(!connector.stress_generator)
		connector.set_rotations_per_minute(rotations_per_minute)

	connector.find_and_propagate(checked, FALSE)
	if(first)
		connector.update_animation_effect()

/obj/structure/proc/find_and_propagate(list/checked, first = FALSE)
	if(!length(checked))
		checked = list()
	checked |= src

	var/turf/step_forward = get_step(src, dir)
	for(var/obj/structure/structure in step_forward.contents)
		if(structure in checked)
			continue
		if(structure.rotation_network)
			propagate_rotation_change(structure, checked, FALSE)

	var/turf/step_back = get_step(src, GLOB.reverse_dir[dir])
	if(step_back)
		for(var/obj/structure/structure in step_back.contents)
			if(structure.rotation_network)
				if(structure in checked)
					continue
				if(structure.rotation_network)
					propagate_rotation_change(structure, checked, FALSE)

	if(first)
		rotation_network?.update_animation_effect()

/obj/structure/proc/pass_rotation_data(obj/structure/connector, list/checked)
	if(!length(checked))
		checked = list()
	checked |= src

	if(connector.rotations_per_minute == rotations_per_minute)
		return

	if(connector.rotations_per_minute > rotations_per_minute)
		connector.propagate_rotation_change(src, first = TRUE)
	else
		propagate_rotation_change(connector, checked, FALSE)

/obj/structure/proc/rotation_break()
	visible_message(span_warning("[src] breaks apart from the opposing directions!"))
	playsound(src, 'sound/foley/cartdump.ogg', 75)
	qdel(src)

/obj/structure/proc/set_rotations_per_minute(speed)
	if(speed > 256)
		rotation_break()
		return FALSE
	rotations_per_minute = speed
	return TRUE

/obj/structure/proc/return_surrounding_rotation(datum/rotation_network/network)
	var/list/surrounding = list()

	var/turf/step_forward = get_step(src, dir)
	if(step_forward)
		for(var/obj/structure/structure in step_forward.contents)
			if(!(structure in network.connected))
				continue
			surrounding |= structure

	var/turf/step_back = get_step(src, GLOB.reverse_dir[dir])
	if(step_back)
		for(var/obj/structure/structure in step_back.contents)
			if(!(structure in network.connected))
				continue
			surrounding |= structure
	return surrounding

/obj/structure/proc/return_connected(obj/structure/deleted, list/passed, datum/rotation_network/network)
	var/list/surroundings = return_surrounding_rotation(network)
	var/list/connected = list()
	if(!length(passed))
		passed = list()
	passed |= src
	if(deleted in surroundings)
		surroundings -= deleted

	connected |= surroundings
	for(var/obj/structure/surrounding in surroundings)
		if(surrounding == src)
			continue
		if(surrounding in passed)
			continue
		connected |= surrounding.return_connected(deleted, passed, network)
	return connected
