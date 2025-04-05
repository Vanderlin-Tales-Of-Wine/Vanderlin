/obj/item/clothing/pants/tights/stockings
	name = "stockings"
	desc = "A legwear made just for the pure aesthetics. Popular in courts."
	icon_state = "stockings"
	r_sleeve_status = SLEEVE_NOMOD
	l_sleeve_status = SLEEVE_NOMOD
	body_parts_covered = null
	flags_inv = null
	salvage_amount = 1

/obj/item/clothing/pants/tights/stockings/random/Initialize()
	color = pick(GLOB.peasant_dyes)
	. = ..()

/obj/item/clothing/pants/tights/stockings/uncolored
	color = CLOTHING_LINEN

/obj/item/clothing/pants/tights/stockings/black
	color = CLOTHING_SOOT_BLACK

/obj/item/clothing/pants/tights/stockings/blue
	color = CLOTHING_BERRY_BLUE

/obj/item/clothing/pants/tights/stockings/red
	color = CLOTHING_BLOOD_RED

/obj/item/clothing/pants/tights/stockings/purple
	color = CLOTHING_PLUM_PURPLE

//Silk variants

/obj/item/clothing/pants/tights/stockings/silk
	name = "silk stockings"
	desc = "A legwear made just for the pure aesthetics. Made out of thin silk. Popular among nobles."
	icon_state = "silk"

/obj/item/clothing/pants/tights/stockings/silk/random/Initialize()
	. = ..()
	color = pick(GLOB.royal_dyes)

/obj/item/clothing/pants/tights/stockings/silk/white
	color = CLOTHING_CHALK_WHITE

/obj/item/clothing/pants/tights/stockings/silk/black
	color = CLOTHING_ROYAL_BLACK

/obj/item/clothing/pants/tights/stockings/silk/teal
	color = CLOTHING_ROYAL_TEAL

/obj/item/clothing/pants/tights/stockings/silk/red
	color = CLOTHING_ROYAL_RED

/obj/item/clothing/pants/tights/stockings/silk/purple
	color = CLOTHING_ROYAL_PURPLE
