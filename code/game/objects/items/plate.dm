/obj/item/plate
	name = "platter"
	desc = "A wood plate that holds food. A powerful tool for morale when you're not eating your meal off a table."
	icon = 'icons/roguetown/items/cooking.dmi'
	icon_state = "platter"
	drop_sound = 'sound/foley/dropsound/gen_drop.ogg'
	w_class = WEIGHT_CLASS_NORMAL
	///How many things fit on this plate?
	var/max_items = 2
	///The offset from side to side the food items can have on the plate
	var/max_x_offset = 4
	///The max height offset the food can reach on the plate
	var/max_height_offset = 5
	///Offset of where the click is calculated from, due to how food is positioned in their DMIs.
	var/placement_offset = -15
	grid_width = 32
	grid_height = 32

/obj/item/plate/attackby(obj/item/I, mob/user, params)
	if(item_flags & IN_STORAGE)
		to_chat(user, span_warning("I cannot reach [src]."))
		return
	if(!istype(I, /obj/item/reagent_containers/food) && !istype(I, /obj/item/reagent_containers/glass/cup) && !istype(I, /obj/item/reagent_containers/glass/bowl))
		to_chat(user, span_notice("[src] isn't made to carry that!"))
		return
	if(contents.len >= max_items)
		to_chat(user, span_notice("[src] can't fit more items!"))
		return
	var/list/modifiers = params2list(params)
	//Center the icon where the user clicked.
	if(!LAZYACCESS(modifiers, ICON_X) || !LAZYACCESS(modifiers, ICON_Y))
		return
	if(user.transferItemToLoc(I, src, silent = FALSE))
		I.pixel_x = clamp(text2num(LAZYACCESS(modifiers, ICON_X)) - 16, -max_x_offset, max_x_offset)
		I.pixel_y = min(text2num(LAZYACCESS(modifiers, ICON_Y)) + placement_offset, max_height_offset)
		to_chat(user, span_notice("You place [I] on [src]."))
		AddToPlate(I, user)
	else
		return ..()

/obj/item/plate/pre_attack(atom/A, mob/living/user, params)
	if(!iscarbon(A))
		return
	if(!contents.len)
		return
	var/obj/item/object_to_eat = contents[1]
	A.attackby(object_to_eat, user)
	return TRUE //No normal attack

///This proc adds the food to viscontents and makes sure it can deregister if this changes.
/obj/item/plate/proc/AddToPlate(obj/item/item_to_plate)
	vis_contents += item_to_plate
	item_to_plate.flags_1 |= IS_ONTOP_1
	item_to_plate.vis_flags |= (VIS_INHERIT_PLANE | VIS_INHERIT_LAYER)
	RegisterSignal(item_to_plate, COMSIG_MOVABLE_MOVED, PROC_REF(ItemMoved))
	RegisterSignal(item_to_plate, COMSIG_PARENT_QDELETING, PROC_REF(ItemMoved))
	// We gotta offset ourselves via pixel_w/z, so we don't end up z fighting with the plane
	item_to_plate.pixel_w = item_to_plate.pixel_x
	item_to_plate.pixel_z = item_to_plate.pixel_y
	item_to_plate.pixel_x = 0
	item_to_plate.pixel_y = 0
	if(istype(item_to_plate, /obj/item/reagent_containers/food/snacks))
		var/obj/item/reagent_containers/food/snacks/S = item_to_plate
		S.rotprocess += 1 MINUTES
	update_icon()
	w_class = contents.len ? WEIGHT_CLASS_BULKY : WEIGHT_CLASS_NORMAL

///This proc cleans up any signals on the item when it is removed from a plate, and ensures it has the correct state again.
/obj/item/plate/proc/ItemRemovedFromPlate(obj/item/removed_item)
	removed_item.flags_1 &= ~IS_ONTOP_1
	removed_item.vis_flags &= ~VIS_INHERIT_PLANE
	removed_item.vis_flags &= ~VIS_INHERIT_LAYER
	vis_contents -= removed_item
	UnregisterSignal(removed_item, list(COMSIG_MOVABLE_MOVED, COMSIG_PARENT_QDELETING))
	// Resettt
	removed_item.pixel_x = removed_item.pixel_w
	removed_item.pixel_y = removed_item.pixel_z
	removed_item.pixel_w = 0
	removed_item.pixel_z = 0
	removed_item.update_transform()
	if(istype(removed_item, /obj/item/reagent_containers/food/snacks))
		var/obj/item/reagent_containers/food/snacks/S = removed_item
		S.rotprocess -= 1 MINUTES
	w_class = contents.len ? WEIGHT_CLASS_BULKY : WEIGHT_CLASS_NORMAL

///This proc is called by signals that remove the food from the plate.
/obj/item/plate/proc/ItemMoved(obj/item/moved_item, atom/OldLoc, Dir, Forced)
	SIGNAL_HANDLER
	ItemRemovedFromPlate(moved_item)

/obj/item/plate/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	. = ..()
	if(.)
		return
	var/generator/scatter_gen = generator(GEN_CIRCLE, 0, 48, NORMAL_RAND)
	var/scatter_turf = get_turf(hit_atom)

	for(var/obj/item/scattered_item as anything in contents)
		ItemRemovedFromPlate(scattered_item)
		scattered_item.forceMove(scatter_turf)
		var/list/scatter_vector = scatter_gen.Rand()
		scattered_item.pixel_x = scatter_vector[1]
		scattered_item.pixel_y = scatter_vector[2]
		scattered_item.throw_impact(hit_atom, throwingdatum)

/obj/item/plate/attack_self(mob/user)
	. = ..()
	if(contents.len) // If the tray isn't empty
		for(var/obj/item/scattered_item as anything in contents)
			scattered_item.forceMove(drop_location())
		user.visible_message(span_notice("[user] empties [src] on the floor."))

/obj/item/plate/clay
	name = "clay platter"
	desc = "A fragile platter made from fired clay. Probably shouldn't throw it."
	icon_state = "platter_clay"
	drop_sound = 'sound/foley/dropsound/brick_drop.ogg'
	resistance_flags = FIRE_PROOF

/obj/item/plate/clay/set_material_information()
	. = ..()
	name = "[lowertext(initial(main_material.name))] clay platter"

/obj/item/plate/clay/throw_impact(atom/hit_atom, datum/thrownthing/thrownthing)
	. = ..()
	new /obj/effect/decal/cleanable/shreds/clay(get_turf(src))
	playsound(get_turf(src), 'sound/foley/break_clay.ogg', 90, TRUE)
	qdel(src)

/obj/item/plate/copper
	name = "copper platter"
	desc = "A platter made from a sheet of copper. Known to impart a metallic taste when eating certain foods."
	icon_state = "platter_copper"
	resistance_flags = FIRE_PROOF
	drop_sound = 'sound/foley/dropsound/armor_drop.ogg'

/obj/item/plate/pewter
	name = "pewter platter"
	desc = "A tin plate that contains just a tinge of lead."
	icon_state = "platter_tin"
	resistance_flags = FIRE_PROOF
	drop_sound = 'sound/foley/dropsound/armor_drop.ogg'

/obj/item/plate/silver
	name = "silver platter"
	desc = "A fancy silver plate often used by the nobility as a symbol of class."
	icon_state = "platter_silver"
	resistance_flags = FIRE_PROOF
	drop_sound = 'sound/foley/dropsound/armor_drop.ogg'
	sellprice = 12
	smeltresult = /obj/item/ingot/silver

/obj/item/plate/gold
	name = "gold platter"
	desc = "A fancy gold plate often used by the nobility as a symbol of class."
	icon_state = "platter_gold"
	resistance_flags = FIRE_PROOF
	drop_sound = 'sound/foley/dropsound/armor_drop.ogg'
	sellprice = 20
	smeltresult = /obj/item/ingot/gold

/obj/item/plate/tray
	name = "tray"
	desc = "Best used when hosting for banquets or drunken taverns."
	icon = 'icons/obj/food/containers.dmi'
	icon_state = "tray"
	max_items = 6
	grid_width = 64
	grid_height = 32

/obj/item/plate/tray/psy
	name = "tray"
	icon_state = "tray_psy"
