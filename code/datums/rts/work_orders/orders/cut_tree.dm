/datum/work_order/cut_wood
	name = "Cutting Tree"
	work_time_left = 30 SECONDS
	stamina_cost = 10

	var/cut_mat = MAT_WOOD
	var/mine_amount = 1
	var/obj/effect/building_node/lumber_yard/lumber_yard

/datum/work_order/cut_wood/New(mob/living/new_worker, datum/work_order/type, obj/effect/workspot/work_spot, obj/effect/building_node/lumber_yard/lumber)
	. = ..()
	lumber_yard = lumber
	set_movement_target(work_spot)

/datum/work_order/cut_wood/finish_work()
	lumber_yard.materials_to_store |= cut_mat
	lumber_yard.materials_to_store[cut_mat] += mine_amount
	. = ..()
