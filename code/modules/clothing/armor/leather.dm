/obj/item/clothing/armor/leather
	name = "leather armor"
	desc = "A light armor typically made out of boiled leather. Offers slight protection from most weapons."
	icon_state = "leather"
	resistance_flags = FLAMMABLE
	blade_dulling = DULLING_BASHCHOP
	blocksound = SOFTHIT
	equip_sound = 'sound/foley/equip/cloak_equip.ogg'
	pickup_sound = 'sound/foley/equip/cloak_take_off.ogg'
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	sewrepair = TRUE
	smeltresult = /obj/item/ash
	sellprice = VALUE_LEATHER_ARMOR

	armor_class = AC_LIGHT
	armor = ARMOR_LEATHER_BAD
	body_parts_covered = COVERAGE_TORSO
	prevent_crits = ALL_EXCEPT_CHOP_AND_STAB
	max_integrity = INTEGRITY_STANDARD
	salvage_result = /obj/item/natural/hide/cured
	item_weight = 3.2

/obj/item/clothing/armor/leather/advanced
	name = "hardened leather coat"
	desc = "Sturdy, durable, flexible. Will keep you alive in style."
	max_integrity = 350
	body_parts_covered = CHEST|GROIN|VITALS|LEGS|ARMS
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT, BCLASS_TWIST)
	armor = list("blunt" = 75, "slash" = 60, "stab" = 30, "piercing" = 10, "fire" = 0, "acid" = 0)

/obj/item/clothing/armor/leather/masterwork
	name = "masterwork leather coat"
	desc = "This coat is a craftsmanship marvel. Made with the finest leather. Strong, nimible, reliable."
	icon_state = "leather"
	max_integrity = 400
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT, BCLASS_TWIST, BCLASS_CHOP) //we're adding chop here!
	armor = list("blunt" = 100, "slash" = 70, "stab" = 40, "piercing" = 10, "fire" = 0, "acid" = 0)

/obj/item/clothing/armor/leather/masterwork/Initialize()
	. = ..()
	filters += filter(type="drop_shadow", x=0, y=0, size=0.5, offset=1, color=rgb(218, 165, 32))

//................ Hide Armor ............... //
/obj/item/clothing/armor/leather/hide
	name = "hide armor"
	desc = "A leather armor with additional internal padding of creacher fur. Offers slightly higher integrity and comfort."
	icon_state = "hidearmor"
	sellprice = VALUE_LEATHER_ARMOR_FUR

	armor = ARMOR_LEATHER
	salvage_result = /obj/item/natural/hide/cured

//................ Splint Mail ............... //
/obj/item/clothing/armor/leather/splint
	name = "splint armor"
	desc = "The smell of a leather coat, with pieces of recycled metal from old breastplates or cooking utensils riveted to the inside."
	icon_state = "splint"
	sellprice = VALUE_LEATHER_ARMOR_PLUS

	armor = ARMOR_LEATHER_GOOD
	prevent_crits = ALL_EXCEPT_STAB
	max_integrity = INTEGRITY_STRONG
	item_weight = 6.7


//................ Leather Vest ............... //	- has no sleeves.  - can be worn in armor OR shirt slot
/obj/item/clothing/armor/leather/vest
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT
	name = "leather vest"
	desc = "Obviously no sleeves, won't really protect much but it's at least padded enough to be an armor, and can be worn against the skin snugly."
	icon_state = "vest"
	color = CLOTHING_BARK_BROWN
	blade_dulling = DULLING_BASHCHOP
	blocksound = SOFTHIT
	sewrepair = TRUE
	sleevetype = null
	sleeved = null

	armor = ARMOR_LEATHER_BAD
	body_parts_covered = COVERAGE_VEST
	prevent_crits = CUT_AND_MINOR_CRITS
	salvage_result = /obj/item/natural/hide/cured
	item_weight = 2.2

/obj/item/clothing/armor/leather/vest/random/Initialize()
	color = pick(CLOTHING_SOOT_BLACK, CLOTHING_BARK_BROWN, CLOTHING_FOREST_GREEN)
	..()

//................ Butchers Vest ............... //
/obj/item/clothing/armor/leather/vest/butcher
	name = "butchers vest"
	icon_state = "leathervest"
	color = "#d69c87" // custom coloring
	item_weight = 1.8

//................ Other Vests ............... //
/obj/item/clothing/armor/leather/vest/butler
	color = CLOTHING_BLOOD_RED

/obj/item/clothing/armor/leather/vest/butler/Initialize()
	..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src
/obj/item/clothing/armor/leather/vest/butler/Destroy()
	GLOB.lordcolor -= src
	return ..()

/obj/item/clothing/armor/leather/vest/black
	color = CLOTHING_DARK_INK

/obj/item/clothing/armor/leather/vest/innkeep // repath to correct padded vest some day
	name = "padded vest"
	desc = "Dyed green, belongs to the owner of the Drunken Saiga inn."
	icon_state = "striped"
	color = "#638b45"

/obj/item/clothing/armor/leather/vest/winterjacket
	name = "winter jacket"
	desc = "The most elegant of furs and vivid of royal dyes combined together into a most classy jacket."
	icon_state = "winterjacket"
	detail_tag = "_detail"
	color = CLOTHING_WHITE
	detail_color = CLOTHING_SOOT_BLACK

/obj/item/clothing/armor/leather/vest/winterjacket/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/armor/leather/vest/winterjacket/lordcolor(primary,secondary)
	detail_color = primary
	update_icon()

/obj/item/clothing/armor/leather/vest/winterjacket/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/armor/leather/vest/winterjacket/Destroy()
	GLOB.lordcolor -= src
	return ..()

//................ Jacket ............... //	- Has a small storage space
/obj/item/clothing/armor/leather/jacket
	name = "tanned jacket"
	icon_state = "leatherjacketo"
	desc = "A heavy leather jacket with wooden buttons, favored by workers who can afford it."

	body_parts_covered = COVERAGE_SHIRT
	item_weight = 2.2

/obj/item/clothing/armor/leather/jacket/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/storage/concrete/grid/cloak)

/obj/item/clothing/armor/leather/jacket/dropped(mob/living/carbon/human/user)
	..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	if(STR)
		var/list/things = STR.contents()
		for(var/obj/item/I in things)
			STR.remove_from_storage(I, get_turf(src))

/obj/item/clothing/armor/leather/jacket/artijacket
	name = "artificer jacket"
	icon_state = "artijacket"
	desc = "A thick leather jacket adorned with fur and cog decals. The height of Heartfelt fashion."

/obj/item/clothing/armor/leather/jacket/gatemaster_jacket
	name = "gatemaster's coat"
	desc = "A thick cloth padded coat specialty made for the gatemaster."
	icon = 'icons/roguetown/clothing/special/gatemaster.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/gatemaster.dmi'
	icon_state = "master_coat"
	blocksound = SOFTHIT
	slot_flags = ITEM_SLOT_ARMOR
	armor = ARMOR_MAILLE_IRON
	body_parts_covered = COVERAGE_ALL_BUT_LEGS
	salvage_result = /obj/item/natural/cloth

/obj/item/clothing/armor/leather/jacket/gatemaster_jacket/armored
	name = "gatemaster's coat"
	desc = "A thick cloth padded coat specialty made for the gatemaster."
	icon_state = "master_coat_cuirass"
	blocksound = PLATEHIT
	armor = ARMOR_MAILLE_GOOD

//................ Sea Jacket ............... //
/obj/item/clothing/armor/leather/jacket/sea
	slot_flags = ITEM_SLOT_ARMOR
	name = "sea jacket"
	desc = "A sturdy jacket worn by daring seafarers. The leather it's made from has been tanned by the salt of Abyssor's seas."
	icon_state = "sailorvest"
	sleevetype = "shirt"

	armor = ARMOR_LEATHER
	body_parts_covered = COVERAGE_VEST

//................ Silk Coat ............... //
/obj/item/clothing/armor/leather/jacket/silk_coat
	name = "silk coat"
	desc = "An expertly padded coat made from the finest silks. Long may live the nobility that dons it."
	icon_state = "bliaut"
	sleevetype = "shirt"
	sellprice = VALUE_LEATHER_ARMOR_LORD

	body_parts_covered = COVERAGE_ALL_BUT_ARMS
	prevent_crits = CUT_AND_MINOR_CRITS

/obj/item/clothing/armor/leather/jacket/silk_coat/Initialize()
	color = pick(CLOTHING_PLUM_PURPLE, CLOTHING_WHITE,CLOTHING_BLOOD_RED)
	..()

//................ Silk Jacket ............... //
/obj/item/clothing/armor/leather/jacket/apothecary
	name = "silk jacket"
	icon_state = "nightman"
	desc = "Displaying wealth while keeping your guts safe from blades with thick leather pads underneath."
	sellprice = VALUE_LEATHER_ARMOR_LORD

	body_parts_covered = COVERAGE_SHIRT

//................ Hand´s Coat ............... //
/obj/item/clothing/armor/leather/jacket/hand
	name = "noble coat"
	icon_state = "handcoat"
	desc = "A quality silken coat, discretely lined with thin metal platr on the inside to protect its affluent wearer."
	sellprice = VALUE_LEATHER_ARMOR_LORD

	body_parts_covered = COVERAGE_ALL_BUT_ARMS

/obj/item/clothing/armor/leather/jacket/handjacket
	name = "noble jacket"
	icon_state = "handcoat"
	icon = 'icons/roguetown/clothing/special/hand.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/hand.dmi'
	sleeved = 'icons/roguetown/clothing/special/onmob/hand.dmi'
	detail_tag = "_detail"
	detail_color = CLOTHING_BERRY_BLUE
	body_parts_covered = COVERAGE_SHIRT

/obj/item/clothing/armor/leather/jacket/handjacket/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/armor/leather/jacket/handjacket/lordcolor(primary,secondary)
	detail_color = primary
	update_icon()

/obj/item/clothing/armor/leather/jacket/handjacket/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/armor/leather/jacket/handjacket/Destroy()
	GLOB.lordcolor -= src
	return ..()

/obj/item/clothing/armor/leather/jacket/leathercoat
	name = "leather coat"
	desc = "A tan and purple leather coat."
	icon_state = "leathercoat"
	icon = 'icons/roguetown/clothing/leathercoat.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/leathercoat.dmi'
	sleeved = 'icons/roguetown/clothing/onmob/leathercoat.dmi'
	boobed = TRUE
	armor = ARMOR_LEATHER
	body_parts_covered = COVERAGE_ALL_BUT_LEGS

/obj/item/clothing/armor/leather/jacket/leathercoat/black
	name = "black leather coat"
	desc = "A black and purple leather coat."
	icon_state = "bleathercoat"
	icon = 'icons/roguetown/clothing/leathercoat.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/leathercoat.dmi'
	sleeved = 'icons/roguetown/clothing/onmob/leathercoat.dmi'
	boobed = TRUE
	armor = ARMOR_LEATHER
	body_parts_covered = COVERAGE_ALL_BUT_LEGS
