/obj/effect/building_node/farm
	name = "Farm"
	work_template = "farm"

	icon = 'icons/roguetown/items/produce.dmi'
	icon_state = "wheatchaff"

	persistant_nodes = list(
		/datum/persistant_workorder/farm/grain,
		/datum/persistant_workorder/farm/fruit,
		/datum/persistant_workorder/farm/vegetable,
	)
