/obj/item/clothing/pants/skirt
	name = "skirt"
	desc = "Long, flowing, and modest."
	icon_state = "skirt"
	item_state = "skirt"
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/pants.dmi'

/obj/item/clothing/pants/skirt/random
	name = "skirt"

/obj/item/clothing/pants/skirt/random/Initialize()
	color = pick(CLOTHING_SALMON, CLOTHING_BERRY_BLUE, CLOTHING_SPRING_GREEN, CLOTHING_PEAR_YELLOW)
	return ..()

/obj/item/clothing/pants/skirt/blue
	color = CLOTHING_BERRY_BLUE

/obj/item/clothing/pants/skirt/green
	color = CLOTHING_SPRING_GREEN

/obj/item/clothing/pants/skirt/red
	color = CLOTHING_RED_OCHRE
