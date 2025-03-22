/obj/effect/building_node/blacksmith
	name = "Blacksmith"
	work_template = "blacksmith"

	icon = 'icons/roguetown/items/ore.dmi'
	icon_state = "ingotsteel"

	persistant_nodes = list(
		/datum/persistant_workorder/forge_ingot,
	)
