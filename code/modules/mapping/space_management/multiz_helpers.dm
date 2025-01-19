/proc/get_step_multiz(ref, dir)
	if(dir & UP)
		dir &= ~UP
		return get_step(GET_TURF_ABOVE(get_turf(ref)), dir)
	if(dir & DOWN)
		dir &= ~DOWN
		return get_step(GET_TURF_BELOW(get_turf(ref)), dir)
	return get_step(ref, dir)

/proc/get_multiz_accessible_levels(center_z)
	. = list(center_z)
	var/other_z = center_z
	var/offset
	while((offset = SSmapping.multiz_levels[other_z][Z_LEVEL_DOWN]))
		other_z -= offset
		if(other_z in .)
			break	// no infinite loops
		. += other_z
	other_z = center_z
	while((offset = SSmapping.multiz_levels[other_z][Z_LEVEL_UP]))
		other_z += offset
		if(other_z in .)
			break	// no infinite loops
		. += other_z

/// A cache of stringified z-level zweb checks.
/// GLOB.zweb_cache[num2text(my_z)][num2text(compare_z)] = TRUE/FALSE
GLOBAL_LIST_EMPTY(zweb_cache)
/proc/is_in_zweb(my_z, compare_z)
	if(!my_z || !compare_z)
		return FALSE
	if(my_z == compare_z)
		return TRUE
	var/my_text = num2text(my_z)
	var/comp_text = num2text(compare_z)
	if(isnull(GLOB.zweb_cache[my_text]?[comp_text]))
		LAZYINITLIST(GLOB.zweb_cache[my_text])
		for(var/zlevel in get_multiz_accessible_levels(my_z))
			var/ztext = num2text(zlevel)
			GLOB.zweb_cache[my_text][ztext] = TRUE
			LAZYINITLIST(GLOB.zweb_cache[ztext])
			LAZYADD(GLOB.zweb_cache[ztext], my_text)
	return GLOB.zweb_cache[my_text][comp_text]

/proc/get_dir_multiz(turf/us, turf/them)
	us = get_turf(us)
	them = get_turf(them)
	if(!us || !them)
		return NONE
	if(us.z == them.z)
		return get_dir(us, them)
	else
		var/turf/T = GET_TURF_ABOVE(us)
		var/dir = NONE
		if(T && (T.z == them.z))
			dir = UP
		else
			T = GET_TURF_BELOW(us)
			if(T && (T.z == them.z))
				dir = DOWN
			else
				return get_dir(us, them)
		return (dir | get_dir(us, them))

/proc/dir_inverse_multiz(dir)
	var/holder = dir & (UP|DOWN)
	if((holder == NONE) || (holder == (UP|DOWN)))
		return turn(dir, 180)
	dir &= ~(UP|DOWN)
	dir = turn(dir, 180)
	if(holder == UP)
		holder = DOWN
	else
		holder = UP
	dir |= holder
	return dir
