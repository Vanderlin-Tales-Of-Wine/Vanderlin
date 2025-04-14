/obj/item/clothing/neck
	name = "necklace"
	desc = ""

	icon = 'icons/roguetown/clothing/neck.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/neck.dmi'
	bloody_icon_state = "bodyblood"

	equip_sound = "rustle"
	pickup_sound = "rustle"
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/gen_drop.ogg'

	body_parts_covered = NECK
	slot_flags = ITEM_SLOT_NECK
	resistance_flags = FIRE_PROOF

	strip_delay = 4 SECONDS
	equip_delay_other = 4 SECONDS

	grid_width = 64
	grid_height = 32
	item_weight = 0.5

	sewrepair = FALSE
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/iron


/obj/item/clothing/neck/worn_overlays(isinhands = FALSE)
	. = list()
