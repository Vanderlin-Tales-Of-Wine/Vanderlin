/obj/structure/gearbox
	name = "gearbox"
	icon = 'icons/obj/rotation_machines.dmi'
	icon_state = "gearbox-horizontal"

	rotation_structure = TRUE

/obj/structure/gearbox/find_rotation_network()

	for(var/direction in GLOB.cardinals)
		var/turf/step_back = get_step(src, direction)
		for(var/obj/structure/structure in step_back.contents)
			if(structure.dir != direction && structure.dir != GLOB.reverse_dir[direction])
				continue
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

/obj/structure/gearbox/return_surrounding_rotation(datum/rotation_network/network)
	var/list/surrounding = list()

	for(var/direction in GLOB.cardinals)
		var/turf/step_back = get_step(src, direction)
		for(var/obj/structure/structure in step_back.contents)
			if(!(structure in network.connected))
				continue
			surrounding |= structure

/obj/structure/gearbox/find_and_propagate(list/checked, first = FALSE)
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
			if(!(structure in rotation_network.connected))
				continue
			propagate_rotation_change(structure, checked, TRUE)

	if(first && rotation_network)
		rotation_network.update_animation_effect()
