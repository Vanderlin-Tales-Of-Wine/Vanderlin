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

//do not use, use QUEUE_SMOOTH(atom)
/atom/proc/smooth_icon()
	if(QDELETED(src))
		return
	smoothing_flags &= ~SMOOTH_QUEUED
	if (!z)
		CRASH("[type] called smooth_icon() without being on a z-level")
	if(smoothing_flags & (SMOOTH_BITMASK|SMOOTH_BITMASK_CARDINALS))
		smooth()
	if(smoothing_flags & SMOOTH_EDGE)
		smooth(edge = TRUE)

/**
  * Basic smoothing proc. The atom checks for adjacent directions to smooth with and changes the icon_state based on that.
  *
  * Returns the previous smoothing_junction state so the previous state can be compared with the new one after the proc ends, and see the changes, if any.
  *
*/
/atom/proc/smooth(edge = FALSE)
	var/new_junction = NONE

	// cache for sanic speed
	var/smoothing_list = src.smoothing_list

	var/smooth_border = (smoothing_flags & SMOOTH_BORDER)
	var/smooth_obj = (smoothing_flags & SMOOTH_OBJ)

	#define SET_ADJ_IN_DIR(direction, direction_flag) \
		set_adj_in_dir: { \
			do { \
				var/turf/neighbor = get_step(src, direction); \
				if(neighbor) { \
					if(smoothing_list) { \
						var/neighbor_smoothing_groups = neighbor.smoothing_groups; \
						if(neighbor_smoothing_groups) { \
							for(var/target as anything in smoothing_list) { \
								if(smoothing_list[target] & neighbor_smoothing_groups[target]) { \
									new_junction |= direction_flag; \
									break set_adj_in_dir; \
								}; \
							}; \
						}; \
						if(smooth_obj) { \
							for(var/atom/movable/thing as anything in neighbor) { \
								var/thing_smoothing_groups = thing.smoothing_groups; \
								if(!thing.anchored || isnull(thing_smoothing_groups)) { \
									continue; \
								}; \
								for(var/target in smoothing_list) { \
									if(smoothing_list[target] & thing_smoothing_groups[target]) { \
										new_junction |= direction_flag; \
										break set_adj_in_dir; \
									}; \
								}; \
							}; \
						}; \
					} else if (type == neighbor.type) { \
						new_junction |= direction_flag; \
						break set_adj_in_dir; \
					}; \
				} else if (smooth_border) { \
					new_junction |= direction_flag; \
				}; \
				break set_adj_in_dir; \
			} while(FALSE) \
		}

	for(var/direction as anything in GLOB.cardinals) //Cardinal case first.
		SET_ADJ_IN_DIR(direction, direction)

	if(smoothing_flags & ONLY_CARDINAL || !(new_junction & (NORTH|SOUTH)) || !(new_junction & (EAST|WEST)))
		if(edge && isturf(src))
			if(isturf(src))
				var/turf/T = src
				T.set_edge_overlays(new_junction)
			return
		set_smoothed_icon_state(new_junction)
		return

	if(new_junction & NORTH_JUNCTION)
		if(new_junction & WEST_JUNCTION)
			SET_ADJ_IN_DIR(NORTHWEST, NORTHWEST_JUNCTION)

		if(new_junction & EAST_JUNCTION)
			SET_ADJ_IN_DIR(NORTHEAST, NORTHEAST_JUNCTION)

	if(new_junction & SOUTH_JUNCTION)
		if(new_junction & WEST_JUNCTION)
			SET_ADJ_IN_DIR(SOUTHWEST, SOUTHWEST_JUNCTION)

		if(new_junction & EAST_JUNCTION)
			SET_ADJ_IN_DIR(SOUTHEAST, SOUTHEAST_JUNCTION)

	set_smoothed_icon_state(new_junction)

	#undef SET_ADJ_IN_DIR

///Changes the icon state based on the new junction bitmask.
/atom/proc/set_smoothed_icon_state(new_junction)
	icon_state = "[initial(icon_state)]-[new_junction]"

/turf/proc/set_edge_overlays(new_junction)
	var/adjacencies = new_junction
	if(adjacencies == NONE)
		return
	if(adjacencies & NORTH)
		var/turf/T = get_step(src, NORTH)
		handle_edge_icon(T, NORTH)

	if(adjacencies & SOUTH)
		var/turf/T = get_step(src, SOUTH)
		handle_edge_icon(T, SOUTH)

	if(adjacencies & EAST)
		var/turf/T = get_step(src, EAST)
		handle_edge_icon(T, EAST)

	if(adjacencies & WEST)
		var/turf/T = get_step(src, WEST)
		handle_edge_icon(T, WEST)

/turf/proc/handle_edge_icon(turf/T, dir)
	if(!isturf(T))
		if(smoothing_flags & SMOOTH_BORDER && neighborlay_override)
			replace_neighborlay(dir, neighborlay_override)
		return
	if(type == T.type)
		return
	if(neighborlay_override)
		replace_neighborlay(dir, neighborlay_override)
		return
	if(neighborlay)
		T.replace_neighborlay(REVERSE_DIR(dir), neighborlay)

/turf/proc/replace_neighborlay(dir, icon)
	var/add
	switch(dir)
		if(NORTH)
			add = "[icon]-n"
		if(SOUTH)
			add = "[icon]-s"
		if(EAST)
			add = "[icon]-e"
		if(WEST)
			add = "[icon]-w"

	if(!add)
		return
	remove_neighborlay(dir)
	LAZYADDASSOC(neighborlay_list, "[dir]", add)
	add_overlay(add)

/turf/proc/remove_neighborlay(dir)
	if(LAZYACCESS(neighborlay_list, "[dir]"))
		cut_overlay(neighborlay_list["[dir]"])
		LAZYREMOVE(neighborlay_list, "[dir]")

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
