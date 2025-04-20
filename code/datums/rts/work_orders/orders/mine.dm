/datum/work_order/mine
	name = "Mining "
	work_time_left = 30 SECONDS
	stamina_cost = 10

	var/mine_mat = MAT_STONE
	var/mine_amount = 1
	var/obj/effect/building_node/mines/mine_node


/datum/work_order/mine/New(mob/living/new_worker, datum/work_order/type, obj/effect/workspot/mine_spot, mining_material, obj/effect/building_node/mines/mine, work_time = 15 SECONDS)
	. = ..()
	mine_mat = mining_material
	mine_node = mine
	name += mining_material
	set_movement_target(mine_spot)
	work_time_left = work_time


/datum/work_order/mine/finish_work()
	mine_node.materials_to_store |= mine_mat
	mine_node.materials_to_store[mine_mat] += mine_amount
	. = ..()
