/datum/work_order/socialize_with
	name = "Socializing with "
	stamina_cost = 0
	work_time_left = 15 SECONDS

/datum/work_order/socialize_with/New(mob/living/new_worker, datum/work_order/type, mob/living/living_worker)
	. = ..()
	set_movement_target(get_turf(living_worker))
	name += living_worker.controller_mind.worker_name
