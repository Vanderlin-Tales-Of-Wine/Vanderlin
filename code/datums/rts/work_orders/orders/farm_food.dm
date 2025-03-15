/datum/work_order/farm_food
	name = "Farming "
	work_time_left = 30 SECONDS
	stamina_cost = 10

	var/food_type = "Fruit"
	var/food_amount = 3
	var/obj/effect/building_node/farm/farm_node

/datum/work_order/farm_food/New(mob/living/new_worker, datum/work_order/type, obj/effect/workspot/farm_spot, farming_food, obj/effect/building_node/farm/farm)
	. = ..()
	food_type = farming_food
	farm_node = farm
	name += food_type
	set_movement_target(farm_spot)


/datum/work_order/farm_food/finish_work()
	farm_node.materials_to_store |= food_type
	farm_node.materials_to_store[food_type] += food_amount
	. = ..()
