/obj/item/clothing/head/chaperon
	name = "chaperon hat"
	icon_state = "chaperon"
	flags_inv = HIDEEARS
	sellprice = VALUE_FINE_CLOTHING

/obj/item/clothing/head/chaperon/greyscale
	name = "chaperon hat"
	desc = "A comfortable and fashionable headgear."
	icon_state = "chap_alt"
	flags_inv = HIDEEARS
	color = CLOTHING_LINEN

/obj/item/clothing/head/chaperon/greyscale/random/Initialize()
	color = pick_assoc(GLOB.noble_dyes)
	return ..()

/obj/item/clothing/head/chaperon/greyscale/silk
	icon_state = "chap_silk"

/obj/item/clothing/head/chaperon/greyscale/silk/random/Initialize()
	color = pick_assoc(GLOB.noble_dyes)
	return ..()

/obj/item/clothing/head/chaperon/greyscale/chaperonsecondary
	color = CLOTHING_PLUM_PURPLE

/obj/item/clothing/head/chaperon/greyscale/chaperonsecondary/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/head/chaperon/greyscale/chaperonsecondary/lordcolor(primary,secondary)
	if(secondary)
		color = secondary

/obj/item/clothing/head/chaperon/greyscale/chaperonsecondary/Destroy()
	GLOB.lordcolor -= src
	return ..()
