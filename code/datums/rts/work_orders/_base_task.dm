/datum/work_order
	var/name = "Generic Work Order"
	var/visible_message
	var/mob/living/worker
	var/atom/work_target
	var/stamina_cost

	var/work_time_left = 0
	var/can_continue = FALSE

/datum/work_order/New(mob/living/new_worker, datum/work_order/type, ...)
	. = ..()
	worker = new_worker

/datum/work_order/proc/start_working(mob/living/worker_mob)
	worker.controller_mind.paused = TRUE
	worker.controller_mind.update_stat_panel()
	var/world_start_time = world.time
	if(visible_message)
		worker.visible_message("[worker] [visible_message]")
	if(!do_after(worker, work_time_left, target = work_target))
		worker.controller_mind.paused = FALSE
		if(!can_continue)
			stop_work()
			return FALSE
		work_time_left = world.time - world_start_time
		return FALSE

	finish_work()

/datum/work_order/proc/finish_work()
	SHOULD_CALL_PARENT(TRUE)
	worker.controller_mind.finish_work(TRUE, stamina_cost)
	worker.controller_mind.update_stat_panel()

/datum/work_order/proc/set_movement_target(atom/target)
	if(!length(get_path_to(worker, get_turf(target), TYPE_PROC_REF(/turf, Heuristic_cardinal_3d), 32 + 1, 250,1)))
		stop_work()
		return
	worker.controller_mind.set_movement_target(target)

/datum/work_order/proc/stop_work()
	SHOULD_CALL_PARENT(TRUE)
	worker.controller_mind.stop_working()
	worker.controller_mind.update_stat_panel()
