/obj/effect/building_node
	name = "Building Node"
	desc = "A generic building"
	plane = STRATEGY_PLANE

	///this is our template id
	var/work_template

	var/list/added_assignments

	var/list/workspots = list()

	var/maximum_workers = 1

	var/list/materials_to_store = list()

	var/list/material_requests = list()

	var/list/persistant_nodes = list()

	var/list/work_materials = list()

/obj/effect/building_node/proc/on_construction(mob/camera/strategy_controller/master_controller)
	SHOULD_CALL_PARENT(TRUE)
	master_controller.constructed_building_nodes |= src
	if(length(added_assignments))
		master_controller.add_assignments(added_assignments)

	var/datum/map_template/template = SSmapping.map_templates[work_template]

	var/list/turfs = template.get_affected_turfs(get_turf(src), TRUE)
	for(var/turf/turf as anything in turfs)
		for(var/obj/effect/workspot/spot in turf.contents)
			workspots |= spot
	after_construction(turfs)

	var/list/created_nodes = list()
	for(var/datum/persistant_workorder/node as anything in persistant_nodes)
		created_nodes |= new node(src)
	persistant_nodes = created_nodes

/obj/effect/building_node/proc/after_construction(list/turfs)
	return

/obj/effect/building_node/proc/add_material_request(location, list/resource_amount, multiplier = 1)
	if(location in material_requests)
		return
	material_requests |= location

	for(var/resource in resource_amount)
		resource_amount[resource] *= multiplier
	material_requests[location] = resource_amount

/obj/effect/building_node/proc/use_work_materials(list/used_materials)
	if(!length(work_materials))
		return FALSE

	for(var/material in used_materials)
		if(!(material in work_materials))
			return FALSE
		if(work_materials[material] < used_materials[material])
			return FALSE

	for(var/material in used_materials)
		work_materials[material] -= used_materials[material]
	return TRUE

/obj/effect/building_node/proc/select_workorder(mob/user)
	if(!length(persistant_nodes))
		return
	var/list/name_to_node = list()
	var/list/radial_options = list()
	for(var/datum/persistant_workorder/order in persistant_nodes)
		radial_options |= order.name
		radial_options[order.name] = image(order.ui_icon, order.ui_icon_state)
		name_to_node |= order.name
		name_to_node[order.name] = order

	var/picked = show_radial_menu(user, src, radial_options)
	if(!picked)
		return

	return name_to_node[picked]

/obj/effect/building_node/stockpile
	name = "Stockpile"
	work_template = "stockpile"

	var/datum/stockpile/stockpile

/obj/effect/building_node/stockpile/on_construction(mob/camera/strategy_controller/master_controller)
	. = ..()
	if(!master_controller.resource_stockpile)
		master_controller.resource_stockpile = new /datum/stockpile
	stockpile = master_controller.resource_stockpile

/obj/effect/building_node/proc/override_click(mob/camera/strategy_controller/user)
	return FALSE
