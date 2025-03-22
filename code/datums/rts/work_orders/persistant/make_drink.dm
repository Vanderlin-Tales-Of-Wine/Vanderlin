/datum/persistant_workorder/make_drink
	name = "Make Food"
	ui_icon = 'icons/roguetown/items/food.dmi'
	work_type = /datum/work_order/make_drink

/datum/persistant_workorder/make_drink/apply_to_worker(mob/living/worker)
	arg_1 = pick(created_node.workspots)
	arg_3 = created_node
	. = ..()


/datum/persistant_workorder/make_drink/beer
	name = "Brew Beer"
	ui_icon_state = "bread_salo"

	arg_2 = /datum/bar_item/beer
