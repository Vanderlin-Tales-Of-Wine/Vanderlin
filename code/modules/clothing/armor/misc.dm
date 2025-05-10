//..................................................................................................................................
/*---------------\
|			 	 |
|  Light Armor	 |
|			 	 |
\---------------*/

/*-------------\
| Padded Armor |	- Cloth based
\-------------*/
//................ Corset.................... //
/obj/item/clothing/armor/corset
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT
	name = "corset"
	desc = "A leather binding to constrict one's figure... and lungs."
	icon_state = "corset"
	armor = ARMOR_PADDED
	body_parts_covered = COVERAGE_VEST

//................ Amazon chainkini ............... //
/obj/item/clothing/armor/amazon_chainkini
	name = "amazonian armor"
	desc = "Fur skirt and maille chest holder, typically worn by warrior women of the isle of Issa."
	icon_state = "chainkini"
	item_state = "chainkini"
	allowed_sex = list(FEMALE)
	sewrepair = TRUE
	smeltresult = /obj/item/ingot/iron
	sellprice = VALUE_IRON_ARMOR_UNUSUAL

	armor_class = AC_LIGHT
	armor = ARMOR_LEATHER_GOOD
	body_parts_covered = COVERAGE_TORSO
	prevent_crits = ALL_EXCEPT_BLUNT
	item_weight = 7 * IRON_MULTIPLIER

//................ Brigandine ............... //
/obj/item/clothing/armor/brigandine
	name = "brigandine"
	desc = "A coat with plates concealed inside an exterior fabric. Protects the user from melee impacts and also ranged attacks to an extent."
	icon_state = "brigandine"
	blocksound = SOFTHIT
	equip_delay_self = 4 SECONDS
	unequip_delay_self = 4 SECONDS
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	sellprice = VALUE_BRIGANDINE
	clothing_flags = CANT_SLEEP_IN

	armor_class = AC_HEAVY
	armor = ARMOR_BRIGANDINE
	body_parts_covered = COVERAGE_ALL_BUT_LEGS
	max_integrity = INTEGRITY_STRONGEST
	prevent_crits = ALL_EXCEPT_BLUNT
	do_sound_plate = TRUE
	item_weight = 3.2 * IRON_MULTIPLIER

/obj/item/clothing/armor/brigandine/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/armor/captain
	name = "captain's brigandine"
	desc = "A coat with plates specifically tailored and forged for the captain of Vanderlin."
	icon_state = "capplate"
	icon = 'icons/roguetown/clothing/special/captain.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/captain.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/captain.dmi'
	detail_tag = "_detail"
	detail_color = CLOTHING_BERRY_BLUE
	blocksound = SOFTHIT
	equip_delay_self = 4 SECONDS
	unequip_delay_self = 4 SECONDS
	anvilrepair = /datum/skill/craft/armorsmithing
	smeltresult = /obj/item/ingot/steel
	sellprice = VALUE_BRIGANDINE
	clothing_flags = CANT_SLEEP_IN
	armor_class = AC_HEAVY
	armor = ARMOR_PLATE_BAD
	body_parts_covered = COVERAGE_ALL_BUT_LEGS
	max_integrity = INTEGRITY_STRONGEST
	prevent_crits = ALL_EXCEPT_BLUNT
	do_sound_plate = TRUE
	item_weight = 7 * STEEL_MULTIPLIER

/obj/item/clothing/armor/captain/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/armor/captain/lordcolor(primary,secondary)
	detail_color = primary
	update_icon()

/obj/item/clothing/armor/captain/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/armor/captain/Destroy()
	GLOB.lordcolor -= src
	return ..()

//................ Coat of Plate ............... //
/obj/item/clothing/armor/brigandine/coatplates
	name = "coat of plates"
	desc = "A Zybantine leather coat with steel scales woven with miniscule threads of adamantine, \
			ensuring the wearer an optimal defence with forgiving breathability and mobility."
	icon_state = "coat_of_plates"
	blocksound = PLATEHIT
	sellprice = VALUE_SNOWFLAKE_STEEL
	armor = ARMOR_PLATE_BAD
	// add armor plate bad from defines

	max_integrity = INTEGRITY_STRONG

/obj/item/clothing/shirt/vampire
	slot_flags = ITEM_SLOT_SHIRT|ITEM_SLOT_ARMOR
	name = "regal silks"
	desc = ""
	body_parts_covered = CHEST|GROIN|LEGS|VITALS
	prevent_crits = list(BCLASS_BITE, BCLASS_TWIST)
	icon_state = "vrobe"
	item_state = "vrobe"
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL
