/obj/item/gear
	icon = 'icons/roguetown/items/misc.dmi'
	name = "gear"
	desc = ""
	icon_state = ""
	w_class = WEIGHT_CLASS_SMALL
	smeltresult = null
	grid_height = 32
	grid_width = 32

/obj/item/gear/metal
	desc = "A gear with teeth meticulously crafted for tight interlocking."
	icon_state = "gear"

// To prevent metal transmutation
/obj/item/gear/metal/bronze
	smeltresult = /obj/item/ingot/bronze

/obj/item/gear/metal/iron
	smeltresult = /obj/item/ingot/iron

/obj/item/gear/metal/steel
	smeltresult = /obj/item/ingot/steel

/obj/item/gear/wood
	var/cart_capacity = 0
	var/misfire_modification
	var/name_prefix
	grid_height = 64
	grid_width = 32

/obj/item/gear/wood/basic
	name = "wooden gear"
	desc = "A very simple wooden gear. Used in carts and machinery."
	icon_state = "upgrade"
	metalizer_result = /obj/item/gear/metal
	cart_capacity = 90
	misfire_modification = -5

/obj/item/gear/wood/reliable
	name = "reliable wooden gear"
	desc = "A gear imbued with a special essence, making it very reliable. Used in carts and machinery."
	icon_state = "upgrade2"
	cart_capacity = 120
	misfire_modification = -50
	name_prefix = "stable"

/obj/item/gear/wood/reliable/Initialize()
	. = ..()
	filters = filter(type="drop_shadow", x=0, y=0, size=0.5, offset=1, color=rgb(32, 196, 218, 200))

/obj/item/gear/wood/unstable
	name = "unstable wooden gear"
	desc = "A gear imbued with a special essence, making it prone to breaking at any time. Used in carts and machinery."
	icon_state = "upgrade2"
	cart_capacity = 140
	misfire_modification = 50
	name_prefix = "unstable"

/obj/item/gear/wood/unstable/Initialize()
	. = ..()
	filters = filter(type="drop_shadow", x=0, y=0, size=0.5, offset=1, color=rgb(167, 17, 17, 200))
