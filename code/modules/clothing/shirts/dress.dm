/obj/item/clothing/shirt/dress
	slot_flags = ITEM_SLOT_ARMOR
	name = "bar dress"
	desc = ""
	body_parts_covered = CHEST|GROIN|LEGS|VITALS
	icon_state = "dress"
	item_state = "dress"
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL

/obj/item/clothing/shirt/dress/gen
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT
	name = "dress"
	desc = ""
	body_parts_covered = CHEST|GROIN|LEGS|VITALS
	icon_state = "dressgen"
	item_state = "dressgen"

/obj/item/clothing/shirt/dress/gen/brown
	color = CLOTHING_PEASANT_BROWN

/obj/item/clothing/shirt/dress/gen/black
	color = CLOTHING_SOOT_BLACK

/obj/item/clothing/shirt/dress/gen/blue
	color = CLOTHING_SKY_BLUE

/obj/item/clothing/shirt/dress/gen/green
	color = CLOTHING_BOG_GREEN

/obj/item/clothing/shirt/dress/gen/purple
	color = CLOTHING_PLUM_PURPLE

/obj/item/clothing/shirt/dress/gen/maid
	color = CLOTHING_DARK_INK

/obj/item/clothing/shirt/dress/gen/maid/Initialize()
	..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/shirt/dress/gen/maid/Destroy()
	GLOB.lordcolor -= src
	return ..()

/obj/item/clothing/shirt/dress/gen/random/Initialize()
	color = pick_assoc(GLOB.peasant_dyes)
	..()

/obj/item/clothing/shirt/dress/silkdress
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT
	name = "chemise"
	desc = "Comfortable yet elegant, it offers both style and comfort for everyday wear"
	body_parts_covered = CHEST|GROIN|LEGS|VITALS
	icon_state = "silkdress"
	color = CLOTHING_LINEN
	salvage_result = /obj/item/natural/silk
	salvage_amount = 1

/obj/item/clothing/shirt/dress/silkdress/princess
	color = CLOTHING_CHALK_WHITE

/obj/item/clothing/shirt/dress/silkdress/princess/Initialize()
	..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/shirt/dress/silkdress/princess/Destroy()
	GLOB.lordcolor -= src
	return ..()

/obj/item/clothing/shirt/dress/silkdress/black
	color = CLOTHING_DARK_INK

/obj/item/clothing/shirt/dress/silkdress/green
	color = CLOTHING_FOREST_GREEN

/obj/item/clothing/shirt/dress/silkdress/random/Initialize()
	color = pick_assoc(GLOB.noble_dyes)
	..()

/obj/item/clothing/shirt/dress/silkdress/silkdressprimary
	color = CLOTHING_BLOOD_RED

/obj/item/clothing/shirt/dress/silkdress/silkdressprimary/Initialize()
	..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/shirt/dress/silkdress/silkdressprimary/Destroy()
	GLOB.lordcolor -= src
	return ..()

/obj/item/clothing/shirt/dress/stewarddress
	name = "steward's dress"
	desc = "A victorian-styled black dress with shining bronze buttons."
	icon = 'icons/roguetown/clothing/special/steward.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/special/onmob/steward.dmi'
	icon_state = "stewarddress"
	sleeved = FALSE
	slot_flags = ITEM_SLOT_ARMOR|ITEM_SLOT_SHIRT

//Royal clothing:
//................ Royal Dress (Ball Gown)............... //
/obj/item/clothing/shirt/dress/royal
	slot_flags = ITEM_SLOT_SHIRT|ITEM_SLOT_ARMOR
	icon = 'icons/roguetown/clothing/shirts_royalty.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/shirts_royalty.dmi'
	name = "royal gown"
	desc = "An elaborate ball gown, a favoured fashion of queens and elevated nobility around Enigma."
	body_parts_covered = CHEST|GROIN|ARMS|VITALS
	icon_state = "royaldress"
	sleeved = 'icons/roguetown/clothing/onmob/helpers/sleeves_shirts_royalty.dmi'
	boobed = TRUE
	detail_tag = "_detail"
	detail_color = CLOTHING_SOOT_BLACK
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL

/obj/item/clothing/shirt/dress/royal/update_icon()
	cut_overlays()
	if(get_detail_tag())
		var/mutable_appearance/pic = mutable_appearance(icon(icon, "[icon_state][detail_tag]"))
		pic.appearance_flags = RESET_COLOR
		if(get_detail_color())
			pic.color = get_detail_color()
		add_overlay(pic)

/obj/item/clothing/shirt/dress/royal/lordcolor(primary,secondary)
	detail_color = primary
	update_icon()

/obj/item/clothing/shirt/dress/royal/Initialize()
	. = ..()
	if(GLOB.lordprimary)
		lordcolor(GLOB.lordprimary,GLOB.lordsecondary)
	else
		GLOB.lordcolor += src

/obj/item/clothing/shirt/dress/royal/Destroy()
	GLOB.lordcolor -= src
	return ..()

//................ Princess Dress ............... //
/obj/item/clothing/shirt/dress/royal/princess
	slot_flags = ITEM_SLOT_SHIRT|ITEM_SLOT_ARMOR
	name = "pristine dress"
	desc = "A flowy, intricate dress made by the finest tailors in the land for the monarch's children."
	icon_state = "princess"
	boobed = TRUE
	detail_color = CLOTHING_BERRY_BLUE

//................ Prince Shirt   ............... //
/obj/item/clothing/shirt/dress/royal/prince
	slot_flags = ITEM_SLOT_SHIRT|ITEM_SLOT_ARMOR
	name = "gilded dress shirt"
	desc = "A gold-embroidered dress shirt specially tailored for the monarch's children."
	icon_state = "prince"
	boobed = TRUE
	detail_color = CLOTHING_ROYAL_MAJENTA

// End royal clothes
/obj/item/clothing/shirt/dress/gen/sexy
	slot_flags = ITEM_SLOT_ARMOR
	name = "dress"
	desc = ""
	body_parts_covered = null
	icon_state = "sexydress"
	item_state = "sexydress"
	sleevetype = null
	sleeved = null
	color = "#a90707"

/obj/item/clothing/shirt/dress/gen/sexy/Initialize()
	color = pick(CLOTHING_WINESTAIN_RED, CLOTHING_SKY_BLUE, CLOTHING_SALMON	, CLOTHING_SOOT_BLACK)
	..()

/obj/item/clothing/shirt/dress/silkydress
	name = "silky dress"
	desc = "Despite not actually being made of silk, the legendary expertise needed to sew this puts the quality on par."
	body_parts_covered = null
	slot_flags = ITEM_SLOT_ARMOR
	icon_state = "silkydress"
	item_state = "silkydress"
	sleevetype = null
	sleeved = null


/obj/item/clothing/shirt/dress/gown
	icon = 'icons/roguetown/clothing/shirts_gown.dmi'
	mob_overlay_icon = 'icons/roguetown/clothing/onmob/shirts_gown.dmi'
	name = "spring gown"
	desc = "A delicate gown that captures the essence of the season’s renewal."
	body_parts_covered = CHEST|GROIN|ARMS|VITALS
	icon_state = "springgown"
	sleeved = 'icons/roguetown/clothing/onmob/helpers/sleeves_shirts_gown.dmi'
	boobed = TRUE
	detail_tag = "_detail"
	detail_color = CLOTHING_SWAMPWEED
	r_sleeve_status = SLEEVE_NORMAL
	l_sleeve_status = SLEEVE_NORMAL
	slot_flags = ITEM_SLOT_SHIRT|ITEM_SLOT_ARMOR
	var/picked = FALSE
	colorgrenz = TRUE

/obj/item/clothing/shirt/dress/gown/summergown
	slot_flags = ITEM_SLOT_SHIRT|ITEM_SLOT_ARMOR
	name = "summer gown"
	desc = "A breezy, flowing gown fit for warm weathers."
	icon_state = "summergown"
	boobed = TRUE
	detail_color = "#e395bb"

/obj/item/clothing/shirt/dress/gown/wintergown
	slot_flags = ITEM_SLOT_SHIRT|ITEM_SLOT_ARMOR
	name = "winter gown"
	desc = "A warm, elegant gown adorned with soft fur for cold."
	icon_state = "wintergown"
	boobed = TRUE
	detail_color = "#45749d"

/obj/item/clothing/shirt/dress/gown/fallgown
	slot_flags = ITEM_SLOT_SHIRT|ITEM_SLOT_ARMOR
	name = "fall gown"
	desc = "A long sleeved, solemn gown signifies the season's nearing end."
	icon_state = "fallgown"
	boobed = TRUE
	detail_color = "#8b3f00"
