/obj/item/storage/crucible
	name = "crucible"
	layer = ABOVE_ALL_MOB_LAYER

	icon = 'icons/roguetown/weapons/crucible.dmi'
	icon_state = "crucible"
	component_type = /datum/component/storage/concrete/grid/crucible
	grid_width = 32
	grid_height = 64

	tool_flags = TOOL_USAGE_TONGS

	var/crucible_temperature = 300

	var/list/melting_pot = list()

/obj/item/storage/crucible/examine(mob/user)
	. = ..()
	if(crucible_temperature)
		. += "The crucible is around [crucible_temperature - 271.3]C"
	if(length(melting_pot))
		for(var/obj/item/atom in melting_pot)
			var/datum/material/material = atom.melting_material
			. += "<font color=[initial(material.color)]> [atom.name] </font> - [FLOOR((melting_pot[atom] / atom.melt_amount) * 100, 1)]% Melted"

/obj/item/storage/crucible/set_material_information()
	. = ..()
	name = "[lowertext(initial(main_material.name))] crucible"

/obj/item/storage/crucible/Initialize()
	. = ..()
	create_reagents(5000)
	color = pick("#766f8c", "#565c5c", "#8d3a2d", "#4f3524")
	START_PROCESSING(SSobj, src)

/obj/item/storage/crucible/examine(mob/user)
	. = ..()
	var/datum/reagent/molten_metal/metal = reagents.get_reagent(/datum/reagent/molten_metal)
	if(metal)
		for(var/datum/material/material as anything in metal.data)
			var/tag = "Molten"
			if(reagents.chem_temp < material.melting_point)
				tag = "Hardened"
			var/total_volume = metal.data[material]
			var/reagent_color = initial(material.color)
			if(total_volume / 3 < 1)
				. += "It contains less than 1 oz of <font color=[reagent_color]> [tag] [initial(material.name)].</font>"
			else
				. += "It contains [round(total_volume / 3)] oz of <font color=[reagent_color]> [tag] [initial(material.name)].</font>"

/obj/item/storage/crucible/process()
	var/obj/machinery/light/fueled/smelter/smelter = loc
	var/obj/machinery/light/fueled/light = locate(/obj/machinery/light/fueled) in get_turf(src)
	if(istype(smelter) && smelter?.on)
		crucible_temperature = max(300, min(smelter.max_crucible_temperature, crucible_temperature + 100))
	else if(light?.on)
		if(crucible_temperature > 1300)
			crucible_temperature = max(300, crucible_temperature - 1)
		else
			crucible_temperature = max(300, min(1300, crucible_temperature + 100))
	else
		crucible_temperature = max(300, crucible_temperature - 10)

	reagents.expose_temperature(crucible_temperature, 1)
	for(var/obj/item/item in contents)
		var/datum/material/material = item.melting_material
		if(crucible_temperature < initial(material.melting_point))
			melting_pot -= item
			continue
		melting_pot |= item
		melting_pot[item] += 5
		if(melting_pot[item] >= item.melt_amount)
			melt_item(item)
	update_overlays()

/obj/item/storage/crucible/get_temperature()
	return crucible_temperature

/obj/item/storage/crucible/tong_interaction(atom/target, mob/user)
	if(istype(target, /obj/item/mould))
		target.attackby(src, user)
		return TRUE

/obj/item/storage/crucible/update_overlays()
	. = ..()
	if(overlays)
		overlays.Cut()

	if(!reagents.total_volume)
		return
	var/mutable_appearance/MA = mutable_appearance(icon, "filling")
	MA.appearance_flags = RESET_COLOR | KEEP_APART

	MA.color = mix_color_from_reagents(reagents.reagent_list)
	var/datum/reagent/molten_metal/metal = reagents.get_reagent(/datum/reagent/molten_metal)
	var/datum/material/largest = metal?.largest_metal
	if(initial(largest?.red_hot) && reagents.chem_temp > initial(largest.melting_point))
		var/mutable_appearance/MA2 = mutable_appearance(icon, "filling")
		MA2.plane = EMISSIVE_PLANE
		overlays += MA2

	overlays += MA

/obj/item/storage/crucible/proc/melt_item(obj/item/item)
	SEND_SIGNAL(item.loc, COMSIG_TRY_STORAGE_TAKE, item, get_turf(src), TRUE)
	var/list/data = list()
	data |= item.melting_material
	data[item.melting_material] = item.melt_amount
	reagents.add_reagent(/datum/reagent/molten_metal, item.melt_amount, data, crucible_temperature)
	melting_pot -= item
	qdel(item)
	update_overlays()

/obj/item/storage/crucible/random/Initialize()
	. = ..()
	main_material = pick(typesof(/datum/material/clay))
	set_material_information()

/obj/item/storage/crucible/test_crucible
	var/list/material_data_to_add = list(
		/datum/material/copper = 18,
		/datum/material/tin = 2
	)
	var/temperature = 1500
	crucible_temperature = 1500

/obj/item/storage/crucible/test_crucible/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/molten_metal, 20, data = material_data_to_add, reagtemp = 4000)
	update_overlays()

/obj/item/storage/crucible/test_crucible/bar
	material_data_to_add = list(
		/datum/material/copper = 90,
		/datum/material/tin = 10,
	)

/obj/item/storage/crucible/test_crucible/copper
	material_data_to_add = list(
		/datum/material/copper = 100,
	)

/obj/item/storage/crucible/test_crucible/tin
	material_data_to_add = list(
		/datum/material/tin = 100,
	)

/obj/item/storage/crucible/test_crucible/gold
	material_data_to_add = list(
		/datum/material/gold = 100,
	)

/obj/item/storage/crucible/test_crucible/silver
	material_data_to_add = list(
		/datum/material/silver = 100,
	)

/obj/item/storage/crucible/test_crucible/steel
	material_data_to_add = list(
		/datum/material/steel = 100,
	)

/obj/item/storage/crucible/test_crucible/blacksteel
	material_data_to_add = list(
		/datum/material/blacksteel = 100,
	)

/obj/item/storage/crucible/test_crucible/everything
	material_data_to_add = list(
		/datum/material/blacksteel = 1,
		/datum/material/copper = 1,
		/datum/material/iron = 1,
		/datum/material/steel = 1,
		/datum/material/gold = 2,
		/datum/material/bronze = 1,
		/datum/material/silver = 1,
	)
