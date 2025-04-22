/obj/item/mould
	name = "mould"

	icon = 'icons/roguetown/weapons/crucible.dmi'
	icon_state = "flat-mold"
	var/filling_icon_state = ""

	var/atom/output_atom
	var/required_metal
	var/fufilled_metal = 0
	var/datum/material/required_material
	var/datum/material/filling_metal

	var/cooling = FALSE
	var/cooling_progress = 0

/obj/item/mould/Initialize()
	. = ..()
	main_material = pick(typesof(/datum/material/clay))
	set_material_information()
	update_overlays()

/obj/item/mould/set_material_information()
	. = ..()
	name = "[initial(main_material.name)] [initial(name)]"

/obj/item/mould/examine(mob/user)
	. = ..()
	if(cooling)
		. += "[src] is hardening."
		return

	if(fufilled_metal)
		var/reagent_color = initial(filling_metal.color)
		. += "[src] has [round(fufilled_metal / 3, 1)] oz of <font color=[reagent_color]> Molten [initial(filling_metal.name)]</font> out of [round(required_metal / 3, 1)] oz.</font>"
	else
		. += "[src] requires [required_metal / 3] oz of Molten Metal to form.</font>"

/obj/item/mould/attackby(obj/item/I, mob/living/user, params)
	. = ..()
	if(!istype(I, /obj/item/storage/crucible))
		return

	var/obj/item/storage/crucible/crucible = I
	var/datum/reagent/molten_metal/metal = crucible.reagents.get_reagent(/datum/reagent/molten_metal)
	if(!metal)
		return

	if(!filling_metal)
		var/list/names = list()
		for(var/datum/material/material as anything in metal.data)
			if(crucible.reagents.chem_temp < initial(material.melting_point))
				continue
			names |= initial(material.name)

		var/choice = input(user, "What metal to pour?", crucible) in names
		if(!choice)
			return
		for(var/datum/material/material as anything in metal.data)
			if(choice != initial(material.name))
				continue
			filling_metal = material
			break
		if(!filling_metal)
			return
	else
		if(!(filling_metal in metal.data))
			return

	var/metal_amount = metal.data[filling_metal]
	if(metal_amount > required_metal - fufilled_metal)
		metal_amount = required_metal - fufilled_metal
	metal.data[filling_metal] -= metal_amount
	if(!metal.data[filling_metal])
		metal.data -= filling_metal
	crucible.reagents.remove_reagent(/datum/reagent/molten_metal, metal_amount)
	if(!QDELETED(metal))
		metal.find_largest_metal()

	fufilled_metal += metal_amount
	update_overlays()
	crucible.update_overlays()
	if(fufilled_metal >= required_metal)
		start_cooling()

/obj/item/mould/update_overlays()
	. = ..()
	if(length(overlays))
		overlays.Cut()

	if(fufilled_metal)
		var/mutable_appearance/MA = mutable_appearance(icon, filling_icon_state)
		MA.color = initial(filling_metal.color)
		MA.alpha = 255 * (fufilled_metal / required_metal)
		MA.appearance_flags = RESET_COLOR | KEEP_APART
		overlays += MA

		var/mutable_appearance/MA2 = mutable_appearance(icon, filling_icon_state)
		if(cooling)
			MA2.alpha = 255 * round((1 - (cooling_progress / 100)),0.1)
		else
			MA2.alpha = 255 * (fufilled_metal / required_metal)
		MA2.plane = EMISSIVE_PLANE
		overlays += MA2

/obj/item/mould/proc/start_cooling()
	cooling = TRUE
	START_PROCESSING(SSobj, src)

/obj/item/mould/process()
	cooling_progress += 2.5
	update_overlays()
	if(cooling_progress >= 100)
		STOP_PROCESSING(SSobj, src)
		create_item()

/obj/item/mould/proc/create_item()
	if(output_atom)
		new output_atom(get_turf(src))
	fufilled_metal = 0
	filling_metal = null
	cooling = FALSE
	cooling_progress = 0
	update_overlays()


/obj/item/mould/ingot
	name = "ingot mold"

	icon_state = "ingot-mold"
	filling_icon_state = "ingot-mold-color"

	required_metal = 100

	grid_width = 64
	grid_height = 32

/obj/item/mould/ingot/create_item()
	var/atom/to_create
	to_create = initial(filling_metal.ingot_type)
	if(filling_metal.ingot_type == /obj/item/ingot/blacksteel)
		GLOB.vanderlin_round_stats[STATS_BLACKSTEEL_SMELTED]++
	new to_create(get_turf(src))
	fufilled_metal = 0
	filling_metal = null
	cooling = FALSE
	update_overlays()
