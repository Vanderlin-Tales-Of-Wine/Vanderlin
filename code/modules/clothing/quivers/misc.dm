/obj/item/ammo_holder/quiver
	name = "quiver"
	icon_state = "quiver0"
	item_state = "quiver"
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_BACK
	max_storage = 20
	ammo_type = list (/obj/item/ammo_casing/caseless/arrow, /obj/item/ammo_casing/caseless/bolt)

/obj/item/ammo_holder/quiver/arrows/Initialize()
	. = ..()
	for(var/i in 1 to max_storage)
		var/obj/item/ammo_casing/caseless/arrow/A = new(src)
		ammo_list += A
	update_icon()

/obj/item/ammo_holder/quiver/bolts/Initialize()
	. = ..()
	for(var/i in 1 to max_storage)
		var/obj/item/ammo_casing/caseless/bolt/A = new(src)
		ammo_list += A
	update_icon()

/obj/item/ammo_holder/bullet
	name = "bullet pouch"
	icon_state = "dartpouch0"
	item_state = "dartpouch"
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_NECK
	max_storage = 10
	ammo_type = list(/obj/item/ammo_casing/caseless/bullet)

/obj/item/ammo_holder/dartpouch
	name = "dart pouch"
	icon_state = "dartpouch0"
	item_state = "dartpouch"
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_NECK
	max_storage = 10
	ammo_type = list(/obj/item/ammo_casing/caseless/dart)

/obj/item/ammo_holder/dartpouch/darts/Initialize()
	. = ..()
	for(var/i in 1 to max_storage)
		var/obj/item/ammo_casing/caseless/dart/A = new(src)
		ammo_list += A
	update_icon()

/obj/item/ammo_holder/dartpouch/poisondarts/Initialize()
	. = ..()
	for(var/i in 1 to 4)
		var/obj/item/ammo_casing/caseless/dart/poison/A = new(src)
		ammo_list += A
	update_icon()
