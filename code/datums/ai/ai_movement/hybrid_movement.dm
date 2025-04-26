///Uses Byond's basic obstacle avoidance mvovement unless the target is on a z-level different to ours
/datum/ai_movement/hybrid_pathing
	requires_processing = TRUE
	max_pathing_attempts = 12
	max_path_distance = 30
	var/fallbacking = FALSE
	var/fallback_fail = 0

/datum/ai_movement/hybrid_pathing/process(delta_time)
	for(var/datum/ai_controller/controller as anything in moving_controllers)
		if(!COOLDOWN_FINISHED(controller, movement_cooldown))
			continue
		COOLDOWN_START(controller, movement_cooldown, controller.movement_delay)

		var/atom/movable/movable_pawn = controller.pawn
		var/turf/target_turf = get_step_towards(movable_pawn, controller.current_movement_target)
		var/turf/end_turf = get_turf(controller.current_movement_target)
		var/advanced = TRUE
		var/turf/current_turf = get_turf(movable_pawn)

		var/mob/cliented_mob = controller.current_movement_target
		var/cliented = FALSE
		if(istype(cliented_mob))
			if(cliented_mob.client)
				cliented = TRUE

		// Check if we've moved to a lower Z-level (possibly thrown) and our path expects us to be higher
		if(length(controller.movement_path) && controller.movement_path[1])
			var/turf/next_step = controller.movement_path[1]

			// If the next step is on a higher Z-level than our current position,
			// verify that there are stairs at our current position leading up
			if(next_step.z > current_turf.z)
				// Check if there's a valid stair to go up
				var/turf/above = get_step_multiz(current_turf, UP)
				var/can_go_up = FALSE

				if(above && !above.density)
					// Look for stairs at current location
					for(var/obj/structure/stairs/S in current_turf.contents)
						var/turf/dest = get_step(above, S.dir)
						if(dest == next_step || get_step(dest, S.dir) == next_step)
							can_go_up = TRUE
							break

				// If we can't go up but our path expects us to, we've likely been thrown down
				// So regenerate the path from our current position
				if(!can_go_up)
					controller.movement_path = null
					fallbacking = FALSE
					fallback_fail = 0

		if(end_turf?.z == movable_pawn?.z && !length(controller.movement_path) && !cliented)
			advanced = FALSE
			var/can_move = controller.can_move()

			var/current_loc = get_turf(movable_pawn)

			if(!is_type_in_typecache(target_turf, GLOB.dangerous_turfs) && can_move)
				step_to(movable_pawn, target_turf, controller.blackboard[BB_CURRENT_MIN_MOVE_DISTANCE], controller.movement_delay)

				if(current_loc == get_turf(movable_pawn))
					advanced = TRUE
					controller.movement_path = null
					fallbacking = TRUE
					SEND_SIGNAL(movable_pawn, COMSIG_AI_GENERAL_CHANGE, "Unable to Basic Move swapping to AStar.")


			if(!advanced)
				if(current_loc == get_turf(movable_pawn)) //Did we even move after trying to move?
					controller.pathing_attempts++
					if(controller.pathing_attempts >= max_pathing_attempts)
						controller.CancelActions()
						SEND_SIGNAL(movable_pawn, COMSIG_AI_GENERAL_CHANGE, "Failed pathfinding cancelling.")
		if(advanced)
			var/minimum_distance = controller.max_target_distance
			// right now I'm just taking the shortest minimum distance of our current behaviors, at some point in the future
			// we should let whatever sets the current_movement_target also set the min distance and max path length
			// (or at least cache it on the controller)
			for(var/datum/ai_behavior/iter_behavior as anything in controller.current_behaviors)
				if(iter_behavior.required_distance < minimum_distance)
					minimum_distance = iter_behavior.required_distance

			if(get_dist(movable_pawn, controller.current_movement_target) <= minimum_distance)
				continue

			var/generate_path = FALSE // set to TRUE when we either have no path, or we failed a step
			if(length(controller.movement_path))
				var/turf/last_turf = controller.movement_path[length(controller.movement_path)]
				var/turf/next_step = controller.movement_path[1]

				// Handle movement along the path normally
				if(next_step.z != movable_pawn.z)
					movable_pawn.Move(next_step)
				else
					step_to(movable_pawn, next_step, controller.blackboard[BB_CURRENT_MIN_MOVE_DISTANCE], controller.movement_delay)

				if(last_turf != get_turf(controller.current_movement_target))
					generate_path = TRUE

				// this check if we're on exactly the next tile may be overly brittle for dense pawns who may get bumped slightly
				// to the side while moving but could maybe still follow their path without needing a whole new path
				if(get_turf(movable_pawn) == next_step || (istype(next_step, /turf/open/transparent) && get_turf(movable_pawn) == GET_TURF_BELOW(next_step)))
					controller.movement_path.Cut(1,2)
					if(length(controller.movement_path))
						var/turf/double_checked = controller.movement_path[1]

						if(get_turf(movable_pawn) == double_checked) //the way z-level stacks work is that it adds the openspace and belowspace so we cull both here
							controller.movement_path.Cut(1,2)

					if(!length(controller.movement_path) && fallbacking)
						fallbacking = FALSE
				else
					if(!fallbacking)
						generate_path = TRUE
					else
						fallback_fail++
						if(fallback_fail >= 2)
							generate_path = TRUE
							fallbacking = FALSE
			else
				generate_path = TRUE

			if(generate_path)
				if(!COOLDOWN_FINISHED(controller, repath_cooldown))
					continue
				controller.pathing_attempts++
				if(controller.pathing_attempts >= max_pathing_attempts)
					controller.CancelActions()
					continue

				COOLDOWN_START(controller, repath_cooldown, 2 SECONDS)
				controller.movement_path = get_path_to(movable_pawn, controller.current_movement_target, /turf/proc/Distance3D, max_path_distance + 1, 250,  minimum_distance, id=controller.get_access())
				SEND_SIGNAL(controller.pawn, COMSIG_AI_PATH_GENERATED, controller.movement_path)
