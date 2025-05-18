
/obj/structure/minecart_rail
	name = "cart rail"
	desc = "Carries carts along the track."
	icon = 'icons/obj/track.dmi'
	icon_state = "track"
	//layer = TRAM_RAIL_LAYER
	plane = FLOOR_PLANE
	anchored = TRUE
	move_resist = INFINITY

	rotation_structure = TRUE
	stress_use = 64
	redstone_structure = TRUE
	initialize_dirs = CONN_DIR_LEFT | CONN_DIR_RIGHT

	var/secondary_direction

	var/static/list/directions = list(
		"South Left Turn" = SOUTHWEST,
		"South Right Turn" = SOUTHEAST,
		"North Left Turn" = NORTHEAST,
		"North Right Turn" = NORTHWEST,
		"Straight" = NORTH,
		"Sideways" = WEST,
	)

/obj/structure/minecart_rail/Initialize(mapload)
	. = ..()
	//AddElement(/datum/element/give_turf_traits, string_list(list(TRAIT_TURF_IGNORE_SLOWDOWN)))
	//AddElement(/datum/element/footstep_override, footstep = FOOTSTEP_CATWALK)
	for(var/obj/structure/closet/crate/miningcar/cart in loc)
		cart.update_rail_state(TRUE)

	for(var/direction in GLOB.cardinals)
		if(direction != dir && direction != GLOB.reverse_dir[dir])
			continue
		var/turf/step_up = GET_TURF_ABOVE(get_step(src, direction))
		var/turf/step_down = GET_TURF_BELOW(get_step(src, direction))
		var/turf/step_side = get_step(src, direction)
		var/turf/above_turf = GET_TURF_ABOVE(get_turf(src))

		if(step_up && istype(above_turf, /turf/open/transparent/openspace))
			for(var/obj/structure/minecart_rail/rail in step_up.contents)
				if(direction != rail.dir && direction != GLOB.reverse_dir[rail.dir])
					continue
				if(dir == WEST || dir == EAST)
					pixel_y = 7
				icon_state = "vertical_track"
				dir = direction

		if(step_down && istype(step_side, /turf/open/transparent/openspace))
			for(var/obj/structure/minecart_rail/rail in step_down.contents)
				if(direction != rail.dir && direction != GLOB.reverse_dir[rail.dir])
					continue
				if(dir == WEST || dir == EAST)
					rail.pixel_y = 7
				rail.icon_state = "vertical_track"

/obj/structure/minecart_rail/redstone_triggered(mob/user)
	. = ..()
	if(!secondary_direction)
		return
	var/last_direction = secondary_direction
	secondary_direction = dir
	setDir(last_direction)

/obj/structure/minecart_rail/attack_right(mob/user)
	. = ..()
	var/obj/item/held_item = user.get_active_held_item()
	if(held_item?.tool_behaviour & TOOL_MULTITOOL)
		rotate_direction(user)
		return

	var/choice = browser_input_list(user, "Choose a direction to have it cycle to.", src, list("South Left Turn", "South Right Turn", "North Right Turn", "Straight", "Sideways", "North Left Turn"))
	if(!choice)
		return

	secondary_direction = directions[choice]

/obj/structure/minecart_rail/proc/rotate_direction(mob/user)
	var/choice = browser_input_list(user, "Choose a direction to rotate it.", src, list("South Left Turn", "South Right Turn", "North Right Turn", "Straight", "Sideways", "North Left Turn"))
	if(!choice)
		return

	playsound(src, 'sound/misc/ratchet.ogg', 20, TRUE)
	setDir(directions[choice])

/obj/structure/minecart_rail/update_animation_effect()
	. = ..()
	if(rotations_per_minute)
		icon_state = "track_shaft"
	else
		icon_state = "track"

/obj/structure/minecart_rail/find_rotation_network()
	if(ISDIAGONALDIR(dir))
		return
	for(var/direction in GLOB.cardinals)
		if(!(direction & dpdir))
			continue
		var/turf/step_back = get_step(src, direction)
		for(var/obj/structure/structure in step_back.contents)
			if(!structure.rotation_network)
				continue
			if(istype(structure, /obj/structure/minecart_rail))
				if(!(REVERSE_DIR(direction) & structure.dpdir))
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

/obj/structure/minecart_rail/return_surrounding_rotation(datum/rotation_network/network)
	if(!(dir in GLOB.cardinals))
		return list()
	. = ..()

/obj/structure/minecart_rail/find_and_propagate(list/checked, first = FALSE)
	if(!length(checked))
		checked = list()
	checked |= src
	if(ISDIAGONALDIR(dir))
		return checked
	. = ..()

/obj/structure/minecart_rail/set_rotations_per_minute(speed)
	. = ..()
	if(!.)
		return
	set_stress_use(32 * (speed / 8))

/obj/structure/minecart_rail/examine(mob/user)
	. = ..()
	. += rail_examine()

/obj/structure/minecart_rail/proc/rail_examine()
	return span_notice("Connect this rail to shafts to give momentum to carts that pass over.")

/obj/structure/minecart_rail/set_connection_dir()
	if(ISDIAGONALDIR(dir))
		dpdir = NONE
		return
	. = ..()

/obj/structure/minecart_rail/railbreak
	name = "cart rail brake"
	desc = "Stops carts in their tracks. On the tracks. You get what I mean."
	icon_state = "track_break"
	can_buckle = TRUE
	buckle_requires_restraints = TRUE
	var/force_disabled = FALSE
	//buckle_lying = NO_BUCKLE_LYING

/obj/structure/minecart_rail/railbreak/rail_examine()
	return span_notice("Connect this rail to shafts to stop carts that pass over it. Currently [force_disabled ? "disabled" : (rotations_per_minute ? "powered" : "unpowered")]")

/obj/structure/minecart_rail/railbreak/redstone_triggered(mob/user)
	force_disabled = !force_disabled
