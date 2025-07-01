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
	uses_lord_coloring = LORD_SECONDARY
