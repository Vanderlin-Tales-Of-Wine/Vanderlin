
/obj/structure/waterwheel
	name = "waterwheel"

	icon = 'icons/roguetown/misc/waterwheel.dmi'
	icon_state = "1"

	layer = 5
	stress_generator = TRUE
	rotation_structure = TRUE

/obj/structure/waterwheel/LateInitialize()
	. = ..()
	var/turf/open/water/river/water = get_turf(src)
	if(!istype(water))
		return
	if(water.water_volume)
		set_rotational_direction_and_speed(water.dir, 8)
		set_stress_generation(1024)

/obj/structure/waterwheel/update_animation_effect()
	if(!rotation_network || rotation_network?.overstressed || !rotations_per_minute)
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

/obj/structure/waterwheel/set_rotations_per_minute(speed)
	. = ..()
