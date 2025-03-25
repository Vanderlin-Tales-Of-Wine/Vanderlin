///Uses Byond's basic obstacle avoidance mvovement unless the target is on a z-level different to ours
/datum/ai_movement/hybrid_pathing
	requires_processing = TRUE
	max_pathing_attempts = 4
	max_path_distance = 30
	var/fallbacking = FALSE
	var/fallback_fail = 0

///Put your movement behavior in here!
/datum/ai_movement/hybrid_pathing/process(delta_time)
	for(var/datum/ai_controller/controller as anything in moving_controllers)
		if(!COOLDOWN_FINISHED(controller, movement_cooldown))
			continue
		COOLDOWN_START(controller, movement_cooldown, controller.movement_delay)

		var/atom/movable/movable_pawn = controller.pawn
		var/turf/target_turf = get_step_towards(movable_pawn, controller.current_movement_target)
		var/turf/end_turf = get_turf(controller.current_movement_target)
		var/advanced = TRUE
		if(end_turf?.z == movable_pawn?.z && !length(controller.movement_path))
			advanced = FALSE
			var/can_move = TRUE

			if(controller.ai_traits & STOP_MOVING_WHEN_PULLED && movable_pawn.pulledby)
				can_move = FALSE

			if(!isturf(movable_pawn.loc)) //No moving if not on a turf
				can_move = FALSE

			if(isliving(movable_pawn))
				var/mob/living/living_pawn = movable_pawn
				if(!(living_pawn.mobility_flags & MOBILITY_MOVE))
					can_move = FALSE

			var/current_loc = get_turf(movable_pawn)

			if(!is_type_in_typecache(target_turf, GLOB.dangerous_turfs) && can_move)
				step_to(movable_pawn, target_turf, controller.blackboard[BB_CURRENT_MIN_MOVE_DISTANCE], controller.movement_delay)

				if(current_loc == get_turf(movable_pawn))
					advanced = TRUE
					controller.movement_path = null
					fallbacking = TRUE


			if(!advanced)
				if(current_loc == get_turf(movable_pawn)) //Did we even move after trying to move?
					controller.pathing_attempts++
					if(controller.pathing_attempts >= max_pathing_attempts)
						controller.CancelActions()
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
				var/turf/next_step = controller.movement_path[1]
				if(next_step.z != movable_pawn.z)
					movable_pawn.Move(next_step)
				else
					step_to(movable_pawn, next_step, controller.blackboard[BB_CURRENT_MIN_MOVE_DISTANCE], controller.movement_delay)

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
