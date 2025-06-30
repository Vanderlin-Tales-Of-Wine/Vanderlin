
/obj/item/statue
	icon = 'icons/roguetown/items/valuable.dmi'
	name = "statue"
	icon_state = ""
	w_class = WEIGHT_CLASS_NORMAL
	smeltresult = null
	grid_width = 32
	grid_height = 64

/obj/item/statue/gold
	name = "gold statue"
	icon_state = "gstatue1"
	smeltresult = /obj/item/ingot/gold
	sellprice = 120

/obj/item/statue/gold/Initialize()
	. = ..()
	icon_state = "gstatue[pick(1,2)]"

/obj/item/statue/gold/loot
	name = "gold statuette"
	icon_state = "lstatue1"
	sellprice = 45

/obj/item/statue/gold/loot/Initialize()
	. = ..()
	sellprice = rand(45,100)
	icon_state = "lstatue[pick(1,2)]"

/obj/item/statue/silver
	name = "silver statue"
	icon_state = "sstatue1"
	smeltresult = /obj/item/ingot/silver
	sellprice = 90

/obj/item/statue/silver/Initialize()
	. = ..()
	icon_state = "sstatue[pick(1,2)]"

/*	..................   Misc   ................... */
/obj/item/statue/silver/gnome
	name = "petrified gnome"
	desc = "A literal gnome, turned to stone mid-step and put on a matching stone platform. Rather unsettling."
	smeltresult = null
	sellprice = 120

/obj/item/statue/steel
	name = "steel statue"
	icon_state = "ststatue1"
	smeltresult = /obj/item/ingot/steel
	sellprice = 60

/obj/item/statue/steel/Initialize()
	. = ..()
	icon_state = "ststatue[pick(1,2)]"

/obj/item/statue/iron
	name = "iron statue"
	icon_state = "istatue1"
	smeltresult = /obj/item/ingot/iron
	sellprice = 40

/obj/item/statue/iron/Initialize()
	. = ..()
	icon_state = "istatue[pick(1,2)]"

/obj/item/statue/iron/deformed
	name = "deformed iron statue"
	desc = "Theres something strange about this statue..."
	icon_state = "istatue1"
	smeltresult = /obj/item/ore/iron
	sellprice = 10
