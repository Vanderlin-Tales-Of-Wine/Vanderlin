// BOUQUETS & FLOWER CROWNS

/obj/item/bouquet
	name = ""
	desc = ""
	icon = 'icons/roguetown/items/misc.dmi'
	icon_state = ""
	item_state = ""

	grid_width = 32
	grid_height = 64

/obj/item/bouquet/rosa
	name = "rosa bouquet"
	desc =  "A bouqet of roses, one of eora's most beautiful flowers. They are a symbol of love and devotion."
	icon_state = "bouquet_rosa"

/obj/item/bouquet/salvia
	name = "salvia boquet"
	desc = "A boquet of sweet smelling salvia, a beautiful and royal purple flower."
	icon_state = "bouquet_salvia"

/obj/item/bouquet/matricaria
	name = "matricaria boquet"
	desc = "A bouqet of maricaria"
	icon_state = "bouquet_matricaria"

/obj/item/bouquet/calendula
	name = "calendula boquet"
	desc = "A bouqet of calendula, a flower used in herbal medicine, said to have healing properties"
	icon_state = "bouquet_calendula"

/obj/item/head/flowercrown
	name = ""
	desc = ""
	icon = 'icons/roguetown/clothing/head.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/head_items.dmi'
	alternate_worn_layer  = 8.9 //On top of helmet
	slot_flags = ITEM_SLOT_HEAD|ITEM_SLOT_MASK
	body_parts_covered = null
	icon_state = ""
	item_state = ""

	grid_width = 64
	grid_height = 32

/obj/item/head/flowercrown/rosa
	name = "rosa crown"
	desc = "A crown of roses, often worn during weddings officated by Eoran priests."
	item_state = "rosa_crown"
	icon_state = "rosa_crown"

/obj/item/head/flowercrown/salvia
	name = "salvia crown"
	desc = "A crown of salvia, often worn by consorts and princesses of particularly joyful royal courts"
	item_state = "salvia_crown"
	icon_state = "salvia_crown"
