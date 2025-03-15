/datum/work_order/wander_to_building
	name = "Wandering to "
	stamina_cost = 0
	work_time_left = 0

/datum/work_order/wander_to_building/New(mob/living/new_worker, datum/work_order/type, obj/effect/building_node/node_to_path)
	. = ..()
	name += node_to_path.name
	new_worker.controller_mind.update_stat_panel()
	set_movement_target(node_to_path)

/datum/work_order/wander_to_building/start_working(mob/living/worker_mob)
	worker.controller_mind.paused = TRUE
	finish_work()
