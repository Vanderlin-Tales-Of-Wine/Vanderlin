/obj/item/roguegear
	icon = 'icons/roguetown/items/misc.dmi'
	name = "cog"
	desc = ""
	icon_state = ""
	w_class = WEIGHT_CLASS_SMALL
	smeltresult = null
	grid_height = 32
	grid_width = 32

/obj/item/roguegear/metal
	name = "cog"
	desc = "A cog with teeth meticulously crafted for tight interlocking."
	icon_state = "gear"

// To prevent metal transmutation
/obj/item/roguegear/metal/bronze
	smeltresult = /obj/item/ingot/bronze

/obj/item/roguegear/metal/iron
	smeltresult = /obj/item/ingot/iron

/obj/item/roguegear/metal/steel
	smeltresult = /obj/item/ingot/steel

/obj/item/roguegear/wood
	var/cart_capacity = 0
	var/misfire_modification
	var/name_prefix
	grid_height = 64
	grid_width = 32

/obj/item/roguegear/wood/basic
	name = "wooden cog"
	desc = "A very simple wooden cog. Used in carts and machinery."
	icon_state = "upgrade"
	metalizer_result = /obj/item/roguegear/metal
	cart_capacity = 90
	misfire_modification = -5

/obj/item/roguegear/wood/reliable
	name = "reliable wooden cog"
	desc = "A cog imbued with a special essence, making it very reliable. Used in carts and machinery."
	icon_state = "upgrade2"
	cart_capacity = 120
	misfire_modification = -50
	name_prefix = "stable"

/obj/item/roguegear/wood/reliable/Initialize()
	. = ..()
	filters = filter(type="drop_shadow", x=0, y=0, size=0.5, offset=1, color=rgb(32, 196, 218, 200))

/obj/item/roguegear/wood/unstable
	name = "unstable wooden cog"
	desc = "A cog imbued with a special essence, making it prone to breaking at any time. Used in carts and machinery."
	icon_state = "upgrade2"
	cart_capacity = 140
	misfire_modification = 50
	name_prefix = "unstable"

/obj/item/roguegear/wood/unstable/Initialize()
	. = ..()
	filters = filter(type="drop_shadow", x=0, y=0, size=0.5, offset=1, color=rgb(167, 17, 17, 200))
