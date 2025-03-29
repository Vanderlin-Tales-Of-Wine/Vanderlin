/*
A Star pathfinding algorithm
Returns a list of tiles forming a path from A to B, taking dense objects as well as walls, and the orientation of
windows along the route into account.
Use:
your_list = AStar(start location, end location, moving atom, distance proc, max nodes, maximum node depth, minimum distance to target, adjacent proc, atom id, turfs to exclude, check only simulated)

Optional extras to add on (in order):
Distance proc : the distance used in every A* calculation (length of path and heuristic)
MaxNodes: The maximum number of nodes the returned path can be (0 = infinite)
Maxnodedepth: The maximum number of nodes to search (default: 30, 0 = infinite)
Mintargetdist: Minimum distance to the target before path returns, could be used to get
near a target, but not right to it - for an AI mob with a gun, for example.
Adjacent proc : returns the turfs to consider around the actually processed node
Simulated only : whether to consider unsimulated turfs or not (used by some Adjacent proc)

Also added 'exclude' turf to avoid travelling over; defaults to null

Actual Adjacent procs :

	/turf/proc/reachableAdjacentTurfs : returns reachable turfs in cardinal directions (uses simulated_only)


*/
#define PF_TIEBREAKER 0.005
#define MASK_ODD 85
#define MASK_EVEN 170

/datum/PathNode
	var/turf/source
	var/datum/PathNode/prevNode
	var/f
	var/g
	var/h
	var/nt
	var/bf

/datum/PathNode/New(s, p, pg, ph, pnt, _bf)
	source = s
	prevNode = p
	g = pg
	h = ph
	f = g + h * (1 + PF_TIEBREAKER)
	nt = pnt
	bf = _bf

/datum/PathNode/proc/setp(p, pg, ph, pnt)
	prevNode = p
	g = pg
	h = ph
	f = g + h * (1 + PF_TIEBREAKER)
	nt = pnt

/datum/PathNode/proc/calc_f()
	f = g + h

/proc/PathWeightCompare(datum/PathNode/a, datum/PathNode/b)
	return a.f - b.f

/proc/HeapPathWeightCompare(datum/PathNode/a, datum/PathNode/b)
	return b.f - a.f

/proc/get_path_to(caller, end, dist, maxnodes, maxnodedepth = 30, mintargetdist, adjacent = /turf/proc/reachableTurftest, id = null, turf/exclude = null, simulated_only = TRUE, check_z_levels = TRUE)
	var/l = SSpathfinder.mobs.getfree(caller)
	while (!l)
		stoplag(3)
		l = SSpathfinder.mobs.getfree(caller)
	var/list/path = AStar(caller, end, dist, maxnodes, maxnodedepth, mintargetdist, adjacent, id, exclude, simulated_only, check_z_levels)
	SSpathfinder.mobs.found(l)
	if (!path)
		path = list()
	return path

/proc/AStar(caller, _end, dist, maxnodes, maxnodedepth = 30, mintargetdist, adjacent = /turf/proc/reachableTurftest, id = null, turf/exclude = null, simulated_only = TRUE, check_z_levels = TRUE)
	var/turf/end = get_turf(_end)
	var/turf/start = get_turf(caller)
	if (!start || !end)
		stack_trace("Invalid A* start or destination")
		return FALSE
	if (start == end)
		return FALSE
	if (maxnodes && start.Distance3D(end) > maxnodes)
		return FALSE
	if(maxnodes)
		maxnodedepth = maxnodes

	var/datum/Heap/open = new /datum/Heap(/proc/HeapPathWeightCompare)
	var/list/openc = new()
	var/list/path = null

	// Important: Initialize with bf=63 to enable all 6 directions (bits 0-5)
	var/datum/PathNode/cur = new /datum/PathNode(start, null, 0, start.Distance3D(end), 0, 63)
	open.Insert(cur)
	openc[start] = cur

	while (!open.IsEmpty() && !path)
		cur = open.Pop()

		// Destination check - must be exact match or valid closeenough on same Z-level
		var/is_destination = (cur.source == end)

		// Only consider "close enough" if on the same Z-level
		var/closeenough = FALSE
		if (!check_z_levels || cur.source.z == end.z)
			if (mintargetdist)
				closeenough = cur.source.Distance3D(end) <= mintargetdist
			else
				closeenough = cur.source.Distance3D(end) < 1

		if (is_destination || closeenough)
			path = new()
			path.Add(cur.source)
			while (cur.prevNode)
				cur = cur.prevNode
				path.Add(cur.source)
			break

		if (!maxnodedepth || cur.nt <= maxnodedepth)
			// Process all 6 directions (bits 0-5)
			for (var/i = 0 to 5)
				var/f = 1 << i
				if (cur.bf & f)
					var/turf/T

					if (i < 4) // Cardinal directions (bits 0-3)
						T = get_step(cur.source, 1 << i)
					else // Z-level movement (bits 4-5)
						// Only process z-level movement if check_z_levels is TRUE
						if (!check_z_levels)
							continue
						T = get_turf_zchange(cur.source, i)

					if (!T || T == exclude)
						continue

					var/datum/PathNode/CN = openc[T]

					// Calculate reverse direction (for 2D only; z-level is handled differently)
					var/r
					if (i < 4) // For cardinal directions
						r = ((f & MASK_ODD) << 1) | ((f & MASK_EVEN) >> 1)
					else // For z-level movement
						r = 1 << (9 - i) // bit 4 (UP) corresponds to bit 5 (DOWN) and vice versa

					var/newg = cur.g + cur.source.Distance3D(T)

					newg += cur.source.path_weight
					// Apply a larger penalty for changing z-levels to prefer same-level paths
					if (i >= 4 && check_z_levels)
						newg += 10 // Increased penalty to make same-level paths more preferred

					if (CN)
						if (i < 4)
							CN.bf &= ~r // Clear reverse cardinal direction
						else
							CN.bf &= ~(1 << (9 - i)) // Clear reverse z-level direction

						if (newg < CN.g && cur.source.reachableTurftest(caller, T, id, simulated_only))
							CN.setp(cur, newg, CN.h, cur.nt + 1)
							open.ReSort(CN)
					else if (cur.source.reachableTurftest(caller, T, id, simulated_only))
						// For new nodes, initialize with all directions except the one we came from
						var/new_bf = 63
						if (i < 4)
							new_bf &= ~r
						else
							new_bf &= ~(1 << (9 - i))

						CN = new(T, cur, newg, T.Distance3D(end), cur.nt + 1, new_bf)
						open.Insert(CN)
						openc[T] = CN

		cur.bf = 0 // Mark as processed
		CHECK_TICK

	if (path)
		for (var/i = 1 to round(0.5 * path.len))
			path.Swap(i, path.len - i + 1)

	openc = null
	return path

/proc/get_turf_zchange(turf/T, dir)
	if (!T)
		return null

	// Check for up/down movement via stairs
	if (dir == 4) // UP
		// Look for stairs at current location
		for (var/obj/structure/stairs/S in T.contents)
			// Get the turf above in the stair's direction
			var/turf/above = get_step_multiz(T, UP)
			if (!above || !isopenturf(above))
				continue

			var/turf/dest = get_step(above, S.dir)
			// Check for matching stairs in the destination
			for (var/obj/structure/stairs/S2 in dest.contents)
				if (S2.dir == S.dir)
					return dest

	else if (dir == 5) // DOWN
		// Look for stairs at current location that lead down
		var/turf/below = get_step_multiz(T, DOWN)
		if (!below || !isopenturf(below))
			return null

		// First check if there are stairs in the current turf leading down
		for (var/obj/structure/stairs/S in T.contents)
			// Destination would be the turf below in the stair's direction
			var/turf/dest = get_step(below, S.dir)
			if (dest && !dest.density)
				return dest

		// If no stairs in current turf, check for stairs in adjacent turfs that might lead to below
		for (var/turf/adjacent in get_adjacent_open_turfs(T))
			for (var/obj/structure/stairs/S in adjacent.contents)
				var/turf/adjacent_below = get_step_multiz(adjacent, DOWN)
				// If these stairs lead to our target floor
				var/turf/dest = get_step(adjacent_below, GLOB.reverse_dir[S.dir])
				if (dest && !dest.density)
					return dest

	return null

/turf/proc/reachableTurftest(caller, turf/T, ID, simulated_only = TRUE, check_z_levels = TRUE)
	if (!T || !istype(T))
		return FALSE

	if (T.density)
		return FALSE

	if (is_type_in_typecache(T, GLOB.dangerous_turfs))
		if(istype(T, /turf/open/transparent))
			var/turf/open/below_turf = GET_TURF_BELOW(T)
			var/obj/structure/stairs/S = locate(/obj/structure/stairs/) in below_turf.contents
			if(!S)
				return FALSE
		else
			return FALSE

	// Same z-level movement - use standard check
	if (!check_z_levels || T.z == z)
		return !LinkBlockedWithAccess(T, caller, ID)

	// Z-level transition - check if it's a valid stair transition
	if (check_z_levels && abs(T.z - z) == 1)
		if (T.z > z) // Moving up
			// Check if we can reach T via stairs
			var/turf/stair_dest = get_turf_zchange(src, 4) // 4 = UP
			return (stair_dest == T) && !LinkBlockedWithAccess(T, caller, ID)
		else // Moving down
			// Check if we can reach T via stairs
			var/turf/stair_dest = get_turf_zchange(src, 5) // 5 = DOWN

			// Only consider the destination valid if it came from get_turf_zchange
			// This prevents the pathfinder from considering direct below/above turfs as valid
			return (stair_dest == T) && !LinkBlockedWithAccess(T, caller, ID)

	return FALSE

// Add a helper function to compute 3D Manhattan distance
/turf/proc/Distance3D(turf/T)
	if (!T || !istype(T))
		return 0
	var/dx = abs(x - T.x)
	var/dy = abs(y - T.y)
	var/dz = abs(z - T.z) * 5 // Weight z-level differences higher
	return (dx + dy + dz)

/turf/proc/LinkBlockedWithAccess(turf/T, caller, ID)
	var/adir = get_dir(src, T)
	var/rdir = ((adir & MASK_ODD)<<1)|((adir & MASK_EVEN)>>1)
	for(var/obj/O in T)
		if(!O.CanAStarPass(ID, rdir, caller))
			return TRUE
	for(var/obj/O in src)
		if(!O.CanAStarPass(ID, adir, caller))
			return TRUE

	for(var/mob/living/M in T)
		if(!M.CanPass(caller, src))
			return TRUE
	for(var/obj/structure/M in T)
		if(!M.CanPass(caller, src))
			return TRUE
	return FALSE
