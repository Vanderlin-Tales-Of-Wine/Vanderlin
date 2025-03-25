/datum/work_order/eat_food
	name = "Eating Food"
	stamina_cost = 0
	work_time_left = 10 SECONDS

	var/food_to_eat
	var/obj/effect/building_node/kitchen/node

/datum/work_order/eat_food/New(mob/living/new_worker, datum/work_order/type, obj/effect/foodspot/eat_spot, food_to_eat, obj/effect/building_node/kitchen/kitchen_datum)
	. = ..()
	src.food_to_eat = food_to_eat
	node = kitchen_datum
	set_movement_target(eat_spot)

/datum/work_order/eat_food/finish_work()
	. = ..()
	node.consume_food(food_to_eat, worker)
