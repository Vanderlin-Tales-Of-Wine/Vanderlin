
/obj/item/clothing/gloves/plate
	name = "plate gauntlets"
	desc = "Plated gauntlets made out of steel. Offers the best protection against melee attacks."
	icon_state = "gauntlets"
	blocksound = PLATEHIT
	equip_delay_self = 25
	unequip_delay_self = 25
	body_parts_covered = ARMS|HANDS
	blade_dulling = DULLING_BASH
	equip_sound = 'sound/foley/equip/equip_armor_plate.ogg'
	pickup_sound = "rustle"
	break_sound = 'sound/foley/breaksound.ogg'
	drop_sound = 'sound/foley/dropsound/armor_drop.ogg'
	anvilrepair = /datum/skill/craft/armorsmithing
	sewrepair = FALSE
	smeltresult = /obj/item/ingot/iron //no 1 to 1 conversion

	armor_class = AC_HEAVY
	armor = ARMOR_PLATE
	prevent_crits = ALL_EXCEPT_STAB
	max_integrity = INTEGRITY_STRONGEST

	grid_width = 64
	grid_height = 32
	item_weight = 7 * IRON_MULTIPLIER

/obj/item/clothing/gloves/plate/rust
	name = "rusted riveted gauntlets"
	desc = "Riveted gauntlets made out of iron. They're covered in rust.. at least the glove liner is good still."
	icon = 'icons/roguetown/clothing/special/rust_armor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/rust_armor.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/rust_armor.dmi'
	icon_state = "rustgloves"
	item_state = "rustgloves"
	smeltresult = /obj/item/ingot/iron
	sellprice = VALUE_IRON_ARMOR/2
	armor = ARMOR_PLATE_BAD
	max_integrity = INTEGRITY_STANDARD
