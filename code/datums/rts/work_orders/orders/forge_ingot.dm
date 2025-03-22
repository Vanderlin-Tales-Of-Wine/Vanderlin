/datum/work_order/forge_ingot
	name = "Forging Ingots "
	work_time_left = 20 SECONDS
	stamina_cost = 5

	var/obj/effect/building_node/blacksmith/smith
	var/obj/effect/workspot/workspot

/datum/work_order/forge_ingot/New(mob/living/new_worker, datum/work_order/type, obj/effect/workspot/cook_spot, obj/effect/building_node/blacksmith/blacksmith)
	. = ..()
	smith = blacksmith
	set_movement_target(cook_spot)
	workspot = cook_spot

/datum/work_order/forge_ingot/start_working(mob/living/worker_mob)
	if(!smith.use_work_materials(list(MAT_ORE = 2,MAT_COAL = 1)))
		worker.controller_mind.pause_task_for(30 SECONDS, workspot)
		smith.add_material_request(src, list(MAT_ORE = 2, MAT_COAL = 1), 3)
		return
	. = ..()

/datum/work_order/forge_ingot/finish_work()
	smith.materials_to_store |= MAT_INGOT
	smith.materials_to_store[MAT_INGOT] += 2
	. = ..()

