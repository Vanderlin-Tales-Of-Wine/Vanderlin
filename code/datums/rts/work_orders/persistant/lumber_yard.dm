/datum/persistant_workorder/cut_wood
	name = "Cut Wood"
	ui_icon = 'icons/roguetown/items/natural.dmi'
	ui_icon_state = "logsmall"
	work_type = /datum/work_order/cut_wood


/datum/persistant_workorder/cut_wood/apply_to_worker(mob/living/worker)
	arg_1 = pick(created_node.workspots)
	arg_2 = created_node
	. = ..()
