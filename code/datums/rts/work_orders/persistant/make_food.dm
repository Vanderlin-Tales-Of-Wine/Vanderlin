/datum/persistant_workorder/make_food
	name = "Make Food"
	ui_icon = 'icons/roguetown/items/food.dmi'
	work_type = /datum/work_order/make_food

/datum/persistant_workorder/make_food/apply_to_worker(mob/living/worker)
	arg_1 = pick(created_node.workspots)
	arg_3 = created_node
	. = ..()


/datum/persistant_workorder/make_food/bread
	name = "Make Bread"
	ui_icon_state = "bread_salo"

	arg_2 = /datum/food_item/bread
