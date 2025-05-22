/obj/structure/rotation_piece
	name = "shaft"

	layer = 5
	icon = 'icons/roguetown/misc/shafts_cogs.dmi'
	icon_state = "shaft"
	rotation_structure = TRUE
	initialize_dirs = CONN_DIR_FORWARD | CONN_DIR_FLIP

/obj/structure/rotation_piece/cog
	name = "cogwheel"

	icon_state = "1"

	cog_size = COG_SMALL
	stress_use = 3

/obj/structure/rotation_piece/cog/large
	name = "large cogwheel"

	icon_state = "l1"

	cog_size = COG_LARGE
	stress_use = 6

/obj/structure/rotation_piece/cog/large/Initialize()
	. = ..()
	var/matrix/skew = matrix()
	skew.Scale(1.5, 1.5)
	transform = skew

/obj/structure/rotation_piece/cog/can_connect(obj/structure/connector)
	if(connector.rotation_direction && rotation_direction && (connector.rotation_direction != rotation_direction))
		if(!istype(connector, /obj/structure/rotation_piece/cog) && !istype(connector, /obj/structure/water_pump))
			if(connector.rotations_per_minute && rotations_per_minute)
				return FALSE
	return TRUE

/obj/structure/rotation_piece/cog/find_rotation_network()
	for(var/direction in GLOB.cardinals)
		var/turf/step_back = get_step(src, direction)
		for(var/obj/structure/structure in step_back?.contents)
			if(QDELETED(structure.rotation_network))
				continue
			if(!(direction & dpdir)) // not in dpdir, check for cog structures
				if(!istype(structure, /obj/structure/rotation_piece/cog) && !istype(structure, /obj/structure/water_pump))
					continue
				if(structure.dir != dir && structure.dir != GLOB.reverse_dir[dir]) // cogs not oriented in same direction
					continue
			else if(!(REVERSE_DIR(direction) & structure.dpdir))
				continue

			if(rotation_network)
				if(!structure.try_network_merge(src))
					rotation_break()
			else
				if(!structure.try_connect(src))
					rotation_break()

	if(!rotation_network)
		rotation_network = new
		rotation_network.add_connection(src)
		last_stress_added = 0
		set_stress_use(stress_use)

/obj/structure/rotation_piece/cog/return_surrounding_rotation(datum/rotation_network/network)
	var/list/surrounding = list()

	for(var/direction in GLOB.cardinals)
		var/turf/step_back = get_step(src, direction)
		for(var/obj/structure/structure in step_back.contents)
			if(!(direction & dpdir)) // not in dpdir, check for cog structures
				if(!istype(structure, /obj/structure/rotation_piece/cog) && !istype(structure, /obj/structure/water_pump))
					continue
			else if(!(REVERSE_DIR(direction) & structure.dpdir))
				continue
			if(!(structure in network.connected))
				continue
			surrounding |= structure
	return surrounding

/obj/structure/rotation_piece/cog/update_animation_effect()
	if(!rotation_network || rotation_network?.overstressed || !rotations_per_minute || !rotation_network?.total_stress)
		animate(src, icon_state = "1", time = 1)
		return
	var/frame_stage = 1 / ((rotations_per_minute / 60) * 4)
	if(rotation_direction == WEST)
		animate(src, icon_state = "1", time = frame_stage, loop=-1)
		animate(icon_state = "2", time = frame_stage)
		animate(icon_state = "3", time = frame_stage)
		animate(icon_state = "4", time = frame_stage)
	else
		animate(src, icon_state = "4", time = frame_stage, loop=-1)
		animate(icon_state = "3", time = frame_stage)
		animate(icon_state = "2", time = frame_stage)
		animate(icon_state = "1", time = frame_stage)

/obj/structure/rotation_piece/cog/find_and_propagate(list/checked, first = FALSE)
	if(!length(checked))
		checked = list()
	checked |= src

	for(var/direction in GLOB.cardinals)
		var/turf/step_back = get_step(src, direction)
		if(!step_back)
			continue
		for(var/obj/structure/structure in step_back.contents)
			if(structure in checked)
				continue
			if(!(direction & dpdir))  // not in dpdir, check for cog structures
				if(!istype(structure, /obj/structure/rotation_piece/cog) && !istype(structure, /obj/structure/water_pump))
					continue
			else if(!(REVERSE_DIR(direction) & structure.dpdir))
				continue
			if(!(structure in rotation_network.connected))
				continue
			propagate_rotation_change(structure, checked, TRUE)
	if(first && rotation_network)
		rotation_network.update_animation_effect()

/obj/structure/rotation_piece/cog/propagate_rotation_change(obj/structure/connector, list/checked, first = FALSE)
	if(!length(checked))
		checked = list()
	checked |= src

	var/direction = get_dir(src, connector)
	if(direction != dir && direction != GLOB.reverse_dir[dir])
		if(istype(connector, /obj/structure/rotation_piece/cog))
			connector.rotation_direction = GLOB.reverse_dir[rotation_direction]
			connector.set_rotations_per_minute(get_speed_mod(connector))
		if(istype(connector, /obj/structure/water_pump))
			connector.rotation_direction = GLOB.reverse_dir[rotation_direction]
			connector.set_rotations_per_minute(rotations_per_minute)
	else
		if(connector.stress_generator && connector.rotation_direction && rotation_direction && (connector.rotation_direction != rotation_direction))
			rotation_break()
			return
		connector.rotation_direction = rotation_direction
		if(!connector.stress_generator)
			connector.set_rotations_per_minute(rotations_per_minute)

	connector.find_and_propagate(checked, FALSE)
	if(first)
		rotation_network.update_animation_effect()

/obj/structure/rotation_piece/cog/proc/get_speed_mod(obj/structure/connector)
	var/obj/structure/rotation_piece/cog = connector
	var/cog_ratio = cog_size / cog.cog_size
	return rotations_per_minute * cog_ratio

/obj/structure/rotation_piece/cog/large/update_animation_effect()
	if(!rotation_network || rotation_network?.overstressed || !rotations_per_minute || !rotation_network?.total_stress)
		animate(src, icon_state = "l1", time = 1)
		return
	var/frame_stage = 1 / ((rotations_per_minute / 60) * 4)
	if(rotation_direction == WEST)
		animate(src, icon_state = "l1", time = frame_stage, loop=-1)
		animate(icon_state = "l2", time = frame_stage)
		animate(icon_state = "l3", time = frame_stage)
		animate(icon_state = "l4", time = frame_stage)
	else
		animate(src, icon_state = "l4", time = frame_stage, loop=-1)
		animate(icon_state = "l3", time = frame_stage)
		animate(icon_state = "l2", time = frame_stage)
		animate(icon_state = "l1", time = frame_stage)
