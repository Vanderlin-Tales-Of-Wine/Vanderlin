/obj/item/storage/bag
	slot_flags = ITEM_SLOT_HIP

/obj/item/storage/bag/Initialize(mapload, ...)
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.allow_quick_gather = TRUE
	STR.allow_quick_empty = TRUE
	STR.display_numerical_stacking = TRUE
	STR.click_gather = TRUE

/*
 * Trays - Agouri
 *///wip
/obj/item/storage/bag/tray
	name = "tray"
	icon = 'icons/obj/food/containers.dmi'
	icon_state = "tray"
	force = 5
	throwforce = 10
	throw_speed = 3
	throw_range = 5
	w_class = WEIGHT_CLASS_BULKY
	flags_1 = CONDUCT_1

/obj/item/storage/bag/tray/psy
	icon_state = "tray_psy"

/obj/item/storage/bag/tray/Initialize(mapload, ...)
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.insert_preposition = "on"
	STR.max_w_class = WEIGHT_CLASS_NORMAL // changed to fit platters, take care if its abused

/obj/item/storage/bag/tray/attack(mob/living/M, mob/living/user)
	..()
	// Drop all the things. All of them.
	var/list/obj/item/oldContents = contents.Copy()
	SEND_SIGNAL(src, COMSIG_TRY_STORAGE_QUICK_EMPTY)

	// Make each item scatter a bit
	for(var/obj/item/I in oldContents)
		if(I)
			do_scatter(I)

	if(prob(10))
		M.Paralyze(4 SECONDS)
	update_appearance(UPDATE_OVERLAYS)

/obj/item/storage/bag/tray/proc/do_scatter(obj/item/I)
	if(I)
		for(var/i in 1 to rand(1, 2))
			var/xOffset = rand(-16, 16)  // Adjust the range as needed
			var/yOffset = rand(-16, 16)  // Adjust the range as needed
			I.x = xOffset
			I.y = yOffset

			sleep(rand(2, 4))

/obj/item/storage/bag/tray/update_overlays()
	. = ..()
	for(var/obj/item/I as anything in contents)
		var/mutable_appearance/M = new /mutable_appearance(I)
		M.plane = FLOAT_PLANE + 0.01
		. += M

/obj/item/storage/bag/tray/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	. = ..()
	update_appearance(UPDATE_OVERLAYS)

/obj/item/storage/bag/tray/Exited(atom/movable/gone, direction)
	. = ..()
	update_appearance(UPDATE_OVERLAYS)
