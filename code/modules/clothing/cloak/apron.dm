
/obj/item/clothing/cloak/apron
	name = "apron"
	desc = ""
	color = null
	icon_state = "apron"
	item_state = "apron"
	alternate_worn_layer = TABARD_LAYER
	body_parts_covered = CHEST|GROIN
	boobed = TRUE
	salvage_result = /obj/item/natural/cloth

/obj/item/clothing/cloak/apron/brown
	color = CLOTHING_BARK_BROWN
	salvage_result = /obj/item/natural/hide/cured

/obj/item/clothing/cloak/apron/waist
	name = "apron"
	desc = ""
	color = null
	icon_state = "waistpron"
	item_state = "waistpron"
	body_parts_covered = GROIN
	boobed = FALSE

/obj/item/clothing/cloak/apron/waist/brown
	color = CLOTHING_BARK_BROWN

/obj/item/clothing/cloak/apron/waist/bar
	color = "#251f1d"


/obj/item/clothing/cloak/apron/cook
	name = "cook apron"
	desc = "An apron covering the frontal part of the body. Apart of protection from spills, won't prevent you from getting cut in half."
	color = null
	icon_state = "aproncook"
	item_state = "aproncook"
	body_parts_covered = GROIN
	boobed = FALSE
