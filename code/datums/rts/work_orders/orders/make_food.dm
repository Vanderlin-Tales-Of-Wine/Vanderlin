/datum/work_order/make_food
	name = "Cooking "
	work_time_left = 15 SECONDS
	stamina_cost = 5

	var/datum/food_item/food_item
	var/obj/effect/building_node/kitchen/kitchen_node
	var/obj/effect/workspot/workspot

/datum/work_order/make_food/New(mob/living/new_worker, datum/work_order/type, obj/effect/workspot/cook_spot, datum/food_item/cooking_food, obj/effect/building_node/kitchen/kitchen)
	. = ..()
	food_item = cooking_food
	kitchen_node = kitchen
	name += initial(cooking_food.name)
	set_movement_target(cook_spot)
	workspot = cook_spot

/datum/work_order/make_food/start_working(mob/living/worker_mob)
	if(!kitchen_node.use_work_materials(initial(food_item.requirements)))
		worker.controller_mind.pause_task_for(30 SECONDS, workspot)
		var/datum/food_item/temp_item = new food_item
		kitchen_node.add_material_request(src, temp_item.requirements, 3)
		qdel(temp_item)
		return
	. = ..()

/datum/work_order/make_food/finish_work()
	. = ..()
	kitchen_node.add_food(food_item)
