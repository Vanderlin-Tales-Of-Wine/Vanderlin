/obj/item/clothing/armor/plate
	name = "steel half-plate"
	desc = "Steel plate armor with shoulder guards. An incomplete, bulky set of excellent armor."
	icon_state = "halfplate"
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	equip_delay_self = 4 SECONDS
	unequip_delay_self = 4 SECONDS
	equip_sound = 'sound/foley/equip/equip_armor_plate.ogg'
	sellprice = VALUE_STEEL_ARMOR
	clothing_flags = CANT_SLEEP_IN
	//Plate doesn't protect a lot against blunt
	armor_class = AC_HEAVY
	armor = ARMOR_PLATE
	body_parts_covered = COVERAGE_ALL_BUT_LEGS //Has shoulder guards, and nothing else to suggest leg protection
	prevent_crits = ALL_EXCEPT_BLUNT
	max_integrity = INTEGRITY_STRONGEST

/obj/item/clothing/armor/plate/Initialize()
	. = ..()
	AddComponent(/datum/component/item_equipped_movement_rustle, custom_sounds = SFX_PLATE_STEP)

/obj/item/clothing/armor/plate/iron
	name = "iron half-plate"
	desc = "Iron plate armor with shoulder guards. An incomplete, bulky set of good armor."
	icon_state = "ihalfplate"
	item_state = "ihalfplate"
	smeltresult = /obj/item/ingot/iron
	sellprice = VALUE_IRON_ARMOR
	armor = ARMOR_PLATE_BAD
	max_integrity = INTEGRITY_STRONG

//................ Full Plate Armor ............... //
/obj/item/clothing/armor/plate/full
	name = "plate armor"
	desc = "Full steel plate. Leg protecting tassets, groin cup, armored vambraces."
	icon_state = "plate"
	item_state = "plate"
	equip_delay_self = 8 SECONDS
	unequip_delay_self = 7 SECONDS
	sellprice = VALUE_FULL_PLATE

	armor = ARMOR_PLATE
	body_parts_covered = COVERAGE_FULL
	item_weight = 12 * STEEL_MULTIPLIER

/obj/item/clothing/armor/plate/full/iron
	name = "iron plate armor"
	desc = "Full iron plate. Leg protecting tassets, groin cup, armored vambraces."
	icon_state = "iplate"
	item_state = "iplate"
	sellprice = VALUE_IRON_ARMOR*2
	smeltresult = /obj/item/ingot/iron

	armor = ARMOR_PLATE_BAD
	max_integrity = INTEGRITY_STRONG
	item_weight = 12 * IRON_MULTIPLIER

//................Old Iron Plate ............... //
/obj/item/clothing/armor/plate/iron/old
	name = "old iron plate armor"//No way to get this right now because I removed the smithing recipe, and it's map spawner spawns iron halfplate instead now. The sprite looks like it's in the steel palette, so it doesn't fit in right.
	desc = "A rough set of iron armor, complete with chainmail joints and pauldrons. An older and cheaper design that protects the torso and legs."
	icon_state = "ironplate"
	smeltresult = /obj/item/ingot/iron
	sellprice = VALUE_IRON_ARMOR*2

	body_parts_covered = COVERAGE_ALL_BUT_ARMS//This one looks like it covers legs
	armor = ARMOR_PLATE_BAD
	max_integrity = INTEGRITY_STRONG
	item_weight = 12 * IRON_MULTIPLIER

//................ Rusted Half-plate ............... //
/obj/item/clothing/armor/plate/rust
	name = "rusted half-plate"
	desc = "Old glory, old defeats, most of the rust comes from damp and not the blood of previous wearers, one would hope."
	icon = 'icons/roguetown/clothing/special/rust_armor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/rust_armor.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/rust_armor.dmi'
	icon_state = "rustplate"
	item_state = "rustplate"
	smeltresult = /obj/item/ingot/iron
	sellprice = VALUE_IRON_ARMOR/2
	armor = ARMOR_PLATE_BAD
	max_integrity = INTEGRITY_STANDARD
	item_weight = 12 * IRON_MULTIPLIER

/obj/item/clothing/armor/plate/blkknight
	name = "blacksteel plate"
	body_parts_covered = COVERAGE_ALL_BUT_LEGS
	armor_class = AC_MEDIUM
	icon_state = "bkarmor"
	icon = 'icons/roguetown/clothing/special/blkknight.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/blkknight.dmi'
	anvilrepair = /datum/skill/craft/blacksmithing
	smeltresult = /obj/item/ingot/blacksteel
	item_weight = 12 * BLACKSTEEL_MULTIPLIER

//................ Deccorated Half-plate ............... //

/obj/item/clothing/armor/plate/decorated
	name = "decorated halfplate"
	desc = "A halfplate decorated with an gold ornament on the chestplate. A status symbol that doesnt lose out on practicality. "
	icon_state = "halfplate_decorated"
	icon = 'icons/roguetown/clothing/special/decorated_armor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/decorated_armor.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/decorated_armor.dmi'
	sellprice = VALUE_LUXURY_THING

/obj/item/clothing/armor/plate/decorated/corset
	name = "decorated halfplate with corset"
	desc = "A halfplate decorated with an gold ornament on the chestplate and a fine silk corset. More for decoration then actual use."
	icon_state = "halfplate_decorated_corset"

//................ Zizo Armor ...............//

/obj/item/clothing/armor/plate/full/zizo
	name = "darksteel fullplate"
	desc = "Full plate. Called forth from the edge of what should be known. In Her name."
	icon_state = "zizoplate"
	icon = 'icons/roguetown/clothing/special/evilarmor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/evilarmor.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/evilarmor.dmi'
	sellprice = 0 // Incredibly evil Zizoid armor, this should be burnt, nobody wants this

//................ Matthios Armor ...............//

/obj/item/clothing/armor/plate/full/matthios
	name = "gilded fullplate"
	desc = "Full plate. Tales told of men in armor such as this stealing many riches, or lives."
	icon_state = "matthiosarmor"
	icon = 'icons/roguetown/clothing/special/evilarmor.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/evilarmor.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/evilarmor.dmi'
	sellprice = 0 // See above comment
