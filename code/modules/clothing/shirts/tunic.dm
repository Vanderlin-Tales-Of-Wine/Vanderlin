/obj/item/clothing/shirt/tunic
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT
	name = "tunic"
	desc = ""
	body_parts_covered = CHEST|GROIN|VITALS
	boobed = FALSE
	icon_state = "tunic"
	color = CLOTHING_LINEN
	sleevetype = "tunic"
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL

/obj/item/clothing/shirt/tunic/noblecoat
	name = "fancy coat"
	desc = "A fancy tunic and coat combo. How elegant."
	icon_state = "noblecoat"
	sleevetype = "noblecoat"
	color = CLOTHING_WHITE
	boobed = TRUE

/obj/item/clothing/shirt/tunic/green
	color = CLOTHING_FOREST_GREEN

/obj/item/clothing/shirt/tunic/blue
	color = CLOTHING_SKY_BLUE

/obj/item/clothing/shirt/tunic/red
	color = CLOTHING_BLOOD_RED

/obj/item/clothing/shirt/tunic/purple
	color = CLOTHING_PLUM_PURPLE

/obj/item/clothing/shirt/tunic/black
	color = CLOTHING_SOOT_BLACK

/obj/item/clothing/shirt/tunic/ucolored
	color = CLOTHING_ASH_GREY

/obj/item/clothing/shirt/tunic/random/Initialize()
	color = pick(CLOTHING_PLUM_PURPLE, CLOTHING_BLOOD_RED, CLOTHING_SKY_BLUE, CLOTHING_FOREST_GREEN)
	return ..()

/obj/item/clothing/shirt/tunic/tunicprimary
	color = CLOTHING_BLOOD_RED

/obj/item/clothing/shirt/tunic/tunicprimary/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/shirt/tunic/tunicprimary/Destroy()
	GLOB.lordcolor -= src
	return ..()
