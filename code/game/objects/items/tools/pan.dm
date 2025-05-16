/obj/item/cooking/pan
	name = "frypan"
	icon_state = "pan"
	experimental_inhand = FALSE

	force = 20
	throwforce = 15
	possible_item_intents = list(/datum/intent/mace/strike/shovel)
	wlength = WLENGTH_SHORT
	sharpness = IS_BLUNT
	slot_flags = ITEM_SLOT_HIP
	can_parry = TRUE
	drop_sound = 'sound/foley/dropsound/shovel_drop.ogg'
	wdefense = ULTMATE_PARRY
	ingsize = 3

/obj/item/cooking/pan/Initialize()
	. = ..()
	AddComponent(/datum/component/storage/concrete/grid/pan)
	AddComponent(/datum/component/container_craft, subtypesof(/datum/container_craft/pan))
	AddComponent(/datum/component/food_burner, 2 MINUTES, TRUE, CALLBACK(src, PROC_REF(can_burn)))

/obj/item/cooking/pan/examine(mob/user)
	. = ..()

/obj/item/cooking/pan/proc/can_burn()
	if(!istype(loc, /obj/machinery/light/fueled))
		return FALSE
	var/obj/machinery/light/fueled/fueled = loc
	if(!fueled.fueluse)
		return FALSE
	return TRUE

/obj/item/cooking/pan/proc/add_to_visible(obj/item/our_item)
	var/mutable_appearance/MA = mutable_appearance(our_item.icon, our_item.icon_state)
	MA.color = our_item.color
	MA.pixel_x = initial(our_item.pixel_x) + rand(-3, 3)
	MA.pixel_y = initial(our_item.pixel_y) + rand(-3, 3)
	MA.vis_flags = VIS_INHERIT_LAYER | VIS_INHERIT_PLANE | VIS_INHERIT_ID
	MA.blend_mode = BLEND_INSET_OVERLAY
	MA.transform *= 0.6
	add_overlay(MA)

/obj/item/cooking/pan/update_overlays()
	. = ..()
	cut_overlays()

	for(var/i=contents.len, i>=1, i--)
		var/obj/item/our_item = contents[i]
		src.add_to_visible(our_item)

