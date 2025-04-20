/datum/work_order/mourn_dead
	name = "Mourning"
	stamina_cost = 0
	work_time_left = 15 SECONDS

/datum/work_order/mourn_dead/New(mob/living/new_worker, datum/work_order/type, mob/living/dead_worker)
	. = ..()
	set_movement_target(get_turf(dead_worker))
	name += dead_worker.real_name
