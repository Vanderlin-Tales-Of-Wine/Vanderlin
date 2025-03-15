/datum/work_order/go_try_eat
	name = "Heading to the Kitchen"
	stamina_cost = 0

	var/obj/effect/building_node/kitchen/kitchen_node

/datum/work_order/go_try_eat/New(mob/living/new_worker, datum/work_order/type, obj/effect/building_node/kitchen/kitchen)
	. = ..()
	kitchen_node = kitchen
	set_movement_target(kitchen)

/datum/work_order/go_try_eat/finish_work()
	. = ..()
	kitchen_node.try_feed(worker)
