/obj/item/clothing/armor/cuirass
	slot_flags = ITEM_SLOT_ARMOR
	name = "steel cuirass"
	desc = "A cuirass of steel. Lightweight and highly durable."
	icon_state = "cuirass"
	item_state = "cuirass"
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	boobed = FALSE
	sellprice = VALUE_STEEL_ARMOR

	armor_class = AC_MEDIUM
	armor = ARMOR_PLATE
	body_parts_covered = COVERAGE_TORSO
	prevent_crits = ALL_EXCEPT_BLUNT
	max_integrity = INTEGRITY_STRONG
	item_weight = 7 * STEEL_MULTIPLIER

//................ Grenzelhoft Cuirass ............... //
/obj/item/clothing/armor/cuirass/grenzelhoft
	name = "grenzelhoft cuirass"
	desc = "Simple armor, but made from Grenzelhoftian black-steel, famed afar for its strength."
	icon_state = "grenzelcuirass"
	item_state = "grenzelcuirass"
	sleeved = 'icons/roguetown/clothing/onmob/helpers/stonekeep_merc.dmi'
	boobed = TRUE

	armor = ARMOR_PLATE_GOOD

//................ Black Oak Cuirass ............... //
/obj/item/clothing/armor/cuirass/elven
	name = "elven guardian cuirass"
	desc = "A cuirass made of steel with a thin decorative gold plating. Lightweight and durable."
	icon_state = "halfplate"
	item_state = "cuirasse"
	color = COLOR_ASSEMBLY_GOLD
	equip_delay_self = 2 SECONDS
	unequip_delay_self = 2 SECONDS
	sellprice = VALUE_SNOWFLAKE_STEEL

//................ Iron Breastplate ............... //	- A breastplate is a cuirass without its back plate.
/obj/item/clothing/armor/cuirass/iron
	name = "iron breastplate"
	desc = "Many cooking pots ended their daes on the anvil to form this protective plate."
	icon_state = "ibreastplate"
	item_state = "ibreastplate"
	smeltresult = /obj/item/ingot/iron
	sellprice = VALUE_IRON_ARMOR

	armor = ARMOR_PLATE_BAD
	body_parts_covered = COVERAGE_VEST
	max_integrity = INTEGRITY_STANDARD
	item_weight = 7 * IRON_MULTIPLIER

//................ Rusted Breastplate ............... //
/obj/item/clothing/armor/cuirass/iron/rust
	name = "rusted curiass"
	desc = "Old but still useful to keep sharp objects from your innards."
	icon = 'icons/roguetown/clothing/special/rust_armor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/rust_armor.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/rust_armor.dmi'
	icon_state = "rustcuriass"
	item_state = "rustcuriass"
	sellprice = VALUE_IRON_ARMOR/2

	max_integrity = INTEGRITY_POOR

//................ Scourge Breastplate ............... //
/obj/item/clothing/armor/cuirass/iron/shadowplate
	name = "scourge breastplate"
	desc = "More form over function, this armor is fit for demonstration of might rather than open combat. The aged gilding slowly tarnishes away."
	icon_state = "shadowplate"
	item_state = "shadowplate"
	allowed_race = list("elf", "dark elf")

/obj/item/clothing/armor/cuirass/copperchest
	name = "heart protector"
	desc = "Very simple and crude protection for the chest. Ancient fighters once used similar gear, with better quality..."
	icon_state = "copperchest"
	item_state = "copperchest"
	smeltresult = /obj/item/ingot/copper
	sellprice = VALUE_DIRT_CHEAP

	armor_class = AC_LIGHT
	armor = ARMOR_PLATE_BAD
	body_parts_covered = CHEST
	prevent_crits = ONLY_VITAL_ORGANS
	max_integrity = INTEGRITY_POOR
	item_weight = 5.5 * COPPER_MULTIPLIER

/obj/item/clothing/armor/cuirass/vampire
	name = "ancient plate"
	desc = "A ornate, ceremonial plate cuirass of considerable age."
	icon_state = "vplate"

	armor_class = AC_MEDIUM
	armor = ARMOR_PLATE_GOOD
	body_parts_covered = COVERAGE_TORSO
	prevent_crits = ALL_CRITICAL_HITS_VAMP
	item_weight = 5.5 * IRON_MULTIPLIER
