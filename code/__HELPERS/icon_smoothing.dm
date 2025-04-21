//generic (by snowflake) tile smoothing code; smooth your icons with this!
/*
	Each tile is divided in 4 corners, each corner has an appearance associated to it; the tile is then overlayed by these 4 appearances
	To use this, just set your atom's 'smoothing_flags' var to 1. If your atom can be moved/unanchored, set its 'can_be_unanchored' var to 1.
	If you don't want your atom's icon to smooth with anything but atoms of the same type, set the list 'smoothing_list' to null;
	Otherwise, put all the smoothing groups you want the atom icon to smooth with in 'smoothing_list', including the group of the atom itself.
	Smoothing groups are just shared flags between objects. If one of the 'smoothing_list' of A matches one of the `smoothing_groups` of B, then A will smooth with B.
	Each atom has its own icon file with all the possible corner states. See 'smooth_wall.dmi' for a template.
	DIAGONAL SMOOTHING INSTRUCTIONS
	To make your atom smooth diagonally you need all the proper icon states (see 'smooth_wall.dmi' for a template) and
	to add the 'SMOOTH_DIAGONAL_CORNERS_CORNERS' flag to the atom's smoothing_flags var (in addition to either SMOOTH_TRUE or SMOOTH_MORE).
	For turfs, what appears under the diagonal corners depends on the turf that was in the same position previously: if you make a wall on
	a plating floor, you will see plating under the diagonal wall corner, if it was space, you will see space.
	If you wish to map a diagonal wall corner with a fixed underlay, you must configure the turf's 'fixed_underlay' list var, like so:
		fixed_underlay = list("icon"='icon_file.dmi', "icon_state"="iconstatename")
	A non null 'fixed_underlay' list var will skip copying the previous turf appearance and always use the list. If the list is
	not set properly, the underlay will default to regular floor plating.
	To see an example of a diagonal wall, see '/turf/closed/wall/mineral/titanium' and its subtypes.
*/

// Components of a smoothing junction
// Redefinitions of the diagonal directions so they can be stored in one var without conflicts
#define NORTH_JUNCTION		NORTH //(1<<0)
#define SOUTH_JUNCTION		SOUTH //(1<<1)
#define EAST_JUNCTION		EAST  //(1<<2)
#define WEST_JUNCTION		WEST  //(1<<3)
#define NORTHEAST_JUNCTION	(1<<4)
#define SOUTHEAST_JUNCTION	(1<<5)
#define SOUTHWEST_JUNCTION	(1<<6)
#define NORTHWEST_JUNCTION	(1<<7)

DEFINE_BITFIELD(smoothing_junction, list(
	"NORTH_JUNCTION" = NORTH_JUNCTION,
	"SOUTH_JUNCTION" = SOUTH_JUNCTION,
	"EAST_JUNCTION" = EAST_JUNCTION,
	"WEST_JUNCTION" = WEST_JUNCTION,
	"NORTHEAST_JUNCTION" = NORTHEAST_JUNCTION,
	"SOUTHEAST_JUNCTION" = SOUTHEAST_JUNCTION,
	"SOUTHWEST_JUNCTION" = SOUTHWEST_JUNCTION,
	"NORTHWEST_JUNCTION" = NORTHWEST_JUNCTION,
))

#define NO_ADJ_FOUND 0
#define ADJ_FOUND 1
#define NULLTURF_BORDER 2

#define DEFAULT_UNDERLAY_ICON 			'icons/turf/floors.dmi'
#define DEFAULT_UNDERLAY_ICON_STATE 	"plating"

#define SET_ADJ_IN_DIR(source, junction, direction, direction_flag) \
	do { \
		var/turf/neighbor = get_step(source, direction); \
		if(!neighbor) { \
			if(source.smoothing_flags & SMOOTH_BORDER) { \
				junction |=  direction_flag; \
			}; \
		}; \
		else { \
			if(!isnull(neighbor.smoothing_groups)) { \
				for(var/target in source.smoothing_list) { \
					if(!(source.smoothing_list[target] & neighbor.smoothing_groups[target])) { \
						continue; \
					}; \
					junction |= direction_flag; \
					break; \
				}; \
			}; \
			if(!(junction & direction_flag) && source.smoothing_flags & SMOOTH_OBJ) { \
				for(var/obj/thing in neighbor) { \
					if(!thing.anchored || isnull(thing.smoothing_groups)) { \
						continue; \
					}; \
					for(var/target in source.smoothing_list) { \
						if(!(source.smoothing_list[target] & thing.smoothing_groups[target])) { \
							continue; \
						}; \
						junction |= direction_flag; \
						break; \
					}; \
					if(junction & direction_flag) { \
						break; \
					}; \
				}; \
			}; \
		}; \
	} while(FALSE)

///Scans all adjacent turfs to find targets to smooth with.
/atom/proc/calculate_adjacencies()
	. = NONE

	if(!loc)
		return

	for(var/direction in GLOB.cardinals)
		switch(find_type_in_direction(direction))
			if(NULLTURF_BORDER)
				if((smoothing_flags & SMOOTH_BORDER))
					. |= direction //BYOND and smooth dirs are the same for cardinals
			if(ADJ_FOUND)
				. |= direction //BYOND and smooth dirs are the same for cardinals

	if(. & NORTH_JUNCTION)
		if(. & WEST_JUNCTION)
			switch(find_type_in_direction(NORTHWEST))
				if(NULLTURF_BORDER)
					if((smoothing_flags & SMOOTH_BORDER))
						. |= NORTHWEST_JUNCTION
				if(ADJ_FOUND)
					. |= NORTHWEST_JUNCTION

		if(. & EAST_JUNCTION)
			switch(find_type_in_direction(NORTHEAST))
				if(NULLTURF_BORDER)
					if((smoothing_flags & SMOOTH_BORDER))
						. |= NORTHEAST_JUNCTION
				if(ADJ_FOUND)
					. |= NORTHEAST_JUNCTION

	if(. & SOUTH_JUNCTION)
		if(. & WEST_JUNCTION)
			switch(find_type_in_direction(SOUTHWEST))
				if(NULLTURF_BORDER)
					if((smoothing_flags & SMOOTH_BORDER))
						. |= SOUTHWEST_JUNCTION
				if(ADJ_FOUND)
					. |= SOUTHWEST_JUNCTION

		if(. & EAST_JUNCTION)
			switch(find_type_in_direction(SOUTHEAST))
				if(NULLTURF_BORDER)
					if((smoothing_flags & SMOOTH_BORDER))
						. |= SOUTHEAST_JUNCTION
				if(ADJ_FOUND)
					. |= SOUTHEAST_JUNCTION


/atom/movable/calculate_adjacencies()
	// if(can_be_unanchored && !anchored)
	// 	return NONE
	return ..()


//do not use, use QUEUE_SMOOTH(atom)
/atom/proc/smooth_icon()
	if(QDELETED(src))
		return
	smoothing_flags &= ~SMOOTH_QUEUED
	if (!z)
		CRASH("[type] called smooth_icon() without being on a z-level")
	if(smoothing_flags & (SMOOTH_BITMASK|SMOOTH_BITMASK_CARDINALS))
		bitmask_smooth()
	if(smoothing_flags & SMOOTH_EDGE)
		if(isturf(src))
			var/turf/T = src
			T.edge_cardinal_smooth(calculate_adjacencies())
		else
			CRASH("SMOOTH_EDGE set on non-compatible atom for [src]! Requires turf.")

/turf/proc/edge_cardinal_smooth(adjacencies)
	var/list/New
	var/turf/used
	var/holder

	for(var/A in neighborlay_list)
		cut_overlay("[A]")
		neighborlay_list -= A

	if(adjacencies & NORTH_JUNCTION)
		used = get_step(src, NORTH)
		if(isturf(used) && (type != used.type))
			var/turf/T = used
			if(neighborlay_override)
				holder = "[neighborlay_override]-n"
				LAZYADD(New, holder)
				neighborlay_list += holder
			else if(T.neighborlay)
				holder = "[T.neighborlay]-n"
				LAZYADD(New, holder)
				neighborlay_list += holder
	if(adjacencies & SOUTH_JUNCTION)
		used = get_step(src, SOUTH)
		if(isturf(used) && (type != used.type))
			var/turf/T = used
			if(neighborlay_override)
				holder = "[neighborlay_override]-s"
				LAZYADD(New, holder)
				neighborlay_list += holder
			else if(T.neighborlay)
				holder = "[T.neighborlay]-s"
				LAZYADD(New, holder)
				neighborlay_list += holder
	if(adjacencies & WEST_JUNCTION)
		used = get_step(src, WEST)
		if(isturf(used) && (type != used.type))
			var/turf/T = used
			if(neighborlay_override)
				holder = "[neighborlay_override]-w"
				LAZYADD(New, holder)
				neighborlay_list += holder
			else if(T.neighborlay)
				holder = "[T.neighborlay]-w"
				LAZYADD(New, holder)
				neighborlay_list += holder
	if(adjacencies & EAST_JUNCTION)
		used = get_step(src, EAST)
		if(isturf(used) && (type != used.type))
			var/turf/T = used
			if(neighborlay_override)
				holder = "[neighborlay_override]-e"
				LAZYADD(New, holder)
				neighborlay_list += holder
			else if(T.neighborlay)
				holder = "[T.neighborlay]-e"
				LAZYADD(New, holder)
				neighborlay_list += holder

	if(New)
		add_overlay(New)
	return New

///Scans direction to find targets to smooth with.
/atom/proc/find_type_in_direction(direction)
	var/turf/target_turf = get_step(src, direction)
	if(!target_turf)
		return NULLTURF_BORDER

	if(isnull(smoothing_list)) //special case in which it will only smooth with itself
		if(isturf(src))
			return (type == target_turf.type) ? ADJ_FOUND : NO_ADJ_FOUND
		var/atom/matching_obj = locate(type) in target_turf
		return (matching_obj && matching_obj.type == type) ? ADJ_FOUND : NO_ADJ_FOUND

	if(!isnull(target_turf.smoothing_groups))
		for(var/target in smoothing_list)
			if(!(smoothing_list[target] & target_turf.smoothing_groups[target]))
				continue
			return ADJ_FOUND

	if(smoothing_flags & SMOOTH_OBJ)
		for(var/am in target_turf)
			var/atom/movable/thing = am
			if(!thing.anchored || isnull(thing.smoothing_groups))
				continue
			for(var/target in smoothing_list)
				if(!(smoothing_list[target] & thing.smoothing_groups[target]))
					continue
				return ADJ_FOUND

	return NO_ADJ_FOUND

/**
  * Basic smoothing proc. The atom checks for adjacent directions to smooth with and changes the icon_state based on that.
  *
  * Returns the previous smoothing_junction state so the previous state can be compared with the new one after the proc ends, and see the changes, if any.
  *
*/
/atom/proc/bitmask_smooth()
	var/new_junction = NONE

	for(var/direction in GLOB.cardinals) //Cardinal case first.
		SET_ADJ_IN_DIR(src, new_junction, direction, direction)

	if(smoothing_flags & SMOOTH_BITMASK_CARDINALS || !(new_junction & (NORTH|SOUTH)) || !(new_junction & (EAST|WEST)))
		set_smoothed_icon_state(new_junction)
		return

	if(new_junction & NORTH_JUNCTION)
		if(new_junction & WEST_JUNCTION)
			SET_ADJ_IN_DIR(src, new_junction, NORTHWEST, NORTHWEST_JUNCTION)

		if(new_junction & EAST_JUNCTION)
			SET_ADJ_IN_DIR(src, new_junction, NORTHEAST, NORTHEAST_JUNCTION)

	if(new_junction & SOUTH_JUNCTION)
		if(new_junction & WEST_JUNCTION)
			SET_ADJ_IN_DIR(src, new_junction, SOUTHWEST, SOUTHWEST_JUNCTION)

		if(new_junction & EAST_JUNCTION)
			SET_ADJ_IN_DIR(src, new_junction, SOUTHEAST, SOUTHEAST_JUNCTION)

	set_smoothed_icon_state(new_junction)

///Changes the icon state based on the new junction bitmask.
/atom/proc/set_smoothed_icon_state(new_junction)
	icon_state = "[initial(icon_state)]-[new_junction]"

//Icon smoothing helpers
/proc/smooth_zlevel(zlevel, now = FALSE)
	var/list/away_turfs = block(locate(1, 1, zlevel), locate(world.maxx, world.maxy, zlevel))
	for(var/V in away_turfs)
		var/turf/T = V
		if(T.smoothing_flags & USES_SMOOTHING)
			if(now)
				T.smooth_icon()
			else
				QUEUE_SMOOTH(T)
		for(var/R in T)
			var/atom/A = R
			if(A.smoothing_flags & USES_SMOOTHING)
				if(now)
					A.smooth_icon()
				else
					QUEUE_SMOOTH(A)

/proc/reverse_ndir(ndir)
	switch(ndir)
		if(NORTH_JUNCTION)
			return NORTH
		if(SOUTH_JUNCTION)
			return SOUTH
		if(WEST_JUNCTION)
			return WEST
		if(EAST_JUNCTION)
			return EAST
		if(NORTHWEST_JUNCTION)
			return NORTHWEST
		if(NORTHEAST_JUNCTION)
			return NORTHEAST
		if(SOUTHEAST_JUNCTION)
			return SOUTHEAST
		if(SOUTHWEST_JUNCTION)
			return SOUTHWEST
		if(NORTH_JUNCTION|WEST_JUNCTION)
			return NORTHWEST
		if(NORTH_JUNCTION|EAST_JUNCTION)
			return NORTHEAST
		if(SOUTH_JUNCTION|WEST_JUNCTION)
			return SOUTHWEST
		if(SOUTH_JUNCTION|EAST_JUNCTION)
			return SOUTHEAST
		if(NORTH_JUNCTION|WEST_JUNCTION|NORTHWEST_JUNCTION)
			return NORTHWEST
		if(NORTH_JUNCTION|EAST_JUNCTION|NORTHEAST_JUNCTION)
			return NORTHEAST
		if(SOUTH_JUNCTION|WEST_JUNCTION|SOUTHWEST_JUNCTION)
			return SOUTHWEST
		if(SOUTH_JUNCTION|EAST_JUNCTION|SOUTHEAST_JUNCTION)
			return SOUTHEAST
		else
			return NONE

#undef NORTH_JUNCTION
#undef SOUTH_JUNCTION
#undef EAST_JUNCTION
#undef WEST_JUNCTION
#undef NORTHEAST_JUNCTION
#undef NORTHWEST_JUNCTION
#undef SOUTHEAST_JUNCTION
#undef SOUTHWEST_JUNCTION

#undef NO_ADJ_FOUND
#undef ADJ_FOUND
#undef NULLTURF_BORDER

#undef DEFAULT_UNDERLAY_ICON
#undef DEFAULT_UNDERLAY_ICON_STATE
