/turf/open
	var/explored_by_workers = FALSE

/datum/idle_tendancies/dynamic/perform_idle(mob/camera/strategy_controller/master, mob/living/worker)
	var/datum/worker_mind/mind = worker.controller_mind

	// Base behavior weights
	var/list/behavior_weights = list(
		"rest" = 30,
		"socialize" = 20,
		"explore" = 15,
		"practice" = 10,
		"create" = 10,
		"visit_building" = 15,  // From basic system
		"play_music" = 8,       // From basic system
		"mourn_dead" = 12       // From basic system
	)

	// Modify weights based on personality and mood
	if(mind.has_personality("social"))
		behavior_weights["socialize"] += 20
		behavior_weights["mourn_dead"] += 10
	if(mind.has_personality("lazy"))
		behavior_weights["rest"] += 15
		behavior_weights["explore"] -= 10
	if(mind.has_personality("artistic"))
		behavior_weights["create"] += 15
		behavior_weights["play_music"] += 12
	if(mind.mood_level < 30)
		behavior_weights["rest"] += 20
		behavior_weights["mourn_dead"] += 15
	if(mind.experience_level > 30)
		behavior_weights["create"] += 15

	// Contextual weight adjustments
	if(!length(master.constructed_building_nodes))
		behavior_weights["visit_building"] = 0
	if(!length(master.dead_workers))
		behavior_weights["mourn_dead"] = 0
	if(!has_instrument(worker))
		behavior_weights["play_music"] = 0
	if(length(master.worker_mobs) <= 1)
		behavior_weights["socialize"] -= 10

	// Select behavior based on weighted random
	var/chosen_behavior = pickweight(behavior_weights)
	perform_dynamic_behavior(chosen_behavior, master, worker)

/datum/idle_tendancies/dynamic/proc/has_instrument(mob/living/worker)
	if(!length(worker.controller_mind.worker_gear))
		return FALSE
	for(var/obj/item/gear in worker.controller_mind.worker_gear)
		if(istype(gear, /obj/item/instrument))
			return TRUE
	return FALSE

/datum/idle_tendancies/dynamic/proc/perform_dynamic_behavior(behavior, mob/camera/strategy_controller/master, mob/living/worker)
	switch(behavior)
		if("rest")
			// Enhanced rest behavior from basic system
			var/list/turfs = view(6, worker)
			shuffle_inplace(turfs)
			for(var/turf/open/open in turfs)
				worker.controller_mind.set_current_task(/datum/work_order/nappy_time, open)
				break
		if("visit_building")
			// From basic system - visit constructed buildings
			if(length(master.constructed_building_nodes))
				worker.controller_mind.set_current_task(/datum/work_order/wander_to_building, pick(master.constructed_building_nodes))
			else
				// Fallback to rest
				var/list/turfs = view(6, worker)
				shuffle_inplace(turfs)
				for(var/turf/open/open in turfs)
					worker.controller_mind.set_current_task(/datum/work_order/nappy_time, open)
					break
		if("socialize")
			// Enhanced socialization from basic system
			if(length(master.worker_mobs) - 1 > 0)
				var/list/mobs_minus_src = master.worker_mobs.Copy()
				mobs_minus_src -= worker
				worker.controller_mind.set_current_task(/datum/work_order/socialize_with, pick(mobs_minus_src))
			else
				// Fallback to rest
				var/list/turfs = view(6, worker)
				shuffle_inplace(turfs)
				for(var/turf/open/open in turfs)
					worker.controller_mind.set_current_task(/datum/work_order/nappy_time, open)
					break
		if("play_music")
			// From basic system - play instruments
			if(length(worker.controller_mind.worker_gear))
				for(var/obj/item/gear in worker.controller_mind.worker_gear)
					if(!istype(gear, /obj/item/instrument))
						continue
					var/list/turfs = view(6, worker)
					shuffle_inplace(turfs)
					for(var/turf/open/open in turfs)
						worker.controller_mind.set_current_task(/datum/work_order/play_music, open, gear)
						return
			// Fallback to rest if no instrument
			var/list/turfs = view(6, worker)
			shuffle_inplace(turfs)
			for(var/turf/open/open in turfs)
				worker.controller_mind.set_current_task(/datum/work_order/nappy_time, open)
				break
		if("mourn_dead")
			// From basic system - mourn dead workers
			if(length(master.dead_workers))
				worker.controller_mind.set_current_task(/datum/work_order/mourn_dead, pick(master.dead_workers))
			else
				// Fallback to rest
				var/list/turfs = view(6, worker)
				shuffle_inplace(turfs)
				for(var/turf/open/open in turfs)
					worker.controller_mind.set_current_task(/datum/work_order/nappy_time, open)
					break
		if("explore")
			// Find unexplored areas
			var/list/unexplored = list()
			for(var/turf/open/T in range(10, worker))
				if(!T.explored_by_workers)
					unexplored += T
			if(length(unexplored))
				worker.controller_mind.set_current_task(/datum/work_order/explore_area, pick(unexplored))
			else
				// Fallback to rest if nowhere to explore
				var/list/turfs = view(6, worker)
				shuffle_inplace(turfs)
				for(var/turf/open/open in turfs)
					worker.controller_mind.set_current_task(/datum/work_order/nappy_time, open)
					break
		if("practice")
			// Practice with equipment or skills
			if(length(worker.controller_mind.worker_gear))
				var/obj/item/gear = pick(worker.controller_mind.worker_gear)
				worker.controller_mind.set_current_task(/datum/work_order/practice_with, gear)
			else
				// Fallback to rest if no gear
				var/list/turfs = view(6, worker)
				shuffle_inplace(turfs)
				for(var/turf/open/open in turfs)
					worker.controller_mind.set_current_task(/datum/work_order/nappy_time, open)
					break
		if("create")
			// Try to build something artistic or decorative
			var/list/turfs = view(3, worker)
			for(var/turf/open/open in turfs)
				worker.controller_mind.set_current_task(/datum/work_order/create_art, open)
				break

// Work order definitions
/datum/work_order/explore_area
	name = "Explore Area"
	visible_message = "begins exploring the area"
	work_time_left = 3 SECONDS
	stamina_cost = 5

/datum/work_order/explore_area/finish_work()
	. = ..()
	var/turf/open/T = get_turf(work_target)
	T?.explored_by_workers = TRUE
	worker.controller_mind.experience_level++
	worker.controller_mind.adjust_mood(2, "discovery")

/datum/work_order/practice_with
	name = "Practice Skills"
	visible_message = "practices with their equipment"
	work_time_left = 5 SECONDS
	stamina_cost = 3

/datum/work_order/practice_with/finish_work()
	. = ..()
	worker.controller_mind.experience_level++
	worker.controller_mind.adjust_mood(5, "satisfying practice")

/datum/work_order/create_art
	name = "Create Art"
	visible_message = "starts creating something artistic"
	work_time_left = 8 SECONDS
	stamina_cost = 8

/datum/work_order/create_art/finish_work()
	. = ..()
	// Create decorative object
	var/obj/item/canvas/random_painting/new_art = new(get_turf(work_target))
	new_art.name = "crude [pick("painting")] by [worker.real_name]"
	worker.controller_mind.adjust_mood(10, "artistic accomplishment")
	// Boost mood of nearby workers who see the art
	for(var/mob/living/other in view(5, worker))
		if(other.controller_mind && other != worker)
			other.controller_mind.adjust_mood(3, "inspired by art")
