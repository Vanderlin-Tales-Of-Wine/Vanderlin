/datum/persistant_workorder/forge_ingot
	name = "Forge Ingot"
	ui_icon = 'icons/roguetown/items/ore.dmi'
	ui_icon_state = "ingotsteel"
	work_type = /datum/work_order/forge_ingot


/datum/persistant_workorder/forge_ingot/apply_to_worker(mob/living/worker)
	arg_1 = pick(created_node.workspots)
	arg_2 = created_node
	. = ..()
